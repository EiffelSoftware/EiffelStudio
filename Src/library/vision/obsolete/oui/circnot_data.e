indexing

	description:
		"Information given by EiffelVision when a window is placed on top %
		%or on bottom of the stacking order. %
		%X event associated: `CirculateNotify'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CIRCNOT_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	make (a_widget: WIDGET; arg_is_placed_on_top: BOOLEAN) is
			-- Create a context_data for `CirculateNotify' event.
		do
			widget := a_widget;
			is_placed_on_top := arg_is_placed_on_top
		end;

	is_placed_on_top: BOOLEAN
			-- Is the window placed on top of stacking order ?

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
