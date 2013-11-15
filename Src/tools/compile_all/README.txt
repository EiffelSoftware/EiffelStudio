== Compile-All tool ==

=== Description ===
This tool can be used to check if all targets in a directory compile.
It recursively scans all directories and looks for files with a .ecf extension.
For each configuration file all targets are processed by actions declared in the command line (could melt, freeze, finalize, ...), and it reports the result as Ok or Failed (or Skipped, Ignored).

=== Command line options ===
To see the list of available command-line options and their help information, use the '/?' switch.

	USAGE:
	   compile_all.exe [-l <directory>] [-compdir <directory>] [-eifgen <directory>]
	 [-logdir <directory>] [-ignore <ignore.ini>] [-log_verbose] [-list_failures] 
	 [-ecb] [-experiment] [-compat] [-clean] [-keep[ <status>]] [-c_compile]
	 [-melt] [-freeze] [-finalize] [-options <key=value> [-options...]] 
	 [-interface <key=value> [-interface...]] 
	 [-version] [-nologo]

	OPTIONS:
	   Options should be prefixed with: '-' or '/'

	   -l            : Directory where to look for configuration files. (Optional)
					   <directory>: A directory to look for ecf files
	   -compdir      : Directory where projects will be compiled. (Optional)
					   <directory>: A directory where the projects will be compiled
	   -eifgen       : Obsolete: see "compdir" option. (Optional)
					   <directory>: ...
	   -logdir       : Directory where logs will be stored (if verbose logging is
					   enabled). (Optional)
					   <directory>: A directory where the logs will be stored
	   -ignore       : Ignore file with files/targets to ignore. (Optional)
					   <ignore.ini>: INI file with the ignores.
	   -log_verbose  : Verbose logging of actions? (Optional)
	   -list_failures: Display a list of failed compilation(s) with associated log filename if
					   available. (Optional)
	   -ecb          : Use ecb instead of ec? (Optional)
	   -experiment   : Use experimental library during compilation? (Optional)
	   -compat       : Use compatible library during compilation? (Optional)
	   -c_compile    : Compile generated C code? (Optional)
	   -melt         : Melt the project? (Optional)
	   -freeze       : Freeze the project? (Optional)
	   -finalize     : Finalize the project? (Optional)
	   -clean        : Clean before compilation? (Optional)
	   -keep         : Keep EIFGENs related data after compilation? (by default
					   they are removed) (Optional)
					   <status>: (Optional) {all | passed | failed}
	   -options      : Comma separated option(s) (Optional)
					   <key=value>: dotnet=(true|false)
									...
	   -interface    : Comma separated option(s) to customize the output (Optional)
					   <key=value>: for instance key "template": using any of
									#action, #target, #uuid, #system, #ecf ,
									#absolute_ecf variables
									...
	   -?            : Display usage information. (Optional)
	   -version      : Displays version information. (Optional)
	   -nologo       : Supresses copyright information. (Optional)

=== Information ===
Online short documentation: https://svn.eiffel.com/eiffelstudio/trunk/Src/tools/compile_all

=== Examples ===
To check if every target in the trunk EIFFEL_SRC folder still compiles, use the following setup
# create a directory which will contain the compilation data (EIFGENs, ...) such as C:\compdir
# compile_all -l %EIFFEL_SRC% -compdir C:\compdir -ignore %EIFFEL_SRC%\tools\compile_all\baseline\trunk.ini -melt -output_template "#ecf #system.#target : "

=== Using -ignore ===
* You can list in an .ini file, the .ecf files or folder to ignore, such as 
	[$EIFFEL_SRC\foo\foo.ecf]
	[$EIFFEL_SRC\foo\bar]

* You can also use regexp  such as

	[regexp=(\\|\/).(svn|git)$]
	[regexp=(\\|\/).*GENs*$]

=== Output progress ===
* During execution of compile_all tool, the default output is for instance
	"Melting test from test (C:\tests\test.ecf)...Ok"

* It is possible to use another output for instance by using 
	-output_template "[#action] #ecf #system.#target : "

* The available variables are #action, #system, #target, #uuid, #ecf, #absolute_ecf and #log_filename

=== Output folders ===
* You can specify the folder that will contains all the compilation data (EIFGENs...) by using "-compdir directory"  (same as obsolete  -eifgen flag). By default this uses the ".ecf" folder.

* You can specify where goes the log files, by using "-logdir directory". By default this uses the ".ecf" folder.

=== Cleaning ===
* By using "-clean" , any compilation will start by cleaning any previous compilation for the target. (i.e: ec -clean ....)

* By default, once the compilation is done, 'compile_all' tool will remove the compilation data (EIFGENs ...). But you decide to keep :
  - all of them by using  "-keep" or "-keep all"
  - only the failed ones by using "-keep failed"
  - only the passed ones by using "-keep passed"

=== Optimization ===
Compling using 'ecb' is slightly faster than just using 'ec' , by default 'compile_all' is using 'ec', but you can decide to use 'ecb' by using flag  " -ecb "

=== Specific -interface .. ===

With release 7.0 the output uses  "passed", "failed", (and others), instead of "Ok",
"Failed" (and others).

However in order to get same output as previous versions of 'compile_all', you
can use:
	-interface "template=#action #target from #system (#ecf)..."
	-interface "text.passed=Ok,text.failed=Failed"

The current possible usage of -interface are:
	-interface text.{id}={new_id}
		where {id} can be: 
			passed, failed, skipped, ignored, error
			target, Parsing, Melting, Freezing, Finalizing
		and {new_id} the value of the wanted text

Note: if ever you want to use comma "," in the template, 
      you can change the non alpha separator by putting the wanted separator char as first character
      For instance, to use ";" as separator
      	-interface ";template=#action, #system, #target, (#ecf), "
	  This way, you can use "," in your value, and here the ";" is used as separator, 
	  Another example:
		-interface ";text.passed=OK;text.failed=Failure, try again later"

=== Specific -options .. ===

This is possible to exclude all dotnet target by using
	-options dotnet=false

The current possible usage of -options are:
	-options dotnet={true|false}
	-options "ec={flags}" and -options "ec.{mode}={flags}"
		where {mode} can be:
			melt, freeze, finalize
		where {flags} is flags for the compiler "ec" such as "-full -verbose" 
		An usage could be:
			-options "ec.finalize=-keep"

Note: in the same way as "-interface", you can choose another separator
		-options "|ec.finalize=-keep|ec.freeze=-c_compile"

Note:
In the future, this "-options" flag will be use for additional purpose such as simulation a specific platform, and so on ...

