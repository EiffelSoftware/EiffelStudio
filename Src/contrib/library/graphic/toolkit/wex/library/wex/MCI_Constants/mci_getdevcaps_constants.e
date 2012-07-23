note
	description: "General Device Capabilities constants"
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_GETDEVCAPS_CONSTANTS

feature -- Access

	Mci_getdevcaps_compound_device: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_COMPOUND_DEVICE"
		end

	Mci_getdevcaps_device_type: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_DEVICE_TYPE"
		end

	Mci_getdevcaps_has_audio: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_HAS_AUDIO"
		end

	Mci_getdevcaps_has_video: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_HAS_VIDEO"
		end

	Mci_getdevcaps_item: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_ITEM"
		end

	Mci_getdevcaps_can_eject: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_CAN_EJECT"
		end

	Mci_getdevcaps_can_play: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_CAN_PLAY"
		end

	Mci_getdevcaps_can_record: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_CAN_RECORD"
		end

	Mci_getdevcaps_can_save: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_CAN_SAVE"
		end

	Mci_getdevcaps_uses_files: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_GETDEVCAPS_USES_FILES"
		end

end -- class WEX_MCI_GETDEVCAPS_CONSTANTS

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
