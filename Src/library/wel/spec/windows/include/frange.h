/*
 * FRANGE.H
 */

#ifndef __WEL_FORMATRANGE__
#define __WEL_FORMATRANGE__

#ifndef __WEL_RICHEDIT__
#	include <redit.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_formatrange_set_hdc(_ptr_, _value_) (((FORMATRANGE *) _ptr_)->hdc = (HDC) (_value_))
#define cwel_formatrange_set_hdctarget(_ptr_, _value_) (((FORMATRANGE *) _ptr_)->hdcTarget = (HDC) (_value_))
#define cwel_formatrange_set_rc(_ptr_, _value_) (((FORMATRANGE *) _ptr_)->rc = (* (RECT *) (_value_)))
#define cwel_formatrange_set_rcpage(_ptr_, _value_) (((FORMATRANGE *) _ptr_)->rcPage = (* (RECT *) (_value_)))
#define cwel_formatrange_set_chrg(_ptr_, _value_) (((FORMATRANGE *) _ptr_)->chrg = (* (CHARRANGE *) (_value_)))

#define cwel_formatrange_get_rc(_ptr_) (& (((FORMATRANGE *) _ptr_)->rc))
#define cwel_formatrange_get_rcpage(_ptr_) (& (((FORMATRANGE *) _ptr_)->rcPage))
#define cwel_formatrange_get_chrg(_ptr_) (& (((FORMATRANGE *) _ptr_)->chrg))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_FORMATRANGE__ */

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
