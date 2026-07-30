import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '@/views/Dashboard.vue'
import Players from '@/views/Players.vue'
import Reports from '@/views/Reports.vue'
import Vehicles from '@/views/Vehicles.vue'
import World from '@/views/World.vue'
import Staff from '@/views/Staff.vue'
import Settings from '@/views/Settings.vue'

const routes = [
  { path: '/', component: Dashboard, name: 'Dashboard' },
  { path: '/players', component: Players, name: 'Players' },
  { path: '/reports', component: Reports, name: 'Reports' },
  { path: '/vehicles', component: Vehicles, name: 'Vehicles' },
  { path: '/world', component: World, name: 'World' },
  { path: '/staff', component: Staff, name: 'Staff' },
  { path: '/settings', component: Settings, name: 'Settings' },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
