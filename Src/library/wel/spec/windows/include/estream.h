/*
 * ESTREAM.H
 */

#ifndef __WEL_GLOBALS__
#	include "wel_globals.h"
#endif

#ifndef __WEL_EDITSTREAM__
#define __WEL_EDITSTREAM__

#ifndef __WEL_RICHEDIT__
#	include <redit.h>
#endif

#include "eif_eiffel.h"

typedef EIF_INTEGER (* EIF_EDITSTREAM_PROCEDURE)
	(EIF_REFERENCE,     /* WEL_EDIT_STREAM Eiffel object */
	 EIF_POINTER, /* buffer * */
	 EIF_INTEGER  /* length */
	 );

#ifndef __WEL_GLOBALS__
#	include "wel_globals.h"
#endif

/* Eiffel routine signature for `internal_callback' */
extern DWORD CALLBACK cwel_editstream_callback (DWORD, LPBYTE, LONG, LONG FAR *);

/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM) */
extern EIF_EDITSTREAM_PROCEDURE wel_editstream_procedure;

#define cwel_editstream_set_dwcookie(_ptr_, _value_) (((EDITSTREAM *) _ptr_)->dwCookie = (DWORD) (_value_))
#define cwel_editstream_set_dwerror(_ptr_, _value_) (((EDITSTREAM *) _ptr_)->dwError = (DWORD) (_value_))
#define cwel_editstream_set_pfncallback(_ptr_) (((EDITSTREAM *) _ptr_)->pfnCallback = (EDITSTREAMCALLBACK) (cwel_editstream_callback))

#define cwel_editstream_get_dwcookie(_ptr_) (((EDITSTREAM *) _ptr_)->dwCookie)
#define cwel_editstream_get_dwerror(_ptr_) (((EDITSTREAM *) _ptr_)->dwError)

#ifdef EIF_THREADS
	extern void wel_set_editstream_procedure_address(EIF_POINTER _value_) ;
#	define cwel_set_editstream_procedure_address(_value_)  (wel_set_editstream_procedure_address(_value_) )
		/* Set `wel_editstream_procedure' with `value' */

	extern void wel_set_editstream_object(EIF_OBJ _value_) ;
#	define cwel_set_editstream_object(_value_)  (wel_set_editstream_object(_value_) )
		/* Set `wel_editstream_object' with `value' */

	extern void wel_release_editstream_object() ;
#	define cwel_release_editstream_object  (wel_release_editstream_object )
		/* Set `wel_editstream_object' with `value' */

	extern void wel_set_editstream_buffer(EIF_POINTER _value_) ;
#	define cwel_set_editstream_buffer(_value_)  (wel_set_editstream_buffer(_value_) )
		/* Set `wel_editstream_buffer' with `value' */

	extern void wel_set_editstream_buffer_size(EIF_INTEGER _value_) ;
#	define cwel_set_editstream_buffer_size(_value_)  (wel_set_editstream_buffer_size(_value_) )
		/* Set `wel_editstream_buffer_size' with `value' */

	extern void wel_set_editstream_in(EIF_BOOLEAN _value_) ;
#	define cwel_set_editstream_in(_value_)  (wel_set_editstream_in(_value_) )
		/* Set `wel_editstream_in' with `value' */

#else

#	define cwel_set_editstream_procedure_address(_value_) (wel_editstream_procedure = (EIF_EDITSTREAM_PROCEDURE) _value_)
		/* Set `wel_editstream_procedure' with `value' */

#	define cwel_set_editstream_object(_value_) (wel_editstream_object = (EIF_OBJ) eif_adopt (_value_))
		/* Set `wel_editstream_object' with `value' */

#	define cwel_release_editstream_object (eif_wean (wel_editstream_object), wel_editstream_object = NULL)
		/* Set `wel_editstream_object' with `value' */

#	define cwel_set_editstream_buffer(_value_) (wel_editstream_buffer = (EIF_POINTER) _value_)
		/* Set `wel_editstream_buffer' with `value' */

#	define cwel_set_editstream_buffer_size(_value_) (wel_editstream_buffer_size = (EIF_INTEGER) _value_)
		/* Set `wel_editstream_buffer_size' with `value' */

#	define cwel_set_editstream_in(_value_) (wel_editstream_in = (EIF_BOOLEAN) _value_)
		/* Set `wel_editstream_in' with `value' */

#endif
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
