indexing
	description: "Objects that ..."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_WINDOW_IMP

inherit
	EV_UNTITLED_WINDOW_I

	EV_SINGLE_CHILD_CONTAINER_IMP
		export
			{NONE} set_expand
			{NONE} set_parent
		undefine
			set_width,
			set_height,
			set_default_colors
		redefine
			destroy,
			set_parent,
			set_size,
			client_height,
			set_minimum_width,
			set_minimum_height,
			parent_ask_resize,
			dimensions_set,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			internal_set_minimum_width,
			internal_set_minimum_height
		end

	WEL_FRAME_WINDOW
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy
		undefine
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_menu_command,
			background_brush,
			on_draw_item,
			on_accelerator_command,
			on_set_cursor,
			window_process_message,
			on_color_control
		redefine
			default_ex_style,
			default_style,
			set_menu,
			on_size,
			on_get_min_max_info,
			on_destroy,
			on_show,
			on_move,
			closeable,
			default_process_message
--			on_wm_vscroll,
--			on_wm_hscroll
		end

	WEL_MA_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_with_owner,
	make_root

feature {NONE} -- Initialization

	make is
			-- Create a window. Window does not have any
			-- parents
		do
			make_top ("")
		end

	make_with_owner (par: EV_UNTITLED_WINDOW) is
			-- Create a window with a parent.
			-- For a window, we cannot set the parent after or it does a 
		local
			ww: WEL_FRAME_WINDOW
		do
			ww ?= par.implementation
			check
				valid_owner: ww /= Void
			end
			make_child (ww, "")
		end

feature -- Access

	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := client_rect.height
			if status_bar /= Void then
				Result := (Result - status_bar.height).max (0)
			end
		end

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have

	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		do
			Result := text
       	end

	widget_group: EV_WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		do
			check
                not_yet_implemented: False
	        end
		end 

	top_level_window_imp: like Current is
			-- Top level window that contains the current widget.
		do
			Result := Current
		end

	status_bar: EV_STATUS_BAR_IMP
			-- Status bar of the window.

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			application.item.remove_root_window (Current)
			if parent_imp /= Void then
				parent_imp.set_insensitive (False)
			end
			wel_destroy
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
		do
			internal_set_minimum_width (system_metrics.window_minimum_width)
			internal_set_minimum_height (system_metrics.window_minimum_height)
			set_maximum_width (system_metrics.screen_width)
			set_maximum_height (system_metrics.screen_height)
			if parent_imp /= Void then
				notify_change (1 + 2)
			end
		end

--	set_horizontal_resize (flag: BOOLEAN) is
--			-- Allow the window to be verticaly resized.
--		do
--			{EV_CONTAINER_IMP} Precursor (flag)
--			if flag then
--				min_track.set_x (width)
--				max_track.set_x (width)
--			else
--				min_track.set_x (minimum_width)
--				max_track.set_x (maximum_width)
--			end
--		end

