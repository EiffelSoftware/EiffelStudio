--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when the pointer enters a window.
-- X event associated: `EnterNotify'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class ENTER_DATA 

inherit

	CONTEXT_DATA
		undefine
			make
		end

creation

	make

feature {NONE}

	absolute_x: INTEGER;
            -- Absolute horizontal position of the point of entry of the
			-- pointer

    absolute_y: INTEGER;
            -- Absolute vertical position of the point of entry of the
			-- pointer

    relative_x: INTEGER;
            -- Horizontal position of the point of entry of the pointer
			-- relative to the receiving window

    relative_y: INTEGER;
            -- Vertical position of the point of entry of the pointer relative
			-- to the receiving window

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `EnterNotify' event.
		do
			widget := a_widget
		end -- Create

end -- class ENTER_DATA
