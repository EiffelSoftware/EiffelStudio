indexing
	description:
		" A class for MS-Windows to simulate the resizing of%
		% a container";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

deferred class
	EV_SIZEABLE_CONTAINER_IMP

inherit
	EV_SIZEABLE_IMP
		redefine
			internal_resize,
			minimum_width,
			minimum_height
		end

feature -- Access

	minimum_width: INTEGER is
			-- Minimum width of the window.
			-- We recompute it if necessary.
		do
			if bit_set (internal_changes, 1) then
				compute_minimum_width
				internal_changes := set_bit (internal_changes, 1, False)
				internal_changes := set_bit (internal_changes, 4, True)
			end
			Result := internal_minimum_width
		end

	minimum_height: INTEGER is
			-- Minimum height of the window.
			-- We recompute it if necessary.
		do
			if bit_set (internal_changes, 2) then
				compute_minimum_height
				internal_changes := set_bit (internal_changes, 2, False)
				internal_changes := set_bit (internal_changes, 8, True)
			end
			Result := internal_minimum_height
		end

feature -- Basic operations

	internal_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Make `x' and `y' the new position of the current object and
			-- `w' and `h' the new width and height of it.
			-- If there is any child, it also adapt them to fit to the given
			-- value.
		do
			-- We recompute the minimum width if necessary.
			if bit_set (internal_changes, 1) then
				compute_minimum_width
				internal_changes := set_bit (internal_changes, 4, True)
			end

			-- We recompute then minimum height if necessary.
			if bit_set (internal_changes, 2) then
				compute_minimum_height
				internal_changes := set_bit (internal_changes, 8, True)
			end

			-- Then, we resize from minimum or normally depending on what is necessary.
			if bit_set (internal_changes, 4) or bit_set (internal_changes, 8) then
				resize_from_minimum (a_x, a_y, a_width, a_height)
				internal_changes := set_bit (internal_changes, 1, False)
				internal_changes := set_bit (internal_changes, 2, False)
				internal_changes := set_bit (internal_changes, 4, False)
				internal_changes := set_bit (internal_changes, 8, False)
			else
				resize_proportionnaly (a_x, a_y, a_width, a_height)
			end
		end

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
			-- Should call only set_internal_minimum_width.
		do
			-- Nothing by default
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
			-- Should call only set_internal_minimum_height.
		do
			-- Nothing by default
		end

	resize_from_minimum (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize from the minimum size of the children
		do
			move_and_resize (a_x, a_y, a_width, a_height, True)
		end

	resize_proportionnaly (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize everything by difference with the current size.
		do
			move_and_resize (a_x, a_y, a_width, a_height, True)
		end

end -- class EV_CONTAINER_SIZEABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
