#!/bin/bash
# 提交并设置相关.sh为可执行
# by dralee 2025.7.2
# $2: y/Y for release
comment=$1
release=$2
if [ -z "$comment" ]; then
    comment="feat: update the project"
fi

echo commit the project ...
git add .
echo add the chmod for shell to execute
#git add --chmod=+x *.sh
find . -type f -name "*.sh" -exec git add --chmod=+x {} +

git status

git commit -m "$comment"
git push

if [[ "$release" =~ ^[yY]$ ]]; then
    git checkout release
    git merge --no-ff -m "merge dev to release" dev
    git push

    echo back to dev for local
    git checkout dev
fi