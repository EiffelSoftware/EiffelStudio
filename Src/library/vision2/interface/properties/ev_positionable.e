indexing
	description:
		"Abstraction for objects whos position can be set."
	status: "See notice at end of class"
	keywords: "position, width, height"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_POSITIONABLE

inherit
	EV_POSITIONED
		redefine
			implementation
		end
		
feature -- Status setting

	set_x_position (a_x: INTEGER) is
			-- Assign `a_x' to `x_position' in pixels.
		do
			implementation.set_x_position (a_x)
		ensure
			x_position_assigned: x_position = a_x
		end

	set_y_position (a_y: INTEGER) is
			-- Assign `a_y' to `y_position' in pixels.
		do
			implementation.set_y_position (a_y)
		ensure
			y_position_assigned: y_position = a_y
		end

	set_position (a_x, a_y: INTEGER) is
			-- Assign `a_x' to `x_position' and `a_y' to `y_position' in pixels.
		do
			implementation.set_position (a_x, a_y)
		ensure
			x_position_assigned: x_position = a_x
			y_position_assigned: y_position = a_y
		end

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width' in pixels.
		require
			a_width_positive_or_zero: a_width >= 0
		do
			implementation.set_width (a_width)
		ensure
			width_assigned: width = minimum_width or else width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Assign `a_height' to `height' in pixels.
		require
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.set_height (a_height)
		ensure
			height_assigned: height = minimum_height or else height = a_height
		end

	set_size (a_width, a_height: INTEGER) is
			-- Assign `a_width' to `width' and `a_height' to `height' in pixels.
		require
			a_width_positive_or_zero: a_width >= 0
			a_height_positive_or_zero: a_height >= 0
		do
			implementation.set_size (a_width, a_height)
		ensure
			width_assigned: width = minimum_width or else width = a_width
			height_assigned: height = minimum_height or else height = a_height
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_POSITIONABLE_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_POSITIONABLE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
