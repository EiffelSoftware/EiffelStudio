indexing
	description: "EiffelVision widget, mswindows implementation."
	note: "The parent of a widget cannot be void, except for a%
		%  window. Therefore, each feature that call the parent%
		%  here need to be redefine by EV_WINDOW to check if%
		%  parent is `Void'"
	note: "The current class would be the equivalent of a wel_window%
		% Yet, it doesn't inherit from wel_window. Then, all the%
		% feature we used are defined as deferred. They will be%
		% implemented directly by the heirs thanks to inheritance%
		% from a heir of wel_window."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_IMP

inherit
	EV_WIDGET_I
		redefine
			set_vertical_resize,
			set_horizontal_resize
		end

	EV_SIZEABLE_IMP

	EV_EVENT_HANDLER_IMP

	EV_WIDGET_EVENTS_CONSTANTS_IMP

	EV_ACCELERATOR_HANDLER_IMP

	EV_PND_SOURCE_IMP

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEL_MK_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	widget_make (an_interface: EV_WIDGET) is
			-- Creation of the widget.
		do
			!! child_cell
			interface := an_interface
			set_default_options
			set_default_colors
			set_default_minimum_size
		end

feature -- Access

	cursor: EV_CURSOR is
			-- Cursor used currently on the widget.
		do
			if cursor_imp = Void then
--				!! Result.make
				Result := Void
			else
				Result ?= cursor_imp.interface
			end
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		do
			if background_color_imp /= Void then
				Result ?= background_color_imp.interface
			else
				Result := Void
			end
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
		do
			if foreground_color_imp /= Void then
				Result ?= foreground_color_imp.interface
			else
				Result := Void
			end
		end

	top_level_window: EV_WINDOW is
			-- Top level window that contains the current widget.
		do
			Result ?= top_level_window_imp.interface
		end

	default_parent: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- A default parent for creation of the widgets.
		once
			!! Result.make_top ("Eiffel Vision default parent window")
		ensure
			valid_parent: Result /= Void
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that has currently the focus.
		once
			!! Result.put (Void)
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- This cell contains the widget_imp that currently
			-- has the pointer of the mouse. As it is a once 
			-- feature, it is a shared data.
			-- it is used for the `mouse_enter' and `mouse_leave'
			-- events.
		once
			!! Result.put (Void)
		ensure
			result_exists: Result /= Void
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current widget destroyed ?
		do
			Result := not exists
		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
       	do
      			Result := not enabled
		end

	shown: BOOLEAN is
			-- Is the widget shown?
			-- Do not use the WEL feature because it can be shown and
			-- displayed when the parent is not shown.
		do
			Result := flag_set (style, Ws_visible)
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.remove_child (Current)
			end
			wel_destroy
		end

	show is
			-- Show the window
			-- Need to notify the parent.
		do
			show_window (item, Sw_show)
			if parent_imp /= Void then
				parent_imp.notify_change (1 + 2)
			end
		end

	hide is
			-- Hide the window
		do
			show_window (item, Sw_hide)
			if parent_imp /= Void then
				parent_imp.notify_change (1 + 2)
			end
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
			-- `flag'. This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.  Set it to
			-- sensitive mode otherwise.
		do
			if flag then
				disable
			else
				enable
			end
		end

	set_expand (flag: BOOLEAN) is
			-- Make `flag' the new expand option.
		do
			expandable := flag
			-- May be replaced by a child_expand changed.
			if parent_imp /= Void then
				parent_imp.notify_change (2+1)
			end
		end

-- 	set_horizontal_resize (flag: BOOLEAN) is
-- 			-- Adapt `resize_type' to `flag'.
-- 		do
-- 			if flag then
-- 				if vertical_resizable then
-- 					resize_type := 3
-- 				else
-- 					resize_type := 1
-- 				end
-- 			else
-- 				if vertical_resizable then
-- 					resize_type := 2
-- 				else
-- 					resize_type := 0
-- 				end				
-- 			end
-- 			if parent_imp /= Void then
-- 				parent_ask_resize (child_cell.width, child_cell.height)
-- 			end
-- 		end
-- 
-- 	set_vertical_resize (flag: BOOLEAN) is
-- 			-- Adapt `resize_type' to `flag'.
-- 		do
-- 			if flag then
-- 				if horizontal_resizable then
-- 					resize_type := 3
-- 			else
-- 					resize_type := 2
-- 				end
-- 			else
-- 				if horizontal_resizable then
-- 					resize_type := 1
-- 				else
-- 					resize_type := 0
-- 				end				
-- 			end
-- 			if parent_imp /= Void then
-- 				parent_ask_resize (child_cell.width, child_cell.height)
-- 			end
-- 		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		do
			internal_set_minimum_size (0, 0)
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		deferred
		end

	set_cursor (value: EV_CURSOR) is
			-- Make `value' the new cursor of the widget
		do
			if value /= Void then
				cursor_imp ?= value.implementation
				if cursor_on_widget.item = Current then
					cursor_imp.set
				end
			else
				cursor_imp := Void
			end
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
		end

feature -- Accelerators - command association

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
		do
			add_accel_command (acc, cmd, arg)
		end

	remove_accelerator_commands (acc: EV_ACCELERATOR) is
			-- Empty the list of commands to be executed when
			-- `acc' is completed by the user.
		do
			remove_accel_commands (acc)
		end

