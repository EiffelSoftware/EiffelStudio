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

class MODIFY_DATA 

inherit 

	MOTION_DATA
		rename
			make as motion_make
		end

creation

	make

feature 

	start_position: INTEGER;
			-- Start position of the text to be modified

	last_position: INTEGER;
			-- Last position of the text to be modified

	text: STRING;
			-- Text to be inserted between `start_position' and `last_position'

	make (a_widget: WIDGET; a_current, a_next, a_start, a_last: INTEGER; a_text: STRING) is
			-- Create a context_data `modify' action.
		do
			widget := a_widget;
			current_cursor_position := a_current;
			next_cursor_position := a_next;
			start_position := a_start;
			last_position := a_last;
			text := a_text
		end

end
