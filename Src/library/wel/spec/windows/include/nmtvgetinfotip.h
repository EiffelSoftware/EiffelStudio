/*
 * NMTVGETINFOTIP.H
 */

#ifndef __WEL_NM_TREEVIEWGETINFOTIP__
#define __WEL_NM_TREEVIEWGETINFOTIP__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_nmtvinfotip_get_hdr(_ptr_) (&(((NMTVGETINFOTIP *) _ptr_)->hdr))
#define cwel_nmtvinfotip_get_psztext(_ptr_) (&(((NMTVGETINFOTIP *) _ptr_)->pszText))
#define cwel_nmtvinfotip_get_cchtextmax(_ptr_) (((NMTVGETINFOTIP *) _ptr_)->cchTextMax)
#define cwel_nmtvinfotip_get_hitem(_ptr_) (((NMTVGETINFOTIP *) _ptr_)->hItem)
#define cwel_nmtvinfotip_get_lparam(_ptr_) ((((NMTVGETINFOTIP *) _ptr_)->lParam))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_NM_TREEVIEWGETINFOTIP__ */

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
