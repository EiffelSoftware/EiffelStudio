indexing

	description:
		"Information given by EiffelVision when a mouse's button click. %
		%X event associated: `ButtonRelease'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BUTCLICK_DATA 

inherit

	BUTREL_DATA
		rename
			make as button_rel_data_make
		end

creation

	make

feature 

	make (a_widget: WIDGET; a_relative_x, a_relative_y, an_absolute_x, an_absolute_y, a_button: INTEGER; a_buttons_state: BUTTONS) is
            -- Create a context_data for `ButtonClick' event.
        do
            widget := a_widget;
            relative_x := a_relative_x;
            relative_y := a_relative_y;
            absolute_x := an_absolute_x;
            absolute_y := an_absolute_y;
            button := a_button;
            buttons_state := a_buttons_state
        end

end


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
