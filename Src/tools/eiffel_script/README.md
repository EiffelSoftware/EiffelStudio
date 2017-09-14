Eiffel script-like execution
============================

#Overview
The purpose of this `eiffel` tool, is to execute an Eiffel project by providing the .ecf file.

`Usage:  eiffel prog.ecf arg1 arg2 ...`

The first time, іt compiles `prog.ecf` in finalized mode, then launch the generated executable with arguments `arg1 arg2 ...`.

Then the next time, `eiffel` reuses the executable previously compiled (if any). The (re)compilation is triggered only if the `prog.ecf` is changed, or if required by the `eiffel` command using specific options `-b or --build`.

# Build instruction

The `eiffel` can also be used to compile the `prog.ecf` and save the generated file at given location.
`eiffel build prog.ecf path-to-prog.exe`

# Usage:

```
USAGE:
   eiffel (-v|--verbose) (-h|--help) (-b|--build) <project.ecf> ...
   eiffel build (-v|--verbose) <project.ecf> <output_executable_path> ...

COMMANDS:
    <project.ecf> ...   : build once and launch <project.ecf> execution.
    build               : build project and save executable as <output_executable_path>.

OPTIONS:
    -o --executable-output <path> : build and save executable as <path>.
                                  : note: no execution.!
    -b --build                    : force a fresh system build.
    -v --verbose                  : verbose output.
    -h --help                     : display this help.
    ...                           : arguments for the <project.ecf> execution.

    Note: you can overwrite default value, using 
    EIFFEL_SCRIPT_DIR       : root directory for eiffel script app (default under Eiffel user files/.apps) 
    EIFFEL_SCRIPT_CACHE_DIR : directory caching the compiled executables ($EIFFEL_SCRIPT_DIR/cache) 
    EIFFEL_SCRIPT_COMP_DIR : directory caching the EIFGENs compilation ($EIFFEL_SCRIPT_DIR/comp) 

```

# Status

* status:experimental

For now, this is an experimentation.

