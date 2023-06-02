<template>
  <div class="frame">
    <h1>Rent Indexation Result</h1>
    <h3>Your index rent amounts {{ newRent }} €</h3>

    <div class="formulae">
      <div class="up">
        <span>Base rent ({{ baseRent }} €)</span>
        <fai icon="fa-solid fa-xmark" />
        <span>Current index ({{ currentIndex }})</span>
      </div>

      <div class="down">
        <span>Base Index ({{ baseIndex }})</span>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { toRefs } from "vue"
  import useIndexStore from "../stores/IndexStore"

  const indexStore = useIndexStore()
  const { newRent, baseRent, currentIndex, baseIndex } = toRefs(indexStore)
</script>

<style lang="scss" scoped>
  .formulae {
    align-items: center;
    display: flex;
    flex-direction: column;

    div {
      padding: 10px;
    }
    .up {
      border-bottom: 1px solid #d3d3d333;
      display: flex;
      gap: 30px;
    }
  }
</style>
