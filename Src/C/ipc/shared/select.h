/*
	description: "Declarations for select functions."
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

#ifndef _select_h_
#define _select_h_

#include "stream.h"
#ifndef EIF_WINDOWS
#include "timehdr.h"
#endif

/* List of error number which may be reported by the select routines. This list
 * must be kept in sync with the error arrays.
 */
#define S_FDESC		1				/* Invalid file descriptor */
#define S_CALBAK	2				/* Invalid call back address */
#define S_CALSET	3				/* A callback is already set */
#define S_NOCALBAK	4				/* No callback was set */
#define S_SELECT	5				/* Select system call failed */
#define S_NOFILE	6				/* No more file to select on */

extern int s_errno;					/* Error number */

/* Type definition for functions that take a STREAM as only argument and return void */
typedef void(*STREAM_FN)(STREAM*);

/* Function declarations */
extern int add_input(EIF_PSTREAM, STREAM_FN);			/* Add STREAM input function */
extern STREAM_FN new_callback(EIF_PSTREAM, STREAM_FN);	/* Change call back for a given fd */
extern STREAM_FN rem_input(EIF_PSTREAM);				/* Remove input selection */
extern char *s_strerror(void);							/* Return description of last error */
extern char *s_strname(void);							/* Return symbolic name of last error */
extern int has_input(EIF_PSTREAM);		/* Check whether file is still selected */

#ifdef EIF_WINDOWS
extern int do_select(DWORD timeout);					/* Run the select system call */
#else
extern int do_select(struct timeval *timeout);	/* Run the select system call */
#endif

#endif
