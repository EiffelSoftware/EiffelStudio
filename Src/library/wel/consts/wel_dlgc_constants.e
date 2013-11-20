note
	description: "Dialog constants (DLGC_xxxx, ...)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DLGC_CONSTANTS

feature -- Window Messages

	Dlgc_want_arrows: INTEGER = 1
		-- Declared in Windows as DLGC_WANTARROWS
	
	Dlgc_want_tab: INTEGER = 2
		-- Declared in Windows as DLGC_WANTTAB

	Dlgc_want_all_keys: INTEGER = 4
			-- Declared in Windows as DLGC_WANTALLKEYS
	
	Dlgc_want_message: INTEGER = 4
			-- Declared in Windows as DLGC_WANTMESSAGE
			
	Dlgc_has_set_sel: INTEGER = 8
			-- Declared in Windows as DLGC_HASSETSEL
			
	Dlgc_def_push_button: INTEGER = 16
			-- Declared in Windows as DLGC_DEFPUSHBUTTON
			
	Dlgc_undef_push_button: INTEGER = 32
			-- Declared in Windows as DLGC_UNDEFPUSHBUTTON
			
	Dlgc_radio_button: INTEGER = 64
			-- Declared in Windows as DLGC_RADIOBUTTON
			
	Dlgc_want_chars: INTEGER = 128
			-- Declared in Windows as DLGC_WANTCHARS
			
	Dlgc_static: INTEGER = 256
			-- Declared in Windows as DLGC_STATIC
			
	Dlgc_button: INTEGER = 512;
			-- Declared in Windows as DLGC_BUTTON

			
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




end -- class WEL_DLGC_CONSTANTS

