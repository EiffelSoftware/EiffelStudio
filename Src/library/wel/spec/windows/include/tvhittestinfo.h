/*
 * TVHITTESTINFO.H
 */

#ifndef __WEL_TVHITTESTINFO__
#define __WEL_TVHITTESTINFO__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#define cwel_tv_hittestinfo_set_pt(_ptr_, _value_) (((TVHITTESTINFO *) _ptr_)->pt = *((POINT *) (_value_)))

#define cwel_tv_hittestinfo_get_pt(_ptr_) (&(((TVHITTESTINFO *) _ptr_)->pt))
#define cwel_tv_hittestinfo_get_flags(_ptr_) (((TVHITTESTINFO *) _ptr_)->flags)
#define cwel_tv_hittestinfo_get_hitem(_ptr_) (((TVHITTESTINFO *) _ptr_)->hItem)

#endif /* __WEL_TVHITTESTINFO__ */

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
