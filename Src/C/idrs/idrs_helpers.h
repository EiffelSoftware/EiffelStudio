/*
	description: "Helpers for IDRS facilities."
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

#ifndef _idrs_helper_h_
#define _idrs_helper_h_

#include "idrs.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
doc:<file name="idrs.h" version="$Id$" summary="Header file for `idrs.c'">
*/

/* Make sure the buffer can hold 'x' bytes, return false if this is not
 * possible. When serializing, this makes sure we'll have enough room for the
 * current type (especially simple types). When deserializing, it helps keeping
 * the consistency (trying to deserialize a longer structure).
 */
#define CHK_SIZE(i, x) { \
	if (((i)->i_ptr + (x)) > ((i)->i_buf + (i)->i_size)) \
		return FALSE; \
	}


/* Helper macro to avoid copy/pasting. */
#define EIF_IDR_SERIALIZER(a_buffer, a_value, a_data_type) \
	if (a_buffer->i_op == IDR_ENCODE) { \
		memcpy (idrs->i_ptr, a_value, sizeof(a_data_type)); \
	} else { \
		memcpy (a_value, idrs->i_ptr, sizeof(a_data_type)); \
	} \
	idrs->i_ptr += sizeof(a_data_type); 

rt_private bool_t idr_type_index(IDR* idrs, EIF_TYPE_INDEX *val) {
	CHK_SIZE(idrs,sizeof(EIF_TYPE_INDEX));
	EIF_IDR_SERIALIZER(idrs,val,EIF_TYPE_INDEX);
	return TRUE;
}
rt_private bool_t idr_int(IDR* idrs, int *val) {
	CHK_SIZE(idrs,sizeof(int));
	EIF_IDR_SERIALIZER(idrs,val,int);
	return TRUE;
}
rt_private bool_t idr_rt_uint_ptr(IDR* idrs, rt_uint_ptr *val) {
	CHK_SIZE(idrs,sizeof(rt_uint_ptr));
	EIF_IDR_SERIALIZER(idrs,val,rt_uint_ptr);
	return TRUE;
}
rt_private bool_t idr_eif_reference(IDR* idrs, EIF_REFERENCE *val) {
	CHK_SIZE(idrs,sizeof(EIF_REFERENCE));
	EIF_IDR_SERIALIZER(idrs,val,EIF_REFERENCE);
	return TRUE;
}
rt_private bool_t idr_unsigned_char(IDR* idrs, unsigned char *val) {
	CHK_SIZE(idrs,sizeof(unsigned char));
	EIF_IDR_SERIALIZER(idrs,val,unsigned char);
	return TRUE;
}
rt_private bool_t idr_size_t(IDR* idrs, size_t *val) {
	CHK_SIZE(idrs,sizeof(size_t));
	EIF_IDR_SERIALIZER(idrs,val,size_t);
	return TRUE;
}

/*
doc:	<routine name="idr_string" return_type="bool_t" export="private">
doc:		<summary>Serialize a string. Dynamic allocation for data storage is done when deserializing if the address of the string is NULL. There is a big difference with the pending XDR routines, since maxlen may be left to 0 to avoid string length limitations. The serialization will fail if the buffer limits are reached. If the size given is strictly less than 0, then the absolute value gives the maximum string length, and the string will be truncated if it is longer than that. Strings are serialized by first emitting the length as an size_t, then the characters from the string itself, with the trailing null byte omitted.</summary>
doc:		<param name="idrs" type="IDR *">IDR structure managing the stream.</param>
doc:		<param name="sp" type="char **">Pointer to area where string address is stored.</param>
doc:		<param name="maxlen" type="int">Maximum length, 0 = no limit.</param>
doc:		<return>TRUE if successful, FALSE otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:	</routine>
*/

rt_private bool_t idr_string(IDR *idrs, char **sp, int maxlen)
{
	size_t len = 0;		/* String length */
	char *string;	/* Allocated string pointer */

	if (idrs->i_op == IDR_ENCODE) {
		string = *sp;
		if (!string) {
			return FALSE;
		}
		len = strlen(string);
		if ((maxlen > 0) && (len > (size_t) maxlen))
			return FALSE;

		if ((maxlen < 0) && (len > (size_t) -maxlen))
			len = (size_t) -maxlen;				/* Truncate string if too long */

		if (!idr_size_t(idrs, &len))		/* Emit string length */
			return FALSE;

		CHK_SIZE(idrs, len);			/* Make sure there is enough room */
		memcpy (idrs->i_ptr, string, len + 1);
	} else {
		if (!idr_size_t(idrs, &len))		/* Get string length */
			return FALSE;

		if ((maxlen > 0) && (len > (size_t) maxlen))
			return FALSE;

		if ((maxlen < 0) && (len > (size_t) -maxlen))
			return FALSE;

		string = *sp;
		if (!string) {
			string = malloc(len + 1);	/* Don't forget trailing null byte */
			if (!string) {
				return FALSE;
			}
			*sp = string;				/* Set up string pointer dynamically */
		}
		memcpy (string, idrs->i_ptr, len + 1);
	}
	
	idrs->i_ptr += len + 1;

	return TRUE;
}

#ifdef __cplusplus
}
#endif

#endif

/*
doc:</file>
*/
