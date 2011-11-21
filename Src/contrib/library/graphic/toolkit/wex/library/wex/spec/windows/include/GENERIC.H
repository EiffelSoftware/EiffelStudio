/*
 * GENERIC.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __GENERIC__
#define __GENERIC__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#define cwex_mci_generic_set_callback(_ptr_, _value_) (((MCI_GENERIC_PARMS *) _ptr_)->dwCallback = (DWORD_PTR) (_value_))

#define cwex_mci_generic_get_callback(_ptr_) ((((MCI_GENERIC_PARMS *) _ptr_)->dwCallback))

#endif /* __GENERIC__ */

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
