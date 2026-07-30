<template>
  <div class="p-4 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
    <div class="p-4 rounded-lg bg-white dark:bg-slate-800 shadow-card transition-colors">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-xs text-slate-400">Active Players</div>
          <div class="text-2xl font-semibold">{{active}}</div>
        </div>
        <div class="text-green-500 text-lg">+5%</div>
      </div>
    </div>

    <div class="p-4 rounded-lg bg-white dark:bg-slate-800 shadow-card transition-colors">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-xs text-slate-400">Reports</div>
          <div class="text-2xl font-semibold">{{reports}}</div>
        </div>
        <div class="text-blue-500 text-lg">{{openReports}}</div>
      </div>
    </div>

    <div class="p-4 rounded-lg bg-white dark:bg-slate-800 shadow-card transition-colors">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-xs text-slate-400">Vehicles</div>
          <div class="text-2xl font-semibold">{{vehicles}}</div>
        </div>
        <div class="text-indigo-500 text-lg">{{parked}}</div>
      </div>
    </div>

    <div class="p-4 rounded-lg bg-white dark:bg-slate-800 shadow-card transition-colors">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-xs text-slate-400">Staff Online</div>
          <div class="text-2xl font-semibold">{{staff}}</div>
        </div>
        <div class="text-yellow-500 text-lg">{{onDuty}}</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
const active = ref(128)
const reports = ref(43)
const vehicles = ref(812)
const staff = ref(12)
const openReports = ref(6)
const parked = ref('512')
const onDuty = ref(8)

onMounted(() => {
  // Placeholder: fetch metrics from server via NUI RPC later
})
</script>
