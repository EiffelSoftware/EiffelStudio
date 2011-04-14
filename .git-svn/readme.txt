
	-----------------------------
	--       IN-PROGRESS       --
	-----------------------------
	-- USE AT YOUR OWN RISK 	--
	-- author: jfiat@eiffel.com --
	-----------------------------

Overview: How to use git-svn with EiffelStudio subversion repository  

== Usign git-svn on Eiffelstudio subversion repository ==
The following instruction is to "clone" the svn repository of eiffelstudio,
but only the trunk, and from recent revision (otherwise ... it will take for
ever, the full svn repository is huged ...)

  mkdir trunk.git
  cd trunk.git

Create the git local repository from svn repository
  svn cat -r 86251 https://svn.eiffel.com/eiffelstudio/trunk/.git-svn/users.txt > users.txt
  git svn init https://svn.eiffel.com/eiffelstudio/trunk 
  git svn --authors-file=users.txt fetch -r 86251 

The previous command will download the full source code related to revision
86251 and then, it will fetch all the more recent revisions incrementally.
Note: you can fetch from older revision, if you want to have older history. A
good habit would be to fetch from the revision of previous release.


Once you get at least revision 86251
You can use the committed .git-svn/users.txt file
Clean temporary users.txt, to use a better solution, see 2 lines below
  del users.txt

For later usage, associate the svn author with real users
  git config --local --add svn.authorsfile .git-svn/users.txt

If you don't have this folder .git-svn , you might have done something bad

then to update, do 
  *** Windows ***                |   *** Linux ***                                       
  echo Stash                     |   echo Stash
  @call git stash                |   git stash
                                 |   
  echo Rebase                    |   echo Rebase
  @call git svn rebase           |   git svn rebase
                                 |   
  echo Apply Stash               |   echo Apply Stash
  @call git stash apply          |   git stash apply
  echo Clear Stash               |   echo Clear Stash
  @call git stash clear          |   git stash clear

== Map users committers ==
(note: if you followed previous instructions, you should already have done the following operations)
To map subversion user with git user (name+email), you should use the following file users.txt

 git config --local --add svn.authorsfile .git-svn/users.txt

if git svn complains about unknown users, you need to update users.txt with missing author(s) and relaunch your git svn command

== Using submodules to mimic svn:externals ==

=== ejson ===
 git submodule add -b trunk_ise git://github.com/Eiffel-World/ejson-svn.git Src/contrib/library/ejson

=== gobo ===
 git submodule add git://github.com/Eiffel-World/gobo.git Src/library/gobo/svn
 eventually git submodule add -b last_svn_commit git://github.com/Eiffel-World/gobo.git Src/library/gobo/svn

=== freeELKS ===
 git submodule add git://github.com/Eiffel-World/freeelks-svn.git .git-svn/submodules/freeelks
* On Windows 
 Require: junction installed (see: http://www.sysinternals.com and look for File and Disk utilities > junction)
 cd Src\library\base
 junction elks ..\..\..\.git-svn\submodules\freeelks\void_safe\library

* On Linux
 cd Src/library/base
 ln -s ../../../.git-svn/submodules/freeelks/void_safe/library elks

== Updating ==
To include the submodules in the update operation, you can use the following
script

  *** Windows ***                       |   *** Linux ***                                       
  echo Stash                            |   echo Stash
  @call git stash                       |   git stash
                                        |   
  echo Rebase                           |   echo Rebase
  @call git svn rebase                  |   git svn rebase
  echo Update submodules                |   echo Update submodules
  @call git submodule update            |   git submodule update
  @call git submodule foreach git pull  |   git submodule foreach git pull
                                        |   
  echo Apply Stash                      |   echo Apply Stash
  @call git stash apply                 |   git stash apply
  echo Clear Stash                      |   echo Clear Stash
  @call git stash clear                 |   git stash clear


== Miscellanious ==
=== Windows instructions to create your git local repository ===
	set TMP_REV_GIT_SVN=86251
	set TMP_REV=%TMP_REV_GIT_SVN%
	mkdir trunk.git
	cd trunk.git
	svn cat -r %TMP_REV_GIT_SVN% https://svn.eiffel.com/eiffelstudio/trunk/.git-svn/users.txt > users.txt
	git svn init https://svn.eiffel.com/eiffelstudio/trunk 

	git svn --authors-file=users.txt fetch -r %TMP_REV% 
	del users.txt
	git config --local --add svn.authorsfile .git-svn/users.txt

	git stash
	git svn rebase
	git submodule update
	git submodule foreach git pull
	git stash apply
	git stash clear

	git submodule add git://github.com/Eiffel-World/gobo.git Src/library/gobo/svn
	git submodule add -b trunk_ise git://github.com/Eiffel-World/ejson-svn.git Src/contrib/library/ejson
	git submodule add git://github.com/Eiffel-World/freeelks-svn.git .git-svn/submodules/freeelks
	cd Src\library\base
	junction elks ..\..\..\.git-svn\submodules\freeelks\void_safe\library

* note: if you copy that into a script, you might need to prepend the svn and git commands with  "@call "

=== Linux script ===
 Adapt the Windows script for your shell, this is pretty straight forward
 for instance with bash
	TMP_REV_GIT_SVN=86251
	TMP_REV=$TMP_REV_GIT_SVN
	mkdir trunk.git
	cd trunk.git
	svn cat -r $TMP_REV_GIT_SVN https://svn.eiffel.com/eiffelstudio/trunk/.git-svn/users.txt > users.txt
	git svn init https://svn.eiffel.com/eiffelstudio/trunk 

	git svn --authors-file=users.txt fetch -r $TMP_REV 
	del users.txt
	git config --local --add svn.authorsfile .git-svn/users.txt

	git stash
	git svn rebase
	git submodule update
	git submodule foreach git pull
	git stash apply
	git stash clear

	git submodule add git://github.com/Eiffel-World/gobo.git Src/library/gobo/svn
	git submodule add -b trunk_ise git://github.com/Eiffel-World/ejson-svn.git Src/contrib/library/ejson
	git submodule add git://github.com/Eiffel-World/freeelks-svn.git .git-svn/submodules/freeelks
	cd Src/library/base
	ln -s ../../../.git-svn/submodules/freeelks/void_safe/library elks


