/*
 * ESTREAM.C
 *
 * Functions used by the class WEL_EDIT_STREAM.
 *
 */

#include "wel_globals.h"

#ifndef EIF_THREADS
	EIF_EDITSTREAM_PROCEDURE wel_editstream_procedure = NULL;
	/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM) */
	
	EIF_OBJ wel_editstream_object = NULL;
	/* Address of the Eiffel object WEL_EDIT_STREAM created */
	
	EIF_POINTER wel_editstream_buffer = NULL;
	/* Address of the buffer */
	
	EIF_INTEGER wel_editstream_buffer_size = 0;
	/* Size of `wel_editstream_buffer' */
	
	EIF_BOOLEAN wel_editstream_in;
	/* Is the operation stream_in? */
#endif

DWORD CALLBACK cwel_editstream_callback (DWORD dwCookie, LPBYTE pbBuff, LONG cb, LONG FAR * pcb)
{
	/*
	 * The control calls the this callback function repeatedly, transferring
	 * a portion of the data with each call.
	 * -- PK.
	 */

	WGTCX
	dwCookie = dwCookie;

	if (wel_editstream_object)
	{
		DWORD result;

		/* If EM_STREAMOUT message, let's close the string. */
		if (!wel_editstream_in)
			pbBuff [cb] = '\0';

		/* Call the Eiffel routine `internal_callback'. */
		result = (DWORD) ((wel_editstream_procedure) (
			(EIF_OBJ) eif_access (wel_editstream_object),
			(EIF_POINTER) pbBuff,
			(EIF_INTEGER) cb));

		/* Set the number of bytes read or written. */
		* pcb = wel_editstream_buffer_size;

		/* If EM_STREAMIN, let's copy the Eiffel string
		 * into the C buffer `pbBuff'.
		 */
		if (wel_editstream_in)
			memcpy (pbBuff, wel_editstream_buffer, * pcb);

		return result;
	}
	else
	{
		return (DWORD) 0;
	}
}

#ifdef EIF_THREADS


void wel_set_editstream_procedure_address(EIF_POINTER _value_) 
{
		WGTCX
		wel_editstream_procedure = (EIF_EDITSTREAM_PROCEDURE) _value_;
}

void wel_set_editstream_object(EIF_OBJ _value_) 
{
		WGTCX
		wel_editstream_object = (EIF_OBJ) eif_adopt (_value_);
}

void wel_release_editstream_object() 
{
		WGTCX
		eif_wean (wel_editstream_object);
}

void wel_set_editstream_buffer(EIF_POINTER _value_) 
{
		WGTCX
		wel_editstream_buffer = (EIF_POINTER) _value_;
}

void wel_set_editstream_buffer_size(EIF_INTEGER _value_) 
{
		WGTCX
		wel_editstream_buffer_size = (EIF_INTEGER) _value_;
}

void wel_set_editstream_in(EIF_BOOLEAN _value_) 
{
		WGTCX
		wel_editstream_in = (EIF_BOOLEAN) _value_;
}


#endif

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
