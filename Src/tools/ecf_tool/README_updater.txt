updater - Version: 14.11
Copyright Eiffel Software 1985-2014. All Rights Reserved.

USAGE: 
   ecf_tool.exe updater [-r <r|root>] [-f] [-base <base>] [-base_variable <base_variable>] [-ise_library] [-eiffel_library] [-replace <replace> [-replace...]] [-x <replace> [-x...]] [-v] [-b] [-n] [-d] [-v] [-nologo] [<path> [<path>, ...]]

OPTIONS:
   Options should be prefixed with: '-' or '/'

   -r --root                : Root directory (Optional)
                              <r|root>: Root directory
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
