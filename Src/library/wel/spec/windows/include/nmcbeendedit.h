/*
 * NMCBEENDEDIT.H
 */

#ifndef __WEL_NM_CBEENDEDIT__
#define __WEL_NM_CBEENDEDIT__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#define cwel_nm_cbeendedit_get_hdr(_ptr_) (&(((NMCBEENDEDIT *) _ptr_)->hdr))
#define cwel_nm_cbeendedit_get_fchanged(_ptr_) (((NMCBEENDEDIT *) _ptr_)->fChanged)
#define cwel_nm_cbeendedit_get_inewselection(_ptr_) (((NMCBEENDEDIT *) _ptr_)->iNewSelection)
#define cwel_nm_cbeendedit_get_tchar(_ptr_) (&(((NMCBEENDEDIT *) _ptr_)->szText))
#define cwel_nm_cbeendedit_get_iwhy(_ptr_) (((NMCBEENDEDIT *) _ptr_)->iWhy)

#endif /* __WEL_NM_CBEENDEDIT__ */

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
