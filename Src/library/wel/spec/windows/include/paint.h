/*
 * PAINT.H
 */

#ifndef __WEL_PAINTSTRUCT__
#define __WEL_PAINTSTRUCT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_paintstruct_get_ferase(_ptr_) ((EIF_BOOLEAN) (((PAINTSTRUCT *) _ptr_)->fErase))
#define cwel_paintstruct_get_rcpaint(_ptr_) ((EIF_POINTER) &(((PAINTSTRUCT *) _ptr_)->rcPaint))
// #define cwel_paintstruct_get_hdc(_ptr_) ((EIF_POINTER) (((PAINTSTRUCT *) _ptr_)->hdc))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_PAINTSTRUCT__ */

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
