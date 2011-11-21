/*
 * MCI_OPEN.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __MCI_OPEN__
#define __MCI_OPEN__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <generic.h>

#define cwex_mci_open_set_device(_ptr_, _value_) (((MCI_OPEN_PARMS *) _ptr_)->wDeviceID = (MCIDEVICEID) (_value_))
#define cwex_mci_open_set_device_type(_ptr_, _value_) (((MCI_OPEN_PARMS *)_ptr_)->lpstrDeviceType = (LPCSTR) (_value_))
#define cwex_mci_open_set_element_name(_ptr_, _value_) (((MCI_OPEN_PARMS *) _ptr_)->lpstrElementName = (LPCSTR) (_value_))
#define cwex_mci_open_set_alias(_ptr_, _value_) (((MCI_OPEN_PARMS *) _ptr_)->lpstrAlias = (LPCSTR) (_value_))

#define cwex_mci_open_get_device(_ptr_) ((((MCI_OPEN_PARMS *) _ptr_)->wDeviceID))
#define cwex_mci_open_get_device_type(_ptr_) ((((MCI_OPEN_PARMS *)_ptr_)->lpstrDeviceType))
#define cwex_mci_open_get_element_name(_ptr_) ((((MCI_OPEN_PARMS *) _ptr_)->lpstrElementName))
#define cwex_mci_open_get_alias(_ptr_) ((((MCI_OPEN_PARMS *) _ptr_)->lpstrAlias))

#endif /* __MCI_OPEN__ */

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
