note
	description: "Constants used with the MCI_SET command %
		%for any MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_SET_CONSTANTS

feature -- Access

	Mci_set_door_closed: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_DOOR_CLOSED"
		end

	Mci_set_door_open: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_DOOR_OPEN"
		end

	Mci_set_off: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_OFF"
		end

	Mci_set_on: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_ON"
		end

	Mci_set_audio: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_AUDIO"
		end

	Mci_set_time_format: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_TIME_FORMAT"
		end

	Mci_set_video: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_VIDEO"
		end

	Mci_set_audio_all: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_AUDIO_ALL"
		end

	Mci_set_audio_left: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_AUDIO_LEFT"
		end

	Mci_set_audio_right: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET_AUDIO_RIGHT"
		end

end -- class WEX_MCI_SET_CONSTANTS

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
