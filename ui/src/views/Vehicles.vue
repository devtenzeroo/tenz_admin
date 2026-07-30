<template>
  <div class="space-y-4">
    <h1 class="text-2xl font-semibold">Vehicles</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <Card>
        <h3 class="text-lg font-medium">Vehicle List</h3>
        <p class="mt-2 text-sm text-slate-500">List of tracked vehicles.</p>
      </Card>
      <Card>
        <h3 class="text-lg font-medium">Spawned Vehicles</h3>
        <p class="mt-2 text-sm text-slate-500">Statistics and controls for despawn/spawn.</p>
      </Card>
    </div>
  </div>
</template>

<script setup>
import Card from '@/src/components/Card.vue'
</script>
