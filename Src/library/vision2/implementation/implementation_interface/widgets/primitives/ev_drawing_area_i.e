indexing
	description: "Eiffel Vision drawing area. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_DRAWING_AREA_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_I

feature -- Drawing operations

	redraw is
			-- Redraw the window without clearing it.
		deferred
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw the rectangle described.
		deferred
		end

	clear_and_redraw is
			-- Redraw the window after clearing it.
		deferred
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear and Redraw the rectangle described.
		deferred
		end

	flush is
			-- Update immediately the screen if needed
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

end -- class EV_DRAWING_AREA_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

