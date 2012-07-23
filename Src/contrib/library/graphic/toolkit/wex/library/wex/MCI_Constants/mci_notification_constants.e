note
	description: "Constants used for notification on command completion %
		%for any MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_NOTIFICATION_CONSTANTS

feature -- Access

	Mci_notify_aborted: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_NOTIFY_ABORTED"
		end

	Mci_notify_failure: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_NOTIFY_FAILURE"
		end

	Mci_notify_successful: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_NOTIFY_SUCCESSFUL"
		end

	Mci_notify_superseded: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_NOTIFY_SUPERSEDED"
		end

end -- class WEX_MCI_NOTIFICATION_CONSTANTS

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
