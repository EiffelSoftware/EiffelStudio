indexing
	description: "Eiffel Vision positionable, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POSITIONABLE_I

inherit
	EV_POSITIONED_I
		redefine
			interface
		end

feature -- Status setting

	set_x_position (a_x: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
		deferred
		ensure
			x_position_assigned: x_position = a_x
		end

	set_y_position (a_y: INTEGER) is
			-- Set vertical offset to parent to `a_y'.
		deferred
		ensure
			y_position_assigned: y_position = a_y
		end

	set_position (a_x, a_y: INTEGER) is
			-- Set horizontal offset to parent to `a_x'.
			-- Set vertical offset to parent to `a_y'.
		deferred
		ensure
			x_position_assigned: x_position = a_x
			y_position_assigned: y_position = a_y
		end

	set_width (a_width: INTEGER) is
			-- Set the horizontal size to `a_width'.
		require
			a_width_positive_or_zero: a_width >= 0
		deferred
		ensure
			width_assigned: width = minimum_width or else width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set the vertical size to `a_height'.
		require
			a_height_positive_or_zero: a_height >= 0
		deferred
		ensure
			height_assigned: height = minimum_height or else height = a_height
		end

	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		deferred
		ensure
			width_assigned: width = minimum_width or else width = a_width
			height_assigned: height = minimum_height or else height = a_height
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_POSITIONABLE

end -- class EV_POSITIONABLE_I

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

