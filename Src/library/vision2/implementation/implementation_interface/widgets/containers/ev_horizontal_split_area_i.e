indexing
	description: 
		"Eiffel Vision horizontal split area. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_SPLIT_AREA_I

inherit
	EV_SPLIT_AREA_I
		redefine
			make
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create split_box and separator.

		do
			{EV_SPLIT_AREA_I} Precursor (an_interface)
			create {EV_HORIZONTAL_BOX} split_box
			create {EV_VERTICAL_SEPARATOR} sep
			initialize_split_area
			sep.pointer_button_press_actions.extend (~on_click)
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
			if first_item /= Void then
				Result := first_item.minimum_width + 1
			else
				Result := 1
			end
		end

	maximum_split_position: INTEGER is
			-- Maximum size of `split_position'.
		local
			sec_item_min_width: INTEGER
		do
			if second_item /= Void then
				sec_item_min_width := second_item.minimum_width
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
			if first_item /= Void then
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
				scr.draw_segment (wid, first_cell_screen_y, wid, first_cell_screen_y + sep.height)
			else
				scr.draw_segment (wid, first_cell_screen_y, wid, first_cell_screen_y + sep.height)
				separator_in_motion := True
			end

			line_drawn := True

			previous_split_position := wid
		end

	previous_split_position: INTEGER
		-- Previous split_position

	first_cell_screen_x: INTEGER
	first_cell_screen_y: INTEGER
		-- Screen X/Y of first cell, used for speed optimization of motion routine.

	on_release (a_x, a_y, e: INTEGER; f, g, h: DOUBLE; scr_x, scr_y: INTEGER) is
			-- End of the drag.
		do
			if line_drawn then
				line_drawn := False
				scr.draw_segment (previous_split_position, first_cell_screen_y,
					previous_split_position, first_cell_screen_y + sep.height)
			end
	
			first_cell.set_minimum_width (valid_split_position (scr_x - mouse_screen_coord))
			sep.pointer_motion_actions.wipe_out
			sep.disable_capture
			separator_in_motion := False
			sep.pointer_button_release_actions.wipe_out
		end

	valid_split_position (wid: INTEGER): INTEGER is
			-- Valid split_position of `sep' from `wid'.
		require
			first_item_not_void: first_item /= Void
		local
			sec_item_min_width: INTEGER
		do
			Result := wid + first_item.width

			if second_item /= Void then
				sec_item_min_width := second_item.minimum_width
			end

			if Result < first_item.minimum_width then
				Result := first_item.minimum_width
			elseif Result > (split_box.width - sep.width - sec_item_min_width) then
				Result := (split_box.width - sep.width - sec_item_min_width)
			end
		end
			
end -- class EV_HORIZONTAL_SPLIT_AREA_I

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.17  2000/02/10 19:04:26  king
--| Added checks for items to test for validity
--|
--| Revision 1.5.6.16  2000/02/10 17:06:16  king
--| Changed on click to perform no operations if first cell item is void
--|
--| Revision 1.5.6.15  2000/02/10 08:45:44  oconnor
--| added Void checks
--|
--| Revision 1.5.6.14  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.5.6.13  2000/01/28 17:32:09  oconnor
--| revised to inherit EV_AGGREGATE_WIDGET_IMP
--|
--| Revision 1.5.6.12  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.11  2000/01/26 17:39:17  king
--| Added remove line on button release (for overlapping windows)
--|
--| Revision 1.5.6.10  2000/01/26 02:50:32  king
--| Added set_proportion routine
--|
--| Revision 1.5.6.9  2000/01/26 01:03:30  king
--| Updated line drawing routine to remove previous line
--|
--| Revision 1.5.6.8  2000/01/25 19:17:03  king
--| Changed parameter name in agents from x/y to a_x/y
--|
--| Revision 1.5.6.7  2000/01/25 19:08:01  king
--| Changed position features to split_position
--|
--| Revision 1.5.6.6  2000/01/25 17:15:09  king
--| Added drawing of moving separator, needs modification to erase previous frame
--|
--| Revision 1.5.6.5  2000/01/21 22:32:59  king
--| Removed testing comments, changed min resize to be that of first item
--|
--| Revision 1.5.6.4  2000/01/21 18:56:45  king
--| First implementation of h split area
--|
--| Revision 1.5.6.3  2000/01/20 18:53:00  oconnor
--| formatting
--|
--| Revision 1.5.6.2  2000/01/20 18:42:31  oconnor
--| reimplemented platform indeoendantly in line with new interface
--|
--| Revision 1.5.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
