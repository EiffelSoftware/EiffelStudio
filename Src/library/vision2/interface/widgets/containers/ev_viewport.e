indexing
	description:
		"Displays a single widget that may be larger than the container.%
		%Clipping may occur though item size is not effected by viewport"
	appearance:
		" - - - - - - - - - - - - - - -  ^%N%
		%|             `item'          |`y_offset'%N%
		%                                v%N%
		%|          ---------------    |%N%
		%           |             |%N%
		%|          |  viewport   |    |%N%
		%           |             |%N%
		%|          ---------------    |%N%
		% - - - - - - - - - - - - - - -%N%
		%<`x_offset'>"
	status: "See notice at end of class"
	keywords: "container, virtual, display"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEWPORT

inherit
	EV_CELL
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	DOUBLE_MATH
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.x_offset
		ensure
			bridge_ok: Result = implementation.x_offset
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.y_offset
		ensure
			bridge_ok: Result = implementation.y_offset
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Assign `an_x' to `x_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_x_offset (an_x)
		ensure
			assigned: x_offset = an_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Assign `a_y' to `y_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_y_offset (a_y)
		ensure
			assigned: y_offset = a_y
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_offset (an_x, a_y)
		ensure
			assigned: x_offset = an_x
			assigned: y_offset = a_y
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CELL} and x_offset = 0 and
				y_offset = 0
		end
		
feature -- Contract support

	item_width: INTEGER is
			-- Width of `item'. Zero if `item' `Void'.
		do
			if readable then
				Result := item.width
			end
		end

	item_height: INTEGER is
			-- Height of `item'. Zero if `item' `Void'.
		do
			if readable then
				Result := item.height
			end
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_VIEWPORT_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VIEWPORT_IMP} implementation.make (Current)
		end

invariant

	item_void_means_offset_zero: is_usable implies
		(item = Void implies x_offset = 0 and y_offset = 0)

end -- class EV_VIEWPORT

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
