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
			child_minheight_changed,
			child_minwidth_changed,
			child_width_changed
		end
	
creation
	
	make

feature {NONE} -- Access

	level: INTEGER is
			-- Position of the splitter in the window
		do
			if child1 /= Void then
				Result := child1.child_cell.width
			else
				Result := 0
			end
		end

	minimum_level: INTEGER is
			-- Minimum level that the splitter is allowed to go
			-- Depends of the first child minimum size
		do
			if child1 = Void then
				Result := 0
			else
				Result := child1.minimum_width
			end
		end	

	maximum_level: INTEGER is
			-- Maximum level that the splitter is allowed to go
			-- Depends of the second child minimum size
		do
			if child2 = Void then
				Result := width - size
			else
				Result := width - child2.minimum_width - size
			end
		end

feature -- Implementation

	child_width_changed (new_width: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the window and redraw the split according to
			-- the resize of a child.
		local
			temp_width: INTEGER
		do
			if the_child = child1 then
				refresh
			else
				temp_width := size + child1.child_cell.width
				if child2 /= Void then
					child2.set_x (temp_width)
					temp_width := temp_width + child2.child_cell.width
					set_width (temp_width)
				end
				parent_imp.child_width_changed (width, Current)
			end
		end

	set_local_height (new_height: INTEGER) is
			-- Make `new_height' the new `height' of the 
			-- container and both children.
		do
			if new_height > minimum_height then
				set_height (new_height)
				resize_children (level)
			end
		end

	set_local_width (new_width: INTEGER) is
			-- Make `new_width' the new `width' of the 
			-- container and both children.
		do
			if new_width > width then
				set_width (new_width)
				if child2 /= Void then
					child2.parent_ask_resize (new_width - child1.child_cell.width - size, child2.child_cell.height)
				end
			end
		end

	child_minwidth_changed (child_new_minimum: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_width because the child did.
		local
			local_width: INTEGER
		do
			if child1 /= Void then
				local_width := local_width + child1.minimum_width
			end
			if child2 /= Void then
				local_width := local_width + child2.minimum_width
			end
			set_minimum_width (local_width + size)
		end

	child_minheight_changed (child_new_minimum: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_height because onr of the children did.
		do
			set_minimum_height (child_new_minimum.max(minimum_height))
		end

feature {NONE} -- Implementation

	resize_children (a_level: INTEGER) is
			-- Resize the two children according to the new level of the 
			-- splitter.
		do
			if child1 /= Void then
				child1.parent_ask_resize (a_level, height)
			end
			if child2 /= Void then
				child2.set_move_and_size (a_level + size, 0, 
							width - a_level - size, height)
			end
		end

feature {NONE} -- Implementation : Event handling

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
		local
			rectangle: WEL_RECT
		do
			dc.get
			if 	child1 = Void then
				!! rectangle.make (0, 0, level, height)
				dc.fill_rect (rectangle, class_background)
			end
			if child2 = Void and width > level + size then
				!! rectangle.make (level + size, 0, width, height)
				dc.fill_rect (rectangle, class_background)
			end
			dc.release
			disable_default_processing
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
				!! cursor.make_by_predefined_id (Idc_sizewe)
			else
				cursor := Void
			end

			if cursor /= Void and then code = Htclient then
				cursor.set
				disable_default_processing
			end
		end

	on_left_button_down (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button down message.
		do
			if on_split (a_x) then
				set_capture
				is_splitting := True
				temp_level := level
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
				if a_x < minimum_level then
					acceptable_x := minimum_level
				elseif a_x > maximum_level then
					acceptable_x := maximum_level
				else
					acceptable_x := a_x
				end
				if acceptable_x /= temp_level then
					invert_split
					temp_level := acceptable_x
					invert_split
				end
			end
		end
	
	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button up message.
		do
			if is_splitting then
				is_splitting := False
				resize_children (temp_level)
				on_wm_erase_background (0)	
				draw_split
				release_capture
			end
		end

feature -- Implementation : Basic routines

	draw_split is
			-- draw a vertical split at `level'.
		do
			dc.get
			dc.select_pen (face_pen)
			dc.line (level, 0, level, height)
			dc.select_pen (highlight_pen)
			dc.line (level + 1, 0, level + 1, height)
			dc.select_pen (face_pen)
			dc.line (level + 2, 0, level + 2, height)
			dc.line (level + 3, 0, level + 3, height)
			dc.select_pen (shadow_pen)
			dc.line (level + 4, 0, level + 4, height)
			dc.select_pen (window_frame_pen)
			dc.line (level + 5, 0, level + 5, height)
			dc.release
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
			dc.rectangle (temp_level, -1, temp_level + size, height+1)
			dc.set_rop2 (old_rop2)
			dc.release
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
