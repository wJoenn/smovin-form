<template>
  <div class="container">
    <Form />
  </div>
</template>

<script setup>
  import Form from "./components/Form.vue"
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
