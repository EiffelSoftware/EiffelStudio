note
	description: "Constants used with the MCI_MODE command %
		%for any MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_MODE_CONSTANTS

feature -- Access

	Mci_mode_not_ready: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_MODE_NOT_READY"
		end

	Mci_mode_pause: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_MODE_PAUSE"
		end

	Mci_mode_play: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_MODE_PLAY"
		end

	Mci_mode_stop: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_MODE_STOP"
		end

	Mci_mode_open: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_MODE_OPEN"
		end

	Mci_mode_record: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_MODE_RECORD"
		end

	Mci_mode_seek: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_MODE_SEEK"
		end

end -- class WEX_MCI_MODE_CONSTANTS

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