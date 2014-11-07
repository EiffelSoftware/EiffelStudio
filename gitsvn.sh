#!/bin/bash

set -x

PROJECT_ROOT=/home/svn/EiffelStudio.git
SVN_REPO=https://svn.eiffel.com/eiffelstudio/trunk
GIT_REPO=git@github.com:EiffelSoftware/EiffelStudio.git
SVN_LAYOUT="--trunk=."

SVN_CLONE="${PROJECT_ROOT}/svn-clone"
GIT_BARE="${PROJECT_ROOT}/git-bare-tmp"

if [ ! -d "${PROJECT_ROOT}" ]; then
	echo Directory "${PROJECT_ROOT}" does not exist.
	exit 1
else
	cd "${PROJECT_ROOT}"

	if [ ! -d "${SVN_CLONE}" ]; then
		git svn clone "${SVN_REPO}" "${SVN_LAYOUT}" "${SVN_CLONE}"
		cd "${SVN_CLONE}"
	else
		cd "${SVN_CLONE}"
		git remote rm bare || echo "failed to delete remote:bare, proceeding anyway"
			# We perform a checkout because with some svn files without a 
			# svn:eol-style native property, gits get confused and will mark them
			# as modified even if we just did a rebase before.
		git checkout .
		git svn rebase --fetch-all
	fi

	git remote add bare "${GIT_BARE}"
	git config remote.bare.push 'refs/remotes/*:refs/heads/*'

	if [ -d "${GIT_BARE}" ]; then
		rm -rf "${GIT_BARE}"
	fi

	mkdir -p "${GIT_BARE}"
	cd "${GIT_BARE}"
	git init --bare .
	git symbolic-ref HEAD refs/heads/trunk

	cd "${SVN_CLONE}"
	git push bare

	cd "${GIT_BARE}"
	git branch -m trunk master
# To uncomment if we have some tags/branches
#	git for-each-ref --format='%(refname)' refs/heads/tags | \
#		 cut -d / -f 4 | \
#		 while read ref;
#		 do
#				git tag "$ref" "refs/heads/tags/$ref"
#				git branch -D "tags/$ref"
#		 done
	git remote add origin "${GIT_REPO}"
	git config branch.master.remote origin
	git config branch.master.merge refs/heads/master
	git push --tags origin master
	git push --all

	rm -rf "${GIT_BARE}"
fi
