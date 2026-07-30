# UI README

This folder contains a Vue 3 + Vite project used as the NUI for tenz_admin.

Build steps (on your development machine):
1. cd ui
2. npm install
3. npm run build

The build will output files into ui/dist which the FiveM resource serves as its NUI.

Design notes:
- TailwindCSS is configured with class-based dark mode (toggle stored in localStorage as `tenz_admin_dark`).
- The UI is responsive and includes a sidebar, top navigation, cards, and pages for Dashboard, Players, Reports, Vehicles, World, Staff, and Settings.
- No NodeJS backend is required — the UI interacts with the game via the standard NUI postMessage / SendReactMessage patterns which you can wire up in the client scripts.
