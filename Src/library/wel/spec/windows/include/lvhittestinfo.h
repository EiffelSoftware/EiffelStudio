/*
 * LVHITTESTINFO.H
 */

#ifndef __WEL_LVHITTESTINFO__
#define __WEL_LVHITTESTINFO__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_lv_hittestinfo_set_pt(_ptr_, _value_) (((LVHITTESTINFO *) _ptr_)->pt = *((POINT *) (_value_)))

#define cwel_lv_hittestinfo_get_pt(_ptr_) (&(((LVHITTESTINFO *) _ptr_)->pt))
#define cwel_lv_hittestinfo_get_flags(_ptr_) (((LVHITTESTINFO *) _ptr_)->flags)
#define cwel_lv_hittestinfo_get_iitem(_ptr_) (((LVHITTESTINFO *) _ptr_)->iItem)
#define cwel_lv_hittestinfo_get_isubitem(_ptr_) (((LVHITTESTINFO *) _ptr_)->iSubItem)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_LVHITTESTINFO__ */

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
