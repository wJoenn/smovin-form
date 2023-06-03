<template>
  <div class="result">
    <img src="../assets/images/smovin.png" alt="smovin logo">

    <div class="content">
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

      <div class="redirect" @click="redirect">New computation</div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { toRefs } from "vue"
  import useIndexStore from "../stores/IndexStore.ts"

  const indexStore = useIndexStore()
  const { newRent, baseRent, currentIndex, baseIndex } = toRefs(indexStore)

  const redirect = () => {
    window.location.reload()
  }
</script>

<style lang="scss" scoped>
  .content {
    align-items: center;
    background-color: $background;
    display: flex;
    flex-direction: column;
    font-size: 20px;
    gap: 50px;
    height: 100%;
    justify-content: center;
    position: relative;
    width: 600px;

    .redirect {
      bottom: 30px;
      color: $blue;
      cursor: pointer;
      filter: brightness(3);
      font-size: 16px;
      position: absolute;
      right: 30px;
    }
  }
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

  .result {
    background-image: url("../assets/images/background.png");
    background-position: right;
    background-size: cover;
    height: 100%;
    position: relative;
    width: 100%;

    img {
      position: absolute;
      right: 30px;
      top: -10px;
      width: 250px;
    }
  }
</style>