feature -- Event - command association

	add_button_press_command (mouse_button: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button no 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				add_command (Cmd_button_one_press, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_press, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_press, cmd, arg)
			else
				io.putstring ("This button do not exists")
			end
		end
	
	add_button_release_command (mouse_button: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button no 'mouse_button' is released.
		do
			inspect mouse_button
			when 1 then
				add_command (Cmd_button_one_release, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_release, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_release, cmd, arg)
			else
				io.putstring ("This button do not exists")
			end
		end

	add_double_click_command (mouse_button: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button no `mouse_button' is double clicked.
		do
			inspect mouse_button
			when 1 then
				add_command (Cmd_button_one_dblclk, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_dblclk, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_dblclk, cmd, arg)
			else
				io.putstring ("This button do not exists")
			end
		end

	add_motion_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the mouse move in the widget area.
			-- Be careful, in this motion-notify, windows considers that
			-- pushing and releasing a button is a move ???
			-- Need to be fix, it shouldn't be like this.
			-- Use the `WM_mousemove' windows event
		do
			add_command (Cmd_motion_notify, cmd, arg)
		end
	
	add_destroy_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is destroyed.
		do
			add_command (Cmd_destroy, cmd, arg)
		end

	add_key_press_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a key is pressed.
			-- Use the `Wm_keydown' and the `Wm_char' windows event.
			-- The result will be this givent by `Wm_char', because the 
			-- other event give only a virtual key number and not
			-- the character corresponding to the key.
		do
			add_command (Cmd_key_press, cmd, arg)
		end
	
	add_key_release_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a key is released.
			-- Use the `Wm_keyup' windows event.
		do
			add_command (Cmd_key_release, cmd, arg)
		end

	add_enter_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the mouse enters the widget.
		do
			add_command (Cmd_enter_notify, cmd, arg)
		end
	
	add_leave_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the mouse leaves the widget.
		do
			add_command (Cmd_leave_notify, cmd, arg)
		end

	add_get_focus_command  (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget get the focus.
		do
			add_command (Cmd_get_focus, cmd, arg)
		end

	add_lose_focus_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget lose the focus.
		do
			add_command (Cmd_lose_focus, cmd, arg)
		end

feature -- Event -- removing command association

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_press)
			when 2 then
				remove_command (Cmd_button_two_press)
			when 3 then
				remove_command (Cmd_button_three_press)
			else
				io.putstring ("This button do not exists")
			end
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_release)
			when 2 then
				remove_command (Cmd_button_two_release)
			when 3 then
				remove_command (Cmd_button_three_release)
			else
				io.putstring ("This button do not exists")
			end
		end

	remove_double_click_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is double clicked.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_dblclk)
			when 2 then
				remove_command (Cmd_button_two_dblclk)
			when 3 then
				remove_command (Cmd_button_three_dblclk)
			else
				io.putstring ("This button do not exists")
			end
		end

	remove_motion_notify_commands is
			-- Empty the list of commands to be executed when
			-- the mouse move.
		do
			remove_command (Cmd_motion_notify)
		end

	remove_destroy_commands is
			-- Empty the list of commands to be executed when
			-- the widget is destroyed.
		do
			remove_command (Cmd_destroy)
		end

	remove_key_press_commands is
			-- Empty the list of commands to be executed when
			-- a key is pressed on the keyboard while the widget has the
			-- focus.
		do
			remove_command (Cmd_key_press)
		end

	remove_key_release_commands is
			-- Empty the list of commands to be executed when
			-- a key is released on the keyboard while the widget has the
			-- focus.
		do
			remove_command (Cmd_key_release)
		end

	remove_enter_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse enter the widget.
		do
			remove_command (Cmd_enter_notify)
		end

	remove_leave_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse leave the widget.
		do
			remove_command (Cmd_leave_notify)
		end

	remove_get_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget get the focus.
		do
			remove_command (Cmd_get_focus)
		end

	remove_lose_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget lose the focus.
		do
			remove_command (Cmd_lose_focus)
		end

feature -- Implementation

	cursor_imp: EV_CURSOR_IMP
			-- Current cursor used on the widget.

	background_color_imp: EV_COLOR_IMP
			-- Color used for the background of the widget

	foreground_color_imp: EV_COLOR_IMP
			-- Color used for the foreground of the widget,
			-- usually the text.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this widget. The same than
			-- parent but with a different type.
		do
			if wel_parent = default_parent then
				Result := Void
			else
				Result ?= wel_parent
			end
		end

feature {NONE} -- Implementation, mouse button events

	get_button_data (button, keys, x_pos, y_pos: INTEGER): EV_BUTTON_EVENT_DATA is
			-- Give the event data with the values `x_pos',
			-- `y_pos' and `keys'
		local
			wid: EV_WIDGET
		do
			!! Result.make
			wid ?= interface
			Result.implementation.set_all (wid, x_pos, y_pos, button,
				flag_set (keys, Mk_shift), flag_set (keys, Mk_control),
				flag_set (keys, Mk_lbutton), flag_set (keys, Mk_mbutton),
				flag_set (keys, Mk_rbutton))
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_one_press) then
				data := get_button_data (1, keys, x_pos, y_pos)
				execute_command (Cmd_button_one_press, data)
			end
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_two_press) then
				data := get_button_data (2, keys, x_pos, y_pos)
				execute_command (Cmd_button_two_press, data)
			end
		end
	
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_three_press) then
				data := get_button_data (3, keys, x_pos, y_pos)
				execute_command (Cmd_button_three_press, data)
			end
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_one_release) then
				data := get_button_data (1, keys, x_pos, y_pos)
				execute_command (Cmd_button_one_release, data)
			end
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_two_release) then
				data := get_button_data (2, keys, x_pos, y_pos)
				execute_command (Cmd_button_two_release, data)
			end
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_three_release) then
				data := get_button_data (3, keys, x_pos, y_pos)
				execute_command (Cmd_button_three_release, data)
			end
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_one_dblclk) then
				data := get_button_data (1, keys, x_pos, y_pos)
				execute_command (Cmd_button_one_dblclk, data)
			end
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_two_dblclk) then
				data := get_button_data (2, keys, x_pos, y_pos)
				execute_command (Cmd_button_two_dblclk, data)
			end
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_BUTTON_EVENT_DATA
		do
			if has_command (Cmd_button_three_press) then
				data := get_button_data (3, keys, x_pos, y_pos)
				execute_command (Cmd_button_three_dblclk, data)
			end
		end

