/*

   ##    #####    ####   #    #           ####
  #  #   #    #  #    #  #    #          #    #
 #    #  #    #  #       #    #          #
 ######  #####   #  ###  #    #   ###    #
 #    #  #   #   #    #   #  #    ###    #    #
 #    #  #    #   ####     ##     ###     ####

	Initialization of the argc/argv run-time copies for class ARGUMENTS.
*/

#include "eif_portable.h"
#include "eif_malloc.h"				/* For cmalloc() */
#include "eif_plug.h"				/* For makestr() */
#include "eif_except.h"				/* For fatal_error() */
#include "eif_argv.h"
#include <string.h>				/* For strcpy(), strlen() */


/*
doc:<file name="argv.c" header="eif_argv.h">
doc:	<attribute name="eif_argc" return_type="int">
doc:		<summary>Initial `argc' value (argument count). Used from Eiffel code to get access to command line arguments.</summary>
doc:		<thread_safety>Initialized by `arg_init' in `eif_rtinit' so no need for synchronization.</thread_safety>
doc:		<eiffel_classes>ARGUMENTS, MEL_DISPLAY, EV_APPLICATION_IMP (gtk implementation)</eiffel_classes>
doc:	</attribute>
doc:	<attribute name="eif_argv" return_type="char **">
doc:		<summary>Copy of initial `argv'. Used from Eiffel code to get access to command line arguments.</summary>
doc:		<thread_safety>Initialized by `arg_init' in `eif_rtinit' so no need for synchronization.</thread_safety>
doc:		<eiffel_classes>ARGUMENTS, MEL_DISPLAY, EV_APPLICATION_IMP (gtk implementation)</eiffel_classes>
doc:	</attribute>
doc:</file>
*/
rt_public int eif_argc;			/* Initial argc value (argument count) */
rt_public char **eif_argv;			/* Copy of initial argv (argument vector) */

#define ERROR_MSG "can't set argument vector"

rt_public EIF_INTEGER arg_number(void)
{
	return eif_argc;
}

rt_public void arg_init(int eargc, char **eargv)
{
	/* Save command-line arguments array and number */

	int i;

	eif_argc = eargc;					/* Save number of arguments */

	/* Allocate memory for array duplication */
	eif_argv = (char **) cmalloc((eargc + 1) * sizeof(char *));
	if (eif_argv == (char **)0)
		fatal_error(ERROR_MSG);

	/* Duplicate arguments array */
	for (i = 0; i < eargc; i++) {
		eif_argv[i] = cmalloc(strlen(eargv[i]) + 1);
		if (eif_argv[i] == (char *)0)
			fatal_error(ERROR_MSG);
		strcpy (eif_argv[i], eargv[i]);
	}

	eif_argv[eargc] = (char *)0;
}

rt_public EIF_REFERENCE arg_option(EIF_INTEGER num)
{
	/* Build up Eiffel string associated with the corresponding argument which
	 * was specified in the command line. Note that this always returns a new
	 * string.
	 */

	return makestr(eif_argv[num], strlen(eif_argv[num]));
}

