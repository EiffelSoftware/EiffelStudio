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

	splitter_region: WEL_REGION is
			-- A region that recover the splitter
		do
			!! Result.make_rect (0, level, width, level + size)
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

feature {NONE} -- Basic operation

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
			refresh
		end

	update_display is
			-- Feature that update the actual container.
		do
			if child1.height = 0 then
				child1.parent_ask_resize (width, child1.minimum_height)
			end
			resize_children (level)
		end

feature {NONE} -- Implementation fo automatic size compute

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

	draw_split is
			-- Draw an horizontal split at 'level'.
		local
			ldc: WEL_CLIENT_DC
			llevel: INTEGER
		do
			-- Some local variable for speed
			ldc := dc
			llevel := level
			-- Drawing
			ldc.get
			ldc.select_pen (face_pen)
			ldc.line (0, llevel, width, llevel)
			ldc.select_pen (highlight_pen)
			ldc.line (0, llevel + 1, width, llevel + 1)
			ldc.select_pen (face_pen)
			ldc.line (0, llevel + 2, width, llevel + 2)
			ldc.line (0, llevel + 3, width, llevel + 3)
			ldc.select_pen (shadow_pen)
			ldc.line (0, llevel + 4, width, llevel + 4)
			ldc.select_pen (window_frame_pen)
			ldc.line (0, llevel + 5, width, llevel + 5)
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
			dc.rectangle (-1, temp_level, width+1, temp_level + size)
			dc.set_rop2 (old_rop2)
			dc.release
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
