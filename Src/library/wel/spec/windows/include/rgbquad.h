/*
 * RGBQUAD.H
 */

#ifndef __WEL_RGBQUAD__
#define __WEL_RGBQUAD__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_rgb_quad_set_rgb_red(_ptr_, _value_) (((RGBQUAD *) _ptr_)->rgbRed = (BYTE) (_value_))
#define cwel_rgb_quad_set_rgb_green(_ptr_, _value_) (((RGBQUAD *) _ptr_)->rgbGreen = (BYTE) (_value_))
#define cwel_rgb_quad_set_rgb_blue(_ptr_, _value_) (((RGBQUAD *) _ptr_)->rgbBlue = (BYTE) (_value_))
#define cwel_rgb_quad_set_rgb_reserved(_ptr_, _value_) (((RGBQUAD *) _ptr_)->rgbReserved = (BYTE) (_value_))

#define cwel_rgb_quad_get_rgb_red(_ptr_) ((EIF_INTEGER) (((RGBQUAD *) _ptr_)->rgbRed))
#define cwel_rgb_quad_get_rgb_green(_ptr_) ((EIF_INTEGER) (((RGBQUAD *) _ptr_)->rgbGreen))
#define cwel_rgb_quad_get_rgb_blue(_ptr_) ((EIF_INTEGER) (((RGBQUAD *) _ptr_)->rgbBlue))
#define cwel_rgb_quad_get_rgb_reserved(_ptr_) ((EIF_INTEGER) (((RGBQUAD *) _ptr_)->rgbReserved))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_RGBQUAD__ */

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
