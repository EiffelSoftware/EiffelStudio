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
			compute_minimum_width,
			set_default_minimum_size,
			on_set_cursor
		end
	
creation
	make

feature {NONE} -- Access

	position: INTEGER is
			-- Position of the splitter in the window
		do
			if child1 /= Void and then child1.child_cell /= Void then
				Result := child1.child_cell.height
			else
				Result := 0
			end
		end

	splitter_region: WEL_REGION is
			-- A region that recover the splitter
		do
			!! Result.make_rect (0, position, width, position + size)
		end

	minimum_position: INTEGER is
			-- Minimum position that the splitter is allowed to go
			-- Depends of the first child minimum size
		do
			Result := 0
		end	

	maximum_position: INTEGER is
			-- Maximum position that the splitter is allowed to go
			-- Depends of the second child minimum size
		do
			Result := height - size
		end

feature -- Element change

	set_default_minimum_size is
			-- Initialize the size of the widget.
		do
			internal_set_minimum_height (size)
			if parent_imp /= Void then
				notify_change (2)
			end
		end

	set_position (value: INTEGER) is
			-- Make `value' the new position of the splitter.
			-- `value' is given in pixel.
			-- Has an effect only if the split area has
			-- already a child.
		do
			resize_children (value)
		end

feature {NONE} -- Basic operation

	resize_children (a_position: INTEGER) is
			-- Resize the two children according to the new position of the 
			-- splitter
		do
			if child1 /= Void then
				child1.parent_ask_resize (width, a_position)
			end
			if child2 /= Void then
				child2.set_move_and_size (0, a_position + size,
					width, (height - a_position - size).max (0))
			end
			refresh
		end

feature {NONE} -- Implementation

	draw_split is
			-- Draw an horizontal split at 'position'.
		local
			ldc: WEL_CLIENT_DC
			lposition: INTEGER
		do
			-- Some local variable for speed
			ldc := dc
			lposition := position
			-- Drawing
			ldc.get
			ldc.select_pen (face_pen)
			ldc.line (0, lposition, width, lposition)
			ldc.select_pen (highlight_pen)
			ldc.line (0, lposition + 1, width, lposition + 1)
			ldc.select_pen (face_pen)
			ldc.line (0, lposition + 2, width, lposition + 2)
			ldc.line (0, lposition + 3, width, lposition + 3)
			ldc.select_pen (shadow_pen)
			ldc.line (0, lposition + 4, width, lposition + 4)
			ldc.select_pen (window_frame_pen)
			ldc.line (0, lposition + 5, width, lposition + 5)
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
			dc.rectangle (-1, temp_position, width+1, temp_position + size)
			dc.set_rop2 (old_rop2)
			dc.release
		end

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
			-- Should call only set_internal_minimum_width.
		local
			value: INTEGER
		do
			if child1 /= Void then
				value := child1.minimum_width
			end
			if child2 /= Void and then child2.minimum_width > value then
				value := child2.minimum_width
			end
			internal_set_minimum_width (value)		
		end

feature {NONE} -- WEL Implementation

	on_set_cursor (code: INTEGER) is
			-- Respond to a cursor message.
		local
			point: WEL_POINT
		do
			!! point.make (0, 0)
			point.set_cursor_position
			point.screen_to_client (Current)
			
			if on_split (point.y) then
				!! internal_cursor.make_by_predefined_id (Idc_sizens)
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
				temp_position := position
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
				if acceptable_y /= temp_position then
					invert_split
					temp_position := acceptable_y
					invert_split
				end
			end
		end
	
	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button up message.
		do
			if is_splitting then
				is_splitting := False
				resize_children (temp_position)
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
