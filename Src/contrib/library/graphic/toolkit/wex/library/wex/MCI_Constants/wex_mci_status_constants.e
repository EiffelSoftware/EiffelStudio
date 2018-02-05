note
	description: "Constants used with the MCI_STATUS command %
		%for any MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_STATUS_CONSTANTS

feature -- Access

	Mci_status_item: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_ITEM"
		end

	Mci_status_current_track: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_CURRENT_TRACK"
		end

	Mci_status_length: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_LENGTH"
		end

	Mci_status_mode: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_MODE"
		end

	Mci_status_number_of_tracks: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_NUMBER_OF_TRACKS"
		end

	Mci_status_position : INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_POSITION "
		end

	Mci_status_ready: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_READY"
		end

	Mci_status_time_format: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_TIME_FORMAT"
		end

	Mci_status_start: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_START"
		end

	Mci_track: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_TRACK"
		end

end -- class WEX_MCI_STATUS_CONSTANTS

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
