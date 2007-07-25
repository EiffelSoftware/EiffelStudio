/*
 * WAVE_OPEN.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __WAVE_OPEN__
#define __WAVE_OPEN__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <open.h>

#define cwex_mci_wave_open_set_buffer_seconds(_ptr_, _value_) (((MCI_WAVE_OPEN_PARMS *) _ptr_)->dwBufferSeconds = (DWORD) (_value_))

#define cwex_mci_wave_open_get_buffer_seconds(_ptr_) ((((MCI_WAVE_OPEN_PARMS *) _ptr_)->dwBufferSeconds))

#endif /* __WAVE_OPEN__ */

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
