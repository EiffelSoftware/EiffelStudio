set TMP_REV_GIT_SVN=89805
set TMP_REV=%TMP_REV_GIT_SVN%
mkdir Src.git
cd Src.git
svn cat https://svn.eiffel.com/eiffelstudio/trunk/Src/.git-svn/users.txt > users.txt
call git svn init https://svn.eiffel.com/eiffelstudio/trunk/Src

call git svn --authors-file=users.txt fetch -r %TMP_REV% 
del users.txt
call git config --local --add svn.authorsfile .git-svn/users.txt

call git stash
call git svn rebase
rem git submodule update
rem git submodule foreach git pull
call git stash apply
call git stash clear

call git remote add -f _elks https://github.com/Eiffel-World/freeelks-svn.git
call git merge -s ours --no-commit --squash _elks/master
call git read-tree --prefix=library/base/elks/ -u _freeelks/master:void_safe/library
call git commit -m "Added freeELKS as subtree merged in library/base/elks"

