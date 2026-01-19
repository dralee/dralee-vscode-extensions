#!/bin/bash
# 提交并设置相关.sh为可执行
# by dralee 2025.7.2
comment=$1
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