/*
 * NMTB.H
 */

#ifndef __WEL_NMTOOLBAR__
#define __WEL_NMTOOLBAR__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#define cwel_nmtoolbar_get_hdr(_ptr_) (&(((NMTOOLBAR *) _ptr_)->hdr))
#define cwel_nmtoolbar_get_iitem(_ptr_) (((NMTOOLBAR *) _ptr_)->iItem)
#define cwel_nmtoolbar_get_tbbutton(_ptr_) (&(((NMTOOLBAR *) _ptr_)->tbButton))
#define cwel_nmtoolbar_get_cchtext(_ptr_) ((((NMTOOLBAR *) _ptr_)->cchText))
#define cwel_nmtoolbar_get_psztext(_ptr_) (&(((NMTOOLBAR *) _ptr_)->pszText))

#endif /* __WEL_NMTOOLBAR__ */

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
