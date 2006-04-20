/*
	description: "[
		Uuencoding and decoding routines:
			* uuencode is a simple algorithm to convert strings of binary data to
			ASCII streams.  Every 3 characters of input gets converted to 4 character
			on output

			* uudecode is the reverse.
			]"
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

#include "eif_eiffel.h"
#include "rt_assert.h"
#include "windows.h"
#include "uu.h"

#define ENC(c) (((c) & 077) + ' ')

/*
	uuencode a string `s' and put the result in `Result'
*/

void uuencode (char s[], char *Result)
{
	/* s is 3 characters to be uuencode */
	*Result = (char) (ENC(s[0] >> 2));
	*(Result+1) = (char) (ENC(s[0] << 4 & 060 | s[1] >> 4 & 017));
	*(Result+2) = (char) (ENC(s[1] << 2 & 074 | s[2] >> 6 & 03));
	*(Result+3) = (char) (ENC(s[2] & 077));
}

#define DEC(c) (((c) - ' ') & 077)


/*
	uudecode a string `s' and put the result in `Result'
*/

void uudecode (char s[], char *Result)
{
	/* s is 4 characters to be uudecoded */
	*Result = (char) (DEC(s[0]) << 2 | DEC(s[1]) >> 4);
	*(Result+1) = (char) (DEC(s[1]) << 4 | DEC(s[2]) >> 2);
	*(Result+2) = (char) (DEC(s[2]) << 6 | DEC(s[3]));
}


/*
	uudecode the string s
*/

char *uudecode_str (char *s)
{
	char *Result, *i, *j;

	Result = (char *) calloc (strlen(s) / 4 * 3+1,1);
	for (i = s, j = Result; i < s+strlen(s); i += 4, j += 3)
		uudecode (i, j);
	return Result;
}

/*
doc:	<routine name="uuencode_buffer_size" return_type="int" export="shared">
doc:		<summary>Given a number of pointers value to uuencode, gives the needed size to hold the uuencoded value.</summary>
doc:		<param name="nb_pointers" type="int"></param>
doc:		<return>0 if collection was done, -1 otherwise.</return>
doc:		<thread_safety>Safe with synchronization</thread_safety>
doc:		<synchronization>Through `trigger_gc_mutex'.</synchronization>
doc:	</routine>
*/

rt_shared int uuencode_buffer_size (int nb_pointers) {
	int sz;

	REQUIRE("nb_pointers_positive", nb_pointers > 0);

	sz = (4 * nb_pointers * sizeof(void *) + 2) / 3;
	if (sz % 4) {
		sz = sz + 4 - (sz % 4);
	}

	ENSURE("sz_positive", sz > 0);
	return sz;
}

/*
	uuencode the string s for a length size.  This allows for strings with \0 in them
	I got the routine from a newsgroup referring to somewhere on a DEC site.
*/

char *uuencode_str (char *s, int size)
{
	char *Result, *i, *j, *t;
	int sz;

	sz = (size * 4 + 2) / 3;
	if (sz % 4)
		sz += 4 - (sz % 4);
	Result = (char *) calloc (sz+1,1);
	for (i = s, j = Result; i < s+size; i += 3, j += 4)
		if (s+size-i < 3)
			{
			t = (char *) calloc (3,1);
			memcpy (t, i, s+size-i);
			uuencode (t,j);
			free (t);
			}
		else
			uuencode (i, j);
	return Result;
}
