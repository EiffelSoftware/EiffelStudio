indexing

	description: 
		"EiffelVision scrollable area, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SCROLLABLE_AREA_I
	
inherit
	EV_CONTAINER_I

feature -- Access

	horizontal_step: INTEGER is
			-- Step of the horizontal scrolling
			-- ie : the user clicks on a horizontal arrow
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

	horizontal_leap: INTEGER is
			-- Leap of the horizontal scrolling
			-- ie : the user clicks on the horizontal scroll bar
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

	vertical_step: INTEGER is
			-- Step of the vertical scrolling
			-- ie : the user clicks on a vertical arrow
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

	vertical_leap: INTEGER is
			-- Leap of the vertical scrolling
			-- ie : the user clicks on the vertical scroll bar
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

	horizontal_value: INTEGER is
			-- Current position of the horizontal scroll bar
		require
			exists: not destroyed
		deferred
		end

	vertical_value: INTEGER is
			-- Current position of the vertical scroll bar
		require
			exists: not destroyed
		deferred
		end

	horizontal_minimum: INTEGER is
			-- Minimal position on the horizontal scroll bar
		require
			exists: not destroyed
		deferred
		end

	vertical_minimum: INTEGER is
			-- Maximal position on the vertical scroll bar
		require
			exists: not destroyed
		deferred
		end

	horizontal_maximum: INTEGER is
			-- Maximal position on the horizontal scroll bar
		require
			exists: not destroyed
		deferred
		end

	vertical_maximum: INTEGER is
			-- Maximal position on the vertical scroll bar
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_horizontal_step (value: INTEGER) is
			-- Make `value' the new horizontal step.
		require
			exists: not destroyed
			positive_value: value >= 0
		deferred
		ensure
			value_set: horizontal_step = value
		end

	set_vertical_step (value: INTEGER) is
			-- Make `value' the new vertical step.
		require
			exists: not destroyed
			positive_value: value >= 0
		deferred
		ensure
			value_set: vertical_step = value
		end

	set_horizontal_leap (value: INTEGER) is
			-- Make `value' the new horizontal leap.
		require
			exists: not destroyed
			positive_value: value >= 0
		deferred
		ensure
			value_set: horizontal_leap = value
		end

	set_vertical_leap (value: INTEGER) is
			-- Make `value' the new vertical leap.
		require
			exists: not destroyed
			positive_value: value >= 0
		deferred
		ensure
			value_set: vertical_leap = value
		end

	set_horizontal_value (value: INTEGER) is
			-- Make `value' the new horizontal value where `value' is given in percentage.
			-- As this feature use and integer approximation, the post-condition is not
			-- always verified.
		require
			exists: not destroyed
		deferred
		ensure
--			value_set: horizontal_value = value
		end

	set_vertical_value (value: INTEGER) is
			-- Make `value' the new vertical value where `value' is given in percentage.
			-- As this feature use and integer approximation, the post-condition is not
			-- always verified.
		require
			exists: not destroyed
		deferred
		ensure
--			value_set: vertical_value = value
		end

end -- class EV_SCROLLABLE_AREA_I

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
