/*
 * DGV_WIN.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __DGV_WINDOW__
#define __DGV_WINDOW__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <generic.h>

#define cwex_mci_dgv_window_set_display_window(_ptr_, _value_) (((MCI_DGV_WINDOW_PARMS *) _ptr_)->hWnd = (HWND) (_value_))
#define cwex_mci_dgv_window_set_display_style(_ptr_, _value_) (((MCI_DGV_WINDOW_PARMS *) _ptr_)->nCmdShow = (UINT) (_value_))
#define cwex_mci_dgv_window_set_caption(_ptr_, _value_) (((MCI_DGV_WINDOW_PARMS *) _ptr_)->lpstrText = (LPSTR) (_value_))

#define cwex_mci_dgv_window_get_display_window(_ptr_) ((((MCI_DGV_WINDOW_PARMS *) _ptr_)->hWnd))
#define cwex_mci_dgv_window_get_display_style(_ptr_) ((((MCI_DGV_WINDOW_PARMS *) _ptr_)->nCmdShow))
#define cwex_mci_dgv_window_get_caption(_ptr_) ((((MCI_DGV_WINDOW_PARMS *) _ptr_)->lpstrText))

#endif /* __DGV_WINDOW__ */

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
