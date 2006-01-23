indexing

	description:
		"Informations given by EiffelVision when a key is pressed or released. %
		%Parent of KYPRESS_DATA and KEYREL_DATA"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	KEY_DATA 

inherit

	CONTEXT_DATA

feature -- Access

	keyboard: KEYBOARD;
			-- State of modifiers key (Shift, control...)

	keycode: INTEGER;
			-- Server-dependent code corresponding to the keystroke

	string: STRING;;
			-- String stroked on keyboard

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




end -- class KEY_DATA

