indexing
	description: "EiffelVision toolbar, mswindows implementation."
	status: "See notica at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I

	EV_PRIMITIVE_IMP
		undefine
			set_default_options,
			minimum_width,
			minimum_height,
			internal_resize
		redefine
			parent_imp,
			move_and_resize,
			on_left_button_up,
			on_left_button_down,
			on_right_button_down,
			on_right_button_up,
			on_middle_button_up,
			on_middle_button_down,
			on_mouse_move,
			destroy
		end

	EV_SIZEABLE_CONTAINER_IMP
		redefine
			compute_minimum_width,
			compute_minimum_height
		end

	EV_ITEM_HOLDER_IMP

	WEL_TOOL_BAR
		rename
			make as wel_make,
			button_count as count,
			insert_button as wel_insert_button,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			destroy_item as wel_destroy_item
		undefine
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_key_up,
			on_key_down,
			on_kill_focus,
			on_set_focus,
			on_set_cursor,
			window_process_message
		redefine
			wel_set_parent,
			move,
			resize,
			move_and_resize,
			hide,
			show,
			shown,
			default_style,
			default_process_message
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_with_size

feature {NONE} -- Initialization

	make is
			-- Create the tool-bar.
		local
			ctrl: EV_INTERNAL_TOOL_BAR_IMP
		do
			create ctrl.make (default_parent, "EV_INTERNAL_TOOL_BAR_IMP")
			wel_make (ctrl, 0)
			create ev_children.make (1)
		end

	make_with_size (w, h: INTEGER) is
			-- Create the tool-bar with a size (w, h).
		do
			make
			set_bitmap_size (w, h)
		end

feature -- Access

	bar: EV_INTERNAL_TOOL_BAR_IMP is
			-- WEL container of the tool-bar
		do
			Result ?= wel_parent
		end

	ev_children: HASH_TABLE [EV_TOOL_BAR_BUTTON_IMP, INTEGER]
			-- The buttons of the tool-bar.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this tool-bar.
		do
			if bar.parent = default_parent then
				Result := Void
			else
				Result ?= bar.parent
			end
		end

	separator_count: INTEGER is
			-- Number of separators in the toolbar.
			-- Necessary for the implementation of the minimum_width
			-- of the toolbar. As soon as the message Tb_getmaxsize
			-- is available, this feature should not be so usefull.
		local
			list: HASH_TABLE [EV_TOOL_BAR_BUTTON_IMP, INTEGER]
		do
			from
				list := ev_children
				list.start
			until
				list.after
			loop
				if list.item_for_iteration.type = 5 then
					Result := Result + 1
				end
				list.forth
			end
		end

feature -- Status report

	button_width: INTEGER is
			-- Current width of the buttons
		do
			Result := cwin_lo_word (cwin_send_message_result (item,
						Tb_getbuttonsize, 0, 0))
		end

	separator_width: INTEGER is
			-- Current width of a separator
		do
			Result := 8
		end

	button_height: INTEGER is
			-- Current width of the buttons
		do
			Result := cwin_hi_word (cwin_send_message_result (item,
						Tb_getbuttonsize, 0, 0))
		end

	shown: BOOLEAN is
			-- Is the window shown?
		do
			Result := bar.shown
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.remove_child (Current)
			end
			bar.destroy
		end

	show is
			-- Show the window
		do
			bar.show
		end

	hide is
			-- Hide the window
		do
			bar.hide
		end

feature -- Element change

	add_button (button: EV_TOOL_BAR_BUTTON_IMP) is
			-- Add `but' to the toolbar.
		require
			valid_button: button /= Void and then not button.destroyed
		do
			insert_button (button, count + 1)
		end

	insert_button (button: EV_TOOL_BAR_BUTTON_IMP; index: INTEGER) is
			-- Insert `button' at the `index' position in the tool-bar.
		require
			valid_button: button /= Void and then not button.destroyed
			valid_index: index >= 1 and then index <= count + 1
		local
			bmp: WEL_TOOL_BAR_BITMAP
			but: WEL_TOOL_BAR_BUTTON
			num: INTEGER
		do
			-- We create the button
			inspect button.type
			when 1 then -- Usual button
				create but.make_button (-1, button.id)
			when 2 then -- Check button
				create but.make_check (-1, button.id)
			when 3 then -- Radio button
				create but.make_check (-1, button.id)
			when 4 then -- Option button
				create but.make_button (-1, button.id)
			when 5 then -- Separator
				create but.make_separator
				but.set_command_id (button.id)
			end
	
			-- First, we take care of the pixmap,
			if button.pixmap_imp /= Void then
				create bmp.make_from_bitmap (button.pixmap_imp.bitmap)
				add_bitmaps (bmp, 1)
				but.set_bitmap_index (last_bitmap_index)
			end

			-- Then, the text of the button.
			if button.text /= Void and then text /= "" then
				add_strings (<<button.text>>)
				but.set_string_index (last_string_index)
			end

			-- Finally, we insert the button
			wel_insert_button (index - 1, but)
			ev_children.put (button, button.id)

			-- We notify the change to integrate them if necessary
			notify_change (2 + 1)
		end

	move_button (button: EV_TOOL_BAR_BUTTON_IMP; index: INTEGER) is
			-- Move `button' to the `index' position.
		do
			remove_button (button)
			insert_button (button, index)
		end

	remove_button (button: EV_TOOL_BAR_BUTTON_IMP) is
			-- Remove button from the toolbar.
		do
			delete_button (internal_index (button.id))
			ev_children.remove (button.id)
			notify_change (2 + 1)
		end

