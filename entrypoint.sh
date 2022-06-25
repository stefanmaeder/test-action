#!/bin/sh -l

DEPLOYMENT_BRANCH=prod

echo $GITHUB_EVENT_PATH

npm install
npm run build
mv ./public/* ./

git config user.name github-actions
git config user.email github-actions@github.com
git checkout -b $DEPLOYMENT_BRANCH

git rm -r --cached .github/workflows --ignore-unmatch
git rm -r --cached scripts --ignore-unmatch
git rm -r --cached src --ignore-unmatch
git rm --cached README.md --ignore-unmatch
git rm --cached package.json --ignore-unmatch
git rm --cached rollup.config.js --ignore-unmatch
git rm --cached .gitignore --ignore-unmatch

git add .
git commit -m "${GITHUB_REPOSITORY}-build${GITHUB_RUN_NUMBER}"
git push --set-upstream origin $DEPLOYMENT_BRANCH --force
