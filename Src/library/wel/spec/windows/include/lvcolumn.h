/*
 * LVCOLUMN.H
 */

#ifndef __WEL_LISTVIEWCOLUMN__
#define __WEL_LISTVIEWCOLUMN__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#define cwel_lv_column_set_mask(_ptr_, _value_) 		(((LV_COLUMN *) _ptr_)->mask = (UINT) (_value_))
#define cwel_lv_column_set_fmt(_ptr_, _value_)			(((LV_COLUMN *) _ptr_)->fmt = (int) (_value_))
#define cwel_lv_column_set_cx(_ptr_, _value_)			(((LV_COLUMN *) _ptr_)->cx = (int) (_value_))
#define cwel_lv_column_set_psztext(_ptr_, _value_)		(((LV_COLUMN *) _ptr_)->pszText = (LPTSTR) (_value_))
#define cwel_lv_column_set_cchtextmax(_ptr_, _value_)	(((LV_COLUMN *) _ptr_)->cchTextMax = (int) (_value_))
/* Not define in Borland C++
 * #define cwel_lv_column_set_iimage(_ptr_, _value_) 		(((LV_COLUMN *) _ptr_)->iImage = (int) (_value_)) */

#define cwel_lv_column_get_mask(_ptr_)			(((LV_COLUMN *) _ptr_)->mask)
#define cwel_lv_column_get_fmt(_ptr_)			(((LV_COLUMN *) _ptr_)->fmt)
#define cwel_lv_column_get_cx(_ptr_)			(((LV_COLUMN *) _ptr_)->cx)
#define cwel_lv_column_get_psztext(_ptr_)		(((LV_COLUMN *) _ptr_)->pszText)
#define cwel_lv_column_get_cchtextmax(_ptr_)	(((LV_COLUMN *) _ptr_)->cchTextMax)
/* Not define in Borlan C++
 * #define cwel_lv_column_get_iimage(_ptr_)		(((LV_COLUMN *) _ptr_)->iImage) */

#endif /* __WEL_LISTVIEWCOLUMN__ */

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
