--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a window's configuration is
-- asked to change.
-- The values in this class indicates the hints of the request.
-- X event associated: `ConfigureRequest'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CONFREQ_DATA 

inherit

	CONFNOT_DATA
		rename
			make as confnot_data_make
		end

creation

	make

feature 

	make (a_widget: WIDGET; a_x, a_y, a_width, a_height, a_border_width: INTEGER) is
			-- Create a context_data for `ConfigureRequest' event.
		do
			confnot_data_make (a_widget, a_x, a_y, a_width, a_height, a_border_width)
		end

end
