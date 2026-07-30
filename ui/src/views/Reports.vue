<template>
  <div class="space-y-4">
    <h1 class="text-2xl font-semibold">Reports</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <Card>
        <h3 class="text-lg font-medium">Open Reports</h3>
        <ul class="mt-3 space-y-2 text-sm text-slate-500">
          <li v-for="i in 6" :key="i" class="p-2 rounded-md hover:bg-slate-50 dark:hover:bg-slate-700 transition">Report #{{i}} - Issue description...</li>
        </ul>
      </Card>
      <Card>
        <h3 class="text-lg font-medium">Closed Reports</h3>
        <p class="mt-2 text-sm text-slate-500">Summary and statistics.</p>
      </Card>
    </div>
  </div>
</template>

<script setup>
import Card from '@/src/components/Card.vue'
</script>
