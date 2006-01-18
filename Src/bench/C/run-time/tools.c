/*
	description: "Some general purpose tools."
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
doc:<file name="tools.c" header="eif_tools.h" version="$Id$" summary="General purpose tools">
*/

#include "rt_tools.h"
#include <stddef.h>					/* For size_t typedef. */

rt_public EIF_INTEGER hashcode(register char *s, register EIF_INTEGER count)
{
	/* Compute the hash code associated with given string s. The magic number
	 * below is the greatest prime lower than 2^23 so that this magic number
	 * shifted to the left does not exceed 2^31.
	 *
	 * Note: Manu 09/27/2002: They are some other algorithms very similar to
	 * the one we are currently using, but I figure out if one day we do some
	 * serious performance checking, that it might be good to have some
	 * alternatives:
	 *
	 *	djb2 algorithm
	 *	size_t hashval = 5381;
			
	 *	while (count--)
	 *		hashval = ((hashval << 5) + hashval) + c; *//* hashval * 33 + c *//*
	 */

	size_t hashval = 0;
	int magic = 8388593;

	while (count--)
		hashval = ((hashval % magic) << 8) + (size_t) *s++;

	
	return (EIF_INTEGER) (hashval & 0x7fffffff);	/* Clear bit 31 (no unsigned in Eiffel) */
}

rt_shared size_t nprime(size_t n)
{
	/* Return the closest prime number greater than `n' */

	while (!prime(n))
		n++;

	return n;
}

rt_shared size_t prime(size_t n)
{
	/* Return 1 if `n' is a prime number */

	uint32 divisor;

	if (n == 1)
		return 0;
	else if (n == 2)
		return 1;
	else if (n % 2) {
		for (
			divisor = 3; 
			divisor * divisor <= n;
			divisor += 2
		)
			if (0 == (n % divisor))
				return 0;
		return 1;
	}
	return 0;
}

/*
doc:</file>
*/
