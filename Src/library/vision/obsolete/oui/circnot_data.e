--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a window is placed on top
-- or on bottom of the stacking order.
-- X event associated: `CirculateNotify'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CIRCNOT_DATA 

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
