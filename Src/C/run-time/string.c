/*
	description:	"Manipulations with strings and string objects."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2020-2021, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="string.c" header="rt_string.h" version="$Id$" summary="Manipulations with strings and string objects.">
*/

#include "eif_config.h"
#include "eif_macros.h"
#include "rt_string.h"
#include "rt_malloc.h"

/*
doc:	<routine name="string_32_from_char_8" return_type="EIF_REFERENCE" export="shared">
doc:		<summary>Create a new (mutable) STRING_32 object from a 0-terminated sequence of 8-bit characters. </summary>
doc:		<param name="data" type="char*">C representation to be used for initialization.</param>
doc:		<return>Newly created object on success. NULL if there is not enough memory.</return>
doc:		<synchronization>None.</synchronization>
doc:		<thread_safety>Safe.</thread_safety>
doc:	</routine>
*/
rt_shared EIF_REFERENCE string_32_from_char_8 (const char * data)
{
	EIF_REFERENCE result;		/* The Eiffel string returned. */
	size_t i, n;
	char * data_32;

		/* Get length of 8-bit string in bytes. */
	n = strlen (data);
		/* Allocate buffer to build 32-bit string. */
	data_32 = (char *) eif_rt_xcalloc(n * 4, sizeof(EIF_CHARACTER_32));
		/* Return Void on failure. */
	if (data_32 == (char *) 0)
		return (EIF_REFERENCE) 0;
		/* Copy data from 8-bit to 32-bit string. */
		/* TODO: Handle Unicode, e.g. encoded as UTF-8. */
	for (i = 0; i < n; i++)
	{
		data_32 [i * sizeof(EIF_CHARACTER_32)
#		if BYTEORDER != 0x1234
			+ 3
#		endif
			] = * (data++);
	}
		/* Create Eiffel object. */
	result = RTMS32_EX (data_32, n);
		/* Free the temporary buffer. */
	eif_rt_xfree(data_32);
	return result;
}

/*
doc:	<attribute name="eif_CHARACTER_8_as_lower_table" return_type="EIF_CHARACTER_8" export="public">
doc:		<summary>Lower case of CHARACTER_8.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe: read only.</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</attribute>
*/
rt_public EIF_CHARACTER_8 eif_CHARACTER_8_as_lower_table [] =
	"\000\001\002\003\004\005\006\007\010\011\012\013\014\015\016\017"
	"\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037"
	" !\"#$%&'()*+,-./0123456789:;<=>?"
	"@abcdefghijklmnopqrstuvwxyz[\\]^_"
	"`abcdefghijklmnopqrstuvwxyz{|}~\177"
	"\200\201\202\203\204\205\206\207\210\211\212\213\214\215\216\217"
	"\220\221\222\223\224\225\226\227\230\231\232\233\234\235\236\237"
	"\240\241\242\243\244\245\246\247\250\251\252\253\254\255\256\257"
	"\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277"
	"\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357"
	"\360\361\362\363\364\365\366\327\370\371\372\373\374\375\376\337"
	"\340\341\342\343\344\345\346\347\350\351\352\353\354\355\356\357"
	"\360\361\362\363\364\365\366\367\370\371\372\373\374\375\376\377";

/*
doc:	<attribute name="eif_CHARACTER_8_as_upper_table" return_type="EIF_CHARACTER_8" export="public">
doc:		<summary>Upper case of CHARACTER_8.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe: read only.</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</attribute>
*/
rt_public EIF_CHARACTER_8 eif_CHARACTER_8_as_upper_table [] =
	"\000\001\002\003\004\005\006\007\010\011\012\013\014\015\016\017"
	"\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037"
	" !\"#$%&'()*+,-./0123456789:;<=>?"
	"@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_"
	"`ABCDEFGHIJKLMNOPQRSTUVWXYZ{|}~\177"
	"\200\201\202\203\204\205\206\207\210\211\212\213\214\215\216\217"
	"\220\221\222\223\224\225\226\227\230\231\232\233\234\235\236\237"
	"\240\241\242\243\244\245\246\247\250\251\252\253\254\255\256\257"
	"\260\261\262\263\264\265\266\267\270\271\272\273\274\275\276\277"
	"\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317"
	"\320\321\322\323\324\325\326\327\330\331\332\333\334\335\336\337"
	"\300\301\302\303\304\305\306\307\310\311\312\313\314\315\316\317"
	"\320\321\322\323\324\325\326\367\330\331\332\333\334\335\336\377";

/*
doc:	<attribute name="eif_CHARACTER_8_is_space_table" return_type="EIF_BOOLEAN" export="public">
doc:		<summary>`is_space` status for CHARACTER_8.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe: read only.</thread_safety>
doc:		<synchronization>None.</synchronization>
doc:	</attribute>
*/
rt_public EIF_BOOLEAN eif_CHARACTER_8_is_space_table [] = {
	/*      	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F, */
	/* 0x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, /* 0x09, 0x0A, 0x0B, 0x0C, 0x0D */
	/* 1x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, /* 0x1C, 0x1D, 0x1E, 0x1F */
	/* 2x */	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, /* 0x20 */
	/* 3x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* 4x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* 5x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* 6x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* 7x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* 8x */	0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, /* 0x85 */
	/* 9x */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* Ax */	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, /* 0xA0 */
	/* Bx */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* Cx */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* Dx */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* Ex */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	/* Fx */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	};

/*
doc:</file>
*/
