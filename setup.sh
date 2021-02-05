#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt-get purge --auto-remove nodejs -y
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install jq -y 
sudo apt install moreutils -y
mkdir -p project/dist/ && mkdir project/src/
cd project/dist/ && touch index.html style.css
cd ../src/ && touch style.css
cd ../ && npm init -y
npm install tailwindcss@latest postcss@latest autoprefixer@latest && npx tailwindcss init
jq '.scripts.test = "tailwind build src/style.css -o dist/style.css"' package.json|sponge package.json
sed -i s/test/build:css/g package.json
printf '@tailwind base;\n@tailwind components;\n@tailwind utilities;' >> src/style.css
npm run build:css
touch .gitignore && echo "node_modules/" >> .gitignore && git rm -r --cached node_modules ; git status










