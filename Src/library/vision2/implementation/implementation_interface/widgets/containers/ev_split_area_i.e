indexing
	description: 
		"EiffelVision split area, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_AREA_I
	
inherit
	EV_CONTAINER_I

feature -- Status report

	position: INTEGER is
			-- Current position of the splitter.
		require
			exits: not destroyed
		deferred
		ensure
			result_large_enough: Result >= minimum_position
			result_small_enough: Result <= maximum_position
		end

	minimum_position: INTEGER is
			-- Minimum position the splitter can have.
		require
			exists: not destroyed
		deferred
		ensure
			positive_value: Result >= 0
			coherent_position: Result <= maximum_position
		end

	maximum_position: INTEGER is
			-- Maximum position the splitter can have.
		require
			exists: not destroyed
		deferred
		ensure
			positive_value: Result >= 0
			coherent_position: Result >= minimum_position
		end

	is_first_area_shrinkable: BOOLEAN is
			-- Can the first area be shrunk to a size smaller than the
			-- child it contains? True if it does not contain any child.
		require
			exits: not destroyed
		deferred
		end

	is_second_area_shrinkable: BOOLEAN is
			-- Can the second area be shrunk to a size smaller than the
			-- child it contains? True if it does not contain any child.
		require
			exits: not destroyed
		deferred
		end

feature -- Status setting

	set_position (value: INTEGER) is
			-- Make `value' the new position of the splitter.
			-- `value' is given in pixel.
			-- Has an effect only if the split area has
			-- already a child.
		require
			exists: not destroyed
		deferred
		end

	set_first_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the first area if `flag', forbid
			-- it otherwise.
		require
			exits: not destroyed
		deferred
		ensure
			flag_set: is_first_area_shrinkable = flag
		end

	set_second_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the second area if `flag', forbid
			-- it otherwise.
		require
			exits: not destroyed
		deferred
		ensure
			flag_set: is_second_area_shrinkable = flag
		end

end -- class EV_SPLIT_AREA_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------
