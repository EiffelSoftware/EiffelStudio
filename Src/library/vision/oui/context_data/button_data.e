
-- Information given by ArchiVision when a mouse's button is pressed or
-- released.
-- X events associated: `ButtonPress' or `ButtonRelease'.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BUTTON_DATA 

inherit

	CONTEXT_DATA

feature 

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

	not (buttons_state = Void)

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
