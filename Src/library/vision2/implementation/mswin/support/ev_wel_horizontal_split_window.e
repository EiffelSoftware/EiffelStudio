indexing
	description: "EiffelVision wel horizontal split window.%
			% Mswindows implementation.%
			% This class is used by EV_HORIZONTAL_SPLIT_IMP."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	EV_WEL_HORIZONTAL_SPLIT_WINDOW
	
inherit

	EV_WEL_SPLIT_WINDOW
		redefine
			split_imp,
			on_wm_erase_background,
			on_set_cursor,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up
		end

creation
	make

feature -- Initialization

	initialize_parent (imp: EV_SPLIT_IMP) is
			-- Initialize the horizontal parent of the window
		do
			split_imp ?= imp
		end

feature {NONE} -- Access

	split_imp: EV_HORIZONTAL_SPLIT_IMP
			-- The parent container, an EV_SPLIT_IMP

feature -- Event handling

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
		local
			rectangle: WEL_RECT
		do
			dc.get
			if 	split_imp.child1 = Void then
				!! rectangle.make (0, 0, level, height)
				dc.fill_rect (rectangle, class_background)
			end
			if split_imp.child2 = Void then
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
				if a_x < split_imp.minimum_level then
					acceptable_x := split_imp.minimum_level
				elseif a_x > split_imp.maximum_level then
					acceptable_x := split_imp.maximum_level
				else
					acceptable_x := a_x
				end
				if acceptable_x /= level then
					invert_split
					level := acceptable_x
					invert_split
				end
 			end
		end
	
	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button up message.
		do
			if is_splitting then
				is_splitting := False
				split_imp.resize_children (level)
				on_wm_erase_background (0)	
				draw_split
				release_capture
			end
		end

feature -- Basic routines

	draw_split is
			-- draw a vertical split at 'level'.
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
			dc.rectangle (level, -1, level + size, height+1)
			dc.set_rop2 (old_rop2)
			dc.release
		end

end -- class EV_WEL_HORIZONTAL_SPLIT_WINDOW

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