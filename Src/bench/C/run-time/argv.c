/*

   ##    #####    ####   #    #           ####
  #  #   #    #  #    #  #    #          #    #
 #    #  #    #  #       #    #          #
 ######  #####   #  ###  #    #   ###    #
 #    #  #   #   #    #   #  #    ###    #    #
 #    #  #    #   ####     ##     ###     ####

	Initialization of the argc/argv run-time copies for class ARGUMENTS.
*/

#include "config.h"
#ifdef I_STRING
#include <string.h>				/* For strcpy(), strlen() */
#else
#include <strings.h>
#endif
#include "portable.h"
#include "malloc.h"				/* For cmalloc() */
#include "plug.h"				/* For makestr() */
#include "except.h"				/* For fatal_error() */
#include "argv.h"


rt_public int eif_argc;			/* Initial argc value (argument count) */
rt_public char **eif_argv;			/* Copy of initial argv (argument vector) */

rt_private char *error = "can't set argument vector";

rt_public int arg_number(void)
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
		fatal_error(MTC error);

	/* Duplicate arguments array */
	for (i = 0; i < eargc; i++) {
		eif_argv[i] = cmalloc(strlen(eargv[i]) + 1);
		if (eif_argv[i] == (char *)0)
			fatal_error(MTC error);
		strcpy (eif_argv[i], eargv[i]);
	}

	eif_argv[eargc] = (char *)0;
}

rt_public char *arg_option(int num)
{
	/* Build up Eiffel string associated with the corresponding argument which
	 * was specified in the command line. Note that this always returns a new
	 * string.
	 */

	return makestr(eif_argv[num], strlen(eif_argv[num]));
}

