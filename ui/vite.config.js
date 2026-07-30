import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

// Vite config for NUI frontend
export default defineConfig({
  plugins: [vue()],
  base: './', // Ensure relative paths (important for NUI file loading)
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  build: {
    outDir: '../dist',
    emptyOutDir: true,
  }
})
