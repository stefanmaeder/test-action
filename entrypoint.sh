#!/bin/sh -l

# echo "Hello $1"
# time=$(date)
# echo "::set-output name=time::$time"

ls -la $GITHUB_WORKSPACE

npm install
npm run build
echo "::set-output name=date::$(date +'%Y-%m-%d-%H%M')"
git config user.name github-actions
git config user.email github-actions@github.com
git checkout -b "production"
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
git commit -m ${{ steps.date.outputs.date }}-${{ github.event.repository.name }}-build${{ github.run_number }}
git push --set-upstream origin production --force
