                                CECIL

                   (C-Eiffel Call-In Library)

Overview
========

Cecil is the library that permits C and C++ applications (as well
as applications written in other languages) to take advantage of
almost all Eiffel facilities: create Eiffel objects, apply features
to them.

The basics of Cecil are described in chapter 24 of "Eiffel: The
Language", devoted to interfaces between Eiffel and other
languages; important material can also be found in "Eiffel: The
Environment" and on ISE's Web and FTP pages (http://www.eiffel.com
and ftp://ftp.eiffel.com).

The following elements complement the descriptions of "Eiffel: The
Language". Note that Cecil has been revised and improved since
that book was published, so the eplanations below have precedence
over those of the books.

The present document is intended for Windows users. A companion
file (README-unix) addresses the use of Cecil for Unix development. 

A Cecil example in the present directory illustrates the use
of Cecil and will serve as guide for applications needing Cecil.
 
1) Building a Cecil link file
=============================

The ISE Eiffel compiler produces C code and a "Makefile" to compile
and link that C code in a directory below the EIFGEN of a project.
If you are using the ISE Eiffel environment to simply develop and build 
Eiffel applications, you will never have to manipulate the generated
files directly. 

In "Workbench" mode (melting, freezing), the code will be generated
in the EIFGEN/W_code directory.  In  "finalized" mode it will be
generated in EIFGEN/F_code.

To produce a Cecil link file, go to the appropriate directory
(W_code or F_code) and type:

	wmake cecil.lnk

This produces a link file. 

You may build a Cecil archive for a system compiled in either of
the two modes, finalized and workbench. In the latter case (usually
intended for testing, since only finalized code is extensively
optimized), you must copy the "melted.eif" file located in
"EIFGEN/W_code" to the directory from where you intend to execute
your C application. Note that each time you melt the Eiffel system,
the "melted.eif" file is updated. (Rather than a copy, you can have
a symbolic link to the "melted.eif" file.)
 
CAVEAT in melted mode: it is not currently possible, through
the Cecil interface, to call melted routines. Such calls will
raise the exception "$ applied to melted routine". So if you
change the Eiffel side you should refreeze the system before
regenerating the Cecil archive.

2) Using a Cecil link file
==========================

2.a) Linking the Cecil link file into a program

The Cecil link file already incorporates the Eiffel run-time. To use the
functions provided in the Cecil link file, simply write the C programs
according to the Cecil specifications of "Eiffel: The Language",
and include the Cecil link file in the linking line of your C
application.

For example, In the file app.lnk

	system app
	@cecil.lnk
	... other directives to the linker ...

Execute this by:

	wlink @app

2.b) Initializing the Eiffel run-time

Even though the main thread of control resides on the C side of the
program, the Eiffel run-time must be initialized correctly before the
C functions can use Cecil facilities to communicate with the Eiffel
world.
 
In the C file containing the "main" C function, you must include
the Eiffel run-time header file "except.h" and provide the following
declarations:


================== Code segment ==================================
#include "except.h"
extern void failure();
extern void eif_init();
extern int _argc;
extern char **_argv;
================== End code segment ==============================

In the "main" function, include the following declarations:

================== Code segment =========================== 
struct ex_vect *exvect;
jmp_buf exenv;
================== End code segment ==============================

Also in the "main" function, include the following lines *BEFORE*
any Cecil call:

================== Code segment ==================================
initsig();
initstk();
exvect = exset((char *) 0, 0, (char *) 0);
exvect->ex_jbuf = (char *) exenv;
if (echval = setjmp(exenv))
	failure();
 
eif_init (_argc, _argv, envp);
================== End code segment ==============================

The built-in WinMain function will call a function called
"main" so you will need to have this in your Windows application.

Note that the above mentioned lines must imperatively be in the body
of the "main" function for the Eiffel exception handling mechanism to
function correctly.

"argc", "argv" and "envp" are the three standard arguments of the
C "main" function":

================== Code segment ==================================
main(argc, argv, envp)
int argc;
char **argv;
char **envp;
================== End code segment ==============================

Note that you need to add the Eiffel run time directory to the list of
directories in which the C compiler searches for #include files. You may
do so by using the "-I" option of your C compiler.

2.c) The Cecil interface

To use the Cecil functions, you must include the header file "eiffel.h"
(not "cecil.h" as specified in ETL)

"eif_field" does not return an EIF_OBJ but a "raw", unprotected object.
If you wish to protect it you may use the function "henter", and "hfree"
to later release it.

The second argument of "eif_proc" is a EIF_TYPE_ID (not an EIF_OBJ)

4) Current restrictions
=======================
 
Currently you can only link one Cecil library into a C application.
