indexing
	description: "Constants used with the MCI_FORMAT command %
		%for any MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_FORMAT_CONSTANTS

feature -- Access

	Mci_format_bytes: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_BYTES"
		end

	Mci_format_frames: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_FRAMES"
		end

	Mci_format_hms: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_HMS"
		end

	Mci_format_milliseconds: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_MILLISECONDS"
		end

	Mci_format_msf: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_MSF"
		end

	Mci_format_samples: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_SAMPLES"
		end

	Mci_format_smpte_24: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_SMPTE_24"
		end

	Mci_format_smpte_25: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_SMPTE_25"
		end

	Mci_format_smpte_30: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_SMPTE_30"
		end

	Mci_format_smpte_30drop: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_SMPTE_30DROP"
		end

	Mci_format_tmsf: INTEGER is
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FORMAT_TMSF"
		end

end -- class WEX_MCI_FORMAT_CONSTANTS

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