feature {NONE} -- Implementation, mouse move, enter and leave events

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_MOTION_EVENT_DATA
			wid: EV_WIDGET
		do
			if cursor_on_widget.item /= Current then
				if cursor_on_widget.item /= Void then
					cursor_on_widget.item.on_mouse_leave
				end
				cursor_on_widget.replace (Current)
				on_mouse_enter
			end
			if has_command (Cmd_motion_notify) then
				!! data.make
				wid ?= interface
				data.implementation.set_all (wid, x_pos, y_pos,
				flag_set (keys, Mk_shift), flag_set (keys, Mk_control),
				flag_set (keys, Mk_lbutton), flag_set (keys, Mk_mbutton),
				flag_set (keys, Mk_rbutton))
				execute_command (Cmd_motion_notify, data)
			end
		end

	on_mouse_enter is
		do
			execute_command (Cmd_enter_notify, Void)
		end

feature {EV_WIDGET_IMP} -- on_mouse_leave must be visible 

	on_mouse_leave is
		do
			execute_command (Cmd_leave_notify, Void)
		end

feature {NONE} -- Implementation, key events

	get_key_data (virtual_key, key_data: INTEGER): EV_KEY_EVENT_DATA is
			-- Give the event data with the values `x_pos',
			-- `y_pos' and `keys'
		local
			wid: EV_WIDGET
		do
			!! Result.make
			wid ?= interface
			Result.implementation.set_all (wid, virtual_key,
				key_to_string (key_data), key_down (Vk_shift),
				key_down (Vk_control), key_locked (Vk_capital),
				key_locked (Vk_numlock), key_locked (Vk_scroll))
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_KEY_EVENT_DATA
		do
			if has_command (Cmd_key_press) then
				data := get_key_data (virtual_key, key_data)
				execute_command (Cmd_key_press, data)
			end
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Executed when a key is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_KEY_EVENT_DATA
		do
			if has_command (Cmd_key_release) then
				data := get_key_data (virtual_key, key_data)
				execute_command (Cmd_key_release, data)
			end
		end

