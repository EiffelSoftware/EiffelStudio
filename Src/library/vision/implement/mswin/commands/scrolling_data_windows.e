indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLING_DATA_WINDOWS

inherit

	CONTEXT_DATA
		rename
			make as context_data_make 
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; code, pos: INTEGER; direction: BOOLEAN) is
			-- Create a context data for `scrolling' events
		do
			widget := a_widget
			event_code := code
			new_position := pos
			is_vertical := direction
		end

feature -- Access

	event_code: INTEGER
			-- Code of the event that has occurred

	new_position: INTEGER
			-- New thumb position

	is_vertical: BOOLEAN
			-- Did this come from a VSCROLL?

end -- class SCROLLING_DATA_WINDOWS 

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

