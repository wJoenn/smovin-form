import useIndexStore from "../stores/IndexStore.ts"

const validateInputs = () => {
  const indexStore = useIndexStore()

  const proceed = (element: HTMLInputElement) => {
    switch (element.name) {
      case "start_date":
        if (validateDateOf(element.value)) {
          element.classList.remove("error")
          indexStore.removeError(element.name)
        }
        break
      case "signed_on":
        if (validateDateOf(element.value) && validateIndexabilityOf(element.value)) {
          element.classList.remove("error")
          indexStore.removeError(element.name)
        }
        break
      case "base_rent":
        if (validatePositivenessOf(element.value)) {
          element.classList.remove("error")
          indexStore.removeError(element.name)
        }
        break
      default:
        break
    }
  }

  const calculateYear = (stringDate: string) => {
    const date = new Date(stringDate)
    const baseDate = new Date(date.getFullYear(), date.getMonth() - 1, date.getDay())

    return baseDate.getFullYear()
  }

  const validateDateOf = (date: string) => new Date(date) < new Date()

  const validateIndexabilityOf = (date: string) => calculateYear(date) >= 1994

  const validatePositivenessOf = (baseRent: string) => +baseRent > 0

  return { proceed }
}

export default validateInputs
