note
	description: "MCI macros"
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_MACROS

feature -- Access

	cwin_mci_hms_hour (hms: INTEGER): INTEGER
			-- SDK MCI_HMS_HOUR
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_HMS_HOUR"
		end

	cwin_mci_hms_minute (hms: INTEGER): INTEGER
			-- SDK MCI_HMS_MINUTE
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_HMS_MINUTE"
		end

	cwin_mci_hms_second (hms: INTEGER): INTEGER
			-- SDK MCI_HMS_SECOND
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_HMS_SECOND"
		end

	cwin_mci_make_hms (hours, minutes, seconds: INTEGER): INTEGER
			-- SDK MCI_MAKE_HMS
		external
			"C [macro <wex_mci.h>] (BYTE, BYTE, BYTE): EIF_INTEGER"
		alias
			"MCI_MAKE_HMS"
		end

	cwin_mci_make_msf (minutes, seconds, frames: INTEGER): INTEGER
			-- SDK MCI_MAKE_MSF
		external
			"C [macro <wex_mci.h>] (BYTE, BYTE, BYTE): EIF_INTEGER"
		alias
			"MCI_MAKE_MSF"
		end

	cwin_mci_make_tmsf (tracks, minutes, seconds, frames: INTEGER): INTEGER
			-- SDK MCI_MAKE_TMSF
		external
			"C [macro <wex_mci.h>] (BYTE, BYTE, BYTE, BYTE): EIF_INTEGER"
		alias
			"MCI_MAKE_TMSF"
		end

	cwin_mci_msf_frame (msf: INTEGER): INTEGER
			-- SDK MCI_MSF_FRAME
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_MSF_FRAME"
		end

	cwin_mci_msf_minute (msf: INTEGER): INTEGER
			-- SDK MCI_MSF_MINUTE
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_MSF_MINUTE"
		end

	cwin_mci_msf_second (msf: INTEGER): INTEGER
			-- SDK MCI_MSF_SECOND
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_MSF_SECOND"
		end

	cwin_mci_tmsf_frame (tmsf: INTEGER): INTEGER
			-- SDK MCI_TMSF_FRAME
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_TMSF_FRAME"
		end

	cwin_mci_tmsf_minute (tmsf: INTEGER): INTEGER
			-- SDK MCI_TMSF_MINUTE
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_TMSF_MINUTE"
		end

	cwin_mci_tmsf_second (tmsf: INTEGER): INTEGER
			-- SDK MCI_TMSF_SECOND
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_TMSF_SECOND"
		end

	cwin_mci_tmsf_track (tmsf: INTEGER): INTEGER
			-- SDK MCI_TMSF_TRACK
		external
			"C [macro <wex_mci.h>] (DWORD): EIF_INTEGER"
		alias
			"MCI_TMSF_TRACK"
		end

end -- class WEX_MCI_MACROS

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
