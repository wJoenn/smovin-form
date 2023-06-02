import { createApp } from "vue"

import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome"
import { library } from "@fortawesome/fontawesome-svg-core"
import { faCircleExclamation } from "@fortawesome/free-solid-svg-icons"

import App from "./App.vue"
import "./assets/stylesheets/application.scss"

const app = createApp(App)

library.add(faCircleExclamation)

app.component("fai", FontAwesomeIcon).mount("#app") // eslint-disable-line vue/component-definition-name-casing
