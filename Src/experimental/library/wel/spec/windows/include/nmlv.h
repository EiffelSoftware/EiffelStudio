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

#ifndef __WEL_NM_LISTVIEW__
#define __WEL_NM_LISTVIEW__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_nm_listview_get_hdr(_ptr_) (&(((NM_LISTVIEW *) _ptr_)->hdr))
#define cwel_nm_listview_get_iitem(_ptr_) (((NM_LISTVIEW *) _ptr_)->iItem)
#define cwel_nm_listview_get_isubitem(_ptr_) (((NM_LISTVIEW *) _ptr_)->iSubItem)
#define cwel_nm_listview_get_unewstate(_ptr_) (((NM_LISTVIEW *) _ptr_)->uNewState)
#define cwel_nm_listview_get_uoldstate(_ptr_) (((NM_LISTVIEW *) _ptr_)->uOldState)
#define cwel_nm_listview_get_uchanged(_ptr_) (((NM_LISTVIEW *) _ptr_)->uChanged)
#define cwel_nm_listview_get_ptaction(_ptr_) (&(((NM_LISTVIEW *) _ptr_)->ptAction))
#define cwel_nm_listview_get_lparam(_ptr_) (((NM_LISTVIEW *) _ptr_)->lParam)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_NM_LISTVIEW__ */
