indexing
	description: 
		"Eiffel Vision horizontal split area. Displays `first_item' on the%N%
		%left of a separator and `second_item' on the right."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_HORIZONTAL_SPLIT_AREA

inherit
	EV_SPLIT_AREA
		redefine
			initialize
		end

create
	default_create,
	make_for_test

feature -- Initialization

	initialize is
		do
			create {EV_HORIZONTAL_BOX} split_box
			create {EV_VERTICAL_SEPARATOR} sep
			Precursor
			sep.pointer_button_press_actions.extend (~on_click)
			previous_split_position := -1
		end
	
feature -- Access

	split_position: INTEGER is
			-- split_position of the left side of `sep' relative to
			-- the left side of `split_box'.
		do
			Result := first_cell.width
		end

	minimum_split_position: INTEGER is
			-- Minimum size of `split_position'.
		do
			if first_cell.readable then
				Result := first.minimum_width
			else
				Result := 1
			end
		end

	maximum_split_position: INTEGER is
			-- Maximum size of `split_position'.
		local
			sec_item_min_width: INTEGER
		do
			if second_cell.readable /= Void then
				sec_item_min_width := second.minimum_width
			else
				sec_item_min_width := 1
			end
			Result := split_box.width - sep.width - sec_item_min_width
		end

feature -- Status setting

	set_split_position (a_split_position: INTEGER) is
			-- Set the pixel-split_position of the left side of `sep'
			-- with respect to `split_box'.
		do
			if a_split_position < first_cell.width then
				first_cell.set_minimum_witdth (a_split_position)
				second_cell.set_minimum_witdth (split_box.width - sep.width - a_split_position)
			elseif a_split_position > first_cell.width then
				second_cell.set_minimum_witdth (split_box.width - sep.width - a_split_position)
				first_cell.set_minimum_witdth (a_split_position)
			end
		end

	set_proportion (a_proportion: REAL) is
			-- Set the position of the separator relative to `split_box'
			-- The position set must not break min sizes of items.
		local
			current_proportion: INTEGER	
		do
			current_proportion := (a_proportion * split_box.width).rounded
			if current_proportion < minimum_split_position then
				set_split_position (minimum_split_position)
			elseif current_proportion > maximum_split_position then
				set_split_position (maximum_split_position)
			else
				set_split_position (current_proportion)
			end	
		end

feature {NONE} -- Implementation

	x_offset: INTEGER
		-- X offset of the initial click on the separator.

	previous_split_position: INTEGER
		-- Previous split_position

	x_origin: INTEGER
		-- Horizontal screen offset of first cell.

	y_origin: INTEGER
		-- Vertical screen offset of first cell.

	on_click (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Start of the drag.
		do
			if first /= Void then
				x_offset := a_x
				x_origin := scr_x - a_x - first_cell.width
				y_origin := scr_y - a_y
				sep.enable_capture
				sep.pointer_motion_actions.extend (~on_motion)
				sep.pointer_button_release_actions.extend (~on_release)
				draw_line (first_cell.width + a_x)
			end
		end

	on_motion (a_x, a_y: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Draw separator line.
		do
			remove_line
			draw_line (splitter_position_from_screen_x (scr_x))
		end

	on_release (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- End of the drag.
		do
			remove_line
			set_split_position (splitter_position_from_screen_x (scr_x))
			sep.disable_capture
			sep.pointer_motion_actions.wipe_out
			sep.pointer_button_release_actions.wipe_out
		end

	splitter_position_from_screen_x (a_x: INTEGER): INTEGER is
			-- Return splitter position given screen `a_x'.
		do
			Result := a_x - x_origin
			if Result < minimum_split_position then
				Result := minimum_split_position
			elseif Result > maximum_split_position then
				Result := maximum_split_position
			end
		end

	remove_line is
			-- Remove previously drawn line by redrawing it over the old one.
		do
			if previous_split_position >= 0 then
				scr.draw_segment (
					previous_split_position + x_origin + x_offset,
					y_origin,
					previous_split_position + x_origin + x_offset,
					y_origin + sep.height
				)
				previous_split_position := -1
			end
		end

	draw_line (a_position: INTEGER) is
			-- Draw line on `a_position'.
		do
			scr.draw_segment (
				a_position + x_origin + x_offset,
				y_origin,
				a_position + x_origin + x_offset,
				y_origin + sep.height
			)
			previous_split_position := a_position
		end
		
end -- class EV_HORIZONTAL_SPLIT_AREA_I

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/03/04 03:12:16  brendel
--| Implemented moving of separator, but cannot be made smaller after that, so
--| we need to find a solution.
--|
--| Revision 1.12  2000/03/04 00:17:33  brendel
--| Simplified implementation.
--|
--| Revision 1.11  2000/03/03 23:13:21  brendel
--| Fixed bug in moving of separator.
--|
--| Revision 1.9  2000/03/03 20:32:24  brendel
--| Fixed bug in initialize. Before, Precursor was not called.
--| Formatted for 80 columns.
--|
--| Revision 1.8  2000/03/01 03:30:06  oconnor
--| added make_for_test
--|
--| Revision 1.7  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/21 20:11:17  rogers
--| There is no longer an EV_HORIZONTAL_SPLIT_AREA_I, so moved the appropriate
--| implementation into this class.
--|
--| Revision 1.5  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.6  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.4  2000/01/20 18:59:47  oconnor
--| formatting, comments
--|
--| Revision 1.4.6.3  2000/01/20 18:49:09  oconnor
--| reimplemented in line with new EV_SPLIT_AREA
--|
--| Revision 1.4.6.2  2000/01/19 22:16:12  king
--| First foundation of platform independent split area
--|
--| Revision 1.4.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
