# Architecture & Design

This document explains the high-level architecture for the tenz_admin resource foundation.

Key principles
- Modular: client and server features live in modules under client/modules and server/modules
- Event-driven: use QBCore events, custom events, and lightweight threads for scheduled work
- Clean code: single responsibility per module, centralized configuration via config/
- Scalable: keep per-player state minimal on server; use batched queries and throttling where required

Folders
- client/: client-side modules, UI interactions and local caching
- server/: server-side modules, database interactions, validation, and audit logging
- shared/: shared utilities, constants and helper functions used both sides
- config/: central config and secret placeholders
- ui/: Vue 3 + Vite source for the NUI frontend (build to ui/dist)
- sql/: schema and migrations
- locales/: JSON translation files
- assets/: images and static files

Performance guidance
- Avoid global, frequent server->client broadcasts. Use targeted events.
- Cache frequently-read data in memory (with expirations) rather than constantly hitting the DB.
- When adding admin features that affect many players, implement rate-limiting and deferred processing.

Security guidance
- Validate all server-side requests; never trust client-provided identifiers for privileged actions.
- Keep an audit log for admin actions; consider async DB insertion to avoid blocking critical paths.

