--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a window is asked to be placed
-- on top or on bottom of the stacking order.
-- The values in this class indicates the hints of the request.
-- X event associated: `CirculateRequest'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CIRCREQ_DATA 

inherit

	CIRCNOT_DATA
		rename
			make as circnot_data_make
		end

creation

	make

feature 

	make (a_widget: WIDGET; arg_is_placed_on_top: BOOLEAN) is
			-- Create a context_data for `CirculateRequest' event.
		do
			circnot_data_make (a_widget, arg_is_placed_on_top)
		end

end
