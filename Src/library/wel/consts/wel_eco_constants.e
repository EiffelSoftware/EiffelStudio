indexing
	description: "Edit control options (ECO) for the rich edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ECO_CONSTANTS

feature -- Access

	Eco_autowordselection: INTEGER is
			-- Automatic selection of word on doubleclick.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_AUTOWORDSELECTION"
		end

	Eco_autovscroll: INTEGER is
			-- Same as ES_AUTOVSCROLL style.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_AUTOVSCROLL"
		end

	Eco_autohscroll: INTEGER is
			-- Same as ES_AUTOHSCROLL style.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_AUTOHSCROLL"
		end

	Eco_nohidesel: INTEGER is
			-- Same as ES_NOHIDESEL style.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_NOHIDESEL"
		end

	Eco_readonly: INTEGER is
			-- Same as ES_READONLY style.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_READONLY"
		end

	Eco_wantreturn: INTEGER is
			-- Same as ES_WANTRETURN style.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_WANTRETURN"
		end

	Eco_savesel: INTEGER is
			-- Same as ES_SAVESEL style.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_SAVESEL"
		end

	Eco_selectionbar: INTEGER is
			-- Same as ES_SELECTIONBAR style.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_SELECTIONBAR"
		end

	Eco_vertical: INTEGER is
			-- Same as ES_VERTICAL style. Available in
			-- Asian-language versions only.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECO_VERTICAL"
		end

	Ecoop_set: INTEGER is
			-- Set the options to those specified by fOptions.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECOOP_SET"
		end

	Ecoop_or: INTEGER is
			-- Combine the specified options with the current
			-- options.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECOOP_OR"
		end

	Ecoop_and: INTEGER is
			-- Retain only those current options that are also
			-- specified by fOptions.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECOOP_AND"
		end

	Ecoop_xor: INTEGER is
			-- Retain only those current options that are not
			-- specified by fOptions.
		external
			"C [macro %"redit.h%"]"
		alias
			"ECOOP_XOR"
		end

end -- class WEL_ECO_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

