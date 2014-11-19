== "ecf_tool integration" command ==

This command will create an Eiffel Configuration File (ecf) that includes a collection of .ecf files.
Such generated ecf can be used during integration/testing to compile many ecf projects at once,
and then, for instance this can help refactorying operations across many projects.

== Examples ==

>  ecf_tool integration -o all.ecf path-to-libs


== Usage ==

integration - Version: 14.11
Copyright Eiffel Software 1985-2014. All Rights Reserved.

USAGE: 
   ecf_tool.exe integration [-r <folder>] -o <ecf_file> [-f] [-v] [-x <path> [-x...]] [-v] [-nologo] [<path>]

OPTIONS:
   Options should be prefixed with: '-' or '/'

   -r --root   : Root directory (Optional)
                 <folder>: Root directory
   -o --output : Output config file
                 <ecf_file>: output config file
   -f --force  : Force execution without any confirmation (Optional)
   -v --verbose: Verbose output (Optional)
   -x --exclude: Excluded directories (Optional)
                 <path>: directory
   -? --help   : Display usage information. (Optional)
   -v --version: Displays version information. (Optional)
      --nologo : Supresses copyright information. (Optional)

NON-SWITCHED ARGUMENTS:
   <path>: folder to look Eiffel configuration files
