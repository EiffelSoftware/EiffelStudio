indexing

	description:
		"Information given by EiffelVision when a mouse's button is pressed or %
		%released. %
		%X events associated: `ButtonPress' or `ButtonRelease'";
	status: "See notice at end of class";
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

end -- class BUTTON_DATA

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

