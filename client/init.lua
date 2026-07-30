-- Client entry for tenz_admin
-- Purpose: bootstrap client-side modules and event listeners.
-- NOTE: This file is a placeholder. Do NOT implement gameplay features here.

-- Use local references to avoid polluting _G
local QBCore

-- Initialize: wait for QBCore object
CreateThread(function()
    -- Acquire QBCore from exports (supports both export and global patterns)
    if GlobalState and GlobalState.QBCore then
        QBCore = GlobalState.QBCore
    else
        -- Try export
        local ok, qb = pcall(function() return exports['qb-core']:GetCoreObject() end)
        if ok then QBCore = qb end
    end

    -- If QBCore is not found, log a warning — server scripts may still function
    if not QBCore then
        print("[tenz_admin] WARNING: QBCore object not found. Ensure qb-core is started before tenz_admin.")
    end

    -- Load client modules here (modules are intentionally empty placeholders)
    -- Example: exports, event subscriptions, keybinds and lightweight loop registration
    -- Keep heavy work off the main thread; use event-driven design.
end)
