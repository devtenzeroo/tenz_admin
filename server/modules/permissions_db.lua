-- Server DB helper for tenz_admin permissions
-- Purpose: provide synchronous (blocking) helper functions wrapping oxmysql calls
-- Notes:
--  - These functions use a simple busy-wait to convert oxmysql callbacks into synchronous-style returns.
--  - Keep queries lightweight on the main thread. For heavy operations, run them off the main thread.

local oxmysql = exports['oxmysql']
local DB = {}

local function querySync(sql, params)
    local result = nil
    oxmysql:execute(sql, params or {}, function(res)
        result = res
    end)
    -- Busy-wait until callback populates result
    while result == nil do
        Wait(0)
    end
    return result
end

-- Get group by name
function DB.getGroupByName(name)
    local rows = querySync('SELECT * FROM tenz_admin_groups WHERE name = ? LIMIT 1', { name })
    return rows and rows[1] or nil
end

function DB.getGroupById(id)
    local rows = querySync('SELECT * FROM tenz_admin_groups WHERE id = ? LIMIT 1', { id })
    return rows and rows[1] or nil
end

-- Get or create player row by canonical identifier (first identifier string)
-- identifier should be the raw FiveM identifier (eg. 'steam:xxxxx', 'license:xxxxx', 'discord:123')
function DB.getPlayerByIdentifier(identifier)
    local rows = querySync('SELECT p.*, g.name as group_name, g.rank as group_rank, g.ace_group as ace_group FROM tenz_admin_players p LEFT JOIN tenz_admin_groups g ON p.group_id = g.id WHERE p.identifier = ? LIMIT 1', { identifier })
    return rows and rows[1] or nil
end

-- Helper: find player by any identifier (search matching any identifier column)
function DB.findPlayerByAnyIdentifier(identifier)
    -- We store the canonical identifier in `identifier` column; extra identifiers may be stored in identifiers JSON if needed
    return DB.getPlayerByIdentifier(identifier)
end

-- Set player group (upserts player row and updates group_id). Returns true/false and message
-- addedBy should be an identifier string for audit (who performed change)
function DB.setPlayerGroup(identifier, groupName, addedBy, discordId)
    local group = DB.getGroupByName(groupName)
    if not group then
        return false, 'group_not_found'
    end

    -- Check existing
    local existing = DB.getPlayerByIdentifier(identifier)
    if existing then
        if existing.group_id == group.id then
            return true, 'no_change'
        end
        -- update
        querySync('UPDATE tenz_admin_players SET group_id = ?, discord_id = ?, updated_at = CURRENT_TIMESTAMP WHERE identifier = ?', { group.id, discordId or existing.discord_id, identifier })
    else
        querySync('INSERT INTO tenz_admin_players (identifier, discord_id, group_id, added_by) VALUES (?, ?, ?, ?)', { identifier, discordId or nil, group.id, addedBy or 'system' })
    end

    -- Insert audit log
    querySync('INSERT INTO tenz_admin_audit (actor_identifier, action, target_identifier, metadata) VALUES (?, ?, ?, ?)', { addedBy or 'system', 'set_group', identifier, json.encode({ group = groupName }) })

    return true, 'ok'
end

-- List groups
function DB.listGroups()
    local rows = querySync('SELECT * FROM tenz_admin_groups ORDER BY rank ASC', {})
    return rows
end

-- Seed default groups (idempotent)
function DB.createDefaultGroups()
    local defaults = {
        { name = 'Founder', rank = 0, ace_group = 'tenz_founder', description = 'Top-level owner.' },
        { name = 'Owner', rank = 1, ace_group = 'tenz_owner', description = 'Server owner.' },
        { name = 'Developer', rank = 2, ace_group = 'tenz_developer', description = 'Developer / coder.' },
        { name = 'Management', rank = 3, ace_group = 'tenz_management', description = 'Management team.' },
        { name = 'HeadAdmin', rank = 4, ace_group = 'tenz_headadmin', description = 'Head administrators.' },
        { name = 'SeniorAdmin', rank = 5, ace_group = 'tenz_senioradmin', description = 'Senior administrators.' },
        { name = 'Admin', rank = 6, ace_group = 'tenz_admin', description = 'Regular administrators.' },
        { name = 'Moderator', rank = 7, ace_group = 'tenz_moderator', description = 'Moderators and helpers.' },
        { name = 'Helper', rank = 8, ace_group = 'tenz_helper', description = 'Helpers and trial staff.' },
    }

    for _, g in ipairs(defaults) do
        local existing = DB.getGroupByName(g.name)
        if not existing then
            querySync('INSERT INTO tenz_admin_groups (name, rank, ace_group, description) VALUES (?, ?, ?, ?)', { g.name, g.rank, g.ace_group, g.description })
        else
            -- if group exists, ensure ace_group and rank are up-to-date
            querySync('UPDATE tenz_admin_groups SET rank = ?, ace_group = ?, description = ? WHERE id = ?', { g.rank, g.ace_group, g.description, existing.id })
        end
    end
end

-- Utility: resolve canonical identifier for a player source
-- Prefer license, then steam, then discord, then xbl, etc.
function DB.getCanonicalIdentifierFromSource(source)
    if not source or type(source) ~= 'number' then return nil end
    local ids = GetPlayerIdentifiers(source)
    if not ids or #ids == 0 then return nil end

    -- Preference order
    local priorities = { 'license:', 'steam:', 'discord:', 'xbl:', 'ip:' }
    for _, p in ipairs(priorities) do
        for _, id in ipairs(ids) do
            if id:sub(1, #p) == p then
                return id
            end
        end
    end

    -- fallback first identifier
    return ids[1]
end

return DB
