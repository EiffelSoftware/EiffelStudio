indexing
	description: "Font type constants for WEL_CHOOSE_FONT_DIALOG class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_TYPE_CONSTANTS

feature -- Access

	Simulated_fonttype: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"SIMULATED_FONTTYPE"
		end

	Printer_fonttype: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"PRINTER_FONTTYPE"
		end

	Screen_fonttype: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"SCREEN_FONTTYPE"
		end

	Bold_fonttype: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"BOLD_FONTTYPE"
		end

	Italic_fonttype: INTEGER is
		external
			"C [macro <cdlg.h>]"
		alias
			"ITALIC_FONTTYPE"
		end

	Regular_fonttype: INTEGER is
		external
			"C [macro <cdlg.h>]"
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

end -- class WEL_FONT_TYPE_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All righttype reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
