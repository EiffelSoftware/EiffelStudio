/*
	description: "System error handling."
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
doc:<file name="error.c" header="eif_error.h" version="$Id$" summary="System error handling">
*/

#include "eif_portable.h"
#include "rt_except.h"
#include "rt_error.h"

#include <string.h>			/* Try to find strerror() there */

rt_public char *error_tag(int code)
{
	/* Returns a pointer to the English description of the system error whose
	 * code is stored in errno, or a null pointer if that description is not
	 * available.
	 */

	if (code == 0)					/* No error recorded */
		return (char *) 0;			/* No description necessary */

#if defined HAS_STRERROR || defined HAS_SYS_ERRLIST
	return (char *) Strerror(code);			/* Macro defined by Configure */
#else
	return (char *) 0;		/* English description not available */
#endif
}

rt_public void esys(void)
{
	/* Raise the 'Operating system error' exception, based on the error code
	 * held in variable errno. The associated tag will be an English description
	 * of that error, if provided by the system.
	 * If errno is zero, the 'External event' exception is generated instead.
	 */

#ifdef EIF_VMS
	int err = errno;
#endif
	if (errno == 0)					/* Function did not set errno? */
		xraise(EN_EXT);				/* External event */

	xraise(EN_SYS);					/* Operating system error */
}

rt_public void eise_io(char *tag)
{
	/* As a special case, an I/O error is raised when a system call which is
	 * I/O bound fails.  */

	eraise(tag, EN_ISE_IO);					/* I/O error */
}

/*
doc:</file>
*/
