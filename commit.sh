#!/bin/bash
# 提交并设置相关.sh为可执行
# by dralee 2025.7.2
# 2026.01.21 by dralee for release
# 2026.5.20 by dralee support for -c,-h,-r arguments
# -c: the comment of commit
# -r: y/Y for release
# -p: pull the code only, if want to commit need the -c
# -h: print help message

while getopts "c:rph" opt;do
	case $opt in
		c)
			comment=$OPTARG
			;;
		r)
			release="Y"
			;;
		p)
			pull_code="Y"
			;;
		h)
			echo "========================================================================="
			echo "commit the current code for repo"
			echo "-c: set the commit comment"
			echo "-p: pull the code only, if want to commit the code need the -c argument"
            echo "-r: for release the code to github release"
			echo "-h: print this help message."
			echo "========================================================================="
			exit 0
			;;
	esac
done

#if [ -z "$comment" ]; then
#    comment="feat: update the project"
#fi

if [[ $"$pull_code" == "Y" ]];then
	echo begin to pull the code...
	git pull
fi

if [[ -z "$comment" ]];then
	echo empty for commit the code, please give the comment first!
	exit 1
fi

echo commit the project ...
git config set advice.addIgnoredFile false # hint: Use -f if you really want to add them.
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