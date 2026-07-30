# tenz_admin

A production-quality foundation for a FiveM admin resource built for QBCore.

This repository contains only the project foundation and scaffolding — no gameplay/admin features are implemented yet. The layout and modules are designed to be modular, event-driven, and optimized for servers with high player counts (200+).

Key choices and constraints:
- Framework: QBCore (latest), oxmysql, ox_lib
- Lua 5.4
- NUI: Vue 3 + Vite + TailwindCSS (frontend build artefacts live under ui/dist)
- No NodeJS backend or WebSocket backend
- No license system or external dependencies except Discord webhooks

Folder structure (top-level):
- client/       -- client-side Lua entry & modules
- server/       -- server-side Lua entry & modules
- shared/       -- shared utilities and constants
- config/       -- configuration files
- sql/          -- SQL schema & migration files
- ui/           -- Vue 3 + Vite NUI source (build to ui/dist)
- docs/         -- design docs, architecture, contribution
- locales/      -- localization files (JSON)
- assets/       -- images and other static assets

Files included in this scaffold:
- fxmanifest.lua
- README.md
- LICENSE (MIT)
- .gitignore
- Placeholders and READMEs in each directory explaining purpose

How to use:
1. Build the UI: cd ui && npm install && npm run build (this produces ui/dist)
2. Place the resource folder on your FiveM server resources directory
3. Ensure qb-core, oxmysql and ox_lib are available and configured
4. Start the server and the resource

Notes:
- This scaffold intentionally does NOT implement gameplay features. Implement features as modular modules under client/modules and server/modules.
- Keep performance, security, and scalability in mind when adding commands and features.

