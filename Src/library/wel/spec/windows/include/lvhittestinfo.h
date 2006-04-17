/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
