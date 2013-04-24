note
	description: "Edit control options (ECO) for the rich edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ECO_CONSTANTS

feature -- Access

	Eco_autowordselection: INTEGER = 1
			-- Automatic selection of word on doubleclick.

	Eco_autovscroll: INTEGER = 64
			-- Same as ES_AUTOVSCROLL style.

	Eco_autohscroll: INTEGER = 128
			-- Same as ES_AUTOHSCROLL style.

	Eco_nohidesel: INTEGER = 256
			-- Same as ES_NOHIDESEL style.

	Eco_readonly: INTEGER = 2048
			-- Same as ES_READONLY style.

	Eco_wantreturn: INTEGER = 4096
			-- Same as ES_WANTRETURN style.

	Eco_savesel: INTEGER = 32768
			-- Same as ES_SAVESEL style.

	Eco_selectionbar: INTEGER = 16777216
			-- Same as ES_SELECTIONBAR style.

	Eco_vertical: INTEGER = 4194304
			-- Same as ES_VERTICAL style. Available in
			-- Asian-language versions only.

	Ecoop_set: INTEGER = 1
			-- Set the options to those specified by fOptions.

	Ecoop_or: INTEGER = 2
			-- Combine the specified options with the current
			-- options.

	Ecoop_and: INTEGER = 3
			-- Retain only those current options that are also
			-- specified by fOptions.

	Ecoop_xor: INTEGER = 4;
			-- Retain only those current options that are not
			-- specified by fOptions.

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




end -- class WEL_ECO_CONSTANTS

