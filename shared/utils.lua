-- Shared utilities and constants
-- Purpose: provide small shared helper functions and definitions used by both client and server

local Shared = {}

-- Example: centralized event names to avoid typos
Shared.Events = {
    EXAMPLE = 'tenz_admin:example',
}

-- Utility: safe print wrapper (togglable logging)
Shared.config = {
    debug = true,
}

function Shared.log(fmt, ...)
    if Shared.config.debug then
        print(('[tenz_admin] %s'):format(fmt:format(...)))
    end
end

return Shared
