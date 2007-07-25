/*
 * DGV_RECT.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __DGV_RECT__
#define __DGV_RECT__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <generic.h>

#define cwex_mci_dgv_rect_set_rect(_ptr_, _value_) (((MCI_DGV_RECT_PARMS *) _ptr_)->rc = (RECT) (_value_))

#define cwex_mci_dgv_rect_get_rect(_ptr_) ((EIF_POINTER) &(((MCI_DGV_RECT_PARMS *) _ptr_)->rc))

#endif /* __DGV_RECT__ */

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