--	set_vertical_resize (flag: BOOLEAN) is
--			-- Allow the window to be horizontaly resized.
--		do
--			{EV_CONTAINER_IMP} Precursor (flag)
--			if flag then
--				min_track.set_y (height)
--				max_track.set_y (height)
--			else
--				min_track.set_y (maximum_height)
--				max_track.set_y (maximum_height)
--			end
--		end

	forbid_resize is
			-- Forbid the resize of the window.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := clear_flag (new_style, Ws_maximizebox)
			new_style := clear_flag (new_style, Ws_minimizebox)
			new_style := clear_flag (new_style, Ws_sizebox)
			set_style (new_style)
			if shown then
				hide
				show
			end
		end

	allow_resize is
			-- Allow the resize of the window.
		local
			new_style: INTEGER
		do
			new_style := style
			new_style := set_flag (new_style, Ws_maximizebox)
			new_style := set_flag (new_style, Ws_minimizebox)
			new_style := set_flag (new_style, Ws_sizebox)
			set_style (new_style)
			if shown then
				hide
				show
			end
		end

	set_modal is
			-- Make the window modal
		do
			set_capture
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			ww: WEL_WINDOW
		do
			if par /= Void then
				ww ?= par.implementation
				wel_set_parent (ww)
			else
				wel_set_parent (Void)
			end
		end

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and don't notify the parent.
		do
			resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- If the Current size is smaller, the size
			-- change.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor (value)
			if value > width then
				resize (value, height)
			end
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- If the Current size is smaller, the size
			-- change.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor (value)
			if value > height then
				resize (width, value)
			end
		end

	set_maximum_width (value: INTEGER) is
			-- Make `value' the new maximum width.
			-- If the Current size is larger, the size
			-- change.
		do
			maximum_width := value
			if value < width then
				resize (value, height)
			end
		end

	set_maximum_height (value: INTEGER) is
			-- Make `value' the new maximum height.
			-- If the Current size is larger, the size
			-- change.
		do
			maximum_height := value
			if value < height then
				resize (width, value)
			end
		end

	set_title (txt: STRING) is
			-- Make `txt' the title of the window.            
		do
			set_text (txt)
		end

	set_widget_group (widget: EV_WIDGET) is
			-- Make Current part of the group of `widget'.
		do
			check
				not_yet_implemented: False
			end
		end

	set_status_bar (a_bar: EV_STATUS_BAR_IMP) is
			-- Make `a_bar' the new status bar of the window.
		do
			status_bar := a_bar
			update_minimum_size
		end

	remove_status_bar is
			-- Remove the current status bar of the window.
		do
			status_bar := Void
		end

feature -- Event - command association

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is closed.
		do
			add_command (Cmd_close, cmd, arg)
		end

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the window is resized.
		do
			add_command (Cmd_size, cmd, arg)
		end

	add_move_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is resized.
		do
			add_command (Cmd_move, cmd, arg)
		end

feature -- Event -- removing command association

	remove_close_commands is
			-- Empty the list of commands to be executed
			-- when the window is closed.
		do
			remove_command (Cmd_close)
		end

	remove_resize_commands is
			-- Empty the list of commands to be executed
			-- when the window is resized.
		do
			remove_command (Cmd_size)
		end

	remove_move_commands is
			-- Empty the list of commands to be executed
			-- when the widget is resized.
		do
			remove_command (Cmd_move)
		end

feature -- Assertion features

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- we must redefine it because windows do not
			-- allow as little windows as we want.
		do
			Result := (width = new_width or else width = minimum_width.max (system_metrics.window_minimum_width)) and then
				  (height = new_height or else height = minimum_height.max (system_metrics.window_minimum_height))
		end

feature {EV_STATIC_MENU_BAR_IMP} -- Implementation

	set_menu (a_menu: WEL_MENU) is
			-- Set `menu' with `a_menu'.
		do
			{WEL_FRAME_WINDOW} Precursor (a_menu)
			update_minimum_size
		end

feature {NONE} -- Implementation

	update_minimum_size is
			-- Update the minimum_size of the window according
			-- to the component inside the window.
		local
			value: INTEGER
		do
			-- For the width first
			value := 2 * window_frame_width
			if child /= Void then
				value := value + child.minimum_width
			end
			internal_set_minimum_width (value)

			-- For the height then
			value := title_bar_height + window_border_height + 2 * window_frame_height
			if child /= Void then
				value := value + child.minimum_height
			end
			if has_menu then
				value := value + menu_bar_height
			end
			if status_bar /= Void then
				value := value + status_bar.height
			end
			internal_set_minimum_height (value)
		end

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- If the Current size is smaller, the size
			-- change.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor (value)
			if value > width then
				resize (value, height)
			end
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- If the Current size is smaller, the size
			-- change.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor (value)
			if value > height then
				resize (width, value)
			end
		end

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		do
			update_minimum_size
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		do
			update_minimum_size
		end

