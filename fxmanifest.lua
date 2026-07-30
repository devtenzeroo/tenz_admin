fx_version 'cerulean'

-- Resource metadata
-- name: tenz_admin
-- description: Production-quality FiveM admin resource (foundation only)

author 'devtenzeroo'
url 'https://github.com/devtenzeroo/tenz_admin'
version '0.1.0'

-- Use Lua 5.4
lua54 'yes'

-- This resource depends on QBCore, oxmysql and ox_lib
-- We declare them as dependencies so the server will warn if missing.
dependency 'qb-core'
dependency 'oxmysql'
dependency 'ox_lib'

-- Shared files loaded on both client and server
shared_scripts {
    'shared/*.lua',
}

-- Client-side scripts
client_scripts {
    'client/init.lua',
    'client/modules/*.lua',
}

-- Server-side scripts
server_scripts {
    'server/init.lua',
    'server/modules/*.lua',
    'config/*.lua',
}

-- NUI (UI) configuration - this points to the built UI's index.html
ui_page 'ui/dist/index.html'

-- Files to be included in resource (UI build output will be placed under ui/dist/)
files {
    'ui/dist/**',
    'locales/**',
    'assets/**',
}

-- Exported functions/events can be added later in modules

-- Notes:
-- - We only provide the project foundation and placeholders. Gameplay/admin features are NOT implemented here.
-- - The UI folder contains a Vue 3 + Vite scaffold for NUI; build output should be placed into ui/dist before starting the server.
