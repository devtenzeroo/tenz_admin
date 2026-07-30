<template>
  <div class="space-y-6">
    <div class="flex items-center justify-between">
      <h2 class="text-xl font-semibold">Overview</h2>
      <div class="text-sm text-slate-400">Updated: just now</div>
    </div>

    <StatGrid />

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">
      <Card>
        <h3 class="text-lg font-medium">Recent Reports</h3>
        <ul class="mt-3 space-y-2 text-sm text-slate-500">
          <li v-for="i in 5" :key="i" class="p-2 rounded-md hover:bg-slate-50 dark:hover:bg-slate-700 transition">Report #{{i}} - Player X</li>
        </ul>
      </Card>

      <Card>
        <h3 class="text-lg font-medium">World Status</h3>
        <p class="mt-2 text-sm text-slate-500">Server time, weather, neighborhood events coming soon.</p>
      </Card>

      <Card>
        <h3 class="text-lg font-medium">Staff Activity</h3>
        <p class="mt-2 text-sm text-slate-500">Recent staff logs and actions will appear here.</p>
      </Card>
    </div>
  </div>
</template>

<script setup>
import StatGrid from '@/src/components/StatGrid.vue'
import Card from '@/src/components/Card.vue'
</script>
