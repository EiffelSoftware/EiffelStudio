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
			child_minheight_changed
		end
	
creation
	make

feature {NONE} -- Access

	level: INTEGER is
			-- Position of the splitter in the window
		do
			if child1 /= Void and then child1.child_cell /= Void then
				Result := child1.child_cell.height
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
				Result := child1.minimum_height
			end
		end	

	maximum_level: INTEGER is
			-- Maximum level that the splitter is allowed to go
			-- Depends of the second child minimum size
		do
			if child2 = Void then
				Result := height - size
			else
				Result := height - child2.minimum_height - size
			end
		end

feature -- Implementation

--	child_height_changed (new_height: INTEGER; the_child: EV_WIDGET_IMP) is
--			-- Resize the window and redraw the split according to
--			-- the resize of a child.
--		local
--			local_height: INTEGER
--		do
--			if the_child = child1 then
--				refresh
--			else
--				local_height := size + child1.child_cell.height
--				if child2 /= Void then
--					child2.set_y (local_height)
--					local_height := local_height + child2.child_cell.height
--					set_height (local_height)
--				end
--				parent_imp. child_height_changed (height, Current)
--			end
--		end

	set_local_width (new_width: INTEGER) is
			-- Make `new_width' the new `width' of the 
			-- container and both children.
		do
			if new_width > minimum_width then
				set_width (new_width)
				resize_children (level)
			end
		end

	set_local_height (new_height: INTEGER) is
			-- Make `new_height' the new `height' of the 
			-- container and both children.
		do
			if new_height > minimum_height then
				set_height (new_height)
				if child2 /= Void then
					child2.parent_ask_resize (child2.width, new_height - child1.child_cell.height - size)
				end
			end
		end

	child_minheight_changed (child_new_minimum: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_width because the child did.
		local
			local_height: INTEGER
		do
			if child1 /= Void then
				local_height := local_height + child1.minimum_height
			end
			if child2 /= Void then
				local_height := local_height + child2.minimum_height
			end
			set_minimum_height (local_height + size)
		end

feature {NONE} -- Implementation

	resize_children (a_level: INTEGER) is
			-- Resize the two children according to the new level of the 
			-- splitter
		do
			if child1 /= Void then
				child1.parent_ask_resize (width, a_level)
			end
			if child2 /= Void then
				child2.set_move_and_size (0, a_level + size, 
							width, height - a_level - size)
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
				!! rectangle.make (0, 0, width, level)
				dc.fill_rect (rectangle, class_background)
			end
			if child2 = Void and height > level + size then
				!! rectangle.make (0, level + size, width, height)
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
			
			if on_split (point.y) then
				!! cursor.make_by_predefined_id (Idc_sizens)
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
			if on_split (a_y) then
				set_capture
				is_splitting := True
				temp_level := level
				invert_split
			end
		end

	on_mouse_move (code, a_x, a_y: INTEGER) is
			-- Respond to a mouse move message.
		local
			acceptable_y: INTEGER
		do
			if is_splitting then
				if a_y < minimum_level then
					acceptable_y := minimum_level
				elseif a_y > maximum_level then
					acceptable_y := maximum_level
				else
					acceptable_y := a_y
				end
				if acceptable_y /= temp_level then
					invert_split
					temp_level := acceptable_y
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

feature {NONE} -- Implementation : Basic routines

	draw_split is
			-- Draw an horizontal split at 'level'.
		do
			dc.get
			dc.select_pen (face_pen)
			dc.line (0, level, width, level)
			dc.select_pen (highlight_pen)
			dc.line (0, level + 1, width, level + 1)
			dc.select_pen (face_pen)
			dc.line (0, level + 2, width, level + 2)
			dc.line (0, level + 3, width, level + 3)
			dc.select_pen (shadow_pen)
			dc.line (0, level + 4, width, level + 4)
			dc.select_pen (window_frame_pen)
			dc.line (0, level + 5, width, level + 5)
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
			dc.rectangle (-1, temp_level, width+1, temp_level + size)
			dc.set_rop2 (old_rop2)
			dc.release
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
