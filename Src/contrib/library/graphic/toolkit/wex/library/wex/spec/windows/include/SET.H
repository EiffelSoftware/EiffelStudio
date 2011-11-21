/*
 * SET.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __SET__
#define __SET__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <generic.h>

#define cwex_mci_set_set_time_format(_ptr_, _value_) (((MCI_SET_PARMS *) _ptr_)->dwTimeFormat = (DWORD) (_value_))
#define cwex_mci_set_set_audio(_ptr_, _value_) (((MCI_SET_PARMS *)_ptr_)->dwAudio = (DWORD) (_value_))

#define cwex_mci_set_get_time_format(_ptr_) ((((MCI_SET_PARMS *) _ptr_)->dwTimeFormat))
#define cwex_mci_set_get_audio(_ptr_) ((((MCI_SET_PARMS *)_ptr_)->dwAudio))

#endif /* __SET__ */

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
