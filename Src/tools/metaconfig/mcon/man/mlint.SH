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
echo "Extracting mcon/man/metalint.$manext (with variable substitutions)"
$rm -f metalint.$manext
$spitshell >metalint.$manext <<!GROK!THIS!
.TH METALINT $manext "Version $VERSION PL$PATCHLEVEL"
''' @(#) Manual page for metalint
'''
''' $Id: mlint.SH 78389 2004-11-30 00:17:17Z manus $
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
''' Revision 3.0.1.9  1997/02/28  16:30:25  ram
''' patch61: new "create" and "empty" lint directives
''' patch61: documented new messages
'''
''' Revision 3.0.1.8  1995/09/25  09:18:07  ram
''' patch59: documented new ?Y: directive
''' patch59: fixed my e-mail address
'''
''' Revision 3.0.1.7  1995/07/25  14:18:51  ram
''' patch56: added two new warnings for : comments lines in Configure
'''
''' Revision 3.0.1.6  1994/10/29  16:33:56  ram
''' patch36: documents new ?F: lines and the related metalint warnings
''' patch36: removed statement in BUGS since all warnings may now be shut
'''
''' Revision 3.0.1.5  1994/05/06  15:20:30  ram
''' patch23: added -L switch to override public unit repository path
''' patch23: two new warnings concerning last unit lines
'''
''' Revision 3.0.1.4  1994/01/24  14:20:39  ram
''' patch16: can now easily suppress warning about made "special units"
'''
''' Revision 3.0.1.3  1993/11/10  17:37:39  ram
''' patch14: documents stale ?M: dependency check
'''
''' Revision 3.0.1.2  1993/10/16  13:52:23  ram
''' patch12: added support for ?M: lines and fixed some typos
'''
''' Revision 3.0.1.1  1993/08/19  06:42:24  ram
''' patch1: leading config.sh searching was not aborting properly
'''
''' Revision 3.0  1993/08/18  12:10:15  ram
''' Baseline for dist 3.0 netwide release.
'''
'''
.SH NAME
metalint \- a metaconfig unit consistency checker
.SH SYNOPSIS
.B metalint
[ \-\fBhklsV\fR ]
[ \-\fBL \fIdir\fR ]
.SH DESCRIPTION
.I Metalint
parses the units and performs some extensive consistency checks, to make sure
the whole set is sound. Due to the relatively huge amount of units available,
it is becoming very difficult to maintain the units manually, and an automated
process can be of real help, although not perfect.
.PP
.I Metalint
operates from within your top level package directory and is used to make sure
your own private units are correctly relying on the publicly available units.
If you intensively develop new units, you should run \fImetalint\fR on them
before making them publicly available.
.SH OPTIONS
.I Metalint
recognizes the following set of options:
.TP 15
.B \-h
Print a short usage description and exit.
.TP
.B \-k
Keep temporary \fI.MT\fR directory.
.TP
.B \-l
(not implemented yet) By default, \fImetalint\fR only reports problems related
to your own private units. This switch directs \fImetalint\fR to also report
problems in publicly available units.
.TP
.B \-s
Silent mode.
.TP
\fB\-L\fI dir\fR
Override default library location. Normally only useful for metaconfig
maintainers to locally check the units being developped instead of the
publicly available ones. The \fIdir\fR specified is the one containing the
units \fIU\fR directory.
.TP
.B \-V
Print version number and exit.
.SH DIAGNOSTICS
The following diagnostics may be emitted by \fImetalint\fR:
.TP 5
"(?MAKE) ignoring duplicate dependency listing line."
More than one ?MAKE: line bearing dependencies was found in the unit. There
may be only one such line, although multiple ?MAKE action lines may occur.
.TP
"(?MAKE) special unit 'Xxx' should not be listed as made."
A special unit symbol (first letter capitalized) may only be listed as made
in the special unit itself. To suppress this warning in legitimate cases,
add a '+' in front of the offending symbol (note that for non-special units,
the '+' in this position indicates an internal symbol which should not appear
in the config.sh file).
.TP
"(?MAKE) '+xxx' is listed x times."
A conditional dependency is listed more than once. This is harmless though.
.TP
"(?MAKE) 'xxx' is listed x times."
A normal depdendency is listed more than once. Again, an harmless error.
.TP
"(?MAKE) 'xxx' listed as both conditional and full dependency."
Symbol is listed as a normal dependency and as a conditional one.
.I Metaconfig
will consider this as being a full dependency, but that may not be what you
initially wanted...
.TP
"(?Y) unknown layout directive 'xxx'."
Layout directives may only be one of \fItop\fR, \fIdefault\fR or \fIbottom\fR,
but case does not matter. An unknown directive is just ignored and
handled as if \fIdefault\fR had been specified.
.TP
"(?S) duplicate description for variable '\$xxx'."
Shell symbol is described more than once, and that will produce two entries
in the Glossary.
.TP
"(?S) variable '\$xxx' is not listed on ?MAKE: line."
The unit describes a shell symbol entry which cannot be used externally since
not listed as a dependency.
.TP
"(?S) syntax error in ?S: construct."
Self explainatory.
.TP
"(?C) duplicate description for symbol 'XXX'."
C symbol is described more than once, and that will produce two entries for
it in the Glossary.
.TP
"(?C) syntax error in ?C: construct."
Self explainatory.
.TP
"(?H) symbol 'XXX' was already defined."
Apparently, two ?H: lines are defining the same C symbol.
.TP
"(?H) variable '\$xxx' not even listed on ?MAKE: line."
A variable is used, but not listed on the dependency line.
.TP
"(?M) syntax error in ?M: construct."
Self explainatory.
.TP
"(?M) symbol 'xxx' already listed on a ?M: line in 'yyy'."
A magic definition for symbol xxx is attempted, but another one was
already provided in unit yyy.
.TP
"(?V) visible declaration in non-special unit ignored."
Visible declarations (?V: lines) may only appear in special units. Otherwise,
they are meaningless.
.TP
"(?V) wanted variable '\$xxx' made visible."
A wanted variable (described as a dependency on the ?MAKE: line) cannot be
made visible since that does not make any sense: the unit cannot depend on
it and then advertise it as being locally defined.
.TP
"(?V) defined variable '\$xxx' made visible."
A defined variable (listed as made on the ?MAKE: line) cannot be made
visible, since it could as well be directly wanted in another unit.
.TP
"(?V) variable '\$xxx' already made visible by unit yyy."
Inconsistent declaration: two units are making one single symbol visible...
.TP
"(?V) variable '\$xxx' already read-write visible in yyy."
The variable was already made visible as read-write by another unit.
.TP
"(?V) variable '\$xxx' already read-only visible in yyy."
The variable was already made visible as read-only by another unit.
.TP
"(?W) variable '\$xxx' already wanted."
Variable is already wanted, there is no need to explicitely ask for it here.
.TP
"(?W) variable '\$xxx' also locally defined."
A wanted variable would conflict with a locally defined variable and could
result in getting a garbage value.
.TP
"(?W) variable '\$xxx' already listed on a ?W: line in 'yyy'."
The variable in the shell symbol section of a ?W: line can only appear in
one unit.
.TP
"(?F) produced file 'xxx' mutiply declared."
The file is listed more than once on the ?F: line, under the same name.
This does not appear when declaring both a private UU file and a public
file with the same name, for instance.
.TP
"(?F) UU file $uufile in non-special unit ignored."
Private UU files (i.e. files like the \fImyread\fR script created for
later perusal by \fIConfigure\fR) may only be created in special units.
Exceptions allowed if the ?F: line is preceded by a proper ?LINT: hint.
.TP
"(?T) temporary symbol '\$xxx' multiply declared."
Self explainatory.
.TP
"control sequence '?XXX:' ignored within body."
Attempt to use a control line other than ?X: or ?LINT: in the unit body,
which should be only shell code
.TP
"variable '\$xxx' is changed."
A variable listed as wanted in the dependency line is changed. Such a variable
should be read-only for the unit. Use the \fIchange\fR lint hint to suppress
this message in pathological cases.
.TP
"no ?MAKE: line describing dependencies."
Every unit should have a dependency line, or it will be silently ignored by
\fImetaconfig\fR. This message is suppressed by a ?LINT: empty hint.
.TP
"not ending with a blank line."
Since all units are gathered together to form one big script, it is recommended
(hence enforced by \fImetalint\fR) that every unit file end with an empty line.
.TP
"last line not ending with a new-line character."
This is merely intended to users whose editor does not always append a
new-line at the end of text files. Should not happen when you use \fIvi\fR.
.TP
"symbol '\$xxx' was not described."
The shell symbol defined by this unit was not documented. Use the \fIdescribe\fR
lint hint to suppress this message.
.TP
"C symbol 'XXX' was not described."
The C symbol defined by this unit was not documented. Use the \fIknown\fR lint
hint to suppress this message.
.TP
"C symbol 'XXX' was not defined by any ?H: line."
A C symbol was advertised by never defined, hence it cannot appear in the
\fIconfig.h\fR file and is therefore useless...
.TP
"variable '\$xxx' should have been set."
A variable listed on the make line as made by the unit was not set by the
shell code body. Use the \fIset\fR lint hint to suppress this message in
pathological cases.
.TP
"unused dependency variable '\$xxx'."
Apparently no usage is made from a shell variable. Use the \fIchange\fR or
\fIuse\fR lint hints (depending on the situation) to suppress this message.
.TP
"unused conditional variable '\$xxx'.
Apparently no usage is made from this conditional dependency. The \fIchange\fR
or \fIuse\fR lint hints can be used to suppress this message.
.TP
"unused temporary variable '\$xxx'."
A variable declared as temporary in a ?T: line is not used. The \fIuse\fR lint
hint will fool \fImetalint\fR into thinking it's indeed used.
.TP
"unknown control sequence '?XXX:'."
Attempt to use an unknown control sequence.
.TP
"unknown LINT request '$xxx' ignored."
An unknown ?LINT: tag was used. All such tags must be spelled out in lowercase.
.TP
"symbol '\$xxx' has no default value."
A symbol used as a conditional dependency in some unit has no default value
set by a ?D: line.
.TP
"stale ?MAKE: dependency 'xxx'."
Unit lists a symbol as a dependency, but that symbol is otherwise unknown, i.e.
never appears as made by any other unit.
.TP
"symbol '\$xxx' missing from ?MAKE."
A symbol used or defined was not listed as a dependency in the ?MAKE: line.
.TP
"missing xxx from ?MAKE for visible '\$yyy'."
A symbol defined as visible by a special unit is used, but that special unit
is not part of the dependency line.
.TP
"stale ?M: dependency 'xxx'."
Magic line lists a C symbol as a dependency but that symbol is not known
by any unit.
.TP
"unknown symbol '\$xxx'."
I have no idea about what this symbol is. If the variable is externally
define, this warning can be suppresed via a proper ?LINT: extern.
.TP
"read-only symbol '\$xxx' is set."
A symbol that should be read-only is set by the unit's shell code body.
.TP
"obsolete symbol 'xxx' is used."
An obsolete symbol is used in the unit's shell code.
.TP
"undeclared symbol '\$xxx' is set."
The unit tries to set a shell variable which has not been otherwise declared
as made or as a temporary variable, or whatever.
.TP
"meaningful shell character '>' in comment line."
A shell charcter like '>' or ';' was found on a : comment line, which
is parsed by the shell, although not executed. Therefore, those symbols
are dangerous and can cause weird behaviour, and should be avoided if
possible.
.TP
"unmatched single quote in comment line."
The : comment line is parsed by the shell, so any unmatched quote will
result in having a chunk of the produced Configure script ignored at
interpretation time, causing trouble at best. A similar message will
be issued for unmatched double quotes.
.TP
"C symbol 'xxx' is defined in the following units:"
The C symbol is defined in more that one unit. Offending units are listed.
.TP
"Shell symbol 'xxx' is defined in the following units:"
A shell symbol is defined in more than one unit. Offending units folllow.
.TP
"Shell symbol 'xxx' is altogether:"
A shell symbol is defined by some units, obsoleted by others and used as
a temporary.
.TP
"Shell symbol 'xxx' is both defined and obsoleted:"
Self explainatory.
.TP
"Shell symbol 'xxx' is both defined and used as temporary:"
Self explainatory.
.TP
"Shell symbol 'xxx' obsoleted also used as temporary:"
Self explainatory.
.TP
"definition of '\$xxx' not closed by '?S:.'."
Self explainatory.
.TP
"definition of 'XXX' not closed by '?C:.'."
Self explainatory.
.TP
"magic definition of 'xxx' not closed by '?M:.'."
Self explainatory.
.TP
"variable '\$xxx' is defined externally."
A variable defined externally (i.e. in another unit) is used, without proper
dependency information. Use the \fIextern\fR lint hint to suppress this message.
.TP
"file 'xxx' was not created."
A file listed as a private UU file is not created by the special unit.
Creation is detected by seing an explicit shell redirection to the file,
not by an implicit creation (such as a C compilation would for instance).
All special units should create only shell scripts explicitely anyway so this
message cannot be suppressed via a lint hint.
.TP
"local file 'xxx' may override the one set by 'unit.U'."
You are attempting to create a local file, but the special unit creates one
bearing the exact same name and should it be loaded before
within \fIConfigure\fR, you would override that file. Change the name of your
local file.
.TP
"unused temporary file 'xxx'.
The file was declared on the ?F: line but does not appear to be used
anywhere.
.TP
"mis-used temporary file 'xxx'.
A local temporary file has been declared on the ?F: line and is used in
a way that may not be the proper one. Indeed, all such local files should
be called with an explicit relative path, to avoid PATH lookups which could
get you another file.
.TP
"you might not always get file 'xxx' from 'unit.U'."
You seem to be calling the specified file, but not by using an explicit
relative pathname. Relying on the PATH to find this file is not safe.
To fix this problem, call your file using somthing like \fI./xxx\fR.
.TP
"missing Unit from ?MAKE for private file 'xxx'."
You are using a private UU file without listing the special unit that
produces it in your dependency line. Add the unit to your dependency list.
.TP
"unknown private file 'xxx'."
The file does not appear on any ?F: line; however it should.
.TP
"File 'xxx' is defined in the following units:"
The listed units cannot seem to agree on who is defining the file.
.TP
"Cycle found for:"
There is a dependency cycle found for the symbols listed. Only the symbols
involved in the cycle are listed.
.TP
"Cycle involves:"
An exerpt of the dependencies where the cycle was found is listed. This may
involve far more symbols than the previous message, because \fImetalint\fR
actually rescans the rules to emphasize the cycle and stops whenever it has
found one, i.e. it does not try to minimize it (the cycle is found using
another algorithm, which unfortunately cannot spit it out but only say
for sure there is one).
.SH REFERENCE
.I Metalint
uses the following control lines, which are otherwise ignored by
\fImetaconfig\fR:
.TP 5
?V:\fIread-only symbols\fR:\fIread-write symbols\fR
This line should be used only in special units. It lists all the shell
variable defined by the unit which should not be used directly as dependencies
by other units: they must include this special unit in their dependency list
if they make use of any of the symbols described here. Those can be viewed
as exported symbols which you inherit from when depending from the unit.
Symbols may be exported read-only or read-write.
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
This line should list all the shell variables used as temporaries within
the unit's body. This line should be kept accurate, and prevents you from
writing a unit defining a symbol which would be used as a scratch variable
in another unit...
.TP
?LINT:\fIkeyword\fR \fIsymbol_list\fR
Specifies a lint hint. The following keywords are available:
.RS +10
.TP 15
.PD 0
.I change
shell variable ok to be changed
.TP
.I create
persistent file ok to be created by non-special unit
.TP
.I define
shell variables listed are defined in this unit
.TP
.I describe
listed shell variables are described by ?S:
.TP
.I extern
variable known to be externally defined
.TP
.I empty
unit file is empty and kept only as a placeholder.
.TP
.I known
listed C variables are described
.TP
.I set
listed variables are set
.TP
.I use
variables listed are used by this unit
.PD
.RS -10
.SH AUTHORS
Harlan Stenn <harlan@mumps.pfcs.com> wrote the first version, based on
Larry Wall's \fImetaconfig\fR from dist 2.0.
.br
Raphael Manfredi <ram@hptnos02.grenoble.hp.com> rewrote it from scratch for
3.0 with a few enhancements.
.SH FILES
.TP 10
.PD 0
LIB/dist/mcon/U/*.U
Public unit files
.TP
U/*.U
Private unit files
.PD
.sp
.in +5
where LIB is $privlibexp.
.in -5
.SH BUGS
Maybe.
.SH "SEE ALSO"
metaconfig($manext), metaxref($manext)
!GROK!THIS!
chmod 444 metalint.$manext
