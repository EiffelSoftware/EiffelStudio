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

	EV_TAB_CONTROLLABLE_I
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

