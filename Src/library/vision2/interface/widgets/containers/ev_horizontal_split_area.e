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
			initialize_split_area
			sep.pointer_button_press_actions.extend (~on_click)
			Precursor
		end
	
feature -- Access

	split_position: INTEGER is
			-- split_position of the left side of `sep' relative to
			-- the left side of `split_box'.
		do
			Result := first_cell.width + 1

		end

	minimum_split_position: INTEGER is
			-- Minimum size of `split_position'.
		do
			if first /= Void then
				Result := first.minimum_width + 1
			else
				Result := 1
			end
		end

	maximum_split_position: INTEGER is
			-- Maximum size of `split_position'.
		local
			sec_item_min_width: INTEGER
		do
			if second /= Void then
				sec_item_min_width := second.minimum_width
			end
			Result := (split_box.width - sep.width - sec_item_min_width) + 1
		end

feature -- Status setting

	set_split_position (a_split_position: INTEGER) is
			-- Set the pixel-split_position of the left side of `sep'
			-- with respect to `split_box'.
		do
			first_cell.set_minimum_width (a_split_position - 1)
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

	separator_in_motion: BOOLEAN
		-- Is the separator currently being dragged.

	line_drawn: BOOLEAN
		-- Has the separator line been drawn on screen.

	x_offset: INTEGER
		-- X offset of the initial click on the separator.

	mouse_screen_coord: INTEGER
		-- Initial X screen-coordinate of the drag.

	on_click (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Start of the drag.
		do
			if first /= Void then
				mouse_screen_coord := scr_x
				x_offset := a_x
				sep.pointer_motion_actions.extend (~on_motion)
				first_cell_screen_x := first_cell.screen_x
				first_cell_screen_y := first_cell.screen_y 
				sep.enable_capture
				sep.pointer_button_release_actions.extend (~on_release)
			end
		end

	on_motion (a_x, a_y: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- Draw separator line.
		local
			wid: INTEGER
		do
			wid := valid_split_position (scr_x - mouse_screen_coord)
			wid := first_cell_screen_x + wid + x_offset

			if separator_in_motion then
				scr.draw_segment (previous_split_position, first_cell_screen_y,
					previous_split_position, first_cell_screen_y + sep.height)
				scr.draw_segment (wid, first_cell_screen_y, wid,
					first_cell_screen_y + sep.height)
			else
				scr.draw_segment (wid, first_cell_screen_y, wid,
					first_cell_screen_y + sep.height)
				separator_in_motion := True
			end

			line_drawn := True

			previous_split_position := wid
		end

	previous_split_position: INTEGER
		-- Previous split_position


	first_cell_screen_x: INTEGER
		-- Horizontal screen offset of first cell.
		-- Used for speed optimization of motion routine.

	first_cell_screen_y: INTEGER
		-- Vertical screen offset of first cell.
		-- Used for speed optimization of motion routine.

	on_release (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- End of the drag.
		do
			if line_drawn then
				line_drawn := False
				scr.draw_segment (previous_split_position, first_cell_screen_y,
					previous_split_position, first_cell_screen_y + sep.height)
			end
	
			first_cell.set_minimum_width (valid_split_position (
				scr_x - mouse_screen_coord))
			sep.pointer_motion_actions.wipe_out
			sep.disable_capture
			separator_in_motion := False
			sep.pointer_button_release_actions.wipe_out
		end

	valid_split_position (wid: INTEGER): INTEGER is
			-- Valid split_position of `sep' from `wid'.
		require
			first_item_not_void: first /= Void
		local
			sec_item_min_width: INTEGER
		do
			Result := wid + first.width

			if second /= Void then
				sec_item_min_width := second.minimum_width
			end

			if Result < first.minimum_width then
				Result := first.minimum_width
			elseif Result > (split_box.width -
					sep.width - sec_item_min_width) then
				Result := (split_box.width - sep.width - sec_item_min_width)
			end
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
