#!/bin/bash
# release all the syntaxes
# by dralee 2026.01.19

git checkout release
git merge --no-ff -m "merge dev to release" dev
git push

echo back to dev for local
git checkout dev
