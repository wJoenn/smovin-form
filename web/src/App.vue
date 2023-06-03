<template>
  <Result v-if="indexStore.hasNewRent" />
  <Form v-else />
</template>

<script setup lang="ts">
  import Result from "./components/Result.vue"
  import Form from "./components/Form.vue"
  import useIndexStore from "./stores/IndexStore.ts"

  const indexStore = useIndexStore()
</script>

<style lang="scss">
  #app {
    align-items: center;
    display: flex;
    height: 100%;
    justify-content: center;
    width: 100%;
  }

  .frame {
    align-items: center;
    border: 2px solid #d3d3d333;
    display: flex;
    flex-direction: column;
    gap: 50px;
    padding: 20px 0 50px;
  }
</style>
