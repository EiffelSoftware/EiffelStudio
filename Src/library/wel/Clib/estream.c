/*
indexing
	description: "Functions used by the class WEL_EDIT_STREAM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "wel_globals.h"

#ifndef EIF_THREADS
	EIF_EDITSTREAM_IN_PROCEDURE wel_editstream_in_procedure = NULL;
	/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM_IN) */

	EIF_EDITSTREAM_OUT_PROCEDURE wel_editstream_out_procedure = NULL;
	/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM_OUT) */
#endif



DWORD CALLBACK cwel_editstream_in_callback (DWORD_PTR dwCookie, LPBYTE pbBuff, LONG cb, LONG FAR * pcb)
{

	// This function is called by the system to transfere text into a Rich Edit Control.
	// dwCookie holds a EIF_OBJECT pointing to the WEL_RICH_EDIT_STREAM_IN object that will
	// process the transfere.
	// pbBuff is a pointer to a character array that receives (from the Eiffel side) the data
	// that will be transfered to the Rich Edit Control.
	// cb is the size of the character array.
	// *pcb will be set to the actual size of data written into pbBuff.

	WGTCX

	if (dwCookie) {
		// Call the Eiffel routine `internal_callback'.
		return (DWORD) (((EIF_EDITSTREAM_IN_PROCEDURE) wel_editstream_in_procedure) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access ((EIF_OBJECT) dwCookie),
#endif
			(EIF_POINTER) pbBuff,
			(EIF_INTEGER) cb,
			(EIF_POINTER)pcb));
	} else {
		return (DWORD) 0;
	}
}


DWORD CALLBACK cwel_editstream_out_callback (DWORD_PTR dwCookie, LPBYTE pbBuff, LONG cb, LONG FAR * pcb)
{

	// This function is called by the system to read text from a Rich Edit Control.
	// dwCookie holds a EIF_OBJECT pointing to the WEL_RICH_EDIT_STREAM_IN object that will
	// process the transfere.
	// pbBuff is a pointer to a character array that holds the text that has been read
	// from the Rich Edit Control.
	// cb is the size of the character array.
	// *pcb will be set to the actual size of data read (and processed).
	// We always read all data so it will be set to cb.

	WGTCX

	if (dwCookie) {
		* pcb = cb;

			/* Call the Eiffel routine `internal_callback'. */
		return (DWORD) (((EIF_EDITSTREAM_OUT_PROCEDURE) wel_editstream_out_procedure) (
#ifndef EIF_IL_DLL
			(EIF_REFERENCE) eif_access ((EIF_OBJECT) dwCookie),
#endif
			pbBuff,
			cb));
	} else {
		return (DWORD) 0;
	}
}

#ifdef EIF_THREADS


void wel_set_editstream_in_procedure_address(EIF_POINTER _value_)
{
		WGTCX
		wel_editstream_in_procedure = (EIF_EDITSTREAM_IN_PROCEDURE) _value_;
}

void wel_set_editstream_out_procedure_address(EIF_POINTER _value_)
{
		WGTCX
		wel_editstream_out_procedure = (EIF_EDITSTREAM_OUT_PROCEDURE) _value_;
}

#endif
