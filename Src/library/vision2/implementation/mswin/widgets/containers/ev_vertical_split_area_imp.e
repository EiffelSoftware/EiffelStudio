--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision vertical split area. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_VERTICAL_SPLIT_AREA_IMP
	
inherit
	EV_VERTICAL_SPLIT_AREA_I

	EV_SPLIT_AREA_IMP
		redefine
			set_first_area_shrinkable,
			set_second_area_shrinkable,
			compute_minimum_height,
			compute_minimum_width,
			compute_minimum_size,
			set_default_minimum_size,
			move_and_resize,
			on_set_cursor
		end
	
creation
	make

feature {NONE} -- Access

	splitter_region: WEL_REGION is
			-- A region that recover the splitter
		do
			!! Result.make_rect (0, position, width, position + size)
		end

	minimum_position: INTEGER is
			-- Minimum position that the splitter is allowed to go
			-- Depends of the first child minimum size
		do
			if is_first_area_shrinkable then
				Result := 0
			else
				Result := child1.minimum_width
			end
		end	

	maximum_position: INTEGER is
			-- Maximum position that the splitter is allowed to go
			-- Depends of the second child minimum size
		do
			if is_second_area_shrinkable then
				Result := (height - size).max (0)
			else
				Result := (height - size - child2.minimum_height).max (0)
			end	
		end

feature -- Status settings

	set_first_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the first area if `flag', forbid
			-- it otherwise.
		do
			{EV_SPLIT_AREA_IMP} Precursor (flag)
			notify_change (2)
		end

	set_second_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the second area if `flag', forbid
			-- it otherwise.
		do
			{EV_SPLIT_AREA_IMP} Precursor (flag)
			notify_change (2)
		end

feature -- Element change

	set_default_minimum_size is
			-- Initialize the size of the widget.
		do
			internal_set_minimum_height (size)
		end

feature {NONE} -- Basic operation

	resize_children (value: INTEGER) is
			-- Resize the two children according to the new position of the 
			-- splitter
		do
			if child1 /= Void then
				child1.set_move_and_size (0, 0, width, value)
			end
			if child2 /= Void then
				child2.set_move_and_size (0, value + size,
					width, (height - value - size).max (0))
			end
			refresh
		end

feature {NONE} -- Implementation

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		local
			first, second: BOOLEAN
		do
			first := child1 /= Void
			second := child2 /= Void
			if first and second then
				internal_set_minimum_width (child1.minimum_width.max (child2.minimum_width))
			elseif first then
				internal_set_minimum_width (child1.minimum_width)
			elseif second then
				internal_set_minimum_width (child2.minimum_width)
			else
				internal_set_minimum_width (0)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		local
			first, second: BOOLEAN
		do
			first := not is_first_area_shrinkable
			second := not is_second_area_shrinkable
			if first and second then
				internal_set_minimum_height (child1.minimum_height + size + child2.minimum_height)
			elseif first then
				internal_set_minimum_height (child1.minimum_height + size)
			elseif second then
				internal_set_minimum_height (child2.minimum_height + size)
			else
				internal_set_minimum_height (size)
			end
		end

	compute_minimum_size is
			-- Recompute the minimum size of the object.
		local
			first, second: BOOLEAN
		do
			first := not is_first_area_shrinkable
			second := not is_second_area_shrinkable

			if first and second then
				internal_set_minimum_size (child1.minimum_width.max (child2.minimum_width),
							child1.minimum_height + size + child2.minimum_height)
			elseif first then
				if child2 /= Void then
					internal_set_minimum_size (child1.minimum_width.max (child2.minimum_width),
							child1.minimum_height + size)
				else
					internal_set_minimum_size (child1.minimum_width, child1.minimum_height + size)
				end
			elseif second then
				if child1 /= Void then
					internal_set_minimum_size (child1.minimum_width.max (child2.minimum_width),
							child2.minimum_height + size)
				else
					internal_set_minimum_size (child2.minimum_width, child2.minimum_height + size)
				end
			else
				first := child1 /= Void
				second := child2 /= Void
				if first and second then
					internal_set_minimum_size (child1.minimum_width.max (child2.minimum_width), size)
				elseif first then
					internal_set_minimum_size (child1.minimum_width, size)
				elseif second then
					internal_set_minimum_size (child2.minimum_width, size)
				else
					internal_set_minimum_size (0, size)
				end
			end
		end

	draw_split is
			-- Draw an horizontal split at 'position'.
		local
			ldc: WEL_CLIENT_DC
			pos: INTEGER
		do
			-- Some local variable for speed
			ldc := dc
			pos := position
			-- Drawing
			ldc.get
			ldc.select_pen (face_pen)
			ldc.line (0, pos, width, pos)
			ldc.select_pen (highlight_pen)
			ldc.line (0, pos + 1, width, pos + 1)
			ldc.select_pen (face_pen)
			ldc.line (0, pos + 2, width, pos + 2)
			ldc.line (0, pos + 3, width, pos + 3)
			ldc.select_pen (shadow_pen)
			ldc.line (0, pos + 4, width, pos + 4)
			ldc.select_pen (window_frame_pen)
			ldc.line (0, pos + 5, width, pos + 5)
			ldc.release
		end

	invert_split is
			-- Invert the vertical split from `first' position to `last' position
			-- Used when the user move the split
			-- It uses rectangle and not fill_rectangle because
			-- the second feature doesn't use the rop2 status.
		local
			old_rop2: INTEGER
		do
			dc.get
			old_rop2 := dc.rop2
			dc.set_rop2 (R2_xorpen)
			dc.select_brush (splitter_brush)
			dc.rectangle (-1, position, width + 1, position + size)
			dc.set_rop2 (old_rop2)
			dc.release
		end

feature {NONE} -- WEL Implementation

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- We resize the children too.
			-- No care about has_changes.
		do
			{EV_SPLIT_AREA_IMP} Precursor (a_x, a_y, a_width, a_height, repaint)
			if a_height /= 0 and then position > (a_height - size).max (0) then
				set_position ((a_height - size).max (0))
			else
				resize_children (position)
			end
		end

	on_set_cursor (code: INTEGER) is
			-- Respond to a cursor message.
		local
			point: WEL_POINT
		do
			!! point.make (0, 0)
			point.set_cursor_position
			point.screen_to_client (Current)
			
			if on_split (point.y) then
				!! internal_cursor.make_with_predefined_id (Idc_sizens)
			else
				internal_cursor := Void
			end

			if internal_cursor /= Void and then code = Htclient then
				internal_cursor.set
				disable_default_processing
			elseif cursor_imp /= Void then
				cursor_imp.set
				disable_default_processing
			end
		end

	on_left_button_down (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button down message.
		do
			if on_split (a_y) then
				set_capture
				is_splitting := True
				invert_split
			end
		end

	on_mouse_move (code, a_x, a_y: INTEGER) is
			-- Respond to a mouse move message.
		local
			acceptable_y: INTEGER
		do
			if is_splitting then
				if a_y < minimum_position then
					acceptable_y := minimum_position
				elseif a_y > maximum_position then
					acceptable_y := maximum_position
				else
					acceptable_y := a_y
				end
				if acceptable_y /= position then
					invert_split
					position := acceptable_y
					invert_split
				end
			end
		end
	
	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button up message.
		do
			if is_splitting then
				is_splitting := False
				resize_children (position)
				release_capture
			end
		end

end -- EV_VERTICAL_SPLIT_AREA_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.10.2  2000/01/27 19:30:24  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.10.1  1999/11/24 17:30:30  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.6.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
