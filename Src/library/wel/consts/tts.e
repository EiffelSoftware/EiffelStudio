indexing
	description: "Tool Tip Style (TTF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTS_CONSTANTS

feature -- Access

	Tts_alwaystip: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTS_ALWAYSTIP"
		end

	Tts_noprefix: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTS_NOPREFIX"
		end

end -- class WEL_TTS_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
