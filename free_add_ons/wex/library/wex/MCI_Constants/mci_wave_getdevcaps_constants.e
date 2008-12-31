note
	description: "Device Capabilities constants for the %
		%waveaudio MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_WAVE_GETDEVCAPS_CONSTANTS

feature -- Access

	Mci_wave_getdevcaps_inputs: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_WAVE_GETDEVCAPS_INPUTS"
		end

	Mci_wave_getdevcaps_outputs: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_WAVE_GETDEVCAPS_OUTPUTS"
		end

end -- class WEX_MCI_WAVE_GETDEVCAPS_CONSTANTS

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