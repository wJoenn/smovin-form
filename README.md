# smovin-form
<p align="center">
  <img src="https://github.com/wJoenn/smovin-form/assets/75388869/e71647e7-5300-4e29-80b1-f50faa23f373" alt="smovin logo">
</p>

This repo serves as a solution for a technical interview test at [Smovin](https://www.smovin.app/).

It includes a simple client app made with Vue.js to fetch an api made with ruby Sinatra and display a calculated new rent price depending on the current and initial index in Belgium.
The frontend client is deployed on Netlify and can be accessed on https://smovin-form.netlify.app/ and has a continuous deployment system enabled to redeploy the `web` subdirectory on pushes to master.
The API is deployed on Heroku with a single endpoint on POST https://smovin-form-api.herokuapp.com/v1/indexations which can be testes on web.postman.co<br/>
An `ENV VITE_API_URL=http://localhost:4567` (for development) has been setup to dynamically use the deployed api in production or the dev server in development

Finally to ensure good styling and successful testing before pushing code to github or heroku a pre-push git hook is enabled with the following code
```
#!/bin/bash

# Run tests before pushing
echo -e "\nRunning esLint..."
echo "###############################"
yarn lint
if [ $? -ne 0 ]; then
  echo -e "\e[31m\nFAILURE: Your esLint tests have failed\e[0m"
  exit 1
else
  echo -e "\e[32m\nSUCCESS: Your esLint tests were successful\e[0m"
fi

echo -e "\nRunning Typescript..."
echo "###############################"
yarn type-check
if [ $? -ne 0 ]; then
  echo -e "\e[31m\nFAILURE: Your Typescript tests have failed\e[0m"
  exit 1
else
  echo -e "\e[32m\nSUCCESS: Your Typescript tests were successful\e[0m"
fi

echo -e "\nRunning Rubocop..."
echo "###############################"
yarn rubocop
if [ $? -ne 0 ]; then
  echo -e "\e[31m\nFAILURE: Your Rubocop tests have failed\e[0m"
  exit 1
else
  echo -e "\e[32m\nSUCCESS: Your Rubocop tests were successful\e[0m"
fi

echo -e "\nRunning RSpec
echo "###############################"
yarn rspec
if [ $? -ne 0 ]; then
  echo -e "\e[31m\nFAILURE: Your RSpec tests have failed\e[0m"
  exit 1
else
  echo -e "\e[32m\nSUCCESS: Your RSpec tests were successful\e[0m"
fi

echo -e "\e[32m\nAll your tests were successful\e[0m"
exit 0
```

## Installation
```
git clone git@github.com:wJoenn/smovin-form.git
cd smovin-form
yarn bundle
yarn vite:install
```
You then need to create a `web/.env` file and paste the following variable `ENV VITE_API_URL=http://localhost:4567`<br/>
Finally run `dev` to run the development server
