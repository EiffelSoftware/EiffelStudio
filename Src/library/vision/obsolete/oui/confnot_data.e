indexing

	description:
		"Information given by EiffelVision when a window's configuration %
		%changes (size, position, border, stacking order). %
		%X event associated: `ConfigureNotify'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CONFNOT_DATA 

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

	border_width: INTEGER;
			-- Width of the window's border

	make (a_widget: WIDGET; a_x, a_y, a_width, a_height, a_border_width: INTEGER) is
			-- Create a context_data for `ConfigureNotify' event.
		do
			widget := a_widget;
			x := a_x;
			y := a_y;
			width := a_width;
			height := a_height;
			border_width := a_border_width
		end;

	height: INTEGER;
			-- Height of the window

	width: INTEGER;
			-- Width of the window

	x: INTEGER;
			-- Horizontal position of the window relative to its parent

	y: INTEGER
			-- Vertical position of the window relative to its parent

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
