/*
 * ESTREAM.H
 */

#ifndef __WEL_EDITSTREAM__
#define __WEL_EDITSTREAM__

#ifndef __WEL_RICHEDIT__
#	include <redit.h>
#endif

#include "eif_eiffel.h"

#define cwel_editstream_set_dwcookie(_ptr_, _value_) (((EDITSTREAM *) _ptr_)->dwCookie = (DWORD) (_value_))
#define cwel_editstream_set_dwerror(_ptr_, _value_) (((EDITSTREAM *) _ptr_)->dwError = (DWORD) (_value_))
#define cwel_editstream_set_pfncallback(_ptr_, _value_) (((EDITSTREAM *) _ptr_)->pfnCallback = (EDITSTREAMCALLBACK) (_value_))

#define cwel_editstream_get_dwcookie(_ptr_) (((EDITSTREAM *) _ptr_)->dwCookie)
#define cwel_editstream_get_dwerror(_ptr_) (((EDITSTREAM *) _ptr_)->dwError)

typedef EIF_INTEGER (* EIF_EDITSTREAM_PROCEDURE)
	(EIF_OBJ,     /* WEL_EDIT_STREAM Eiffel object */
	 EIF_POINTER, /* buffer * */
	 EIF_INTEGER  /* length */
	 );
/* Eiffel routine signature for `internal_callback' */

DWORD CALLBACK cwel_editstream_callback (DWORD, LPBYTE, LONG, LONG FAR *);

extern EIF_EDITSTREAM_PROCEDURE wel_editstream_procedure;
/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM) */

extern EIF_OBJ wel_editstream_object;
/* Address of the Eiffel object WEL_EDIT_STREAM created */

extern EIF_POINTER wel_editstream_buffer;
/* Address of the buffer */

extern EIF_INTEGER wel_editstream_buffer_size;
/* Size of `wel_editstream_buffer' */

extern EIF_BOOLEAN wel_editstream_in;
/* Is the operation stream_in? */

#define cwel_set_editstream_procedure_address(_value_) (wel_editstream_procedure = (EIF_EDITSTREAM_PROCEDURE) _value_)
/* Set `wel_editstream_procedure' with `value' */

#define cwel_set_editstream_object(_value_) (wel_editstream_object = (EIF_OBJ) eif_adopt (_value_))
/* Set `wel_editstream_object' with `value' */

#define cwel_release_editstream_object (eif_wean (wel_editstream_object))
/* Set `wel_editstream_object' with `value' */

#define cwel_set_editstream_buffer(_value_) (wel_editstream_buffer = (EIF_POINTER) _value_)
/* Set `wel_editstream_buffer' with `value' */

#define cwel_set_editstream_buffer_size(_value_) (wel_editstream_buffer_size = (EIF_INTEGER) _value_)
/* Set `wel_editstream_buffer_size' with `value' */

#define cwel_set_editstream_in(_value_) (wel_editstream_in = (EIF_BOOLEAN) _value_)
/* Set `wel_editstream_in' with `value' */

#endif /* __WEL_EDITSTREAM__ */

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
