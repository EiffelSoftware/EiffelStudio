indexing
	description: "EiffelVision scrollable area. Scrollable area%
				% is a container with scrollbars. Scrollable area%
				% offers automatic scrolling for its child."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA

inherit
	EV_CONTAINER 
		redefine
			make,
			implementation,
			manager
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a fixed widget with, `par' as
			-- parent
		do
			!EV_SCROLLABLE_AREA_IMP!implementation.make
			widget_make (par)
		end

feature -- Access

	manager: BOOLEAN is 
			-- Does the container manage its children?
		do
			Result := True
		end

	horizontal_step: INTEGER is
			-- Step of the horizontal scrolling
			-- ie : the user clicks on a horizontal arrow
		require
			exists: not destroyed
		do
			Result := implementation.horizontal_step
		ensure
			positive_result: Result >= 0
		end

	horizontal_leap: INTEGER is
			-- Leap of the horizontal scrolling
			-- ie : the user clicks on the horizontal scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.horizontal_leap
		ensure
			positive_result: Result >= 0
		end

	vertical_step: INTEGER is
			-- Step of the vertical scrolling
			-- ie : the user clicks on a vertical arrow
		require
			exists: not destroyed
		do
			Result := implementation.vertical_step
		ensure
			positive_result: Result >= 0
		end

	vertical_leap: INTEGER is
			-- Leap of the vertical scrolling
			-- ie : the user clicks on the vertical scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.vertical_leap
		ensure
			positive_result: Result >= 0
		end

	horizontal_value: INTEGER is
			-- Current position of the horizontal scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.horizontal_value
		end

	vertical_value: INTEGER is
			-- Current position of the vertical scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.vertical_value
		end

	horizontal_minimum: INTEGER is
			-- Minimal position on the horizontal scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.horizontal_minimum
		end

	vertical_minimum: INTEGER is
			-- Maximal position on the vertical scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.vertical_minimum
		end

	horizontal_maximum: INTEGER is
			-- Maximal position on the horizontal scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.horizontal_maximum
		end

	vertical_maximum: INTEGER is
			-- Maximal position on the vertical scroll bar
		require
			exists: not destroyed
		do
			Result := implementation.vertical_maximum
		end

feature -- Element change

	set_horizontal_step (value: INTEGER) is
			-- Make `value' the new horizontal step.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_horizontal_step (value)
		ensure
			value_set: horizontal_step = value
		end

	set_vertical_step (value: INTEGER) is
			-- Make `value' the new vertical step.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_vertical_step (value)
		ensure
			value_set: vertical_step = value
		end

	set_horizontal_leap (value: INTEGER) is
			-- Make `value' the new horizontal leap.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_horizontal_leap (value)
		ensure
			value_set: horizontal_leap = value
		end

	set_vertical_leap (value: INTEGER) is
			-- Make `value' the new vertical leap.
		require
			exists: not destroyed
			positive_value: value >= 0
		do
			implementation.set_vertical_leap (value)
		ensure
			value_set: vertical_leap = value
		end

	set_horizontal_value (value: INTEGER) is
			-- Make `value' the new horizontal value where `value' is given in percentage.
			-- As this feature use and integer approximation, the post-condition is not
			-- always verified.
		require
			exists: not destroyed
		do
			implementation.set_horizontal_value (value)
		ensure
--			value_set: horizontal_value = value
		end

	set_vertical_value (value: INTEGER) is
			-- Make `value' the new vertical value where `value' is given in percentage.
			-- As this feature use and integer approximation, the post-condition is not
			-- always verified.
		require
			exists: not destroyed
		do
			implementation.set_vertical_value (value)
		ensure
--			value_set: vertical_value = value
		end

feature -- Implementation

	implementation: EV_SCROLLABLE_AREA_I
		-- Platform dependent access

end -- class EV_SCROLLABLE_AREA

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
