indexing
	description: "EiffelVision split area. Split consists of two %
				% parts divided by a groove, which can be moved  %
				% by the user to change the visible portion of   %
				% the parts. Split is an abstract class with     %
				% effective decendants horizontal and vertical   %
				% split."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA

inherit
	EV_CONTAINER 
		redefine
			implementation
		end

feature -- Status report

	position: INTEGER is
			-- Current position of the splitter.
		require
			exits: not destroyed
		do
			Result := implementation.position
		ensure
			result_large_enough: Result >= minimum_position
			result_small_enough: Result <= maximum_position
		end

	minimum_position: INTEGER is
			-- Minimum position the splitter can have.
		require
			exists: not destroyed
		do
			Result := implementation.minimum_position
		ensure
			positive_value: Result >= 0
			coherent_position: Result <= maximum_position
		end

	maximum_position: INTEGER is
			-- Maximum position the splitter can have.
		require
			exists: not destroyed
		do
			Result := implementation.maximum_position
		ensure
			positive_value: Result >= 0
			coherent_position: Result >= minimum_position
		end

	is_first_area_shrinkable: BOOLEAN is
			-- Can the first area be shrunk to a size smaller than the
			-- child it contains? True if it does not contain any child.
		require
			exits: not destroyed
		do
			Result := implementation.is_first_area_shrinkable
		end

	is_second_area_shrinkable: BOOLEAN is
			-- Can the second area be shrunk to a size smaller than the
			-- child it contains? True if it does not contain any child.
		require
			exits: not destroyed
		do
			Result := implementation.is_second_area_shrinkable
		end

feature -- Status setting

	set_position (value: INTEGER) is
			-- Make `value' the new position of the splitter.
			-- `value' is given in pixels.
			-- Has an effect only if the split area has
			-- already a child.
			-- And on Linux, has an effect an effect only when the window
			-- in which the paned is, is shown.
		require
			exists: not destroyed
		do
			implementation.set_position (value)
		end

	set_first_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the first area if `flag', forbid
			-- it otherwise.
		require
			exits: not destroyed
		do
			implementation.set_first_area_shrinkable (flag)
		ensure
			flag_set: is_first_area_shrinkable = flag
		end

	set_second_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the second area if `flag', forbid
			-- it otherwise.
		require
			exits: not destroyed
		do
			implementation.set_second_area_shrinkable (flag)
		ensure
			flag_set: is_second_area_shrinkable = flag
		end

feature {EV_MENU_ITEM} -- Implementation
	
	implementation: EV_SPLIT_AREA_I

end -- class EV_SPLIT_AREA

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
