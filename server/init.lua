-- Server init: bootstrap modules for tenz_admin
-- Purpose: load and wire server-side modules in a deterministic order

local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    print('[tenz_admin] Resource started. Server scaffolding initialized.')
end)

-- Load DB helper first
local permissions_db = dofile('server/modules/permissions_db.lua')
-- Load permissions core and pass DB helper to it
local permissions_core_factory = dofile('server/modules/permissions.lua')
local Permissions = permissions_core_factory(permissions_db)
Permissions.init()

print('[tenz_admin] Server modules loaded')
