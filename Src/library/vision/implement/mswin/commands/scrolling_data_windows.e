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

creation

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
			-- Code of the event that has occured

	new_position: INTEGER
			-- New thumb position

	is_vertical: BOOLEAN
			-- Did this come from a VSCROLL?

end -- class SCROLLING_DATA_WINDOWS 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
