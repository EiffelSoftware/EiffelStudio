
-- Information given by ArchiVision when a callback is triggered.

indexing

	copyright: "See notice at end of class";
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


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
