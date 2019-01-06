#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

git clone --branch=gh-pages https://${GH_REF} .deploy_git
mv .deploy_git/.git/ ./public

cd ./public
git config user.name "xuchengpeng"
git config user.email "330476629@qq.com"
git add .
git commit -m "Site updated `date +"%Y-%m-%d %H:%M:%S"`"
git push --force --quiet "https://${TRAVIS_TOKEN}@${GH_REF}" gh-pages:gh-pages
