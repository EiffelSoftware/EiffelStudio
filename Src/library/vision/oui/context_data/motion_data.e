--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a callback is triggered.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MOTION_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	current_cursor_position: INTEGER;
			-- Position of cursor at current time (before its motion)

	next_cursor_position: INTEGER;
			-- Future position of cursor if the motion is agreed

	make (a_widget: WIDGET; a_current, a_next: INTEGER) is
			-- Create a context_data for `motion' action.
		do
			widget := a_widget;
			current_cursor_position := a_current;
			next_cursor_position := a_next
		end

end
