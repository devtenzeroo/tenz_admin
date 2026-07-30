<template>
  <aside :class="['bg-white dark:bg-slate-800 shadow-lg transition-colors', collapsed ? 'w-20' : 'w-64']" class="h-screen overflow-hidden">
    <div class="p-4 flex items-center gap-3">
      <img src="/assets/logo.svg" alt="logo" class="w-8 h-8" />
      <h1 v-if="!collapsed" class="font-semibold text-lg text-slate-900 dark:text-slate-100">tenz_admin</h1>
    </div>
    <nav class="mt-4">
      <ul>
        <li v-for="item in items" :key="item.name">
          <router-link :to="item.route" class="flex items-center gap-3 p-3 mx-2 rounded-md hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors">
            <span class="w-6 h-6 bg-primary rounded-sm flex items-center justify-center text-white text-xs">T</span>
            <span v-if="!collapsed" class="font-medium">{{ item.name }}</span>
          </router-link>
        </li>
      </ul>
    </nav>
    <div class="mt-auto p-4">
      <button @click="collapsed = !collapsed" class="w-full py-2 px-3 rounded-md bg-slate-50 dark:bg-slate-700 hover:opacity-90 transition">
        <span v-if="!collapsed">Collapse</span>
        <span v-else>Open</span>
      </button>
    </div>
  </aside>
</template>

<script setup>
import { ref, toRefs } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps({
  items: { type: Array, default: () => [] },
  modelValue: { type: Boolean, default: false },
})

const emit = defineEmits(['update:collapsed'])

const collapsed = ref(props.modelValue)

watch(collapsed, (v) => emit('update:collapsed', v))
</script>

<style scoped>
aside { width: 16rem; }
</style>
