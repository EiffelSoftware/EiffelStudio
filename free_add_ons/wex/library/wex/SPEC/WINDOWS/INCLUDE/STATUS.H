/*
 * STATUS.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __STATUS__
#define __STATUS__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <generic.h>

#define cwex_mci_status_set_status(_ptr_, _value_) (((MCI_STATUS_PARMS *)_ptr_)->dwItem = (DWORD) (_value_))
#define cwex_mci_status_set_track(_ptr_, _value_) (((MCI_STATUS_PARMS *) _ptr_)->dwTrack = (DWORD) (_value_))

#define cwex_mci_status_get_result(_ptr_) ((((MCI_STATUS_PARMS *) _ptr_)->dwReturn))
#define cwex_mci_status_get_status(_ptr_) ((((MCI_STATUS_PARMS *)_ptr_)->dwItem))
#define cwex_mci_status_get_track(_ptr_) ((((MCI_STATUS_PARMS *) _ptr_)->dwTrack))

#endif /* __STATUS__ */

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
