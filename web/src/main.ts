import { createApp } from "vue"
import { createPinia } from "pinia"

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"
import { library } from "@fortawesome/fontawesome-svg-core"
import { faArrowRight, faCircleExclamation, faXmark } from "@fortawesome/free-solid-svg-icons"

import App from "./App.vue"
import "./assets/stylesheets/application.scss"

const app = createApp(App)
const pinia = createPinia()

library.add(faArrowRight, faCircleExclamation, faXmark)

app
  .component("fai", FontAwesomeIcon) // eslint-disable-line vue/component-definition-name-casing
  .use(pinia)
  .mount("#app")
