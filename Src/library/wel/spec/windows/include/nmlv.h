/*
 * NMLV.H
 */

#ifndef __WEL_NM_LISTVIEW__
#define __WEL_NM_LISTVIEW__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#define cwel_nm_listview_get_hdr(_ptr_) (&(((NM_LISTVIEW *) _ptr_)->hdr))
#define cwel_nm_listview_get_iitem(_ptr_) (((NM_LISTVIEW *) _ptr_)->iItem)
#define cwel_nm_listview_get_isubitem(_ptr_) (((NM_LISTVIEW *) _ptr_)->iSubItem)
#define cwel_nm_listview_get_unewstate(_ptr_) (((NM_LISTVIEW *) _ptr_)->uNewState)
#define cwel_nm_listview_get_uoldstate(_ptr_) (((NM_LISTVIEW *) _ptr_)->uOldState)
#define cwel_nm_listview_get_uchanged(_ptr_) (((NM_LISTVIEW *) _ptr_)->uChanged)
#define cwel_nm_listview_get_ptaction(_ptr_) (&(((NM_LISTVIEW *) _ptr_)->ptAction))
#define cwel_nm_listview_get_lparam(_ptr_) (((NM_LISTVIEW *) _ptr_)->lParam)

#endif /* __WEL_NM_LISTVIEW__ */

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
