<template>
  <div class="space-y-4">
    <h1 class="text-2xl font-semibold">Staff</h1>
    <div class="p-4 bg-white dark:bg-slate-800 rounded-lg shadow-card">
      <table class="w-full text-left text-sm">
        <thead class="text-slate-500">
          <tr>
            <th class="p-2">Name</th>
            <th class="p-2">Group</th>
            <th class="p-2">Status</th>
            <th class="p-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in 6" :key="i" class="hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors">
            <td class="p-2">Staff {{ i }}</td>
            <td class="p-2">SeniorAdmin</td>
            <td class="p-2">Online</td>
            <td class="p-2"><button class="px-2 py-1 rounded bg-slate-100 dark:bg-slate-700">Message</button></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
</script>
