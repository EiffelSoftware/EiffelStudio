/*
--|----------------------------------------------------------------
--| Eiffel runtime C code file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
doc:<file name="idrs.c" header="idrs.h" version="$Id$" summary="Routine for basic serialization used by communication routine for EiffelStudio debugger">
*/


#include "eif_config.h"
#include "eif_portable.h"
#include "idrs.h"

/*
doc:	<routine name="idr_create" export="private">
doc:		<summary>Initialize a memory stream, where the (de)serialization is done in the provided buffer pointed to by addr.</summary>
doc:		<param name="idrs" type="IDR *">IDR structure managing the stream.</param>
doc:		<param name="addr" type="char *">Address of serializing buffer.</param>
doc:		<param name="length" type="size_t">Length of serializing buffer.</param>
doc:		<param name="i_op" type="int">Type of operation wanted.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_private void idr_create(IDR *idrs, char *addr, size_t len, int i_op)
{
	idrs->i_op = i_op;
	idrs->i_size = len;
	idrs->i_buf = addr;
	idrs->i_ptr = addr;
}

/*
doc:	<routine name="idr_destroy" export="private">
doc:		<summary>Release the memory used by the IDR stream.</summary>
doc:		<param name="idrs" type="IDR *">IDR structure managing the stream.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_private void idr_destroy(IDR *idrs)
{
	idrs->i_size = 0;
	if (idrs->i_buf) {
		free(idrs->i_buf);
		idrs->i_buf = idrs->i_ptr = NULL;
	}
}

/*
doc:	<routine name="idr_setpos" return_type="bool_t" export="shared">
doc:		<summary>Set the position of the stream to pos and return true if it is possible, false otherwise.</summary>
doc:		<param name="idrs" type="IDR *">IDR structure managing the stream.</param>
doc:		<param name="pos" type="size_t">Set current position of `idrs' to `pos'.</param>
doc:		<return>TRUE if `pos' is valid, FALSE otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared bool_t idr_setpos(IDR *idrs, size_t pos)
{
	if (pos < idrs->i_size) {
		idrs->i_ptr = idrs->i_buf + pos;
		return TRUE;
	} else {
		return FALSE;
	}
}

/*
doc:	<routine name="idrf_create" return_type="int" export="shared">
doc:		<summary>Initializes memory for IDR operations. We create memory streams for input and output. Thus, all the input requests will have the same length, regardless of their type. The same applies for output request, although the size may not be the same.</summary>
doc:		<param name="idrf" type="IDRF *">IDR filtering pair.</param>
doc:		<param name="size" type="size_t">Size of IDR buffers.</param>
doc:		<return>0 if ok, -1 for failure.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared int idrf_create(IDRF *idrf, size_t size)
{
	char *out_addr;			/* IDR output data buffer */
	char *in_addr;			/* IDR input data buffer */
	int result = 0;

	in_addr = (char *) malloc(size);
	if (in_addr) {
		out_addr = (char *) malloc(size);
		if (out_addr) {
			memset(in_addr,0,size);
			memset(out_addr,0,size);

			idr_create(&idrf->i_decode, in_addr, size, IDR_DECODE);
			idr_create(&idrf->i_encode, out_addr, size, IDR_ENCODE);
		} else {
			free(in_addr);
			result = -1;
		}
	} else {
		result = -1;
	}
	return result;
}

/*
doc:	<routine name="idrf_destroy" export="shared">
doc:		<summary>Release the memory used by the IDR streams.</summary>
doc:		<param name="idrf" type="IDRF *">IDR filtering pair.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared void idrf_destroy(IDRF *idrf)
{
	idr_destroy(&idrf->i_encode);
	idr_destroy(&idrf->i_decode);
}

/*
doc:	<routine name="idrf_reset_pos" export="shared">
doc:		<summary>This routine should be called before any IDR operation, in order to reposition the memory streams.</summary>
doc:		<param name="idrf" type="IDRF *">IDR filtering pair.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared void idrf_reset_pos(IDRF *idrf)
{
	(void) idr_setpos(&idrf->i_encode, 0);
	(void) idr_setpos(&idrf->i_decode, 0);
}

/*
doc:	<routine name="idr_string" return_type="bool_t" export="shared">
doc:		<summary>Serialize a string. Dynamic allocation for data storage is done when deserializing if the address of the string is NULL. There is a big difference with the pending XDR routines, since maxlen may be left to 0 to avoid string length limitations. The serialization will fail if the buffer limits are reached. If the size given is <0, then the absolute value gives the maximum string length, and the string will be truncated if it is longer than that. Strings are serialized by first emitting the length as an size_t, then the characters from the string itself, with the trailing null byte omitted.</summary>
doc:		<param name="idrs" type="IDR *">IDR structure managing the stream.</param>
doc:		<param name="sp" type="char **">Pointer to area where string address is stored.</param>
doc:		<param name="maxlen" type="int">Maximum length, 0 = no limit.</param>
doc:		<return>TRUE if successful, FALSE otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/

rt_shared bool_t idr_string(IDR *idrs, char **sp, int maxlen)
{
	size_t len;		/* String length */
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
