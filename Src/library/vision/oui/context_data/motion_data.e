
-- Information given by ArchiVision when a callback is triggered.

indexing

	copyright: "See notice at end of class";
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
