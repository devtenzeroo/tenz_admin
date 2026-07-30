<template>
  <div class="min-h-screen flex">
    <Sidebar :items="menuItems" v-model:collapsed="collapsed" />
    <div class="flex-1 flex flex-col">
      <TopNav @toggleDark="toggleDark" @toggleSidebar="toggleSidebar" />
      <main class="p-6">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import Sidebar from './components/Sidebar.vue'
import TopNav from './components/TopNav.vue'

const collapsed = ref(false)

const menuItems = [
  { name: 'Dashboard', route: '/' },
  { name: 'Players', route: '/players' },
  { name: 'Reports', route: '/reports' },
  { name: 'Vehicles', route: '/vehicles' },
  { name: 'World', route: '/world' },
  { name: 'Staff', route: '/staff' },
  { name: 'Settings', route: '/settings' },
]

function toggleSidebar() {
  collapsed.value = !collapsed.value
}

function toggleDark() {
  const isDark = document.documentElement.classList.toggle('dark')
  localStorage.setItem('tenz_admin_dark', isDark ? 'true' : 'false')
}
</script>

<style scoped>
/* Top-level layout styles */
</style>
