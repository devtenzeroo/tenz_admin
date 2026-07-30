-- Configuration for tenz_admin
-- Purpose: central place for configurable options and toggles. Keep secrets out of version control.

local Config = {}

-- General
Config.Locale = 'en'
Config.DiscordWebhook = '' -- OPTIONAL: webhook URL for audit logs; leave empty to disable

-- Performance / limits
Config.MaxPlayersToSync = 300 -- internal planning value, do not exceed server limits

-- Add more toggles here (keybinds, default UI positions, dev flags).

return Config
