== "ecf_tool redirection" command ==

Create an ecf redirection, similar to symbolic link but using .ecf files.


== Examples ==

If a library is moved from old\location\lib.ecf to new\location\new_lib.ecf, a redirection could be created to avoid breaking existing project looking for the lib.ecf at the former location.

> ecf_tool redirection create old\location\lib.ecf new\location\new_lib.ecf

== Usage ==


usage: ecf_tool redirection <subcommand> [options] [args]
Type 'ecf_tool redirection help <subcommand> for help on a specific subcommand.
Available subcommands:
   help
   create <redirection_ecf> <target_ecf>
   delete <redirection_ecf>
   check  <redirection_ecf> {target_ecf}
   shadow/unshadow  <redirection_ecf> {target_ecf}

Global options:
   -v|--verbose: verbose output


=== ecf_tool redirection help create ===

usage: ecf_tool redirection create [options] <redirection_ecf> <target_ecf>
   <redirection_ecf> : redirection ecf file
   <target_ecf>      : target ecf file
Create a redirection from <redirection_ecf> to <target_ecf>.

Options:
   -f|--force: force operation

Global options:
   -v|--verbose: verbose output


