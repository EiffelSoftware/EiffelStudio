/*
 * ESTREAM.C
 *
 * Functions used by the class WEL_EDIT_STREAM.
 *
 */

#include "wel_globals.h"

#ifndef EIF_THREADS
	EIF_EDITSTREAM_IN_PROCEDURE wel_editstream_in_procedure = NULL;
	/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM_IN) */

	EIF_EDITSTREAM_OUT_PROCEDURE wel_editstream_out_procedure = NULL;
	/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM_OUT) */
	
#endif



DWORD CALLBACK cwel_editstream_in_callback (DWORD dwCookie, LPBYTE pbBuff, LONG cb, LONG FAR * pcb)
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
		/* Call the Eiffel routine `internal_callback'. */
		return (DWORD) (((EIF_EDITSTREAM_IN_PROCEDURE)wel_editstream_in_procedure) (
			(EIF_REFERENCE) eif_access ((EIF_OBJECT) dwCookie),
			(EIF_POINTER) pbBuff,
			(EIF_INTEGER) cb, 
			(EIF_POINTER)pcb));
	} else {
		return (DWORD) 0;
	}
}


DWORD CALLBACK cwel_editstream_out_callback (DWORD dwCookie, LPBYTE pbBuff, LONG cb, LONG FAR * pcb)
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
			(EIF_REFERENCE) eif_access ((EIF_OBJECT) dwCookie), pbBuff, cb));
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
