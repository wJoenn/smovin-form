/* eslint-env node */
require("@rushstack/eslint-patch/modern-module-resolution")

module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true
  },
  extends: [
    "airbnb-base",
    "plugin:import/recommended",
    "plugin:vue/vue3-recommended",
    "@vue/eslint-config-typescript"
  ],
  overrides: [
    {
      files: ["*.vue"],
      rules: {
        indent: "off"
      }
    }
  ],
  parserOptions: {
    ecmaVersion: "latest",
    sourceType: "module"
  },
  ignorePatterns: [
    "/*",
    "!/src"
  ],
  rules: {
    "arrow-parens": "off",
    "class-methods-use-this": "off",
    "comma-dangle": "off",
    "max-len": ["error", 120],
    "no-param-reassign": "off",
    "no-plusplus": "off",
    "no-use-before-define": "off",
    "object-curly-newline": "off",
    "prefer-destructuring": "off",
    "quotes": ["error", "double"],
    "semi": "off",

    "vue/script-indent": ["error", 2, { "baseIndent": 1 }],
    "vue/max-attributes-per-line": "off",
    "vue/multi-word-component-names": "off",
    "vue/require-default-prop": "off",
    "vue/singleline-html-element-content-newline": "off"
  }
}
