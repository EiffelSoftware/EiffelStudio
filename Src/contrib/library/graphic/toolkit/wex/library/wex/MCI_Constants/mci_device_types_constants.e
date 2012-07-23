note
	description: "Constants defining each MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_DEVICE_TYPES_CONSTANTS

feature -- Access

	Mci_devtype_animation: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_ANIMATION"
		end

	Mci_devtype_cd_audio: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_CD_AUDIO"
		end

	Mci_devtype_dat: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_DAT"
		end

	Mci_devtype_digital_video: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_DIGITAL_VIDEO"
		end

	Mci_devtype_other: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_OTHER"
		end

	Mci_devtype_overlay: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_OVERLAY"
		end

	Mci_devtype_scanner: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_SCANNER"
		end

	Mci_devtype_sequencer: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_SEQUENCER"
		end

	Mci_devtype_vcr: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_VCR"
		end

	Mci_devtype_videodisc: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_VIDEODISC"
		end

	Mci_devtype_waveform_audio: INTEGER
		external
			"C [macro <wex_mci.h>]"
		alias
			"MCI_DEVTYPE_WAVEFORM_AUDIO"
		end

end -- class WEX_MCI_DEVICE_TYPES_CONSTANTS

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
