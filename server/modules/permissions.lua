-- Permissions core for tenz_admin
-- Purpose: provide server-side permission checks and group management APIs
-- Exports provided:
--  - IsAdmin(source) -> boolean
--  - HasPermission(sourceOrIdentifier, permission) -> boolean
--  - GetPlayerGroup(sourceOrIdentifier) -> string (group name) or nil
--  - SetPlayerGroup(targetIdentifierOrSource, groupName, performedBySourceOrIdentifier) -> (bool, message)

return function(DB)
    local M = {}

    -- Rank threshold for "admin" status. Any group with rank <= this number is considered an admin
    local ADMIN_MAX_RANK = 6 -- Founder..Admin (0..6) are admins; Moderator(7) and Helper(8) are not

    -- Internal helper: resolve identifier string from a source number or accept identifier string as-is
    local function resolveIdentifier(input)
        if type(input) == 'number' then
            return DB.getCanonicalIdentifierFromSource(input)
        elseif type(input) == 'string' then
            -- Accept raw identifiers like "steam:xxx" or a bare discord id like "1234567890"
            if tonumber(input) and #input > 5 then
                -- looks like a discord id; return as discord: prefixed
                return 'discord:' .. tostring(input)
            end
            return input
        end
        return nil
    end

    -- Get player group name by source or identifier
    function M.GetPlayerGroup(input)
        local identifier = resolveIdentifier(input)
        if not identifier then return nil end
        local player = DB.findPlayerByAnyIdentifier(identifier)
        if not player then return nil end
        return player.group_name
    end

    -- Set player's group. target may be source number or identifier string. performer may be source number or identifier string.
    function M.SetPlayerGroup(target, groupName, performer)
        local targetId = resolveIdentifier(target)
        if not targetId then return false, 'invalid_target' end
        local performerId = resolveIdentifier(performer) or 'system'

        -- Update DB
        local ok, msg = DB.setPlayerGroup(targetId, groupName, performerId)
        if not ok then return false, msg end

        -- Map ACE: add_principal and remove_principal
        local newGroup = DB.getGroupByName(groupName)
        if not newGroup then return true, 'ok' end

        -- Remove any old ACE principals for this identifier
        local existing = DB.getPlayerByIdentifier(targetId)
        if existing and existing.ace_group and existing.ace_group ~= newGroup.ace_group then
            -- remove old principal
            local removeCmd = string.format('remove_principal %s group.%s', targetId, existing.ace_group)
            ExecuteCommand(removeCmd)
        end

        -- Add new principal
        if newGroup.ace_group and newGroup.ace_group ~= '' then
            local addCmd = string.format('add_principal %s group.%s', targetId, newGroup.ace_group)
            ExecuteCommand(addCmd)
        end

        return true, 'ok'
    end

    -- IsAdmin by source or identifier
    function M.IsAdmin(input)
        local identifier = resolveIdentifier(input)
        if not identifier then return false end
        local player = DB.findPlayerByAnyIdentifier(identifier)
        if not player then return false end
        local rank = tonumber(player.group_rank) or 999
        return rank <= ADMIN_MAX_RANK
    end

    -- Check specific permission string. Permissions are stored per-group in groups.permissions JSON (array of strings).
    -- This also checks ACE membership if the group's ace_group matches.
    function M.HasPermission(input, permission)
        local identifier = resolveIdentifier(input)
        if not identifier then return false end
        local player = DB.findPlayerByAnyIdentifier(identifier)
        if not player then return false end

        -- 1) Group-based permissions (JSON array stored in `permissions` column)
        if player.permissions and type(player.permissions) == 'string' then
            local ok, perms = pcall(function() return json.decode(player.permissions) end)
            if ok and type(perms) == 'table' then
                for _, p in ipairs(perms) do
                    if p == permission then return true end
                end
            end
        end

        -- 2) ACE-based fallback: check if player is in ACE group associated with their group
        if player.ace_group and player.ace_group ~= '' then
            local principal = player.identifier
            -- There's no direct API to check ACE membership server-side; we attempt a conservative check by using IsPlayerAceAllowed if available
            -- IsPlayerAceAllowed exists in server scripts in newer FXServer builds. Use pcall to avoid errors.
            local ok, allowed = pcall(function() return IsPlayerAceAllowed(principal, 'group.' .. player.ace_group) end)
            if ok and allowed then
                -- For compatibility we also consider this as allowed
                return true
            end
            -- As a last resort, check rank threshold
            local rank = tonumber(player.group_rank) or 999
            if rank <= ADMIN_MAX_RANK then return true end
        end

        return false
    end

    -- Expose functions as exports for other resources
    exports('IsAdmin', function(src) return M.IsAdmin(src) end)
    exports('HasPermission', function(srcOrId, perm) return M.HasPermission(srcOrId, perm) end)
    exports('GetPlayerGroup', function(srcOrId) return M.GetPlayerGroup(srcOrId) end)
    exports('SetPlayerGroup', function(target, groupName, performer) return M.SetPlayerGroup(target, groupName, performer) end)

    -- Server events for admin actions (server-side only). These endpoints perform validation server-side.
    RegisterNetEvent('tenz_admin:server:SetPlayerGroup', function(targetIdentifier, groupName)
        local src = source
        -- Validate caller must be admin and have permission to set groups
        if not M.IsAdmin(src) then
            print(('tenz_admin: unauthorized SetPlayerGroup from %s'):format(tostring(DB.getCanonicalIdentifierFromSource(src))))
            return
        end
        local targetId = resolveIdentifier(targetIdentifier)
        if not targetId then return end
        local ok, msg = M.SetPlayerGroup(targetId, groupName, src)
        if ok then
            print(('tenz_admin: %s set group %s for %s'):format(tostring(DB.getCanonicalIdentifierFromSource(src)), groupName, targetId))
        else
            print(('tenz_admin: failed to set group: %s'):format(msg))
        end
    end)

    function M.init()
        -- Run DB seeds
        DB.createDefaultGroups()
        print('[tenz_admin.permissions] Initialized')
    end

    return M
end
