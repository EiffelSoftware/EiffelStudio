--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when the pointer moves.
-- X event associated: `MotionNotify'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MOTNOT_DATA 

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

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

invariant

    not (buttons_state = Void)

end
