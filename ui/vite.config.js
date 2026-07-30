import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// Vite config for NUI frontend
export default defineConfig({
  plugins: [vue()],
  base: './', // Ensure relative paths (important for NUI file loading)
  build: {
    outDir: '../dist',
    emptyOutDir: true,
  }
})
