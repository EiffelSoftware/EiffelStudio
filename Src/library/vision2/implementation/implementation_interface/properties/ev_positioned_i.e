indexing
	description:
		"Eiffel Vision positioned, implementation interface.%N%
		%See bridge pattern notes in ev_any.e"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POSITIONED_I 

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Measurement
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		deferred
		end
	
	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		deferred
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		deferred
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		deferred
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		deferred
		end

	height: INTEGER is
			-- Vertical size in pixels.
		deferred
		end
	
	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		deferred
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_POSITIONED
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.
		-- (See bridge pattern notes in ev_any.e)

invariant
	minimum_width_positive_or_zero: is_usable implies minimum_width >= 0
	minimum_height_positive_or_zero: is_usable implies minimum_height >= 0

end -- class EV_POSITIONED_I

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

