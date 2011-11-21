note
	description: "Constants used with any MCI device"
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_CONSTANTS

feature -- Access

	Mci_from: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FROM"
		end

	Mci_notify: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_NOTIFY"
		end

	Mci_wait: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_WAIT"
		end

	Mci_open_shareable: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_OPEN_SHAREABLE"
		end

	Mci_open_element: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_OPEN_ELEMENT"
		end

	Mci_open_type: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_OPEN_TYPE"
		end

	Mci_break: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_BREAK"
		end

	Mci_escape: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_ESCAPE"
		end

	Mci_set: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SET"
		end

	Mci_spin: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SPIN"
		end

	Mci_freeze: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_FREEZE"
		end

	Mci_load: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_LOAD"
		end

	Mci_pause: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_PAUSE"
		end

	Mci_play: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_PLAY"
		end

	Mci_resume: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_RESUME"
		end

	Mci_stop: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STOP"
		end

	Mci_unfreeze: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_UNFREEZE"
		end

	Mci_cue: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_CUE"
		end

	Mci_seek: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SEEK"
		end

	Mci_step: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STEP"
		end

	Mci_copy: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_COPY"
		end

	Mci_cut: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_CUT"
		end

	Mci_delete: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DELETE"
		end

	Mci_paste: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_PASTE"
		end

	Mci_close: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_CLOSE"
		end

	Mci_open: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_OPEN"
		end

	Mci_realize: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_REALIZE"
		end

	Mci_update: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_UPDATE"
		end

	Mci_getdevcaps: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS"
		end

	Mci_info: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_INFO"
		end

	Mci_status: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_STATUS"
		end

	Mci_sysinfo: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SYSINFO"
		end

	Mci_record: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_RECORD"
		end

	Mci_save: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_SAVE"
		end

	Mci_put: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_PUT"
		end

	Mci_where: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_WHERE"
		end

	Mci_window: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_WINDOW"
		end

end -- class WEX_MCI_CONSTANTS

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