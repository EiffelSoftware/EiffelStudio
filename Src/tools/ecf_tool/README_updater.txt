== "ecf_tool updater" command ==

For a collection of ecf files, update the library location to reflect existing project.
This can be used when moving a library from a location to another, and update all existing ecf that uses this.

== Examples ==

* update ecf files from $ISE_LIBRARY, for instance if a library is moved or renamed.
> ecf_tool updater --simulation --force --diff --root $ISE_LIBRARY/library $ISE_LIBRARY/library 

* update ecf files from $MY_PROJECTS, in case libraries were renamed or moved in $ISE_LIBRARY
> ecf_tool updater --simulation --force --diff --root $ISE_LIBRARY/library $MY_PROJECTS

* Replace $ISE_LIBRARY by $EIFFEL_LIBRARY
> ecf_tool updater --simulation --force --diff --replace ISE_LIBRARY=EIFFEL_LIBRARY --root $ISE_LIBRARY/library $ISE_LIBRARY/library 

* Update ecfs, but only with library locations from $ISE_LIBRARY/library and $ISE_LIBRARY/contrib
> ecf_tool updater --simulation --force --diff --root $ISE_LIBRARY/library --include $ISE_LIBRARY/library --include $ISE_LIBRARY/contrib $MY_PROJECTS

It is also possible to exclude directories from being scanned (and associated ecfs included) thanks to the --exclude option.


== Usage ==

updater - Version: 16.5
Copyright Eiffel Software 1985-2016. All Rights Reserved.

USAGE:
   ecf_tool.exe updater [-r <r|root>] [--include <include> [-include...]] [--exclude <exclude> [-exclude...]] [--avoid <avoid> [-avoid...]] [-f] [--base <base>] [--base_variable <base_variable>] [--ise_library] [--eiffel_library] [--replace <replace> [-replace...]] [-x <replace> [-x...]] [-v] [-b] [-n] [-d] [-v] [--nologo] [<path> [<path>, ...]]

OPTIONS:
   Options should be prefixed with: '-' or '/'

   -r --root                : Root directory (Optional)
                              <r|root>: Root directory
      --include             : Include <directory> (Optional)
                              <include>: directory
      --exclude             : Exclude <directory> (Optional)
                              <exclude>: directory
      --avoid               : Avoid to select new ecf location from <directory> (Optional)
                              <avoid>: directory
   -f --force               : Force execution without any confirmation (Optional)
      --base                : Base name (Optional)
                              <base>: Could be $ISE_LIBRARY
      --base_variable       : Base variable name (Optional)
                              <base_variable>: Could be ISE_LIBRARY
      --ise_library         : Use $ISE_LIBRARY for 'base' (Optional)
      --eiffel_library      : Use $EIFFEL_LIBRARY for 'base' (Optional)
      --replace             : Replace  (Optional)
                              <replace>: use FOO=BAR to replace FOO with BAR (case sensitive)
   -x --expand-variable-with: Expand variable VAR with value (Optional)
                              <replace>: use VAR=value to expand VAR environment variable with 'value'
   -v --verbose             : Verbose output (Optional)
   -b --backup              : Backup modified files (Optional)
   -n --simulation          : Simulation mode (Optional)
   -d --diff                : Display diff (Optional)
   -? --help                : Display usage information. (Optional)
   -v --version             : Displays version information. (Optional)
      --nologo              : Supresses copyright information. (Optional)

NON-SWITCHED ARGUMENTS:
   <path>: Eiffel configuration file or directory

