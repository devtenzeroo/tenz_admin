<template>
  <div class="space-y-4">
    <div class="flex items-center justify-between">
      <h1 class="text-2xl font-semibold">Players</h1>
      <div class="flex items-center gap-2">
        <input placeholder="Filter by name, id..." class="px-3 py-2 rounded-md bg-slate-50 dark:bg-slate-700 outline-none" />
        <button class="px-3 py-2 bg-primary text-white rounded-md">Search</button>
      </div>
    </div>

    <div class="bg-white dark:bg-slate-800 p-4 rounded-lg shadow-card">
      <table class="w-full text-left text-sm">
        <thead class="text-slate-500">
          <tr>
            <th class="p-2">Name</th>
            <th class="p-2">Identifier</th>
            <th class="p-2">Group</th>
            <th class="p-2">Ping</th>
            <th class="p-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="i in 8" :key="i" class="hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors">
            <td class="p-2">Player {{ i }}</td>
            <td class="p-2">license:xxxx{{ i }}</td>
            <td class="p-2">Admin</td>
            <td class="p-2">{{ 50 + i }}</td>
            <td class="p-2"><button class="px-2 py-1 rounded bg-slate-100 dark:bg-slate-700">Manage</button></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
</script>
