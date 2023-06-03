import { computed, ref } from "vue"
import { defineStore } from "pinia"
import axios from "axios"

import BodyRequest from "../types/BodyRequest.ts"

interface ErrorResponse {
  start_date?: string[]
  signed_on?: string[]
  base_rent?: string[]
  region?: string[]
}

const API_URL = import.meta.env.VITE_API_URL

const useIndexStore = defineStore("IndexStore", () => {
  const newRent = ref(0)
  const baseRent = ref(0)
  const currentIndex = ref(0)
  const baseIndex = ref(0)
  const errors = ref<ErrorResponse>({})

  const getErrors = computed(() => errors.value)
  const hasNewRent = computed(() => newRent.value > 0)

  const getNewRent = async (body: BodyRequest) => {
    try {
      const res = await axios.post(`${API_URL}/v1/indexations`, body)
      const data = res.data

      newRent.value = data.new_rent
      baseRent.value = body.base_rent
      currentIndex.value = data.current_index
      baseIndex.value = data.base_index
    } catch (err: any) {
      errors.value = err.response.data
    }
  }

  return { newRent, baseRent, currentIndex, baseIndex, errors, getErrors, hasNewRent, getNewRent }
})

export default useIndexStore
