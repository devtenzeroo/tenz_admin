Permissions system for tenz_admin

Overview
- Server-side permission system using groups + ACE integration + database-backed player group assignments.
- Permissions are validated on the server only.
- Uses oxmysql for persistent storage.

Key concepts
- Groups: defined in `tenz_admin_groups`. Each group has a `rank` (lower = more authority), optional JSON `permissions` array, and an `ace_group` name used to add ACE principals.
- Players: mappings between a canonical identifier (e.g., license:..., steam:..., discord:...) and a group stored in `tenz_admin_players`.
- Audit logs: operations tracked in `tenz_admin_audit`.

API (server exports)
- IsAdmin(sourceOrIdentifier) -> boolean
    Returns true if the player's group rank is within the admin threshold (Founder..Admin by default).

- HasPermission(sourceOrIdentifier, permission) -> boolean
    Returns true if the player's group's permissions JSON contains `permission`, or if ACE membership/rank implies the permission.

- GetPlayerGroup(sourceOrIdentifier) -> string | nil
    Returns the group name assigned to the player.

- SetPlayerGroup(target, groupName, performer) -> (bool, message)
    Sets the player's group. `target` and `performer` can be server sources or identifier strings. This performs DB update, ACE principal updates, and writes to the audit table.

Database
- SQL migration file at sql/migrations/001_create_permissions_tables.sql creates three tables: tenz_admin_groups, tenz_admin_players and tenz_admin_audit.
- Seed groups are created automatically on resource start by the permissions module.

Usage examples
- From server Lua:
    local isAdmin = exports['tenz_admin']:IsAdmin(source)
    local hasPerm = exports['tenz_admin']:HasPermission(source, 'kick_player')
    local group = exports['tenz_admin']:GetPlayerGroup('license:abcd1234')
    local ok, msg = exports['tenz_admin']:SetPlayerGroup('steam:1100001abcdef', 'Admin', 'license:owner123')

Security notes
- All permission checks are performed server-side. Do not rely on any client-side assertions.
- Keep real webhooks and secrets out of version control.

