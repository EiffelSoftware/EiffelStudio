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


#ifdef __cplusplus
extern "C" {
#endif

typedef EIF_INTEGER (* EIF_EDITSTREAM_IN_PROCEDURE)
	(EIF_REFERENCE,     /* WEL_EDIT_STREAM_IN Eiffel object */
	 EIF_POINTER, /* buffer * */
	 EIF_INTEGER,  /* length of buffer */
	 EIF_POINTER /* actual length of data written into the buffer */
	 );

typedef EIF_INTEGER (* EIF_EDITSTREAM_OUT_PROCEDURE)
	(EIF_REFERENCE,	/* WEL_EDIT_STREAM_OUT Eiffel object */
	 EIF_POINTER,	/* buffer */
	 EIF_INTEGER	/* length of buffer */
	 );


#ifdef __cplusplus
}
#endif

#ifndef __WEL_GLOBALS__
#	include "wel_globals.h"
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* Eiffel routine signature for `internal_callback' (WEL_RICH_EDIT_STREAM_IN)*/
extern DWORD CALLBACK cwel_editstream_in_callback (DWORD, LPBYTE, LONG, LONG FAR *);

/* Eiffel routine signature for `internal_callback' (WEL_RICH_EDIT_STREAM_OUT)*/
extern DWORD CALLBACK cwel_editstream_out_callback (DWORD, LPBYTE, LONG, LONG FAR *);

/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM_IN) */
extern EIF_EDITSTREAM_IN_PROCEDURE wel_editstream_in_procedure;

/* Address of the Eiffel routine `internal_callback' (class WEL_EDIT_STREAM_OUT) */
extern EIF_EDITSTREAM_OUT_PROCEDURE wel_editstream_out_procedure;

#define cwel_editstream_set_dwcookie(_ptr_, _value_) (((EDITSTREAM *) _ptr_)->dwCookie = (DWORD) (_value_))
#define cwel_editstream_set_dwerror(_ptr_, _value_) (((EDITSTREAM *) _ptr_)->dwError = (DWORD) (_value_))
#define cwel_editstream_set_pfncallback_in(_ptr_) (((EDITSTREAM *) _ptr_)->pfnCallback = (EDITSTREAMCALLBACK) (cwel_editstream_in_callback))
#define cwel_editstream_set_pfncallback_out(_ptr_) (((EDITSTREAM *) _ptr_)->pfnCallback = (EDITSTREAMCALLBACK) (cwel_editstream_out_callback))


#define cwel_editstream_get_dwcookie(_ptr_) (((EDITSTREAM *) _ptr_)->dwCookie)
#define cwel_editstream_get_dwerror(_ptr_) (((EDITSTREAM *) _ptr_)->dwError)

#define cwel_set_integer_reference_value(_ref_, _value_) * _ref_ = _value_

#ifdef EIF_THREADS
	extern void wel_set_editstream_in_procedure_address(EIF_POINTER _value_) ;
#	define cwel_set_editstream_in_procedure_address(_value_)  (wel_set_editstream_in_procedure_address(_value_) )
		/* Set `wel_editstream_in_procedure' with `value' */

	extern void wel_set_editstream_out_procedure_address(EIF_POINTER _value_) ;
#	define cwel_set_editstream_out_procedure_address(_value_)  (wel_set_editstream_out_procedure_address(_value_) )
		/* Set `wel_editstream_out_procedure' with `value' */

#else

#	define cwel_set_editstream_in_procedure_address(_value_) (wel_editstream_in_procedure = (EIF_EDITSTREAM_IN_PROCEDURE) _value_)
		/* Set `wel_editstream_in_procedure' with `value' */

#	define cwel_set_editstream_out_procedure_address(_value_) (wel_editstream_out_procedure = (EIF_EDITSTREAM_OUT_PROCEDURE) _value_)
		/* Set `wel_editstream_out_procedure' with `value' */

#endif


#ifdef __cplusplus
}
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
