# Goal:

 update the value of the library's location inside the ecf
 this is useful when the location of library changes (especially with relative path).
 It can also be used to transform relative path to absolute path using an environment variable for instance

# Usage:

ecf_updater - Version: 0.1
Copyright Eiffel Software 2011-2012. All Rights Reserved.

USAGE:
   ecf_updater [<path>[ <path>, ...]] [-r <r|root>] [-f] [-base <base>] [-base_variable <base_variable>] [-ise_library] [-eiffel_library] [-r <r|replace> [-r...
]] [-v] [-b] [-n] [-d] [-v] [-nologo]

OPTIONS:
   Options should be prefixed with: '-' or '/'

   -r --root          : Root directory (Optional)
                        <r|root>: Root directory
   -f --force         : Force execution without any confirmation (Optional)
      --base          : Base name (Optional)
                        <base>: Could be $ISE_LIBRARY
      --base_variable : Base variable name (Optional)
                        <base_variable>: Could be ISE_LIBRARY
      --ise_library   : Use $ISE_LIBRARY for 'base' (Optional)
      --eiffel_library: Use $EIFFEL_LIBRARY for 'base' (Optional)
   -r --replace       : Replace  (Optional)
                        <r|replace>: use FOO=BAR to replace FOO with BAR (case sensitive)
   -v --verbose       : Verbose output (Optional)
   -b --backup        : Backup modified files (Optional)
   -n --simulation    : Simulation mode (Optional)
   -d --diff          : Display diff (Optional)
   -? --help          : Display usage information. (Optional)
   -v --version       : Displays version information. (Optional)
      --nologo        : Supresses copyright information. (Optional)

NON-SWITCHED ARGUMENTS:
   <path>: Eiffel configuration file or directory


# Examples
- Update all ecf files located under . (and recursively in sub directories), and update relative path with absolute path using $ISE_LIBRARY

	ecf_updater --simulation --verbose --diff --ise_library .

- If you have a collection of libraries, and that you use relative path to reference .ecf, whenever you want to move a folder to another, you can easily update your .ecf using ecf_updater
	ecf_updater  --simulation --verbose --diff  .

- Now if you want to "release" your libs and use an environment variable to use absolute path, you can do
	ecf_updater --simulation --verbose --diff  --base_variable MY_EIFFEL_LIBS .

- If you want to update only a subfolder, for instance your examples just do
	ecf_updater --simulation --verbose --diff  examples

# Future potential evolutions
- Handle non relative path, and being able to update ecf file using for instance $EIFFEL_LIBRARY , when a folder is moved.

