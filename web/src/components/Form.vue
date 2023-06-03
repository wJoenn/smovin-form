<template>
  <div class="container">
    <div class="header">
      <img src="../assets/images/smovin.png" alt="smovin logo">
      <a href="https://www.smovin.app/">Back to website <fai icon="fa-solid fa-arrow-right" /></a>
    </div>

    <div class="form">
      <h1>Rent Indexation</h1>
      <form @submit.prevent="handleSubmit">
        <div class="row">
          <div class="field">
            <label for="start_date">Contract start date</label>
            <!-- eslint-disable-next-line max-len -->
            <input v-model="startDate" type="date" name="start_date" :class="{ error: errors['start_date'] }" @input="handleInput">
            <div v-if="errors['start_date']" class="errors">
              <span v-for="error in errors['start_date']" :key="error" class="error">
                <fai icon="fa-solid fa-circle-exclamation" />{{ error }}
              </span>
            </div>
          </div>

          <div class="field">
            <label for="signed_on">Contract signed on</label>
            <!-- eslint-disable-next-line max-len -->
            <input v-model="signedOn" type="date" name="signed_on" :class="{ error: errors['signed_on'] }" @input="handleInput">
            <div v-if="errors['signed_on']" class="errors">
              <span v-for="error in errors['signed_on']" :key="error" class="error">
                <fai icon="fa-solid fa-circle-exclamation" />{{ error }}
              </span>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="field">
            <label for="base_rent">Base rent</label>
            <!-- eslint-disable-next-line max-len -->
            <input v-model="baseRent" type="number" name="base_rent" :class="{ error: errors['base_rent'] }" @input="handleInput">
            <div v-if="errors['base_rent']" class="errors">
              <span v-for="error in errors['base_rent']" :key="error" class="error">
                <fai icon="fa-solid fa-circle-exclamation" />{{ error }}
              </span>
            </div>
          </div>

          <div class="field">
            <label for="region">Region</label>
            <div class="region-buttons">
              <span :class="{active: region === 'brussels'}" @click="handleClick('brussels')">Brussels</span>
              <span :class="{active: region === 'flanders'}" @click="handleClick('flanders')">Flanders</span>
              <span :class="{active: region === 'wallonia'}" @click="handleClick('wallonia')">Wallonia</span>
            </div>
            <div v-if="errors['region']" class="errors">
              <span v-for="error in errors['region']" :key="error" class="error">
                <fai icon="fa-solid fa-circle-exclamation" />{{ error }}
              </span>
            </div>
          </div>
        </div>

        <button>Compute index rent</button>
      </form>
    </div>

    <div class="footer" />
  </div>
</template>

<script setup lang="ts">
  import { computed, ref } from "vue"

  import validateInputs from "../composables/validateInputs.ts"
  import useIndexStore from "../stores/IndexStore.ts"
  import BodyRequest from "../types/BodyRequest.ts"

  const indexStore = useIndexStore()
  const validation = validateInputs()

  const startDate = ref("")
  const signedOn = ref("")
  const baseRent = ref(0)
  const region = ref("")

  const errors = computed(() => indexStore.getErrors)

  const handleClick = (input: string) => {
    region.value = input
    indexStore.removeError("region")
  }

  const handleInput = (event: Event) => {
    const target = event.target as HTMLInputElement
    const key = target.name
    const hasError = errors.value[key as keyof typeof errors.value] !== undefined
    if (hasError) validation.proceed(target)
  }

  const handleSubmit = async () => {
    const body: BodyRequest = {
      start_date: startDate.value,
      signed_on: signedOn.value,
      base_rent: baseRent.value,
      region: region.value
    }

    await indexStore.getNewRent(body)
  }
</script>

<style lang="scss" scoped>
  form {
    display: flex;
    flex-direction: column;
    font-size: 14px;
    gap: 30px;

    button {
      background-color: $blue;
      border: none;
      border-radius: 5px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
      color: inherit;
      cursor: pointer;
      font: inherit;
      font-weight: 600;
      padding: 1rem;
    }

    input {
      background-color: transparent;
      border: 1px solid #d3d3d333;
      border-radius: 5px;
      color: inherit;
      font: inherit;
      padding: $padding;
      transition: border-color 0.3s ease;

      &.error {
        animation: glitch 0.1s linear;
        background-color: #3b0012;
        border-color: rgba(255, 0, 0, 0.5);

        &:focus {
          border-color: rgba(255, 0, 0, 0.5);
        }
      }

      &:focus {
        border-color: $blue;
        outline: none;
      }
    }

    span.error {
      color: rgb(212, 46, 46);
      display: flex;
      font-size: 0.9em;
      gap: 10px;
    }

    .field {
      display: flex;
      flex-direction: column;
      flex-grow: 1;
      gap: 10px;
    }

    .region-buttons {
      border: 1px solid #d3d3d333;
      border-radius: 5px;

      span {
        background-color: transparent;
        border-right: 1px solid #d3d3d333;
        cursor: pointer;
        display: inline-block;
        padding: 0.75rem 1.5rem;

        &.active {
          background-color: $blue;
        }

        &:last-child {
          border: none;
        }
      }
    }

    .row {
      display: flex;
      gap: 20px;
    }
  }

  .footer {
    height: 130px;
  }

  .form {
    align-items: center;
    display: flex;
    flex-direction: column;
    gap: 50px;
    margin: 0 auto;
    width: 800px;
  }

  .header {
    align-items: center;
    display: flex;
    height: 130px;
    justify-content: space-between;

    a {
      align-items: center;
      color: $blue;
      display: flex;
      filter: brightness(2.5);
      gap: 10px;

      i {
        font-size: 0.8rem;
      }
    }

    img {
      width: 250px;
    }
  }
</style>
