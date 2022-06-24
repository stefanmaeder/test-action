#!/bin/sh -l

npm install
npm run build
echo "::set-output name=date::$(date +'%Y-%m-%d-%H%M')"
git config user.name github-actions
git config user.email github-actions@github.com
git checkout -b "prod"
mv ./public/* ./
#ls -al # list the files for confirmation.
git rm -r --cached .github/workflows --ignore-unmatch
git rm -r --cached scripts --ignore-unmatch
git rm -r --cached src --ignore-unmatch
git rm --cached README.md --ignore-unmatch
git rm --cached package.json --ignore-unmatch
git rm --cached rollup.config.js --ignore-unmatch
git rm --cached .gitignore --ignore-unmatch
git add .
git commit -m "${GITHUB_REPOSITORY}-build${GITHUB_RUN_NUMBER}"
git push --set-upstream origin prod --force
