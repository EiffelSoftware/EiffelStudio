indexing
	description: "Font type constants for WEL_CHOOSE_FONT_DIALOG class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_TYPE_CONSTANTS

feature -- Access

	Simulated_fonttype: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"SIMULATED_FONTTYPE"
		end

	Printer_fonttype: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PRINTER_FONTTYPE"
		end

	Screen_fonttype: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"SCREEN_FONTTYPE"
		end

	Bold_fonttype: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"BOLD_FONTTYPE"
		end

	Italic_fonttype: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"ITALIC_FONTTYPE"
		end

	Regular_fonttype: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"REGULAR_FONTTYPE"
		end

feature -- Status report

	valid_font_type_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid font type constant?
		do
			Result := c = Simulated_fonttype or else
				c = Printer_fonttype or else
				c = Screen_fonttype or else
				c = Bold_fonttype or else
				c = Italic_fonttype or else
				c = Regular_fonttype
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_FONT_TYPE_CONSTANTS