feature -- Basic operation

	internal_index (command_id: INTEGER): INTEGER is
			-- Retrieve the current index of the button with
			-- `command_id' as id.
		do
			Result := cwin_send_message_result (item, Tb_commandtoindex, command_id, 0)
		end

	compute_minimum_width is
			-- Update the minimum-size of the tool-bar.
		local
			num: INTEGER
		do
			num := separator_count
			num := (count - num) * button_width + num * separator_width
			internal_set_minimum_width (num)
		end

	compute_minimum_height is
			-- Update the minimum-size of the tool-bar.
		do
			internal_set_minimum_height (button_height + 6)
		end

	internal_reset_button (but: EV_TOOL_BAR_BUTTON_IMP) is
			-- XX To update XX
			-- This function is used each we change an attribute of a button as the
			-- text or the pixmap. Yet, it should only be a Temporary implementation.
			-- For now, no message is available to change the text of a button.
			-- But this implementation should be changes as soon as windows allow
			-- a more direct way to change an attribute.
		local
			index: INTEGER
		do
			index := internal_index (but.id) + 1
			remove_button (but)
			insert_button (but, index)
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TOOL_BAR_BUTTON_IMP is
			-- Find the item at the given position.
			-- Position is relative to the toolbar.
		local
			index: INTEGER
			point: WEL_POINT
			button: WEL_TOOL_BAR_BUTTON
		do
			create point.make (x_pos, y_pos)
--			index := cwin_send_message_result (item, Tb_hittest, 0, point.to_integer)
			index := cwin_send_message_result (item, 1093, 0, point.to_integer)
			create button.make
			if index >= 0 then
				cwin_send_message (item, Tb_getbutton, index, button.to_integer)
				Result := ev_children @ button.command_id
			end
		end

	internal_propagate_event (event_id, x_pos, y_pos: INTEGER; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Propagate the `event_id' to the good child.
		local
			tbutton: EV_TOOL_BAR_BUTTON_IMP
		do
			tbutton := find_item_at_position (x_pos, y_pos)
			if tbutton /= Void and then not tbutton.is_insensitive then
				tbutton.execute_command (event_id, ev_data)
			end
		end

feature {NONE} -- Implementation

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- We must not resize the height of the tool-bar.
		do
			bar.move_and_resize (a_x, a_y, a_width, height, repaint)
			reposition
		end

	resize (a_width, a_height: INTEGER) is
			-- We must not resize the hight of the tool-bar.
		do
			bar.resize (a_width, height)
			reposition
		end

	move (a_x, a_y: INTEGER) is
			-- We must move the bar before repositioning the tool-bar.
		do
			bar.move (a_x, a_y)
		end

feature {NONE} -- WEL Implementation

	wel_set_parent (a_parent: WEL_WINDOW) is
			-- Change the parent of the current window.
		do
			bar.set_parent (a_parent)
		end

	default_style: INTEGER is
			-- A new style to avoid a line on the top.
		do
			Result := {WEL_TOOL_BAR} Precursor + Tbstyle_flat
					--	+ Tbstyle_list
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_ncpaint then
				on_wm_ncpaint (wparam)
			end
		end

	on_wm_ncpaint (wparam: INTEGER) is
			-- Wm_paint message.
			-- A WEL_DC and WEL_PAINT_STRUCT are created and
			-- passed to the `on_paint' routine.
			-- To be more efficient when the windows does not
			-- need to paint something, this routine can be
			-- redefined to do nothing (eg. The object creation are
			-- useless).
		require
			exists: exists
		local
			dc: WEL_WINDOW_DC
			color: WEL_COLOR_REF
			pen: WEL_PEN
			int: INTEGER
		do
			create color.make_system (Color_menu)
			create pen.make_solid (2, color)
			create dc.make (Current)
			dc.get
				dc.select_pen (pen)
				int := width
				int := height
				dc.line (-1, 1, width, 1)
			dc.release
			disable_default_processing
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (1, keys, x_pos, y_pos)
			if has_command (Cmd_button_one_press) then
				execute_command (Cmd_button_one_press, ev_data)
			end
			internal_propagate_event (Cmd_button_one_press, x_pos, y_pos, ev_data)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (2, keys, x_pos, y_pos)
			if has_command (Cmd_button_two_press) then
				execute_command (Cmd_button_two_press, ev_data)
			end
			internal_propagate_event (Cmd_button_two_press, x_pos, y_pos, ev_data)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (2, keys, x_pos, y_pos)
			if has_command (Cmd_button_three_press) then
				execute_command (Cmd_button_three_press, ev_data)
			end
			internal_propagate_event (Cmd_button_three_press, x_pos, y_pos, ev_data)
			disable_default_processing
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (1, keys, x_pos, y_pos)
			if has_command (Cmd_button_one_release) then
				execute_command (Cmd_button_one_release, ev_data)
			end
			internal_propagate_event (Cmd_button_one_release, x_pos, y_pos, ev_data)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (2, keys, x_pos, y_pos)
			if has_command (Cmd_button_two_release) then
				execute_command (Cmd_button_two_release, ev_data)
			end
			internal_propagate_event (Cmd_button_two_release, x_pos, y_pos, ev_data)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (3, keys, x_pos, y_pos)
			if has_command (Cmd_button_three_release) then
				execute_command (Cmd_button_three_release, ev_data)
			end
			internal_propagate_event (Cmd_button_three_release, x_pos, y_pos, ev_data)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
			if has_capture then
				disable_default_processing
			end
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

end -- class EV_TOOL_BAR_IMP

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
