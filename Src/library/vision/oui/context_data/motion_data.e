indexing

	description: "Information given by EiffelVision when a callback is triggered";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	MOTION_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; a_current, a_next: INTEGER) is
			-- Create a context_data for `motion' action.
		do
			widget := a_widget;
			current_cursor_position := a_current;
			next_cursor_position := a_next
		end

feature -- Access

	current_cursor_position: INTEGER;
			-- Position of cursor at current time (before its motion)

	next_cursor_position: INTEGER;
			-- Future position of cursor if the motion is agreed

end -- class MOTION_DATA

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

