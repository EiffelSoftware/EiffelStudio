/*
	description: "Initialization of the argc/argv run-time copies for class ARGUMENTS."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="argv.c" header="eif_argv.h" version="$Id$" summary="Initialization of argc/argv run-time copies for ARGUMENTS class.">
*/

#include "eif_portable.h"
#include "eif_malloc.h"				/* For cmalloc() */
#include "eif_plug.h"				/* For makestr() */
#include "eif_except.h"				/* For fatal_error() */
#include "rt_argv.h"
#include <string.h>				/* For strcpy(), strlen() */

/*
doc:	<attribute name="eif_argc" return_type="int" export="public">
doc:		<summary>Initial `argc' value (argument count). Used from Eiffel code to get access to command line arguments.</summary>
doc:		<access>Read/Write Once</access>
doc:		<thread_safety>Initialized by `arg_init' in `eif_rtinit' so no need for synchronization.</thread_safety>
doc:		<eiffel_classes>ARGUMENTS, MEL_DISPLAY, EV_APPLICATION_IMP (gtk implementation)</eiffel_classes>
doc:	</attribute>
*/
rt_public int eif_argc;			/* Initial argc value (argument count) */

/*
doc:	<attribute name="eif_argv" return_type="char **" export="public">
doc:		<summary>Copy of initial `argv'. Used from Eiffel code to get access to command line arguments.</summary>
doc:		<access>Read/Write Once</access>
doc:		<thread_safety>Initialized by `arg_init' in `eif_rtinit' so no need for synchronization.</thread_safety>
doc:		<eiffel_classes>ARGUMENTS, MEL_DISPLAY, EV_APPLICATION_IMP (gtk implementation)</eiffel_classes>
doc:	</attribute>
*/
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

/*
doc:</file>
*/
