/*
 * LOGBRUSH.H
 */

#ifndef __WEL_LOGBRUSH__
#define __WEL_LOGBRUSH__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_logbrush_set_style(_ptr_, _value_) (((LOGBRUSH *) _ptr_)->lbStyle = (UINT) (_value_))
#define cwel_logbrush_set_color(_ptr_, _value_) (((LOGBRUSH *) _ptr_)->lbColor = (COLORREF) (_value_))
#define cwel_logbrush_set_hatch(_ptr_, _value_) (((LOGBRUSH *) _ptr_)->lbHatch = (int) (_value_))

#define cwel_logbrush_get_style(_ptr_) ((EIF_INTEGER) (((LOGBRUSH *) _ptr_)->lbStyle))
#define cwel_logbrush_get_color(_ptr_) ((EIF_INTEGER) (((LOGBRUSH *) _ptr_)->lbColor))
#define cwel_logbrush_get_hatch(_ptr_) ((EIF_INTEGER) (((LOGBRUSH *) _ptr_)->lbHatch))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_LOGBRUSH__ */

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
