/*
 * DEVCAPS.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __DEVCAPS__
#define __DEVCAPS__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <generic.h>

#define cwex_mci_devcaps_set_item(_ptr_, _value_) (((MCI_GETDEVCAPS_PARMS *)_ptr_)->dwItem = (DWORD) (_value_))

#define cwex_mci_devcaps_get_result(_ptr_) ((((MCI_GETDEVCAPS_PARMS *) _ptr_)->dwReturn))

#endif /* __DEVCAPS__ */

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
