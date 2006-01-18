/*
	description: "Special interface to the compile to display timeout message."
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

#ifdef EIF_WINDOWS
#include <windows.h>
#endif

#include "eif_eiffel.h"
#include "eif_misc.h"

rt_public EIF_REFERENCE eif_timeout_msg (void)
{
	/* Message displayed when estudio is unable to launch
	 * the system (because of a timeout).
	 */

	char *eif_timeout;
	extern char *getenv(const char *);				/* Get environment variable value */

	char s[512];

	strcpy(s, "Could not launch system in allotted time.\n");
	strcat(s, "Try restarting estudio after setting ");
#ifdef EIF_VMS
	strcat(s, "the logical name \n");
#else
	strcat(s, "the environment\nvariable ");
#endif
	strcat(s, "ISE_TIMEOUT to a value larger than\n");

	eif_timeout = getenv("ISE_TIMEOUT");
	if (eif_timeout != (char *) 0) {	/* Environment variable set */
		strcat(s, "current value ");
		strcat(s, eif_timeout);
	} else {
		strcat(s, "the default 30");
	}
	strcat(s, " seconds.\n");
	return RTMS (s);
}
