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

#ifndef __WEL_NM_TREEVIEW__
#define __WEL_NM_TREEVIEW__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_nm_treeview_get_hdr(_ptr_) (&(((NM_TREEVIEW *) _ptr_)->hdr))
#define cwel_nm_treeview_get_action(_ptr_) (((NM_TREEVIEW *) _ptr_)->action)
#define cwel_nm_treeview_get_itemnew(_ptr_) (&(((NM_TREEVIEW *) _ptr_)->itemNew))
#define cwel_nm_treeview_get_itemold(_ptr_) (&(((NM_TREEVIEW *) _ptr_)->itemOld))
#define cwel_nm_treeview_get_ptdrag(_ptr_) (&(((NM_TREEVIEW *) _ptr_)->ptDrag))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_NM_TREEVIEW__ */
