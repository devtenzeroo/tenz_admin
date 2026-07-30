<template>
  <div class="space-y-4">
    <h1 class="text-2xl font-semibold">World</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <Card>
        <h3 class="text-lg font-medium">Weather & Time</h3>
        <p class="mt-2 text-sm text-slate-500">Adjust server weather/time settings.</p>
      </Card>
      <Card>
        <h3 class="text-lg font-medium">World Events</h3>
        <p class="mt-2 text-sm text-slate-500">Active world events and schedules.</p>
      </Card>
    </div>
  </div>
</template>

<script setup>
import Card from '@/src/components/Card.vue'
</script>
