note
	description: "Tool Tip Style (TTS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTS_CONSTANTS

feature -- Access

	Tts_alwaystip: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTS_ALWAYSTIP"
		end

	Tts_noprefix: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTS_NOPREFIX"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_TTS_CONSTANTS

