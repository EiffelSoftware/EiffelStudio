--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a window's configuration
-- changes (size, position, border, stacking order).
-- X event associated: `ConfigureNotify'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CONFNOT_DATA 

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
