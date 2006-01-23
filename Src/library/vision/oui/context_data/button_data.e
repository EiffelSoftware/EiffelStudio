indexing

	description:
		"Information given by EiffelVision when a mouse's button is pressed or %
		%released. %
		%X events associated: `ButtonPress' or `ButtonRelease'"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	BUTTON_DATA 

inherit

	CONTEXT_DATA

feature  -- Access

	absolute_x: INTEGER;
			-- Absolute horizontal position of the pointer (in other words
			-- relative to the screen)

	absolute_y: INTEGER;
			-- Absolute vertical position of the pointer (in other words
			-- relative to the screen)

	button: INTEGER;
			-- Button that triggered event

	buttons_state: BUTTONS;
			-- State of buttons just before the event occurs

	relative_x: INTEGER;
			-- Horizontal position of the pointer relative to the receiving
			-- window

	relative_y: INTEGER;
			-- Vertical position of the pointer relative to the receiving
			-- window

	keyboard: KEYBOARD;
			-- State of modifiers key (Shift, control...)
invariant

	buttons_state /= Void

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




end -- class BUTTON_DATA

