note
	description: "Constants used with commands %
		%for the digitalvideo MCI device."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_DGV_CONSTANTS

feature -- Access

	Mci_dgv_open_nostatic: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DGV_OPEN_NOSTATIC"
		end

	Mci_dgv_open_parent: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DGV_OPEN_PARENT"
		end

	Mci_dgv_open_ws: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DGV_OPEN_WS"
		end

	Mci_dgv_cue_input: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DGV_CUE_INPUT"
		end

	Mci_dgv_cue_noshow: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DGV_CUE_NOSHOW"
		end

	Mci_dgv_cue_output: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DGV_CUE_OUTPUT"
		end

	Mci_dgv_window_hwnd: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DGV_WINDOW_HWND"
		end

end -- class WEX_MCI_DGV_CONSTANTS

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
