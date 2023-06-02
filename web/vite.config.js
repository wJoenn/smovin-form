import { defineConfig } from "vite"
import vue from "@vitejs/plugin-vue"

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  build: {
    outDir: "../api/public",
    emptyOutDir: true
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: '@import "./src/assets/stylesheets/config/_variables.scss";'
      }
    }
  }
})
