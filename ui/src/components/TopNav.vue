<template>
  <header class="flex items-center justify-between p-4 border-b bg-white dark:bg-slate-800 transition-colors">
    <div class="flex items-center gap-3">
      <button @click="$emit('toggleSidebar')" class="p-2 rounded-md hover:bg-slate-100 dark:hover:bg-slate-700">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>
      <div class="hidden md:block text-sm text-slate-500">Welcome, Admin</div>
    </div>

    <div class="flex items-center gap-3">
      <div class="hidden sm:flex items-center bg-slate-100 dark:bg-slate-700 rounded-md px-3 py-1 gap-2">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-500" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M8 4a4 4 0 104 4H8V4z" clip-rule="evenodd" />
        </svg>
        <input placeholder="Search players, ids..." class="bg-transparent outline-none text-sm w-40" />
      </div>

      <button @click="$emit('toggleDark')" class="p-2 rounded-md hover:bg-slate-100 dark:hover:bg-slate-700">
        <svg v-if="!isDark" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m8-9h1M3 12H2m15.364-6.364l.707.707M6.343 17.657l-.707.707m12.728 0l-.707-.707M6.343 6.343l-.707-.707" />
        </svg>
        <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
          <path d="M17.293 13.293A8 8 0 116.707 2.707a8 8 0 0010.586 10.586z" />
        </svg>
      </button>

      <div class="flex items-center gap-2">
        <img src="/assets/avatar.png" alt="avatar" class="w-8 h-8 rounded-full" />
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref } from 'vue'
const isDark = ref(document.documentElement.classList.contains('dark'))

// Update reactive value when user toggles dark; listen to storage events
window.addEventListener('storage', (e) => {
  if (e.key === 'tenz_admin_dark') {
    isDark.value = e.newValue === 'true'
  }
})
</script>

<style scoped>
header { height: 64px; }
</style>
