== "ecf_tool create" command ==

This command helps the user to create an ecf file for either a library, an application or a testing suite.

== Examples ==

* New application ecf
>  ecf_tool create --application APPLICATION.make --add_cluster src --add_library base --add_library diff
>  ecf_tool create --application APPLICATION.make --console -c src -l base -l diff -l c:\my_libs\foo.ecf

* New library ecf
>  ecf_tool create --library -c src -l base -l diff


== Usage ==

create - Version: 14.11
Copyright Eiffel Software 1985-2014. All Rights Reserved.

USAGE:
   ecf_tool.exe create [-l <l|add_library> [-l...]] [-c <c|add_cluster> [-c...]] [-t <t|add_test> [-t...]] 
	[-uuid <uuid>] [-n <n|name>] [-syntax <syntax>] [-library] [-application[ <Entry point>]] [-testing]
	[-executable_name <executable_name>] [-console] [-concurrency <concurrency>] [-thread] [-scoop] 
	[-f] [-v] [-v] [-nologo] [<path>]

OPTIONS:
   Options should be prefixed with: '-' or '/'

   -l --add_library    : Libraries (Optional)
                         <l|add_library>: Library to include
   -c --add_cluster    : Clusters (Optional)
                         <c|add_cluster>: Cluster to include
   -t --add_test       : Tests clusters (Optional)
                         <t|add_test>: Tests cluster to include
      --uuid           : UUID (Optional)
                         <uuid>: UUID value
   -n --name           : Target name (Optional)
                         <n|name>: Eiffel target name
      --syntax         : Syntax mode (Optional)
                         <syntax>: Syntax mode: obsolete, transitional, default=standard, provisional
      --library        : This is a library configuration file (Optional)
      --application    : This is an application configuration file (Optional)
                         <Entry point>: (Optional) Root cluster.CLASS_NAME.creation_name information (cluster is
                                        optional)
      --testing        : This is an testing configuration file (Optional)
      --executable_name: Executable name (Optional)
                         <executable_name>: Executable name (without extension)
      --console        : Console application mode (Optional)
      --concurrency    : Concurrency mode (Optional)
                         <concurrency>: Concurrency mode: default=none, thread, scoop
      --thread         : Concurrency mode = thread (Optional)
      --scoop          : Concurrency mode = SCOOP (Optional)
   -f --force          : Force execution without any confirmation (Optional)
   -v --verbose        : Verbose output (Optional)
   -? --help           : Display usage information. (Optional)
   -v --version        : Displays version information. (Optional)
      --nologo         : Supresses copyright information. (Optional)

NON-SWITCHED ARGUMENTS:
   <path>: directory for target

NON-SWITCHED ARGUMENTS:
   <path>: directory for target

