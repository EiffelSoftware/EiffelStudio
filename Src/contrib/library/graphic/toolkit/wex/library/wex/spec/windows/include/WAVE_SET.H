/*
 * WAVESET.H
 *
 * Author: "Robin van Ommeren"
 * date: "$Date$"
 * revision: "$Revision$"
 */

#ifndef __WAVESET__
#define __WAVESET__

#ifndef __WEL_MCI__
#	include <wex_mci.h>
#endif

#include <set.h>

#define cwex_mci_wave_set_input(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->wInput = (UINT) (_value_))
#define cwex_mci_wave_set_output(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->wOutput = (UINT) (_value_))
#define cwex_mci_wave_set_format_tag(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->wFormatTag = (WORD) (_value_))
#define cwex_mci_wave_set_channels(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->nChannels = (WORD) (_value_))
#define cwex_mci_wave_set_samples_per_second(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->nSamplesPerSec = (DWORD) (_value_))
#define cwex_mci_wave_set_bytes_per_second(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->nAvgBytesPerSec = (DWORD) (_value_))
#define cwex_mci_wave_set_block_align(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->nBlockAlign = (WORD) (_value_))
#define cwex_mci_wave_set_bits_per_sample(_ptr_, _value_) (((MCI_WAVE_SET_PARMS *) _ptr_)->wBitsPerSample = (WORD) (_value_))

#define cwex_mci_wave_get_input(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->wInput))
#define cwex_mci_wave_get_output(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->wOutput))
#define cwex_mci_wave_get_format_tag(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->wFormatTag))
#define cwex_mci_wave_get_channels(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->nChannels))
#define cwex_mci_wave_get_samples_per_second(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->nSamplesPerSec))
#define cwex_mci_wave_get_bytes_per_second(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->nAvgBytesPerSec))
#define cwex_mci_wave_get_block_align(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->nBlockAlign))
#define cwex_mci_wave_get_bits_per_sample(_ptr_) ((((MCI_WAVE_SET_PARMS *) _ptr_)->wBitsPerSample))

#endif /* __WAVESET__ */

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
