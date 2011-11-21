note
	description: "Constants used with MCI_STATUS command%
		% to retrieve the format the MCI device is using."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_STATUS_TIME_FORMAT_CONSTANTS

feature -- Access

	Mci_format_bytes: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_BYTES"
		end

	Mci_format_frames: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_FRAMES"
		end

	Mci_format_hms: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_HMS"
		end

	Mci_format_milliseconds: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_MILLISECONDS"
		end

	Mci_format_msf: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_MSF"
		end

	Mci_format_samples: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_SAMPLES"
		end

	Mci_format_tmsf: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_TMSF"
		end

end -- class WEX_MCI_STATUS_TIME_FORMAT_CONSTANTS

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