import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import './index.css'

const app = createApp(App)
app.use(router)
app.mount('#app')

// NUI specific: ensure dark class is set based on localStorage preference
const prefersDark = localStorage.getItem('tenz_admin_dark')
if (prefersDark === 'true') {
  document.documentElement.classList.add('dark')
}
