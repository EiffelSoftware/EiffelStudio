/*
 * MCI_DGV_OPEN.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __MCI_DGV_OPEN__
#define __MCI_DGV_OPEN__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <open.h>

#define cwex_mci_dgv_open_get_dw_style(_ptr_) (((MCI_DGV_OPEN_PARMS*) _ptr_)->dwStyle)
#define cwex_mci_dgv_open_get_hwnd_parent(_ptr_) (((MCI_DGV_OPEN_PARMS*) _ptr_)->hWndParent)

#define cwex_mci_dgv_open_set_dw_style(_ptr_, _value_) (((MCI_DGV_OPEN_PARMS*) _ptr_)->dwStyle = (DWORD)_value_)
#define cwex_mci_dgv_open_set_hwnd_parent(_ptr_, _value_) (((MCI_DGV_OPEN_PARMS*) _ptr_)->hWndParent = (HWND)_value_)

#endif /* __MCI_DGV_OPEN__ */

/*
--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------
*/
