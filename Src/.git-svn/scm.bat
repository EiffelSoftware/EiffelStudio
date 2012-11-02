@echo off
setlocal

rem   #################################
rem   # Script to help using git-svn  #
rem   #################################

set GIT_PATH=
for %%f in (git.exe) do (
   if exist "%%~dp$PATH:f" set GIT_PATH="%%~dp$PATH:f"
)
if .%GIT_PATH%. == .. goto MISSING_GIT
goto START

:MISSING_GIT
echo ERROR: could not find git.exe
goto END

:START
set TMP_OP=%1
if .%TMP_OP%. == .commit. goto GITSVN_commit
if .%TMP_OP%. == .update. goto GITSVN_update
if .%TMP_OP%. == .update_all. goto GITSVN_update_all
if .%TMP_OP%. == .status. goto GITSVN_status
if .%TMP_OP%. == .branch. goto GITSVN_branch
if .%TMP_OP%. == .info. goto GITSVN_info
goto HELP
goto END

:GITSVN_info
echo Info
@call git config -l
goto END

:GITSVN_branch
echo Branch
@call git branch -v -a
goto END

:GITSVN_status
echo Status
@call git status
goto END

:GITSVN_update_all
echo Stash
@call git stash

echo Rebase
@call git svn rebase
echo Update submodules
@call git submodule update
@call git submodule foreach git pull

echo Apply Stash
@call git stash apply
echo Clear Stash
@call git stash clear
goto END

:GITSVN_update
echo Stash
@call git stash
echo Rebase
@call git svn rebase
echo Apply Stash
@call git stash apply
echo Clear Stash
@call git stash clear
goto END

:GITSVN_commit
echo Stash
@call git stash
echo Commit
@call git svn dcommit
echo Apply Stash
@call git stash apply
echo Clear Stash
@call git stash clear
goto END

:HELP
echo Usage:
echo  - update: stash handle and svn rebase, and apply recorded stash
echo  - update_all: same as 'update', but also update submodules
echo  - commit: stash, svn dcommit, and apply recorded stash
goto END

:END
endlocal
