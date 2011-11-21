note
	description: "Constants used with the MCI_STATUS command %
		%for the cd audio device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_STATUS_CD_AUDIO_CONSTANTS

feature -- Access

	Mci_status_media_present: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS_MEDIA_PRESENT"
		end

	Mci_cda_status_type_track: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_CDA_STATUS_TYPE_TRACK"
		end

	Mci_cda_track_other: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_CDA_TRACK_OTHER"
		end

	Mci_cda_track_audio: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_CDA_TRACK_AUDIO"
		end

end -- class WEX_MCI_STATUS_CD_AUDIO_CONSTANTS

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