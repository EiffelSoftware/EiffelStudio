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
			child_minwidth_changed,
			child_minheight_changed,
			set_default_minimum_size
		end
	
creation
	make

feature {NONE} -- Access

	level: INTEGER is
			-- Position of the splitter in the window
		do
			if child1 /= Void and then child1.child_cell /= Void then
				Result := child1.child_cell.width
			else
				Result := 0
			end
		end

	splitter_region: WEL_REGION is
			-- A region that recover the splitter
		do
			!! Result.make_rect (level, 0, level + size, height)
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

feature -- Element change

	set_default_minimum_size is
			-- Initialize the size of the widget.
		do
			set_minimum_height (size)
		end

feature {NONE} -- Basic operation

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

	set_local_height (new_height: INTEGER) is
			-- Make `new_height' the new `height' of the 
			-- container and both children.
		do
			if new_height > minimum_height then
				set_height (new_height)
				resize_children (level)
			end
		end

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
			refresh
		end

feature {NONE} -- Implementation for automatic size compute

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

   	child_minheight_changed (value: INTEGER; the_child: EV_SIZEABLE_IMP) is
   			-- Change the minimum width of the container because
   			-- the child changed his own minimum width.
		local
			temp: INTEGER
		do
			if child1 /= Void then
				temp := child1.minimum_height
			end
			if child2 /= Void then
	 			temp := temp.max (child2.minimum_height)
			end
			set_minimum_height (temp)
		end

feature {NONE} -- Implementation

	draw_split is
			-- draw a vertical split at `level'.
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
			ldc.line (llevel, 0, llevel, height)
			ldc.select_pen (highlight_pen)
			ldc.line (llevel + 1, 0, llevel + 1, height)
			ldc.select_pen (face_pen)
			ldc.line (llevel + 2, 0, llevel + 2, height)
			ldc.line (llevel + 3, 0, llevel + 3, height)
			ldc.select_pen (shadow_pen)
			ldc.line (llevel + 4, 0, llevel + 4, height)
			ldc.select_pen (window_frame_pen)
			ldc.line (llevel + 5, 0, llevel + 5, height)
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
			dc.rectangle (temp_level, -1, temp_level + size, height+1)
			dc.set_rop2 (old_rop2)
			dc.release
		end

	update_display is
			-- Feature that update the actual container.
		do
			if child1.width = 0 then
				child1.parent_ask_resize (child1.minimum_width, height)
			end
			resize_children (level)
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