feature {NONE} -- Implementation, focus event

	on_set_focus is
			-- Wm_setfocus message
		do
			focus_on_widget.put (Current)
			execute_command (Cmd_get_focus, Void)
		end

	on_kill_focus is
			-- Wm_killfocus message
		do
			execute_command (Cmd_lose_focus, Void)
		end

feature {NONE} -- Implementation, cursor of the widget

	on_set_cursor (hit_code: INTEGER) is
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		do
			if cursor_imp /= Void then
				cursor_imp.set
				set_message_return_value (1)
				disable_default_processing
			end
		end

feature {WEL_DISPATCHER} -- Message dispatcher

	window_process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		require
			exists: exists
		do
			if msg = Wm_mousemove then
				on_mouse_move (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_setcursor then
				on_set_cursor (cwin_lo_word (lparam))
			elseif msg = Wm_size then
				on_size (wparam,
					cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = Wm_move then
				on_move (cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = Wm_lbuttondown then
				on_left_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wm_lbuttonup then
				on_left_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_lbuttondblclk then
				on_left_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_mbuttondown then
				on_middle_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_mbuttonup then
				on_middle_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_mbuttondblclk then
				on_middle_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_rbuttondown then
				on_right_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_rbuttonup then
				on_right_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_rbuttondblclk then
				on_right_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = Wm_timer then
				on_timer (wparam)
			elseif msg = Wm_setfocus then
				on_set_focus
			elseif msg = Wm_killfocus then
				on_kill_focus
			elseif msg = Wm_keydown then
				on_key_down (wparam, lparam)
			elseif msg = Wm_keyup then
				on_key_up (wparam, lparam)
			elseif msg = Wm_showwindow then
				on_wm_show_window (wparam, lparam)
			elseif msg = Wm_notify then
				on_wm_notify (wparam, lparam)
			elseif msg = Wm_destroy then
				on_wm_destroy
			else
				default_process_message (msg, wparam, lparam)
			end
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			Result := Current
		end

feature -- Deferred features

	set_capture is
			-- Set the mouse capture to the `Current' window.
			-- Once the window has captured the mouse, all
			-- mouse input is directed to this window, regardless
			-- of whether the cursor is over that window. Only
			-- one window can have the mouse capture at a time.
		deferred
		end

	release_capture is
			-- Release the mouse capture after a call
			-- to `set_capture'.
		deferred
		end

	top_level_window_imp: EV_UNTITLED_WINDOW_IMP is
			-- Top level window that contains the current widget.
		deferred
		end

	set_top_level_window_imp (a_window: EV_UNTITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		deferred
		end

	exists: BOOLEAN is
			-- Does the window exist?
		deferred
		end

	enabled: BOOLEAN is
			-- Is the window enabled for mouse and keyboard input?
		deferred
		end

	disable is
			-- Disable mouse and keyboard input
		deferred
		end
	enable is
			-- Enable mouse and keyboard input.
		deferred
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		deferred
		end

	on_move (x_pos, y_pos: INTEGER) is
			-- Wm_move message.
		deferred
		end

	on_wm_show_window (wparam, lparam: INTEGER) is
			-- Wm_showwindow message
		deferred
		end

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		deferred
		end

	on_wm_destroy is
			-- Wm_destroy message.
			-- The window must be unregistered
		deferred
		end

	on_timer (timer_id: INTEGER) is
			-- Wm_timer message.
		deferred
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		deferred
		end

	wel_parent: WEL_WINDOW is
		deferred
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
		deferred
		end

	default_style: INTEGER is
		deferred
		end

	style: INTEGER is
		deferred
		end

	set_style (a_style: INTEGER) is
		deferred
		end

	client_rect: WEL_RECT is
		deferred
		end

	invalidate is
		deferred
		end

	wel_destroy is
		deferred
		end	

	disable_default_processing is
		deferred
		end

	set_message_return_value (v: INTEGER) is
		deferred
		end

	item: POINTER is
		deferred
		end

feature {NONE} -- Feature that should be directly implemented by externals

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

feature -- Feature that should be directly implemented by externals

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

end -- class EV_WIDGET_IMP

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
