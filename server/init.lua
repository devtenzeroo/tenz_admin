-- Server entry for tenz_admin
-- Purpose: bootstrap server-side modules, exports and database initialization.
-- NOTE: This file is a placeholder. Do NOT implement gameplay features yet.

local QBCore = exports['qb-core']:GetCoreObject()
local oxmysql = exports['oxmysql']

-- Simple startup routine: initialize DB schema or migrations if needed
-- Keep startup fast; heavy migrations should run manually or as an admin task

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    print('[tenz_admin] Resource started. Server scaffolding initialized.')
    -- Example: verify DB connection (do not perform heavy queries here)
    -- oxmysql:execute('SELECT 1', {}, function(result) print('[tenz_admin] oxmysql available') end)
end)

-- Load server modules (placeholders)

