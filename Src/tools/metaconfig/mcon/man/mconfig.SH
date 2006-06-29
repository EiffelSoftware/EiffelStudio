case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting mcon/man/metaconfig.$manext (with variable substitutions)"
$rm -f metaconfig.$manext
$spitshell >metaconfig.$manext <<!GROK!THIS!
.TH METACONFIG $manext "Version $VERSION PL$PATCHLEVEL"
''' @(#) Manual page for metaconfig
'''
''' $Id: mconfig.SH 78389 2004-11-30 00:17:17Z manus $
'''
'''  Copyright (c) 1991-1993, Raphael Manfredi
'''  
'''  You may redistribute only under the terms of the Artistic Licence,
'''  as specified in the README file that comes with the distribution.
'''  You may reuse parts of this distribution only within the terms of
'''  that same Artistic Licence; a copy of which may be found at the root
'''  of the source tree for dist 3.0.
'''
''' $Log$
''' Revision 1.1  2004/11/30 00:17:18  manus
''' Initial revision
'''
''' Revision 3.0.1.17  1997/02/28  16:29:31  ram
''' patch61: documents the runnning environment and the src.U unit
''' patch61: added warnings for $_a and $_o, as well as "startsh"
'''
''' Revision 3.0.1.16  1995/09/25  09:17:48  ram
''' patch59: documented new ?Y: directive
''' patch59: fixed my e-mail address
'''
''' Revision 3.0.1.15  1995/07/25  14:18:24  ram
''' patch56: added extra nroff escapes at line heads to keep leading dots
''' patch56: documented new -G option
''' patch56: extended description of the Csym.U unit
''' patch56: now mentions what a compile-link test line should look like
'''
''' Revision 3.0.1.14  1995/05/12  12:25:02  ram
''' patch54: documented new -K switch for knowledgeable users
'''
''' Revision 3.0.1.13  1995/01/30  14:46:39  ram
''' patch49: documented new special units Prefixit.U and Prefixup.U
'''
''' Revision 3.0.1.12  1995/01/11  15:39:16  ram
''' patch45: documents new -O option and new Getfile escape supports
''' patch45: documents the & escape in Myread and the new cc symbol lookup
'''
''' Revision 3.0.1.11  1994/10/29  16:32:38  ram
''' patch36: added nroff protection for lines beginning with '.'
''' patch36: documents new ?F: line for file declarations
''' patch36: added example showing how ./loc can be used
'''
''' Revision 3.0.1.10  1994/08/29  16:33:40  ram
''' patch32: documented new Typedef.U unit for typedef lookup
'''
''' Revision 3.0.1.9  1994/06/20  07:10:14  ram
''' patch30: added -L option for easier unit testing
''' patch30: new -D and -U options supported by Configure
'''
''' Revision 3.0.1.8  1994/05/13  15:29:16  ram
''' patch27: now understands macro definitions in ?H: lines
'''
''' Revision 3.0.1.7  1994/05/06  15:19:25  ram
''' patch23: documented the new 'p' option in Getfile.U
'''
''' Revision 3.0.1.6  1994/01/24  14:19:47  ram
''' patch16: symbols defined in a unit can be tagged "internal use only"
''' patch16: documents new MailList.U special unit
''' patch16: new general <\$variable> macro substitution
'''
''' Revision 3.0.1.5  1993/10/16  13:51:50  ram
''' patch12: new option -M to activate ?M: lines
''' patch12: documents new ?M: lines format
''' patch12: new internal Makefile command cm_h_weed for ?M: support
''' patch12: documents usage for new confmagic.h file
'''
''' Revision 3.0.1.4  1993/09/09  11:50:35  ram
''' patch9: lots of typo fixes and abusive variable substitution problems
'''
''' Revision 3.0.1.3  1993/08/30  08:53:51  ram
''' patch8: wrongly stated that patchlevel.h should not be part of MANIFEST.new
'''
''' Revision 3.0.1.2  1993/08/24  12:13:32  ram
''' patch3: typo fixes
'''
''' Revision 3.0.1.1  1993/08/19  06:42:23  ram
''' patch1: leading config.sh searching was not aborting properly
'''
''' Revision 3.0  1993/08/18  12:10:14  ram
''' Baseline for dist 3.0 netwide release.
'''
'''
.de Ex		\" Start of Example
.sp
.in +5
.nf
..
.de Ef		\" End of Example
.sp
.in -5
.fi
..
.SH NAME
metaconfig \- a Configure script generator
.SH SYNOPSIS
.B metaconfig
[ \-\fBdhkmostvwGMV\fR ]
[ \-\fBL \fIdir\fR ]
.SH DESCRIPTION
.I Metaconfig
is a program that generates Configure scripts. If you don't know what a
Configure script is, please skip to the \fBTUTORIAL\fR section of this
manual page. If you want a full (formal) description of the way to
use \fImetaconfig\fR and its units, please look at the \fBREFERENCE\fR
section. The following is a quick introduction and reference for
knowledgeable users.
.PP
.B Metaconfig
operates from set of
.I units
which define everything that metaconfig knows about portability.
Each unit is self-contained, and does not have to be registered anywhere
other than by inclusion in either the public U directory or your private
U directory.
If the dist package (of which metaconfig is a part) is installed in LIB,
then the public U directory is LIB/dist/mcon/U. On this machine, the
LIB directory is $privlibexp.
Your private U directory, if you have one,
is in the top level directory of your package.
Before you can run \fImetaconfig\fR you must do a several things:
.IP \(bu 5
Create a .package file in the package's top level directory by running
\fIpackinit\fR.
This program will ask you about your package and remember what you tell
it so that all the dist programs can be smart.
.IP \(bu
Consult the Glossary (in LIB/dist/mcon) and write your shell scripts and
C programs in terms of the symbols that metaconfig knows how to define.
You don't need to tell metaconfig which symbols you used, since metaconfig
will figure that out for you.
.IP \(bu
Generate any .SH scripts needed to write Makefiles or shell scripts that
will depend on values defined by Configure.
There is a program called \fImakeSH\fR that will help you convert a plain
script into a script.SH template; some editing will still need to be performed
on the resulting .SH file to move the variable configuration part in the
top part of the script (see inline comments generated by \fImakeSH\fR within
your .SH file).
.IP \(bu
Create a MANIFEST.new file in your top level directory that lists all the
files in your package. This file will remain private and will not be
part of the final distribution.
The filename should be the first field on each line.
After some whitespace you can add a short comment describing your file.
Only source files should be listed in there. The special file
\fIpatchlevel.h\fR (which is handled and maintained by the patching tools --
see \fIpat\fR(1)) should be part of the MANIFEST.new file, but may be
silently ignored by some tools. As a rule of
thumb, only files maintained by RCS should be listed in there,
the \fIpatchlevel.h\fR file being one important exception.
.IP \(bu
Optionally, you may wish to create a MANIFEST file, which will be an
exported version of your MANIFEST.new. That file must be made part of
the release, i.e. listed in both your MANIFEST.new and MANIFEST itself.
One of the \fImetaconfig\fR units knows about this file and will force
Configure to perform a release check, ensuring all the files listed
there are part of the distribution. The MANIFEST and MANIFEST.new
files should be distinct, not links.
.IP \(bu
Copy any .U files that you want to modify to your private U directory.
Any .U files in your private U directory will be used in preference to
the one in the public U directory.
For example, one way to force inclusion of any unit is to copy the End.U
file to your .U directory and add the name of the unit you want as
a dependency on the end of the ?MAKE: line.
Certain units can ONLY be forced in this way, namely those of the form
Warn_*.U and Chk_*.U.
You can also customize certain default Configure variables by copying
Myinit.U to your package's private U directory and setting the variables in
that unit.
.PP
Now you are ready to run \fImetaconfig\fR. That will create a \fIConfigure\fR
file, and optionally a \fIconfig_h.SH\fR file (if your sources make any use
of C symbols).
The generated files will automatically be added to your MANIFEST.new
if necessary. Do not forget to update your MANIFEST file though.
.PP
In order to create new units, do the following:
.IP \(bu 5
Copy a similar unit to a new .U file.
The name you choose should be the name of a variable generated by the unit,
although this is only a convenience for you, not a requirement.
It should be 12 or less characters to prevent filename chopping.
Actually, it should probably be 10 or less so that those who want to use RCS
can have a .U,v on the end without chopping.
Metaconfig uses the case of the first letter to determine if any variable is
actually produced by this unit, so don't Capitalize your unit
name if it is supposed to produce a shell variable.
.IP \(bu
Edit the new .U file to do what you want.
The first ?MAKE: line indicates the dependencies; before the final list
colon all the variables this unit defines, and after the final colon
all the variables (or other units) on which this unit depends.
It is very important that these lists be accurate. If a dependency is
optional and a default value can be used, you should prefix the dependency
with a '+' sign. The corresponding unit will not be loaded to compute the
symbol, unless really required by another unit.
.IP \(bu
To the extent possible, parameterize your unit based on shell
variable defined on ?INIT: lines.
This will move the variable definitions up to the Init.U unit,
where they can be overridden by definitions in Myinit.U, which is
included after Init.U.
.IP \(bu
Add the definition of any C symbols desired as ?H: lines.
A line beginning with ?H:?%<: in the .U file will be added to the eventual
config.h file if and only if metaconfig decides that this unit is needed.
The %< stands for the unit's name, which happens to be the name of
the file too (without .U) if you followed the convention.
Always put a comment on each ?H: line in case one of the variable
substitutions earlier on the line starts a comment without finishing it.
Any shell variable starting with d_ may do this, so beware.
If you ommit the ?%<:, then metaconfig will try to intuit the symbol whose
definition is needed prior any inclusion in config.h.
.IP \(bu
Add glossary definitions as ?S: lines for shell variables and ?C:
lines for C preprocessor variables.
See a current unit for examples.
It is VERY important to start each entry with a left justified symbol
name, and end each entry with a ?C:. or ?S:. line.  The algorithm
that translates C preprocessor symbol entries for the Glossary into
comments for config.h depends on this.
.IP \(bu
Make sure the order of all your ? lines is right.  The correct order is:
.sp
.RS +10
.PD 0
.TP 15
?RCS: and ?X:
basically just comments
.TP
?MAKE:
metaconfig dependencies
.TP
?Y:
unit layout directive
.TP
?S:
glossary shell definitions
.TP
?C:
glossary C definitions
.TP
?H:
config.h definitions
.TP
?M:
confmagic.h definitions
.TP
?W:
wanted symbols
.TP
?V:
visible symbols
.TP
?F:
files created by this unit
.TP
?T:
temporary shell symbols used
.TP
?D:
optional dependencies default value
.TP
?O:
used to mark obsolete units
.TP
?LINT:
metalint hints
.TP
?INIT:
shell symbols initializations
.PD
.RE
.PP
Here is an example to show the ordering of the lines and the various
formats allowed:
.Ex
?RCS: \$RCS-Id\$
?RCS: Copyright information
?RCS: \$RCS-Log\$
?X:
?X: A contrived example
?X:
?MAKE:d_one two: three +four Five
?MAKE:	-pick add \$@ %<
?Y:DEFAULT
?S:d_one:
?S:	First shell symbol, conditionally defines ONE.
?S:.
?S:two:
?S:	Second shell symbol, value for TWO.
?S:.
?C:ONE:
?C:	First C symbol.
?C:.
?C:TWO:
?C:	Second C symbol.
?C:.
?H:#\$d_one ONE	/**/
?H:#define TWO "\$two"
?H:#\$d_one ONE_TWO "\$two"
?H:.
?M:flip: HAS_FLIP
?M:#ifndef HAS_FLIP
?M:#define flip(x) flop(x)
?M:#endif
?M:.
?W:%<:one_two
?V:p_one p_two:p_three
?F:file ./ftest !tmp
?T:tmp var
?D:two='undef'
?LINT:change three
?INIT:two_init='2'
: shell code implementing the unit follows
p_one='one'
p_two='two'
p_three="$three"
.Ef
Let me state it one more time: the above unit definition is a \fIfake\fR
one to only show the different possibilities. Such a unit would serve
little purpose anyway... Some more advanced features are not described
here. Please refer to the \fBREFERENCE\fR section for more complete
information.
.IP \(bu
Put the unit into the public or private U directory as appropriate.
.IP \(bu
Rerun \fImetaconfig\fR.
.IP \(bu
Send your unit to ram@acri.fr (Raphael Manfredi) for inclusion
in the master copy, if you think it's of general interest.
.PP
In order to add a new program to be located:
.IP \(bu
Edit Loc.U, and add the name of the program both to the ?MAKE: line
(between the two colons) and to either loclist or trylist (depending
on whether the program is mandatory or not).
.IP \(bu
Rerun metaconfig.
.IP \(bu
Send your unit to me for inclusion in the master copy, if you think it's
of general interest.
.PP
Notes for writing .U files:
.IP * 5
Always use "rm -f" because there are systems where rm is interactive by
default.
.IP *
Do not use "set -- ..." because '--' does not work with every shell. Use
"set x ...; shift".
.IP *
Always use echo " " (with a space) because of Eunice systems.
.IP *
Use only programs that came with V7, so that you know everyone has them.
.IP *
Use \$\&contains when you want to grep conditionally, since not all
greps return a reasonable status.
Be sure to redirect the output to /dev/null, by using '>/dev/null 2>&1'.
.IP *
Use "if test" rather than "if [...]" since not every sh knows the
latter construct.
.IP *
Use the myread script for inputs so that they can do shell escapes
and default evaluation.  The general form is
.Ex
case "\$grimble" in
\&'') dflt=452;;
*) dflt="\$grimble";;
esac
rp='How many grimbles do you have?'
\&. ./myread
grimble="\$ans"
.Ef
.IP *
Use the getfile script when asking for a file pathname in order to
have optional ~name expansion and sanity checks. See the Getfile.U
unit for a full decription.
.IP *
Always put a
.Ex
	\$startsh
.Ef
at the top of every generated script that is going to be launched
or sourced by \fIConfigure\fR.
.IP *
Never assume common UNIX-isms like the fact that an object file ends
with a \fI.o\fR and that a library name ends with \fI.a\fR.
Use the \fI\$_o\fR and \fI\$_a\fR variables instead (see Unix.U).
.IP *
When doing a compile-link-execute test, always write it like this:
.Ex
\$\&cc \$\&ccflags \$\&ldflags try.c -o try \$\&libs
.Ef
because some systems require that linking flags be specified before
the compiled target (with the exception of trailing linking libraries).
.IP *
Issue important messages on file descriptor #4, by using '>&4' to redirect
output. Only those messages will appear when the \fB\-s\fR switch is
given to \fIConfigure\fR on the command line (silent mode).
.IP *
Always try to determine whether a feature is present in the most
specific way--don't say "if bsd" when you can grep libc.  There
are many hybrid systems out there, and each feature should stand
or fall by itself.
.IP *
Always try to determine whether a feature is present in the most
general way, so that other packages can use your unit.
.IP *
When in doubt, set a default and ask.  Don't assume anything.
.IP *
If you think the user is wrong, allow for the fact that he may be right.
For instance, he could be running Configure on a different system than
he is going to use the final product on.
.PP
Metaconfig reserves the following names in your directory, and if you use such
a name it may get clobbered or have other unforeseen effects:
.Ex
.MT/*
Configure
Wanted
Obsolete
configure
config_h.SH
confmagic.h
U/*
MANIFEST.new
.Ef
Additionally, Configure may clobber these names in the directory it is run in:
.Ex
UU/*
config.sh
config.h
.Ef
'''
''' O p t i o n s
'''
.SH OPTIONS
The following options are recognized by \fImetaconfig\fR:
.TP 15
.B \-d
Turn on debug mode. Not really useful unless you are debugging \fImetaconfig\fR
itself.
.TP
.B \-h
Print help message and exit.
.TP
.B \-k
Keep temporary directory, so that you may examine the working files used
by \fImetaconfig\fR to build your \fIConfigure\fR script. Useful only when
debugging the units.
.TP
.B \-m
Assume lots of memory and swap space. This will speed up symbol lookup in
source files by a significant amount of time, at the expense of memory
consumption...
.TP
.B \-o
Map obsolete symbols on new ones. Use this switch if you still have some
obsolete symbols in your source code and do not want (or cannot) remove
them for now. The obsolete symbols are otherwise ignored, although that
will give you a warning from \fImetaconfig\fR.
.TP
.B \-s
Turn silent mode on.
.TP
.B \-t
Trace symbols as they are found.
.TP
.B \-v
Turn verbose mode on.
.TP
.B \-w
Assume Wanted file is up-to-date. This will skip the time and memory
consuming phase of source code scanning, looking for known symbols.
Use it only when you know your source file have not changed with respect
to the pool of \fImetaconfig\fR symbols used.
.TP
.B \-G
Also provide a GNU \fIconfigure\fR-like front end to the generated
.I Configure
script, to be included in the distribution as well. This is only
a wrapper around the
.I Configure
script naturally, but it lets people familiar with the GNU tool to
not be lost when facing a new distribution.
.TP
\fB\-L\fI dir\fR
Override default library location. Normally only useful for metaconfig
maintainers to locally use the units being developped instead of the
publicly available ones. The \fIdir\fR specified is the one containing the
units \fIU\fR directory.
.TP
.B \-M
Allow production of a \fIconfmagic.h\fR file to automagically remap some
well-known symbols to some other alternative, like \fIbcopy\fR() being
remapped transparently to \fImemcpy()\fR when not available. This option
is turned on automatically when a \fIconfmagic.h\fR file exists in the
top-level directory. Simply remove that file if you wish to disable this
option permanently.
.TP
.B \-V
Print version number and exit.
'''
''' T u t o r i a l
'''
.SH TUTORIAL
This (long) section is an introduction to \fImetaconfig\fR, in which we will
learn all the basics. If you already know how to use \fImetaconfig\fR, you
may safely skip to the next section.
'''
.SS Overview
.PP
Usually when you want to get some source package to compile on a given
platform you have to edit the main Makefile (assuming there is one!),
choose a C compiler, make sure you have the proper libraries, and then
fire the \fImake\fR command. If the package is reasonably well written, it
will compile (without a warning being an option :-). In itself, the last
sentence is a real performance, since given the variety of UNIX platforms
available today and the diversity of flavours, that means the author of the
package has gone into deep trouble to figure out the right choices given
some standard trial, guessing and messing around with system includes and
types.
.PP
However, despite all his talent, the author cannot possibly know that
some system has a broken system call, or that some sytem structure lacks
one otherwise standard field, or simply wheter a given include file exists
or not. And I'm not considering the implicit assumptions, like the type
returned by the \fImalloc()\fR function or the presence of the \fIrename()\fR
system call to name a few. But that knowledge is necessary to achieve real
portability.
.PP
Now let's not abuse ourselves. Using that information requires greater
skills, yet it can lead to more portable programs since it is then
written in a system-independant fashion and relies only on the fact that
some assumption is true or false on a particular system, each assumption
being unrelated with each other. That is to say, we do not say: We're on
a BSD system or we are on a USG system. That's too fuzzy anyway nowadays.
No, we want to say to the source code: this system does not have the
.I rename()
system call and \fImalloc()\fR returns a \fI(void *)\fR
value.
.PP
Metaconfig is a tool that will let you do just that, with the additional
benefit of not having to hand-edit the Makefile if all goes well. By
running \fImetaconfig\fR, you create a shell script named \fIConfigure\fR.
Lots of efforts have been devoted to the Configure script internals to ensure
it will run on 99% of the existing shells available as of this writing.
Configure will probe the target system, asking questions when in doubt and
gather all the answers in one single shell file, which in turn can be used
to automatically generate configured Makefiles and C include files.
.PP
There is only a limited (but quite large) set of symbols available for your
shell scripts and C programs. They are all documented in the Glossary file.
All you need to do is learn about them and start using them to address
portability and configuration problems. Then, by running \fImetaconfig\fR,
a suitable Configure script will be generated for your package.
.PP
The Configure script is built out several units (more than 300), each
unit being responsible for defining a small number of shell and/or C
symbols. Units are assembled together at the final stage, honoring
the dependency graph (one unit may need the result of several other
units which are then placed before in the script).
'''
.SS Symbols
.PP
Symbols are the most important thing in the \fImetaconfig\fR world. They
are the smallest recognized entity, usually a word, and can be granted
a value at the end of the Configure execution. For instance, the C
pre-processor symbol \fIHAS_RENAME\fR is a \fImetaconfig\fR symbol that is
guranteed to be defined if, and only if, the \fIrename()\fR system call
is present. Likewise, the \fI\$\&ranlib\fR shell variable will be set to
either ':' or 'ranlib' depending on whether the call to the \fIranlib\fR
program is needed to order a library file. How this works is not important
for now, what is important is to understand that those symbols are given
a \fIlife\fR (i.e. a value) upon \fIConfigure\fR execution.
.PP
Using symbols is relatively straightforward. In a C source file, you simply
use the symbol value, as a pre-processor directive (for instance an: \fI#ifdef
HAS_RENAME\fR) or, if the symbol value is a string, directly as you would use
a macro in C. And in a shell file or a Makefile, you may reference a shell
symbol directly.
.PP
Actually, I'm lying, because that's not completely as magic as the previous
paragraph could sound. In a C file, you need to include the Configure-produced
\fIconfig.h\fR file, and you must wrap your shell script or Makefile in a .SH
file and you may reference the shell symbol only in the variable
substitution part of that .SH file. More on this later.
'''
.SS Source Files
.PP
Symbols may only appear in a limited set of source files, because
\fImetaconfig\fR will only scan those when looking for known symbols, trying
to figure out which units it will need. You may use C symbols in C source
files, i.e. files with a \fI.c\fR, \fI.h\fR, \fI.y\fR or \fI.l\fR extension,
and shell symbols are looked for only in .SH files.
.PP
In order to get the value of a symbol, a C file needs to include the special
\fIconfig.h\fR file, which is produced by \fIConfigure\fR when C symbols
are present. And .SH files are run through a shell, producing a new file.
However, in the top section of the .SH file, the special \fIconfig.sh\fR
file (also produced by running \fIConfigure\fR) is sourced, and variable
substitutions apply. Actually, \fIconfig.h\fR is produced by running the
\fImetaconfig\fR-produced \fIconfig_h.SH\fR file, again using variable
substitution. So we're going to look at that a little more closely since
this is the heart of the whole \fIconfiguration\fR scheme...
'''
.SS Variable Substitution
.PP
There is shell construct called \fIhere document\fR which enables a
command to take an input specified within the script itself. That
input is interpreted by the shell as a double-quoted string or a
single quoted string depending on the form of the here document
specification.
.PP
To specify a here document, the '<<' token is used, followed by a single
identifier. From then on, the remaining script lines form the input for
the command, until the here document is found on a line by itself.
Shell substitution (including shell variable substitutions) is done
unless the identifier is surrounded by single quotes. For instance:
.Ex
var='first'
tar='second'
echo "--> first here document:"
cat <<EOM
var='\$var'
tar='\$\&tar'
EOM
echo "--> second here document:"
cat <<'EOM'
echo \$var
echo \$\&tar
EOM
echo "--> end."
.Ef
will produce, when run through a shell:
.Ex
--> first here document:
var='first'
tar='second'
--> second here document:
echo \$var
echo \$\&tar
--> end.
.Ef
The first here document has its content interpreted whilst the second
one is output as-is. Both are useful in a .SH script, as we are about to see.
'''
.SS Using .SH Scripts
.PP
A .SH script is usually produced by running the \fIMakeSH\fR script other
an existing file, transforming \fIfile\fR into a \fIfile.SH\fR. Let's take
a single example. Here is a little script (let's call it \fIintsize\fR)
which prints a single message, the size of the \fBint\fR datatype in C.
Unfortunately, it has the value hardwired in it, thusly:
.Ex
#!/bin/sh
intsize='4'
echo "On this machine, the int type is \$\&intsize bytes"
.Ef
Let's run \fImakeSH\fR on it by typing '\fImakeSH intsize\fR'. We get a single
\fIintsize.SH\fR file that looks like this:
.Ex
case \$CONFIG in
\&'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. \$TOP/config.sh
	;;
esac
: This forces SH files to create target in same directory as SH file.
: This is so that make depend always knows where to find SH derivatives.
case "\$0" in
*/*) cd \`expr X\$0 : 'X\\\\(.*\\\\)/'\` ;;
esac
echo "Extracting intsize (with variable substitutions)"
: This section of the file will have variable substitutions done on it.
: Move anything that needs config subs from !NO!SUBS! section to !GROK!THIS!.
: Protect any dollar signs and backticks that you do not want interpreted
: by putting a backslash in front.  You may delete these comments.
\$spitshell >intsize <<!GROK!THIS!
\$startsh
\&!GROK!THIS!

: In the following dollars and backticks do not need the extra backslash.
\$spitshell >>intsize <<'!NO!SUBS!'
intsize='4'
echo "On this machine, the int type is \$\&intsize bytes"
\&!NO!SUBS!
chmod 755 intsize
\$\&eunicefix intsize
.Ef
The first part of this script (in the \fIcase\fR statement) is trying to
locate the \fIconfig.sh\fR file, in order to source it. The \fI\$CONFIG\fR
variable is false by default, by true when \fIconfig.sh\fR has been sourced
already (which would be the case if this file was executed from within
\fIConfigure\fR itself, but let's not confuse the issue here).
.PP
Once the \fIconfig.sh\fR file has been sources, all the shell symbols
defined by \fIConfigure\fR are set. We know reach a second case statement,
used to change the current directory should a path be used to
reach this program (for instance if we said '\fIsh ../scripts/intsize.SH\fR',
we would first run '\fIcd ../scripts\fR' before continuing). If you do not
understand this, don't worry about it.
.PP
Here comes the intersting stuff. This script uses the \fI\$spitshell\fR
variable, and it's not something we know about...yet. If you look through
the Glossary file, you will see that this is a variable known by
\fImetaconfig\fR. If you make this file part of your distribution (by including
it in the MANIFEST.new file, we'll come back to that later on) and run
\fImetaconfig\fR, then the \fIConfigure\fR script will determine a suitable
value for this variable and it will be set in \fIconfig.sh\fR. Same goes for
\fI\$startsh\fR and the mysterious \fI\$\&eunicefix\fR at the end. On a
reasonable system, the relevant part of \fIconfig.sh\fR would look like this:
.Ex
spitshell='cat'
startsh='#!/bin/sh'
eunicefix=':'
.Ef
Ah! We're getting there. Now it looks familiar. We're facing a single
\fIcat\fR command whose input comes from a variable-interpolated here
document and whose output is redirected to \fIintsize\fR. The value
will be that of \fI\$startsh\fR, i.e. '#!/bin/sh'. Fine so far.
.PP
Then we reach the second here document expansion, to get the remaining of
the script. This time, the here document symbol is surrounded by single
quotes so the contents will be appended verbatim to the \fIintsize\fR file.
So, by running '\fIsh intsize.SH\fR', we get the following output:
.Ex
Extracting intsize (with variable substitutions)
.Ef
and by looking at the produced intsize file, we see:
.Ex
#!/bin/sh
intsize='4'
echo "On this machine, the int type is \$\&intsize bytes"
.Ef
which is exactly what we had at the beginning. So far, it's a no-operation
procedure... But, how marvelous! It so happens (pure coincidence, trust me!),
that \fImetaconfig\fR knows about the \fI$\&intsize\fR shell symbol. By moving
the initialization of intsize to the variable-interpolated area of the .SH
script and initializing it with the \fIConfigure\fR-computed value,
and removing the now useless comments added by \fImakeSH\fR, we get:
.Ex
case \$CONFIG in
\&'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. \$TOP/config.sh
	;;
esac
case "\$0" in
*/*) cd \`expr X\$0 : 'X\\\\(.*\\\\)/'\` ;;
esac
echo "Extracting intsize (with variable substitutions)"
\$\&spitshell >intsize <<!GROK!THIS!
\$\&startsh
intsize='\$\&intsize'
\&!GROK!THIS!

\$\&spitshell >>intsize <<'!NO!SUBS!'
echo "On this machine, the int type is \$\&intsize bytes"
\&!NO!SUBS!
chmod 755 intsize
\$\&eunicefix intsize
.Ef
Of course, running this script through a shell will again output the same
script. But if we run \fIConfigure\fR on a machine where an \fBint\fR is
stored as a 64 bits quantity, \fIconfig.sh\fR will set \fIintsize\fR to
8 and the \fIintsize\fR script will bear the right value and print:
.Ex
On this machine, the int type is 8 bytes
.Ef
which is correct. Congratulations! We have just configured a shell script!!
'''
.SS Producing config.h
.PP
We can now have a look at the way \fIconfig.h\fR is produced out of
\fIconfig_h.SH\fR. We know that running \fIConfigure\fR produces a
\fIconfig.sh\fR script (how exactly this is done is not strictly
relevant here, but for the curious, it's another here document
substitution within \fIConfigure\fR itself). The \fIconfig_h.SH\fR
itself is built by \fImetaconfig\fR at the same time \fIConfigure\fR
is, provided you make use of at least one C symbol within your sources.
.PP
Let's have a look at some random \fIconfig_h.SH\fR file to see what
really happens:
.Ex
case \$CONFIG in
\&'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. \$TOP/config.sh
	;;
esac
case "\$0" in
*/*) cd \`expr X\$0 : 'X\\\\(.*\\\\)/'\` ;;
esac
echo "Extracting config.h (with variable substitutions)"
sed <<!GROK!THIS! >config.h -e 's!^#undef!/\*#define!' -e 's!^#un-def!#undef!'
/*
 * This file was produced by running the config_h.SH script, which
 * gets its values from config.sh, which is generally produced by
 * running Configure.
 *
 * Feel free to modify any of this as the need arises.  Note, however,
 * that running config.h.SH again will wipe out any changes you've made.
 * For a more permanent change edit config.sh and rerun config.h.SH.
 */

/* Configuration time: \$\&cf_time
 * Configured by: \$\&cf_by
 * Target system: \$\&myuname
 */

#ifndef _config_h_
#define _config_h_

/* bcopy:
 *	This symbol is maped to memcpy if the bcopy() routine is not
 *	available to copy strings.
 */
/* HAS_BCOPY:
 *	This symbol is defined if the bcopy() routine is available to
 *	copy blocks of memory. You should not use this symbol under
 *	normal circumstances and use bcopy() directly instead, which
 *	will get mapped to memcpy() if bcopy is not available.
 */
#\$\&d_bcopy HAS_BCOPY	/**/
#ifndef HAS_BCOPY
#ifdef bcopy
#un-def bcopy
#endif
#define bcopy(s,d,l) memcpy((d),(s),(l))		/* mapped to memcpy */
#endif

/* HAS_DUP2:
 *	This symbol, if defined, indicates that the dup2 routine is
 *	available to duplicate file descriptors.
 */
#\$\&d_dup2 HAS_DUP2	/**/

/* I_STRING:
 *	This symbol, if defined, indicates to the C program that it should
 *	include <string.h> (USG systems) instead of <strings.h> (BSD systems).
 */
#\$\&i_string I_STRING		/**/

#endif
\&!GROK!THIS!
.Ef
At the top of the file, we recognize the standard .SH construct that we
have already studied in detail. Next comes the extraction of the file
itself, via a here document with variable substitutions. However, here
we do not use a plain \fIcat\fR but a \fIsed\fR instead, since we need
to do some further editing on-the-fly. We'll see why later on, so let's
forget about it right now.
.PP
We now reach the leading comment, and the file is tagged with the
configuration time, the target system, etc... (those variables coming
from the sourced \fIconfig.sh\fR file have been set up by \fIConfigure\fR).
That comment header is followed by a '#ifndef' protection to guard against
multiple inclusions of this file. Then comes the heart of the file...
.PP
It helps to know that \fI\$d_*\fR and \fI\$i_*\fR variables are set to
either '\fIdefine\fR' or '\fIundef\fR' by \fIConfigure\fR, depending on
wether a function or an include file is present on the system or not.
That means the:
.Ex
#\$\&d_bcopy HAS_BCOPY /**/
.Ef
line will be expanded to either:
.Ex
#define HAS_BCOPY /**/
.Ef
if the \$\&d_bcopy variable is set to 'define' or:
.Ex
#undef HAS_BCOPY /**/
.Ef
if \$\&d_bcopy was set to 'undef', because the feature was not there. However,
that's not what gets written in the \fIconfig.h\fR file because of the
\fIsed\fR filter we have already seen, which will transform the second form
into:
.Ex
/*#define HAS_BCOPY /**/
.Ef
That's a handy form for later editing of \fIconfig.h\fR because you only need
to remove the leading '/*' if you want to override \fIConfigure\fR's choice.
Likewise, you may add a single '/*' at the beginning of a '#define' line
to avoid the definition of a particular symbol. This is why each symbol
definition is protected by a trailing '/**/', to close the leading
comment opened by '/*' (comments are not nested in C).
.PP
Now transforming '#undef' into '/*#define' is nice, but if we want to actually
write a '#undef', we're stuck... unless we write it as '#un-def' and let
\fIsed\fR fix that to '#undef' while producing \fIconfig.h\fR, which is what
is actually done here.
.PP
The same kind of reasoning applies to those two lines:
.Ex
#\$\&d_dup2 HAS_DUP2   /**/
#\$\&i_string I_STRING      /**/
.Ef
and assuming \fIconfig.sh\fR defines:
.Ex
d_dup2='define'
i_string='undef'
.Ef
we'll get in the produced \fIconfig.h\fR:
.Ex
#define HAS_DUP2   /**/
/*#define I_STRING      /**/
.Ef
Clear as running water? Good!
.PP
Now it should be obvious that by including \fIconfig.h\fR in all your
C source files, you get to know what \fIConfigure\fR has guessed on
your system. In effect, by using those symbols, you are writing
configured C code, since \fImetaconfig\fR will know that you need
those symbols and will generate a suitable \fIconfig_h.SH\fR file as
well as all the necessary code in \fIConfigure\fR to compute a
proper value for them (by assigning values to associated shell variables).
'''
.SS Running Metaconfig
.PP
Let's focus on the \fImetaconfig\fR program for a while to understand how
it uses its units and your source code to produce all the needed configuration
files. If you intend to write new units, you should have a good understanding
of the whole scheme.
.PP
Assuming your MANIFEST.new file is properly set and lists all the source
files you wish to configure, and that you have run \fIpackint\fR in your
root source directory to create a \fI.package\fR file, you may run
\fImetaconfig\fR and you'll get the following:
.Ex
\$ metaconfig
Locating units...
Extracting dependency lists from 312 units...
Extracting filenames (*.[chyl] and *.SH) from MANIFEST.new...
Building a Wanted file...
.in +2
Scanning .[chyl] files for symbols...
Scanning .SH files for symbols...
.in -2
Computing optimal dependency graph...
.in +2
Building private make file...
Determining loadable units...
Updating make file...
.in -2
Determining the correct order for the units...
Creating Configure...
Done.
.Ef
The first phase looks for all the units files (ending with .U) in the public
directory first, then in your private one. If you copy a public file in your
private U directory (i.e. a directory named U at the top level of your package),
it will override the public version. Once it has a list of all the available
units, it parses them and extracts all the ?MAKE: lines to know about the
dependencies and the known shell symbols. It also focuses on the ?H: lines to
learn about the C symbols and which shell symbols needs to be computed to get
a proper value for that C symbol (so we have another level of dependencies
here).
.PP
Next, the proper filenames are extracted from the MANIFEST.new files and a
\fIWanted\fR file is built: that file lists all the C symbols and the shell
symbols needed for that package. We first scan the C-type files for C symbols,
then propagate the dependencies to their associated shell symbols (gathered
from ?H: lines). Next .SH files are scanned and finally all the shell symbols
are known.
.PP
A temporary Makefile is built and metaconfig tries to \fImake\fR all the shell
symbols to see what commands (listed on the second ?MAKE: lines) are
executed, and thus which units are really needed. Optional units not otherwise
required are removed and a second Makefile is generated. This time, we know
about all the units and their respective orders, optional units having been
removed and default values computed for their shell symbols. The \fIConfigure\fR
script can then be generated, along with \fIconfig_h.SH\fR. We're done.
'''
.SS Conventions
.PP
Proper conventions needs to be followed to make the whole process sound.
There is a case convention for units and a variable naming convention.
.PP
All units should have their first letter lower-cased, unless they are
special units. By special, we mean they do not really define new
shell variables that can be used by the user in his .SH files, but rather
units producing scripts or shell variables that are to be used internally
by the \fIConfigure\fR script. Typical examples are the \fIInit.U\fR
file which is the main variable initialization, or \fIMyread.U\fR which
produces the \fImyread\fR script used almost everywhere in \fIConfigure\fR
when a question is to be asked to the user.
.PP
Non-special units then subdivise in two distinct groups: units defining
variables associated to a C symbol and units defining shell variables of
their own. The first group is further divided in variables related to
include files (their name begin with \fIi_\fR) and variables related to
other definitions (name starting with \fId_\fR). The second group have
names standing for itself, for instance \fIcc.U\fR defines the \fI\$\&cc\fR
shell variable whose value is the C compiler to be used.
.PP
Special units sometimes reserve themselves some pre-defined variable and
return "results" in other well-known variables. For instance, the \fImyread\fR
script produced by Myread.U expects the prompt in \fI\$rp\fR, the default
answer in \fI\$dflt\fR and places the user answer in \fI\$ans\fR. This is
not documented in this manual page: you have to go and look at the unit
itself to understand which variables are used and how the unit is to be
used.
'''
.SS Using The Glossary
.PP
The Glossary file is automatically produced by the \fImakegloss\fR script,
which extracts the information from ?S:, ?C: and ?MAKE: lines and reformats
them into an alphabetically sorted glossary.
It is important to read the Glossary to know about the symbols you are
allowed to use. However, the Glossary will not tell you how to use them.
Usually, that's up to you.
.PP
One day, you will probably write your own units and you will know enough
about \fImetaconfig\fR to do so quickly and efficiently. However, never
forget to properly document your work in the ?S: and ?C: lines, or other
people will not be able to reuse it. Remember about the time where you
had only the Glossary and this manual page to get started.
'''
.SS Conclusion
.PP
Now that you know the \fImetaconfig\fR basics, you should read the
\fIDESCRIPTION\fR section, then skip to the \fIREFERENCE\fR section
to learn about all the gory details such as the allowed syntax for
unit control lines (lines starting with a '?') or the distinct MAKE
commands you are allowed to use.
.SH REFERENCE
This section documents the internals of \fImetaconfig\fR, basically the
unit syntax, the special units you should know about and the hint files.
'''
.SS General Unit Syntax
.PP
A metaconfig unit is divided into two distinct parts. The header section
(lines starting with '?') and a shell section (code to be included in
the \fIConfigure\fR script). It is possible to add '?X:' comments anywhere
within the unit, but the other '?' lines (also called \fIcontrol lines\fR)
have a strict ordering policy.
.PP
If a control line is too long, it
is possible to use a continuation by escaping the final new-line with a
backslash and continuing on the next line (which should then be indented by
spaces or tabs).
.PP
The following is a formal description of each of the control lines. Unless
stated otherwise, the order of this presentation is the order to be used
within the unit.
.TP 5
?RCS: \fIfree text\fR
To be used for RCS comments, at the top of the unit.
.TP
?X: \fIany text\fR
General purpose comments. May appear anywhere in the unit but must be left
justfied. For RCS comments, please use the ?RCS: comment form.
.TP
?MAKE:\fIsymbol list\fR: \fIdependency list\fR [\fI+optional\fR]
This is the first dependency line. The first \fIsymbol list\fR should list
all the symbols built by this unit (i.e. whose value is computed by the
shell section of the unit). Symbols should be space separated. If a defined
symbol is for internal use only and should  not appear in the generated
\fIconfig.sh\fR file, then it should be preceded by a '+' (not to be confused
with optional dependencies defined hereafter).
The second part of the list (after the middle ':') is the unit dependency.
It should list all the needed special units, as well as all the symbols
used by the shell implementation. If a symbol is nedded but its configuration
value is not critical, it can be preceded by a '+', in which case it is
called a conditional dependency: its corresponding unit will be loaded if,
and only if, that symbol is otherwise really wanted; otherwise the default
value will be used.
.TP
?MAKE:\fItab\fR \fIcommand\fR
There can be one or more command lines following the initial dependency lines.
Those commands will be executed when the unit is wanted to load them into
\fIConfigure\fR. See the paragraph about make commands for more information.
Note that the leading \fItab\fR character is required before the \fIcommand\fR.
.TP
?Y:\fIlayout\fR
Declare a layout directive for this unit. That directive may be one of the
strings \fItop\fR, \fIdefault\fR or \fIbottom\fR (case does not matter,
recommended style is to spell them out uppercased). If omitted, \fIdefault\fR
is assumed.
.sp
This directive is only required if you wish to force a unit at the top or
the bottom of the generated \fIConfigure\fR script, as unit dependencies
permit it. Important questions may thus be forced at the beginning. Within
the same layout class, units are sorted alphabetically with two special
cases for d_* and i_* units, forced respectively at the top and bottom of
their classes (but these should belong to the default class).
.sp
It you force at the top a unit whose dependencies require all the other
unit to precede it, you achieve nothing interesting. Therefore, that directive
should really be used to increase the priority of some interactive units
that do not depend on many other user-visible symbols, like path-related
questions.
.TP
?S:\fIsymbol_name\fR [(\fIobsolete symbol list\fR)]:
Introduces a shell symbol. This first line names the symbol, optionally
followed by a list enclosed between parenthesis and giving the obsolete
equivalent. Those obsolete symbols will be remapped to the new
\fIsymbol_name\fR if the \fB\-o\fR option is given to \fImetaconfig\fR.
.TP
?S:\fIany text, for Glossary\fR
Basically a comment describing the shell symbol, which will be extracted
by \fImakegloss\fR into the Glossary file.
.TP
?S:.
Closes the shell symbol comment.
.TP
?C:\fIsymbol_name\fR [~ \fIalias\fR] [(\fIobsolete symbol list\fR)]:
Introduces a new C symbol. The \fIalias\fR name is the name under which
the C symbol will be controlled, i.e. if the \fIalias\fR symbol is wanted,
then that C symbol will be written in the \fIconfig_h.SH\fR file. Usually,
the alias is just '%<' (stands for the unit's name) and there is also
a ?W: line mapping a C symbol to the \fIalias\fR. Also the relevant parts
of the ?H: lines are explicitely protected by a '?%<' condition. See
the symbol aliasing paragraph for more details.
The remaining of the line is the optional \fIobsolete symbol list\fR,
which lists old equivalents for the new \fIsymbol_name\fR.
.TP
?C:\fIany text, for Glossary and config_h.SH\fR
Basically a comment describing the C symbol, which will be extracted
by \fImakegloss\fR into the Glossary file and by \fImetaconfig\fR into
the \fIconfig_h.SH\fR file if the symbol is wanted (or if its alias is
wanted when symbol aliasing is used).
.TP
?C:.
Closes the C symbol comment.
.TP
?H:?\fIsymbol\fR:\fIconfig_h.SH stuff\fR
This is the general inclusion request into \fIconfig_h.SH\fR. The line is
only written when the guarding \fIsymbol\fR is really wanted. This general
form is needed when C symbol aliasing was used. Otherwise, if you use one
of the other "standard" forms, the guarding is automatically done by
\fImetaconfig\fR itself.
.TP
?H:#\fI\$d_var VAR\fR "\fI\$var\fR"
Conditionally defines the \fIVAR\fR C symbol into \fI\$var\fR when \fI$d_var\fR
is set to '\fIdefine\fR'. Implies a '?\fIVAR\fR:' guarding condition, and
\fImetaconfig\fR automatically links \fIVAR\fR to its two shell variable
dependencies (i.e. both \fI\$d_var\fR and \fI\$var\fR will be flagged as
\fIwanted\fR if \fIVAR\fR is used in C sources).
.TP
?H:#define \fIVAR\fR [\fIoptional text\fR]
Always defines the \fIVAR\fR C symbol to some value. Implies a '?\fIVAR\fR:'
guarding condition. An automatic shell dependency is made to the unit itself.
.TP
?H:#define \fIVAR(x,y,z)\fR \fI\$var\fR
Always defines the macro \fIVAR\fR to be the value of the \fI\$var\fR variable.
It is up to the unit to ensure \fI\$var\fR holds a  sensible value. An
automatic dependency between the C macro \fIVAR\fR and the shell variable
is established, and the whole line is guarded by an implicit '?\fIVAR\fR:'.
.TP
?H:#\fI\$d_var VAR\fR
Conditionally defines \fIVAR\fR if \fI\$d_var\fR is set to '\fIdefine\fR'.
Implies a '?\fIVAR\fR:' guarding condition. An automatic shell dependency is
generated towards \fI\$d_war\fR.
.TP
?H:#define \fIVAR\fR "\fI\$var\fR"
Assigns a configured value to the \fIVAR\fR C symbol. Implies a '?\fIVAR\fR:'
gurading condition. An automatic shell dependency is generated to link
\fIVAR\fR and \fI\$var\fR.
.TP
?H:.
Closes the \fIconfig_h.SH\fR inclusion requests.
.TP
?M:\fIC symbol\fR: \fIC dependencies\fR
Introduces magic definition concerning the C symbol, for \fIconfmagic.h\fR,
and defines the guarding symbol for the remaining ?M: definitions. This
line silently implies '?W:%<:\fIC symbol\fR', i.e. the unit will be loaded
into Configure if the C symbol appears within the C sources, whether magic
is used or not. The C dependencies are activated when magic is used, in order
to force their definition in \fIconfig_h.SH\fR. However, if magic is \fBnot\fR
used but the C symbol appears in the source without the needed C dependencies,
you will be warned every time the Wanted file is built, since it may be a
portability issue (and also because the unit is unconditionally loaded into
Configure whenever the C symbol is used, regardless of the other ?C: lines
from the unit).
.TP
?M:\fIcpp defs\fR
Defines the magic cpp mapping to be introduced in confmagic.h whenever the
concerned symbol is used. There is an implicit '?\fIsym\fR' guarding where
\fIsym\fR is the symbol name defined by the leading ?M: line.
.TP
?M:.
Closes the \fIconfmagic.h\fR inclusion request.
.TP
?W:\fIshell symbol list\fR:\fIC symbol list\fR
Ties up the destiny of the shell symbols with that of the C symbols: if any
of the C symbols listed is wanted, then all the shell symbols are marked
as wanted. Useful to force inclusion of a unit (shell symbol list set to
\&'%<') when the presence of some C symbol is detected. The shell symbol list
may be left empty, to benefit from the side effect of C symbol location
within the builtin pre-processor (symbol being \fIdefined\fR for that
pre-processor if located in the source). To look for patterns with a space
in them, you need to quote the C symbols within simple quotes, as in
\&'struct timezone'.
.TP
?V:\fIread-only symbols\fR:\fIread-write symbols\fR
This is a \fImetalint\fR hint and should be used only in special units
exporting some shell variables. The variables before the middle ':'
are exported read-only (changing them will issue a warning), while
other symbols may be freely read and changed.
.TP
?F:\fIfiles created\fR
This line serves two purposes: it is a \fImetalint\fR hint, and also
a placeholder for future \fIjmake\fR use. It must list three kind of files:
the temporary one which are created for a test, the private UU ones created
in the UU directory for later perusal, and the public ones left in the
root directory of the package. Temporary files must be listed with a
preceding '!' character (meaning "no! they're not re-used later!"), private
UU files should be preceded by a './' (meaning: to use them, say \fI./file\fR,
not just \fIfile\fR), and public ones should be named as-is.
.TP
?T:\fIshell temporaries\fR
Another \fImetalint\fR hint. This line lists all the shell variables used
as temporaries within the shell section of this unit.
.TP
?D:\fIsymbol\fR='\fIvalue\fR'
Initialization value for symbols used as conditional dependencies. If no
?D: line is found, then a null value is used instead. The \fImetalint\fR
program will warn you if a symbol is used at least once as a conditional
dependency and does not have a proper ?D: initialization. It's a good
practice to add those lines even for a null initialization since it
emphasizes on the possibly optional nature of a symbol.
.TP
?O:\fIany message you want\fR
This directive indicates that this unit is obsolete as a whole. Whenever
usage of any of its symbols is made (or indirect usage via dependencies),
the message is output on the screen (on stderr). You can put one ore more
lines, in which case each line will be printed, in order.
.TP
?LINT:\fImetalint hints\fR
See the \fImetalint\fR manual page for an explaination of the distinct
hints that can be used.
.TP
?INIT:\fIinitialization code\fR
The initialization code specified by this line will be loaded at the top
of the \fIConfigure\fR script provided the unit is needed.
'''
.SS C Symbol Aliasing
.PP
Sometimes it is not possible to rely on \fImetaconfig\fR's own default
selection for \fIconfig_h.SH\fR comments and C symbol definition. That's
where aliasing comes into play. Since it's rather tricky to explain, we'll
study an example to understand the underlying mechanism.
.PP
The d_const.U unit tries to determine whether or not your C compiler
known about the \fIconst\fR keyword. If it doesn't we want to remap
that keyword to a null string, in order to let the program compile.
Moreover, we want to automatically trigger the test when the \fIconst\fR
word is used.
.PP
Here are the relevant parts of the d_const.U unit:
.Ex
?MAKE:d_const: cat cc ccflags Setvar
?MAKE:	-pick add \$@ %<
?S:d_const:
?S:	This variable conditionally defines the HASCONST symbol, which
?S:	indicates to the C program that this C compiler knows about the
?S:	const type.
?S:.
?C:HASCONST ~ %<:
?C:	This symbol, if defined, indicates that this C compiler knows about
?C:	the const type. There is no need to actually test for that symbol
?C:	within your programs. The mere use of the "const" keyword will
?C:	trigger the necessary tests.
?C:.
?H:?%<:#$\&d_const HASCONST	/**/
?H:?%<:#ifndef HASCONST
?H:?%<:#define const
?H:?%<:#endif
?H:.
?W:%<:const
?LINT:set d_const
?LINT:known const
: check for const keyword
echo " "
echo 'Checking to see if your C compiler knows about "const"...' >&4
$cat >const.c <<'EOCP'
main()
{
	const char *foo;
}
EOCP
if $\&cc -c $\&ccflags const.c >/dev/null 2>&1 ; then
	val="$\&define"
	echo "Yup, it does."
else
	val="$\&undef"
	echo "Nope, it doesn't."
fi
set d_const
eval $\&setvar
.Ef
First we notice the use of a ?W: line, which basically says: "This unit
is wanted when the \fIconst\fR keyword is used in a C file.". In order
to conditionally remap \fIconst\fR to a null string in \fIconfig.h\fR,
I chose to conditionally define \fIHASCONST\fR via \fI\$\&d_const\fR.
.PP
However, this raises a problem, because the \fIHASCONST\fR symbol is not
going to be used in the sources, only the \fIconst\fR token is. And the
?H: line defining \fIHASCONST\fR is implicitely guarded by '?HASCONST'.
Therefore, we must add the explicit '?%<' constraint to tell \fImetaconfig\fR
that those lines should be included in \fIconfig_h.SH\fR whenever the
\&'%<' symbol gets wanted (%< refers to the unit's name, here \fId_const\fR).
.PP
That's almost perfect, because the ?W: line will want \fId_const\fR whenever
\fIconst\fR is used, then the ?H: lines will get included in the
\fIconfig_h.SH\fR file. However, the leading comment (?C: lines) attached to
\fIHASCONST\fR is itself also guarded via \fIHASCONST\fR, i.e. it has an
implicit '?HASCONST' constraint. Hence the need for \fIaliasing\fR the
\fIHASCONST\fR symbol to '%<'.
.PP
The remaining part of the unit (the shell part) is really straightforward.
It simply tries to compile a sample C program using the \fIconst\fR keyword.
If it can, then it will define \fI\$\&d_const\fR via the \fI\$\&setvar\fR
fonction (defined by the \fISetvar.U\fR unit). See the paragraph about
special units for more details.
'''
.SS Make Commands
.PP
On the ?MAKE: command line, you may write a shell command to be executed as-is
or a special \fI-pick\fR command which is trapped by \fImetaconfig\fR and
parsed to see what should be done. The leading '-' is only there to prevent
\fImake\fR from failing when the command returns a non-zero status -- it's
not really needed since we use '\fImake -n\fR' to resolve the dependencies,
but I advise you to keep it in case it becomes mandatory in future versions.
The syntax of the \fIpick\fR command is:
.Ex
-pick \fIcmd\fR \$@ \fItarget_file\fR
.Ef
where \fI\$@\fR is the standard macro within Makefiles standing for the current
target (the name of the unit being built, with the final .U extension stripped).
The \fIcmd\fR part is the actual \fImetaconfig\fR command to be run, and the
\fItarget_file\fR is yet another parameter, whose interpretation depends on
the \fIcmd\fR itself. It also has its final .U extension stripped and normally
refers to a unit file, unless it start with './' in which case it references
one of the \fImetaconfig\fR control files in the '\fI.MT\fR directory.
.PP
The available commands are:
.TP 10
add
Adds the \fItarget_file\fR to \fIConfigure\fR.
.TP
add.Config_sh
Fills in that part of \fIConfigure\fR producing the \fIconfig.sh\fR file.
Only used variables are added, conditional ones (from conditional dependencies)
are skipped.
.TP
add.Null
Adds the section initializing all the shell variables used to an empty string.
.TP
c_h_weed
Produces the \fIconfig_h.SH\fR file. Only the necessary lines are printed.
.TP
cm_h_weed
Produces the \fIconfmagic.h\fR file. Only the necessary lines are printed.
This command is only enabled when the \fB\-M\fR switch is given, or when a
\fIconfmagic.h\fR file already exists.
.TP
close.Config_sh
Adds the final 'EOT' symbol on a line by itself to end the here document
construct producing the \fIconfig.sh\fR file.
.TP
prepend
Prepends the content of the target to the \fItarget_file\fR if that file is
not empty.
.TP
weed
Adds the unit to \fIConfigure\fR like the \fIadd\fR command, but make some
additional tests to remove the '?\fIsymbol\fR' and '%\fIsymbol\fR' lines
from the \fItarget_file\fR if the symbol is not wanted or conditionally
wanted. The '%' form is only used internally by \fImetaconfig\fR while
producing its own .U files in the '\fI.MT\fR' directory.
.TP
wipe
Same as \fIadd\fR really, but performs an additional macro substitution.
The available macros are described in the \fIHardwired Macros\fR paragraph.
.PP
As a side note, \fImetaconfig\fR generates a \fI-cond\fR command internally
to deal with conditional dependencies. You should not use it by yourself,
but you will see it if scanning the generated \fIMakefile\fR in the \fI.MT\fR
directory.
'''
.SS Hardwired Macros
.PP
The following macros are recognized by the \fIwipe\fR command and subsituted
before inclusion in \fIConfigure\fR:
.TP 10
<BASEREV>
The base revision number of the package, derived from \fI.package\fR.
.TP
<DATE>
The current date.
.TP
<MAINTLOC>
The e-mail address of the maintainer of this package, derived from
your \fI.package\fR.
.TP
<PACKAGENAME>
The name of the package, as derived from your \fI.package\fR file.
.TP
<PATCHLEVEL>
The patch level of the \fImetaconfig\fR program.
.TP
<VERSION>
The version number of the \fImetaconfig\fR program.
.PP
Those macros are mainly used to identify the \fImetaconfig\fR version that
generated a particular \fIConfigure\fR script and for which package it
was done. The e-mail address of the maintainer is hardwired in the leading
instructions that \fIConfigure\fR prints when starting.
.PP
Recent \fImetaconfig\fR versions understand a much more general syntax
of the form:
.Ex
	<\$variable>
.Ef
which is replaced at Configure-generation time by the value of \fIvariable\fR
taken from your \fI.package\fR file. Eventually, the old hardwired macro
format will disappear, and <\$baserev> will replace <BASEREV> in all the
supplied units.
'''
.SS Special Units
.PP
The following special units are used to factorize code and provide higher
level functionalities. They either produce a shell script that can be
sourced or a shell variable that can be \fIeval\fR'ed. Parameter passing
is done via well-know variables, either named or anonymous like \$1, \$2,
etc... (which can be easily set via the shell \fIset\fR operator).
When \fIConfigure\fR executes, it creates and goes into a \fIUU\fR directory,
so every produced script lies in there and does not interfere with the
files from your package.
.PP
Here are the sepcial units that you should know about, and the way to use
them.
.TP 5
Cppsym.U
This unit produces a shell script called \fICppsym\fR, which can be used
to determine whether any symbol in a list is defined by the C preprocessor
or C compiler you have specified.
It can determine the status of any symbol, though the symbols in \fI$al\fR
(attribute list) are more easily determined.
.TP
Csym.U
This sets the \$csym shell variable, used internally by \fIConfigure\fR to
check whether a given C symbol is defined or not. A typical use is:
.Ex
set symbol result [-fva] [previous]
eval \$\&csym
.Ef
That will set the \fIresult\fR variable to 'true' if the 
function [-f],
variable [-v] or
array [-a]
is defined, 'false' otherwise. If a previous value is given and the \fB\-r\fR
switch was provided to \fIConfigure\fR (see the \fIConfigure Options\fR
paragraph), then that value is re-used without questioning.
.sp
The way this computation is done depends on the answer the user gives to
the question \fIConfigure\fR will ask about whether it should perform an
.I nm
extraction or not. If the exctraction was performed, the unit simply looks
through the symbol list, otherwise it performs a compile-link test, unless
.B \-r
was given to reuse the previously computed value, naturally...
.TP
End.U
By copying this unit into your private \fIU\fR directory and appending
dependencies on the ?MAKE: line, you can force a given unit to be loaded
into \fIConfigure\fR even if it is not otherwise wanted. Some units may
only be forced into \fIConfigure\fR that way.
.TP
Filexp.U
This unit produces a shell script \fIfilexp\fR which will expand filenames
beginning with tildes. A typical use is:
.Ex
exp_name=\`./filexp \$name\`
.Ef
to assign the expanded file name in \fIexp_name\fR.
.TP
Findhdr.U
This unit produces a \fIfindhdr\fR script which is used to locate the
header files in \fI$\&usrinc\fR or other stranger places using cpp capabilities.
The script is given an include file base name like 'stdio.h' or 'sys/file.h'
and it returns the full path of the inlcude file and a zero status if found,
or an empty string and a non-zero status if the file could not be located.
.TP
Getfile.U
This unit produces a bit of shell code that must be sourced in order to get
a file name and make some sanity checks. Optionally, a ~name expansion is
performed.
.sp
To use this unit, \fI\$rp\fR and \fI\$dflt\fR must hold the question and the
default answer, which will be passed as-is to the \fImyread\fR script
(see forthcoming \fIMyread.U\fR). The \fI\$fn\fR variable controls the
operation and the result is returned into \fI\$ans\fR.
.sp
To locate a file or directory, put 'f' or 'd' in \fI$fn\fR. If a '~' appears,
then ~name substitution is allowed. If a '/' appears, only absolute pathnames
are accepted and ~name subsitutions are always expanded before returning.
If '+' is specified, existence checks are skipped. If 'n'
appears within \fI\$fn\fR, then the user is allowed to answer 'none'.
.sp
Usually, unless you asked for portability, ~name substitution occurs when
requested. However, there are some times you wish to bypass portability and
force the substitution. You may use the 'e' letter (expand) to do that.
.sp
If the special 'l' (locate) type is used, then the \fI\$fn\fR variable must
end with a ':', followed by a file basename. If the answer is a directory,
the file basename will be appended before testing for file existence. This
is useful in locate-style questions like this:
.Ex
dflt='~news/lib'
: no need to specify 'd' or 'f' when 'l' is used
fn='l~:active'
rp='Where is the active file?'
\&. ./getfile
active="\$ans"
.Ef
.sp
Additionally, the 'p' (path) letter may be used in conjunction with 'l' to
tell \fIgetfile\fR that an answer without a '/' in it should be accepted,
assuming that it will be in everyone's PATH at the time this value will be
needed.
.sp
Also useful is the possibility to specify a list of answers that should be
accepted verbatim, bypassing all the checks. This list must be within
parenthesis and items must be comma separated, with no interleaving spaces.
Don't forget to quote the resulting string since parenthesis are meaningful
to the shell. For instance:
.Ex
dflt='/bin/install'
fn='/fe~(install,./install)'
rp='Use which install program?'
\&. ./getfile
install="\$ans"
.Ef
would let the user only specify fully qualified paths referring to existing
files, but still allow the special "install" and "./install" answers as-is
(assuming of course something will deal with them specially later on in the
chain since they do not conform with the general expected frame).
.sp
If the answer to the question is 'none', then the existence checks are skipped
and the empty string is returned. Note that since \fIgetfile\fR calls
\fImyread\fR internally, all the features available with \fImyread\fR apply
here to.
.sp
If a completely expanded value is needed (for instance in a Makefile), you
may use the \fI\$ansexp\fR variable which is always set up properly
by \fIgetfile\fR
as the expanded version of \fI\$ans\fR. Of course, it will not expand ~name if
you did not allow that in the first place in the \fI\$fn\fR variable.
.TP
Inhdr.U
This unit produces the \fI\$inhdr\fR shell variable, used internally by
\fIConfigure\fR to check whether a set of headers exist or not. A typical
use is:
.Ex
set header i_header [ header2 i_header2 ... ]
eval \$\&inhdr
.Ef
That will print a message, saying whether the header was found or not and
set the \fIi_header\fR variable accordingly. If more than one header
is specified and the first header is not found, we try the next one, until
the list is empty or one is found.
.TP
Inlibc.U
This unit produces the \fI\$inlibc\fR shell variable, used internally
by \fIConfigure\fR to check whether a given C function is defined or not.
A typical use is:
.Ex
set function d_func
eval \$\&inlibc
.Ef
That will print a message, saying whether the function was found or not
and set \fI\$d_func\fR accordingly. Internally, it used the \fI\$\&csym\fR
routine.
.TP
Loc.U
This important unit produces a shell script \fIloc\fR which can be used
to find out where in a list of directories a given file lies. The first
argument specifies the file to be located, the second argument is what
will be returned if the search fails, and the reamining arguments are a
list of directories where the file is to be searched. For instance:
.Ex
dflt=\`./loc sendmail.cf X /usr/lib /var/adm/sendmail /lib\`
.Ef
would set \fI\$dflt\fR to \fIX\fR if no \fIsendmail.cf\fR file was found
under the listed directories, or something like \fI/usr/lib/sendmail.cf\fR
on some systems. See also \fIGetfile.U\fR.
.TP
MailAuthor.U
This unit needs to be included on the ?MAKE: line of your own private End.U
to make it into \fIConfigure\fR. It offers the user to register himself to
the author, optionally being notified when new patches arrive or receiving
them automatically when issued. You need to install \fImailagent\fR to do
this (at least version 3.0).
.TP
MailList.U
This unit needs to be included on the ?MAKE: line of your own private End.U
to make it into \fIConfigure\fR. It offers the user to subscribe or
unsubscribe to a mailing list where discussion related to the package are
taking place. You need to run \fIpackinit\fR and answer the mailing list
related questions to set up the proper variables in your \fI.package\fR
before this unit may become operational.
.TP
Myinit.U
Copy this unit into your private \fIU\fR directory to add your own default
values to some internal variables. This unit is loaded into \fIConfigure\fR
after all the default initializations have been done.
.TP
Myread.U
This unit produces the \fImyread\fR shell script that must be sourced in
order to do a read. It allows shell escapes, default assignment and
parameter evaluation, as documented in the Instruct.U unit. It also allows
dynamic setting of the \fB\-d\fR option, which will be used for the remaining
of the script execution.
.sp
To use this unit, \fI\$rp\fR must hold the question and \fI\$dflt\fR should
contain the default answer. The question will be printed by the script
itself, and the result is returned in the \fI\$ans\fR variable.
.sp
Here is a typical usage:
.Ex
dflt='y'
rp='Question?'
\&. ./myread
value="\$ans"
.Ef
See the unit itself for more information.
.TP
Oldconfig.U
This unit must be part of your dependency ?MAKE: line when some of your
units tries to reuse an old symbol value. This unit is responsible for
getting the old answers from \fIconfig.sh\fR or providing useful hints
when running on a given platform for the first time. See the \fIConfigure
Hints\fR paragraph for more information about hints.
.TP
Prefixit.U
The purpose of this unit is to detect changes in the installation prefix
directory to recompute automatically suitable defaults from previous answers.
It relies on the value of the \fI\$oldprefix\fR variable which holds the
previous prefix directory when it changed, and is empty otherwise. For instance,
if the prefix was changed from \fI/opt\fR to \fI/usr/local\fR, then the
previous binary installation directory will be changed from \fI/opt/bin\fR
to \fI/usr/local/bin\fR, or will remain unchanged if it was, say, \fI/bin\fR.
.sp
You need to call \fBset\fR before issuing an \fBeval\fR on \fI\$prefixit\fR,
such as:
.Ex
set dflt var [dir]
eval \$prefixit
.Ef
which would set \fI\$dflt\fR to \fI\$var\fR or \fI\$prefix/dir\fR depending
on whether the prefix remained the same or not. If \fIdir\fR is the
string \fInone\fR, a single space value in \fI\$dflt\fR is kept as-is, even
when the prefix changes. If \fIdir\fR is omitted, then \fI\$dflt\fR is set
to an empty string if the prefix changed, to \fI\$var\fR otherwise.
.TP
Prefixup.U
The intent of thit unit is similar to that of Prefixit.U, i.e. it helps
fixing the default string to accomodate prefix changes. However, the shell
variable \fI\$prefixup\fR, when evaluated, will only restore ~name expansions,
should prefix use such an escape mechanism. Use it as:
.Ex
set dflt
eval \$prefixup
.Ef
before prompting via \fIgetfile\fR for instance. If the prefix does not
make use of ~name expanstion, then the above will be a no-op on the \fI$dflt\fR
variable, naturally.
.TP
Typedef.U
This unit produces the \fI\$typedef\fR shell variable, used internally by
\fIConfigure\fR to check whether a typedef exists or not. A typical
use is:
.Ex
set typedef val_t default [ includes ]
eval \$\&typedef
.Ef
This will set the variable \fIval_t\fR to the value of \fIdefault\fR if the
typedef was not found among the listed include files, or to \fItypedef\fR
if found. If no include files are specified, the unit looks
in \fI<sys/types.h>\fR only. If you specifiy some includes, only those are
looked at.
.TP
Unix.U
The purpose of this unit is to define some of the most common UNIX-isms
via variables which can be altered from the command line or via proper
hint files. In particular, \fI\$_exe\fR, \fI\$_o\fR and \fI\$_a\fR
are set. All the units should refer to \fI\$_o\fR and not to \fI.o\fR
directly. The '.' is part of these variables.
.TP
Setvar.U
This unit produces the \fI$setvar\fR variable, which is used internally
by \fIConfigure\fR to set a \fIdefine\fR/\fRundef\fR value to a given symbol,
emitting a warning when it suddenly changes from a previous value. For instance:
.Ex
val="\$\&define"
set d_variable
eval \$\&setvar
.Ef
If the previous \fI\$d_variable\fR value was non-null and \fI\$val\fR is
different, a "whoa" warning is issued.
.TP
Whoa.U
This unit produces the \fIwhoa\fR script, which emits a warning when the
\fIvalue\fR in variable whose name is \fI\$var\fR is not the same as
its old previous value held in \fI\$was\fR. Upon return, \fI\$td\fR and
\fI\$tu\fR hold the proper value to \fIdefine\fR or \fIundef\fR the variable.
See examples in \fIInlibc.U\fR.
'''
.SS Builtin Pre-processor
.PP
Each unit to be included in \fIConfigure\fR is ran through a built-in
pre-processor. Pre-processor statements are introduced by the '@' character
('#' is the shell comment character). It functions merely as the C
pre-processor does but allows for shell and perl escapes. Here are the
available functions:
.TP 10
@if \fIexpression\fR
If \fIexpression\fR is true, continue loading code until @end, @elsif or @else.
.TP
@elsif \fIexpression\fR
Alternative choice. If \fIexpression\fR is true, continue loading code until
@end, another @elsif or @else.
.TP
@else
Default code to be loaded if the @if \fIexpression\fR was false and none
of the optional @elsif matched. Load until @end.
.TP
@end
Close the conditional loading statement opened by @if.
.TP
@define \fIsymbol\fR
Tells the pre-processor that \fIsymbol\fR is defined from now on.
.PP
The conditional \fIexpression\fR can include symbol names (value is
true if symbol is wanted or defined via \fI@define\fR or shell/perl
escapes. Those atoms can be combined using the traditional boolean
operators '!' for negation, '&&' for logical and, and '||' for logical
or.
.PP
Text enclosed within single brackets is a shell test, while text between
double brakets is a perl test. Namely the expressions:
.Ex
{ \fIshell text\fR }
{{ \fIperl text\fR }}
.Ef
are translated into:
.Ex
if \fIshell text\fR >/dev/null 2>&1; then exit 0; else exit 1; fi
if (\fIperl text\fR) {exit 0;} else {exit 1;}
.Ef
and the exit status is used in the standard way to get a boolean value,
i.e. 0 is true and everything else is false. Note that only simple
conditions can be expressed in perl, until some complex code can be
loaded within \fImetaconfig\fR and executed.
.PP
The built-in pre-processor can be used to finely tune some units
(see \fId_gethname.U\fR for a complex example) depending on the symbols
actually used by the program or the files present in the distribution.
For instance, the \fIOldconfig.U\fR uses a test like:
.Ex
@if {test -d ../hints}
.Ef
and \fIConfigure\fR will contain hint-dependent code only if there is
a \fIhints\fR directory in the package's top level directory. Note that
tests are ran from within the '\fI.MT\fR' directory, hence the needed
\&'../' in the test.
.PP
The pre-processor can also be used to avoid putting useless code when
a symbol is not defined. Units defining more than one symbol can be
protected that way (since the unit is loaded as a whole) by gathering
symbol-dependent code within an @if/@end pair. For instance:
.Ex
@if I_TIME || I_SYS_TIME || I_SYS_TIME_KERNEL
need_time_h='true'
@else
need_time_h='false'
@end
.Ef
will test whether the source code makes any use of one of the three
symbols that control the \fItime.h\fR or \fIsys/time.h\fR inclusion
and define the shell symbol accordingly. That gives \fIConfigure\fR
a feedback on what the sources need and avoid the drawback of having
fixed frozen units.
.PP
Via the '?W:' lines, you can get intersting combinations. For instance,
the \fIi_time.U\fR unit needs to know whether the C sources make any
use of the \fIstruct timezone\fR type. Therefore, the line:
.Ex
?W::timezone
.Ef
is used for its side-effect of defining the symbol \fItimezone\fR for
the pre-processor. The unit code can then say:
.Ex
@if timezone
for s_timezone in '-DS_TIMEZONE' ''; do
@else
s_timezone=''
@end

\&... code using s_timezone ...

@if timezone
done
@end
.Ef
and have an extra loop trying two successive values for the \fIs_timezone\fR
variable, but only if needed.
'''
.SS Obsolete Symbols
.PP
Obsolete symbols are preserved to ease the transition with older
.I metaconfig
units. Unless the \fB\-o\fR switch is passed to \fImetaconfig\fR they will
be ignored. However, an \fIObsolete\fR file will be generated, telling you
which files are making use of those obsolete symbols and what are the new
symbols to be used.
.PP
The lifetime for obsolete symbols is one full revision, i.e. they will
be removed when the next base revision is issued (patch upgrades do not
count of course). Therefore, it is wise to translate your sources and
start using the new symbols as soon as possible.
'''
.SS Configure Hints
.PP
It may happen that the internal configuration logic makes the wrong choices.
For instance, on some platform, the \fIvfork()\fR system call is present but
broken, so it should not be used. It is not possible to include that knowledge
in the units themselves, because that might be a temporary problem which the
vendor will eventually fix, or something that was introduced by a new OS
upgrade.
.PP
Anyway, for all those tiny little problems that are too system-specific,
\fImetaconfig\fR provides hint files support. To use it, you need to create
a \fIhints\fR directory in the package's top level directory, and have it
when you run \fImetaconfig\fR. That will load the hint-related part from
\fIOldconfig.U\fR.
.PP
From then on, you may pre-set some of the shell variables \fIConfigure\fR uses
in an OS-specific .sh file. There is code in \fIOldconfig.U\fR that tries
to guess which hint files are needed by computing a standard name based
on the system OS name, the kernel name, the release number, etc... Since
this information is likely to change rapidly, I'm not documenting it here.
You have to reverse engineer the code from \fIOldconfig.U\fR.
.PP
When you first release your package, your hints file directory should be empty.
If the users of your package complain that they have problem with
\fIConfigure\fR defaults on a particular system, you have to see whether this
is a platform-specific problem or a general one. In the former case, it's
time to introduce a new hint file, while in the latter, the corresponding
unit should be revised.
.PP
For instance, SGI systems are known to have a broken \fIvfork()\fR system
call, as of this writing. And the corresponding hint file name is \fIsgi.sh\fR.
So all you need to do is create a \fIhints/sgi.sh\fR file in which you write:
.Ex
d_vfork="\$\&define"
.Ef
which will always remap \fIvfork\fR on \fIfork\fR (see \fId_vfork.U\fR). When
running on SGI systems for the first time, \fIConfigure\fR will detect that
there is an \fIhints/sgi.sh\fR file, and that we are on an IRIX machine
(the kernel name is often /irix), therefore it will propose \fIsgi\fR as a
possible hint.
If the user accepts it, and since the \fI\$\&d_vfork\fR value is modified
via the \fI$\&setvar\fR call, a \fIwhoa!\fR will be emitted to warn that we
are about to override the value computed by \fIConfigure\fR.
.PP
Note that you don't have to provide \fIall\fR the hints known by
\fIOldconfig.U\fR. If a hint file is missing, it will not be proposed as a
possible choice. The heuristic tests ran to compute the possible hint
candidates are flaky. If you have new values or different tests, please send
them to me...
'''
.SS Overriding Choices
.PP
If you create a \fIconfig.over\fR file in the top level directory,
\fIConfigure\fR will ask you if you wish to load it to override the default
values. This is done prior creation of the \fIconfig.sh\fR file, so it gives
you a chance to patch the values stored in there.
.PP
This is distinct from the hints approach in that it is a local file, which
the user is free to create for his own usage. You should not provide such
a file yourself, but let the user know about this possibility.
'''
.SS Configure Options
.PP
The \fIConfigure\fR script may be called with some options specified on the
command line, to slightly modify its behaviour. Here are the allowed options:
.TP 10
.B \-d
Use defaults for all answers.
.TP
.B \-e
Go on without questioning past the production of \fIconfig.sh\fR.
.TP
.B \-f \fIfile\fR
Use the specified file as a default configuration. If this switch is not
used, the configuration is taken from \fIconfig.sh\fR, when present.
.TP
.B \-h
Print help message and exit.
.TP
.B \-r
Reuse C symbols value if possible. This will skip the costly \fInm\fR
symbol extraction. If used the first time (with no previous configuration
file), \fIConfigure\fR will try to compile and link a small program in order
to know about the presence of a symbol, or absence thereof.
.TP
.B \-s
Silent mode. Only strings printed on file descriptor #4 will be seen on
the screen (that's the important messages). It's not possible to completely
turn off any output, but you may use '\fIConfigure -ders >/dev/null 2>&1\fR'
to have a full batch run with no output and no user interaction required.
.TP
.B \-D\fI symbol=value\fR
Pre-defines \fIsymbol\fR to bear the specified \fIvalue\fR. It is also
possible to use '\fB-D\fI symbol\fR' which will use a default value
of 'define'.
.TP
.B \-E
Stop at the end of the configuration questions, after having produced
a \fIconfig.sh\fR. This will not perform any '\fImake depend\fR' or .SH files
extraction.
.TP
.B \-K
Knowledgeable user. When you use this option, you know what you are
doing and therefore the \fIconfig.sh\fR file will always be handled as if it
was intended to be re-used, even though it might have been generated on
an alien system. It also prevents aborting when \fIConfigure\fR detects
an unusable C compiler or a wrong set of C flags.
Further shortcuts might be turned on by this option as well in the future.
This option is documented in the \fIConfigure\fR usage message, to remind
us about its existence, but the given description is hoped to be cryptic
enough. :-)
.TP
.B \-O
Allow values specified via a \fB\-D\fR or \fB\-U\fR to override settings from
any loaded configuration file. This is not the default behaviour since the
overriding will not be propagated to variables derived from those you are
presently altering. Naturally, without \fB-O\fR, the setting is only
done when no configuration file is loaded, which is safe since derivative
variables have not been computed yet...
.TP
.B \-S
Perform variable substitution on all the .SH files. You can combine it with the
\fB\-f\fR switch to propagate any configuration you like.
.TP
.B \-U\fI symbol=\fR
Pre-sets \fIsymbol\fR to bear an empty value. It is also
possible to use '\fB-U\fI symbol\fR' which will set \fIsymbol\fR to 'undef'.
.TP
.B \-V
Print the version number of the \fImetaconfig\fR that generated this
.I Configure
script and exit.
'''
.SS Running Environment
Upon starting, \fIConfigure\fR creates a local \fIUU\fR directory and runs
from there. The directory is removed when Configure ends, but this means
you must run the script from a place where you can write, i.e. not from
a read-only file system.
.PP
You can run \fIConfigure\fR remotely though, as in:
.Ex
	../package/Configure
.Ef
to configure sources that are not present locally. All the generated files
will be put in the directory where you're running the script from. This magic
is done thanks to the src.U unit, which is setting the \fI\$src\fR
and \fI\$rsrc\fR variables to point to the package sources. That path is
full or relative, depending on whether \fIConfigure\fR was invoked via a
full or relative path.
.PP
From within the \fIUU\fR subdirectory, you can use \fI\$rsrc\fR to access the
source files (units referring to source files link hints shall always use
this mechanism and not assume the file is present in the parent directory).
All the Makefiles should use the \$src variable as a pointer to the sources
from the top of the build directory (where \fIConfigure\fR is run), either
directly or via a VPATH setting.
.PP
When running \fIConfigure\fR remotely, the .SH files are extracted in the
build directory, not in the source tree. However, it requires some kind of
a \fImake\fR support to be able to compile things in a build directory whilst
the sources lie elsewhere.
'''
.SS Using Magic Redefinitions
.PP
By making use of the \fB\-M\fR switch, some magic remappings may take place
within a \fIconfmagic.h\fR file. That file needs to be included after
\fIconfig.h\fR, of course, but also after all the other needed include files.
Namely:
.Ex
#include "config.h"
\&...
\&... \fIother inclusions\fR ...
\&...
#include "confmagic.h"
.Ef
Typically, \fIconfmagic.h\fR will attempt to remap \fIbcopy()\fR
on \fImemcpy()\fR if no \fIbcopy()\fR is available locally, or transform
\fIvfork\fR into \fIfork\fR when necessary, hence making it useless to
bother about the \fIHAS_VFORK\fR symbol.
.PP
This configuration magic is documented in the Glossary file.
'''
.SS Unit Templates
.PP
There is a set of unit templates in the \fImetaconfig\fR source directory,
which are intended to be used by a (not yet written) program to quickly
produce new units for various kind of situations. No documentation for this
unfinished project, but I thought I would mention it in the manual page in
case you wish to do it yourself and then contribute it...
.SH AUTHORS
Larry Wall <lwall@netlabs.com> for version 2.0.
.br
Harlan Stenn <harlan@mumps.pfcs.com> for important unit extensions.
.br
Raphael Manfredi <ram@hptnos02.grenoble.hp.com>.
.br
Many other contributors for the
\fImetaconfig\fR units. See the credit file for a list.
.SH FILES
.TP 10
.PD 0
LIB/dist/mcon/U/*.U
Public unit files
.TP
U/*.U
Private unit files
.TP
LIB/dist/mcon/Glossary
Glossary file, describing all the metaconfig symbols.
.TP
Obsolete
Lists all the obsolete symbols used by the sources.
.TP
Wanted
Lists all the wanted symbols.
.PD
.sp
.in +5
where LIB is $privlibexp.
.in -5
.SH BUGS
Units are sometimes included unnecessarily if one of its symbols is
accidentally mentioned, e.g. in a comment.
Better too many units than too few, however.
.SH "SEE ALSO"
pat($manext), makeSH($manext), makedist($manext), metalint($manext)
!GROK!THIS!
chmod 444 metaconfig.$manext
