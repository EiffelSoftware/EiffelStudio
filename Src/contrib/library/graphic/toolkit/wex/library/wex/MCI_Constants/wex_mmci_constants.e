note
	description: "Constants used for notification"
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MMCI_CONSTANTS

feature -- Access

	Mm_mcinotify: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MM_MCINOTIFY"
		end

	Mm_mcisignal: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MM_MCISIGNAL"
		end

	Mm_mixm_line_change: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MM_MIXM_LINE_CHANGE"
		end

	Mm_mixm_control_change: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MM_MIXM_CONTROL_CHANGE"
		end

end -- class WEX_MMCI_CONSTANTS

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
