<template>
  <div class="space-y-4">
    <h1 class="text-2xl font-semibold">Settings</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <Card>
        <h3 class="text-lg font-medium">General</h3>
        <div class="mt-3 space-y-2 text-sm text-slate-500">
          <div class="flex items-center justify-between">
            <div>Dark Mode</div>
            <input type="checkbox" v-model="dark" class="w-5 h-5" />
          </div>
          <div class="flex items-center justify-between">
            <div>Enable Audit Logs</div>
            <input type="checkbox" v-model="audit" class="w-5 h-5" />
          </div>
        </div>
      </Card>

      <Card>
        <h3 class="text-lg font-medium">Server</h3>
        <p class="mt-2 text-sm text-slate-500">Settings related to server integration and webhooks.</p>
      </Card>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'
import Card from '@/src/components/Card.vue'

const dark = ref(document.documentElement.classList.contains('dark'))
const audit = ref(true)

watch(dark, (v) => {
  if (v) document.documentElement.classList.add('dark')
  else document.documentElement.classList.remove('dark')
  localStorage.setItem('tenz_admin_dark', v ? 'true' : 'false')
})
</script>
