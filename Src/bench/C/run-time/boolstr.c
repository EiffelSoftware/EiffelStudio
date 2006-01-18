/*
	description: "Externals for class BOOL_STRING."
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
doc:<file name="boolstr.c" header="eif_boolstr.h" version="$Id$" summary="Externals for BOOL_STRING class">
*/

#include "eif_portable.h"
#include "eif_boolstr.h"
#include <string.h>

rt_public char *bl_str_set(char *a1, int s, int n)
      			/* number of boolean in `a1' */
{
	int i;

	for (i = 0; i < s; i++)
		a1[i] = (char) n;	/* n value is either 0 or 1 */

	return a1;
}

rt_public char *bl_str_and(char *a1, char *a2, char *a3, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = (char) (a1[i] && a2[i]);

	return a3;
}

rt_public char *bl_str_or(char *a1, char *a2, char *a3, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = (char) (a1[i] || a2[i]);

	return a3;
}

rt_public char *bl_str_xor(char *a1, char *a2, char *a3, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a3[i] = (char) (a1[i] ^ a2[i]);

	return a3;
}

rt_public char *bl_str_not(char *a1, char *a2, int s)
{
	int i;

	for (i = 0; i < s; i++)
		a2[i] = (char) (!a1[i]);

	return a2;
}

rt_public char *bl_str_shiftr(char *a1, char *a2, int s, int n)
      			/* number of booleans in `a1' */
{
	/* Right shift `a1' by `n' positions */
	if (n < s)
		memcpy  (a2 + n * sizeof(char), a1, (s - n) * sizeof(char));
	else
		n = s;

	memset (a2, 0, n * sizeof (char));

	return a2;
}

rt_public char *bl_str_shiftl(char *a1, char *a2, int s, int n)
      			/* number of booleans in `a1' */
{
    int i;

	if (n < s)
		memcpy (a2, a1 + n * sizeof(char), (s - n) * sizeof(char));
	else
		n = s;

	for (i = 0; i < n; i++)
		a2[s-i-1] = '\0';

	return a2;
}

/*
doc:</file>
*/
