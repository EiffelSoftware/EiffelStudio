indexing
	description:
		"Abstraction for objects that have geometric position."
	status: "See notice at end of class"
	keywords: "position, width, height"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_POSITIONED

inherit
	EV_ANY
		redefine
			implementation
		end
	
feature -- Measurement 
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.x_position
		ensure
			bridge_ok: Result = implementation.x_position
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.y_position
		ensure
			bridge_ok: Result = implementation.y_position
		end

	width: INTEGER is
			-- Horizontal size in pixels.
			-- Same as `minimum_width' when not displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.width
		ensure
			bridge_ok: Result = implementation.width
		end

	height: INTEGER is
			-- Vertical size in pixels.
			-- Same as `minimum_height' when not displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.height
		ensure
			bridge_ok: Result = implementation.height
		end 

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_width
		ensure
			bridge_ok: Result = implementation.minimum_width
			positive_or_zero: Result >= 0
		end 

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_height
		ensure
			bridge_ok: Result = implementation.minimum_height
			positive_or_zero: Result >= 0
		end 

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_POSITIONED_I
			-- Responsible for interaction with native graphics toolkit.

invariant
	width_not_negative: is_usable implies width >= 0
	height_not_negative: is_usable implies height >= 0
	minimum_width_not_negative: is_usable implies minimum_width >= 0
	minimum_height_not_negative: is_usable implies minimum_height >= 0

end -- class EV_POSITIONED

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
