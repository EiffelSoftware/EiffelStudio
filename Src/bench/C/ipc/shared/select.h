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

#ifdef EIF_WINDOWS
#include "stream.h"
#else
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

#ifdef EIF_WINDOWS

/* Type definition for functions that take a HANDLE as only argument and return void */
typedef void(*HANDLE_FN)(HANDLE);

/* Function declarations */
extern int add_input(EIF_LPSTREAM, HANDLE_FN);			/* Add STREAM input function */
extern HANDLE_FN new_callback(EIF_LPSTREAM, HANDLE_FN);	/* Change call back for a given fd */
extern HANDLE_FN rem_input(EIF_LPSTREAM);				/* Remove input selection */
extern char *s_strerror(void);							/* Return description of last error */
extern char *s_strname(void);							/* Return symbolic name of last error */
extern int has_input(STREAM *sp);						/* Check whether file is still selected */
extern void clear_fd(STREAM *sp);						/* Clear selection in select result mask */
extern int do_select(DWORD timeout);					/* Run the select system call */

#else

/* Function declarations */
extern int add_input(int fd, void (*call) (/* ??? */));		/* Add file descriptor input function */
extern void (*new_callback(int fd, void (*call) (/* ??? */)))(void);	/* Change call back for a given fd */
extern void (*rem_input(int fd))(void);		/* Remove input selection */
extern char *s_strerror(void);		/* Return description of last error */
extern char *s_strname(void);		/* Return symbolic name of last error */
extern int has_input(int fd);		/* Check whether file is still selected */
extern void clear_fd(int f);		/* Clear selection in select result mask */
extern int do_select(struct timeval *timeout);	/* Run the select system call */
#endif

#endif
