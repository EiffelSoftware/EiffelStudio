--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a mouse's button is released.
-- X event associated: `ButtonRelease'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BUTREL_DATA 

inherit

	BUTTON_DATA
		rename
			make as button_data_make
		end

creation

	make

feature 

	make (a_widget: WIDGET; a_relative_x, a_relative_y, an_absolute_x, an_absolute_y, a_button: INTEGER; a_buttons_state: BUTTONS) is
            -- Create a context_data for `ButtonPress' event.
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