feature {NONE} -- Inapplicable

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- When the parent asks the resize, it's not
			-- necessary to send him back the information
			-- Can be called but do nothing.
		do
			check
				Inapplicable: True
			end
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			check
				Inapplicable: True
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		-- Set with the option `Ws_clipchildren' to avoid flashing.
		do
			Result := Ws_popup + Ws_overlapped + Ws_dlgframe
					+ Ws_clipchildren + Ws_clipsiblings
		end

	default_ex_style: INTEGER is
		do
			Result := Ws_ex_controlparent
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_mouseactivate then
				on_wm_mouseactivate (wparam, lparam)
			end
		end

	on_show is
			-- When the window receive the on_show message,
			-- it resizes the window at the size of the child.
			-- And it send the message to the child because wel
			-- don't
		do
			if child /= Void and (bit_set (internal_changes, 1) or bit_set (internal_changes, 2)) then
				internal_resize (x, y, (child.minimum_width + 2*system_metrics.window_frame_width).max (minimum_width),
						(child.minimum_height + 2 * system_metrics.window_frame_height).max (minimum_height))
				internal_changes := set_bit (internal_changes, 1, False)
				internal_changes := set_bit (internal_changes, 2, False)
			else
				move_and_resize (x, y, minimum_width, minimum_height, True)
			end
			if has_menu then
				draw_menu
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the window is resized.
			-- Resize the child if it exists.
		do
			execute_command (Cmd_size, Void)
			if child /= Void then
				child.parent_ask_resize (client_width, client_height)
			end
			if status_bar /= Void then
				status_bar.reposition
			end
		end

   	on_move (x_pos, y_pos: INTEGER) is
   			-- Wm_move message.
   			-- This message is sent after a window has been moved.
   			-- `x_pos' specifies the x-coordinate of the upper-left
   			-- corner of the client area of the window.
   			-- `y_pos' specifies the y-coordinate of the upper-left
   			-- corner of the client area of the window.
   		do
			execute_command (Cmd_move, Void)
 		end

-- 	on_wm_vscroll (wparam, lparam: INTEGER) is
-- 			-- Wm_vscroll message.
-- 		local
-- 			gauge: EV_GAUGE_IMP
-- 			p: POINTER
-- 		do
-- 			p := cwin_get_wm_vscroll_hwnd (wparam, lparam)
-- 			if p /= default_pointer then
-- 				-- The message comes from a gauge
-- 				gauge ?= windows.item (p)
-- 				if gauge /= Void then
-- 					check
-- 						gauge_exists: gauge.exists
-- 					end
-- 					gauge.execute_command (Cmd_gauge, Void)
-- 				end
-- 			else
-- 				-- The message comes from a window scroll bar
-- 				on_vertical_scroll (cwin_get_wm_vscroll_code (wparam, lparam),
-- 					cwin_get_wm_vscroll_pos (wparam, lparam))
-- 			end
-- 		end
-- 
-- 	on_wm_hscroll (wparam, lparam: INTEGER) is
-- 			-- Wm_hscroll message.
-- 		local
-- 			gauge: EV_GAUGE_IMP
-- 			p: POINTER
-- 		do
-- 			p := cwin_get_wm_hscroll_hwnd (wparam, lparam)
-- 			if p /= default_pointer then
-- 				-- The message comes from a gauge
-- 				gauge ?= windows.item (p)
-- 				if gauge /= Void then
-- 					check
-- 						gauge_exists: gauge.exists
-- 					end
-- 					gauge.execute_command (Cmd_gauge, Void)
-- 				end
-- 			else
-- 				-- The message comes from a window scroll bar
-- 				on_horizontal_scroll (cwin_get_wm_hscroll_code (wparam, lparam),
-- 					cwin_get_wm_hscroll_pos (wparam, lparam))
-- 			end
-- 		end

	closeable: BOOLEAN is
			-- Can the user close the window?
			-- Yes by default.
		do
			if (command_list = Void) or else 
					(command_list @ Cmd_close) = Void then
				Result := True
				interface.remove_implementation
			else
				execute_command (Cmd_close, Void)
				Result := False
			end
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		local
			min_track, max_track: WEL_POINT
		do
			inspect resize_type
			when 0 then
				!! min_track.make (width, height)
				!! max_track.make (width, height)
			when 1 then
				!! min_track.make (internal_minimum_width, height)
				!! max_track.make (maximum_width, height)
			when 2 then
				!! min_track.make (width, internal_minimum_height)
				!! max_track.make (width, maximum_height)
			when 3 then
				!! min_track.make (internal_minimum_width, internal_minimum_height)
				!! max_track.make (maximum_width, maximum_height)
			end
			min_max_info.set_min_track_size (min_track)
			min_max_info.set_max_track_size (max_track)
		end

	on_destroy is
			-- Called when the window is destroy.
			-- Set the parent sensitive if it exists.
		do
			if parent_imp /= Void and not parent_imp.destroyed and then parent_imp.insensitive then
				parent_imp.set_insensitive (False)
			end
		end

	system_metrics: WEL_SYSTEM_METRICS is
			-- System metrics to query things like
			-- window_frame_width
		once
			!!Result
		end

	on_wm_mouseactivate (wparam, lparam: INTEGER) is
			-- The window have been activated thanks to the click of a window.
			-- If it was a right click, we do not raise the window to the front of
			-- the screen because of the pick-and-drop.
		local
			msg: INTEGER
		do
			msg := cwin_hi_word (lparam)
			if msg = Wm_rbuttondown then
				set_message_return_value (Ma_noactivate)
			end
		end

feature {NONE} -- Feature that should be directly implemented by externals

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

end -- class EV_UNTITLED_WINDOW_IMP

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

