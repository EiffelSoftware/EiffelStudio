indexing

	description:
		"Information given by EiffelVision when the pointer moves. %
		%X event associated: `MotionNotify'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	MOTNOT_DATA 

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature -- Initialization

	make (a_widget: WIDGET; a_relative_x, a_relative_y, an_absolute_x, an_absolute_y: INTEGER; a_buttons_state: BUTTONS) is
			-- Create a context_data for `MotionNotify' event.
		do
			widget := a_widget;
			relative_x := a_relative_x;
			relative_y := a_relative_y;
			absolute_x := an_absolute_x;
			absolute_y := an_absolute_y;
			buttons_state := a_buttons_state
		end

feature -- Access

	absolute_x: INTEGER;
			-- Absolute horizontal position of the pointer (in other words
			-- relative to the screen)

	absolute_y: INTEGER;
			-- Absolute vertical position of the pointer (in other words
			-- relative to the screen)

	buttons_state: BUTTONS;
			-- State of buttons

	relative_x: INTEGER;
			-- Horizontal position of the pointer relative to the receiving
			-- window

	relative_y: INTEGER;
			-- Vertical position of the pointer relative to the receiving
			-- window

invariant

	buttons_state /= Void

end -- class MOTNOT_DATA

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

