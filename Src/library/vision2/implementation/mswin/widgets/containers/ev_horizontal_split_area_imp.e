indexing
	description: "EiffelVision horizontal split. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_HORIZONTAL_SPLIT_AREA_IMP
	
inherit
	EV_HORIZONTAL_SPLIT_AREA_I

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
			!! Result.make_rect (position, 0, position + size, height)
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
				Result := (width - size).max (0)
			else
				Result := (width - size - child2.minimum_width).max (0)
			end
		end

feature -- Status settings

	set_first_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the first area if `flag', forbid
			-- it otherwise.
		do
			{EV_SPLIT_AREA_IMP} Precursor (flag)
			notify_change (1)
		end

	set_second_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the second area if `flag', forbid
			-- it otherwise.
		do
			{EV_SPLIT_AREA_IMP} Precursor (flag)
			notify_change (1)
		end

feature -- Element change

	set_default_minimum_size is
			-- Initialize the size of the widget.
		do
			internal_set_minimum_width (size)
		end

feature {NONE} -- Basic operation

	resize_children (value: INTEGER) is
			-- Resize the two children according to the new position of the 
			-- splitter.
		do
			if child1 /= Void then
				child1.set_move_and_size (0, 0, value, height)
			end
			if child2 /= Void then
				child2.set_move_and_size (value + size, 0, 
					(width - value - size).max (0), height)
			end
			refresh
		end

feature {NONE} -- Implementation

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		local
			first, second: BOOLEAN
		do
			first := child1 /= Void
			second := child2 /= Void
			if first and second then
				internal_set_minimum_height (child1.minimum_height.max (child2.minimum_height))
			elseif first then
				internal_set_minimum_height (child1.minimum_height)
			elseif second then
				internal_set_minimum_height (child2.minimum_height)
			else
				internal_set_minimum_height (0)
			end
		end

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		local
			first, second: BOOLEAN
		do
			first := not is_first_area_shrinkable
			second := not is_second_area_shrinkable
			if first and second then
				internal_set_minimum_width (child1.minimum_width + size + child2.minimum_width)
			elseif first then
				internal_set_minimum_width (child1.minimum_width + size)
			elseif second then
				internal_set_minimum_width (child2.minimum_width + size)
			else
				internal_set_minimum_width (size)
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
				internal_set_minimum_size (child1.minimum_width + size + child2.minimum_width,
							child1.minimum_height.max (child2.minimum_height))
			elseif first then
				if child2 /= Void then
					internal_set_minimum_size (child1.minimum_width + size,
							child1.minimum_height.max (child2.minimum_height))
				else
					internal_set_minimum_size (child1.minimum_width + size, child1.minimum_height) 
				end
			elseif second then
				if child1 /= Void then
					internal_set_minimum_size (child2.minimum_width + size,
							child1.minimum_height.max (child2.minimum_height))
				else
					internal_set_minimum_size (child2.minimum_width + size, child2.minimum_height)
				end
			else
				first := child1 /= Void
				second := child2 /= Void
				if first and second then
					internal_set_minimum_size (size, child1.minimum_height.max (child2.minimum_height))
				elseif first then
					internal_set_minimum_size (size, child1.minimum_height)
				elseif second then
					internal_set_minimum_size (size, child2.minimum_height)
				else
					internal_set_minimum_size (size, 0)
				end
			end
		end

	draw_split is
			-- draw a vertical split at `position'.
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
			ldc.line (pos, 0, pos, height)
			ldc.select_pen (highlight_pen)
			ldc.line (pos + 1, 0, pos + 1, height)
			ldc.select_pen (face_pen)
			ldc.line (pos + 2, 0, pos + 2, height)
			ldc.line (pos + 3, 0, pos + 3, height)
			ldc.select_pen (shadow_pen)
			ldc.line (pos + 4, 0, pos + 4, height)
			ldc.select_pen (window_frame_pen)
			ldc.line (pos + 5, 0, pos + 5, height)
			ldc.release
		end

	invert_split is
			-- Invert the vertical split from `first' position to `last' position
			-- Used when the user move the split
			-- It uses rectangle and not fill_rectangle because
			-- the second feature doesn't use the rop2 status.
		local
			old_rop2: INTEGER
			ldc: WEL_CLIENT_DC
		do
			ldc := dc
			ldc.get
			old_rop2 := ldc.rop2
			ldc.set_rop2 (R2_xorpen)
			ldc.select_brush (splitter_brush)
			ldc.rectangle (position, -1, position + size, height+1)
			ldc.set_rop2 (old_rop2)
			ldc.release
		end

feature {NONE} -- WEL Implementation

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- We resize the children too.
			-- No care about has_changes.
		do
			{EV_SPLIT_AREA_IMP} Precursor (a_x, a_y, a_width, a_height, repaint)
			if a_width /= 0 and then position > (a_width - size).max (0) then
				set_position ((a_width - size).max (0))
			end
			resize_children (position)
		end

	on_set_cursor (code: INTEGER) is
			-- Respond to a cursor message.
		local
			point: WEL_POINT
		do
			!! point.make (0, 0)
			point.set_cursor_position
			point.screen_to_client (Current)
			
			if on_split (point.x) then
				!! internal_cursor.make_by_predefined_id (Idc_sizewe)
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
			if on_split (a_x) then
				set_capture
				is_splitting := True
				invert_split
			end
		end

	on_mouse_move (code, a_x, a_y: INTEGER) is
			-- Respond to a mouse move message.
			-- Do something only if the user is moving the splitter
			-- inside the acceptable area.
		local
			acceptable_x: INTEGER
		do
			if is_splitting then
				if a_x < minimum_position then
					acceptable_x := minimum_position
				elseif a_x > maximum_position then
					acceptable_x := maximum_position
				else
					acceptable_x := a_x
				end
				if acceptable_x /= position then
					invert_split
					position := acceptable_x
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

end -- EV_HORIZONTAL_SPLIT_AREA_IMP

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
