/*
 * NMTV.H
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
