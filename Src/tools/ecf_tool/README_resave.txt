== "ecf_tool resave" command ==

Resave an Eiffel Configuration File (or all ecf from a directory), so that it uses latest .ecf schema.

== Examples ==

>  ecf_tool resave my_project.ecf


== Usage ==


resave - Version: 14.11
Copyright Eiffel Software 1985-2014. All Rights Reserved.

USAGE: 
   ecf_tool.exe resave [-r] [-version] [-nologo] [<path> [<path>, ...]]

OPTIONS:
   Options should be prefixed with: '-' or '/'

   -r      : Recursive scan any directories for *.ecf (Optional)
   -?      : Display usage information. (Optional)
   -version: Displays version information. (Optional)
   -nologo : Supresses copyright information. (Optional)

NON-SWITCHED ARGUMENTS:
   <path>: An Eiffel configuration file or a directory
