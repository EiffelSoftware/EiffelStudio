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

	EV_PND_SOURCE_IMP

	EV_PND_TARGET_IMP

	WEL_WINDOWS_ROUTINES
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
		local
			ev_imp: EV_WINDOW_IMP
		do
			ev_imp ?= top_level_window_imp
			Result ?= ev_imp.interface
		end

	default_parent: CELL [WEL_FRAME_WINDOW] is
			-- A default parent for creation of the widgets.
			-- It is the main window because it exists as long
			-- as the application exists.
		local
			ww: WEL_FRAME_WINDOW
		once
			!! ww.make_top ("Eiffel Vision default parent window")
			ww.set_style (clear_flag (ww.style, Ws_visible))
			!! Result.put (ww)
		ensure
			valid_parent: Result.item /= Void
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current widget destroyed?
		do
			Result := not exists
		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
       	do
      		Result := not enabled
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
--				parent_imp.set_insensitive (False)
				parent_imp.remove_child (Current)
			end
			wel_destroy
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
		end

	set_horizontal_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		do
			if flag then
				if vertical_resizable then
					resize_type := 3
				else
					resize_type := 1
				end
			else
				if vertical_resizable then
					resize_type := 2
				else
					resize_type := 0
				end				
			end
			if parent_imp /= Void and then parent_imp.already_displayed then
				parent_ask_resize (child_cell.width, child_cell.height)
			end
		end

	set_vertical_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		do
			if flag then
				if horizontal_resizable then
					resize_type := 3
			else
					resize_type := 2
				end
			else
				if horizontal_resizable then
					resize_type := 1
				else
					resize_type := 0
				end				
			end
			if parent_imp /= Void and then parent_imp.already_displayed then
				parent_ask_resize (child_cell.width, child_cell.height)
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

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		do
			set_minimum_width (0)
			set_minimum_height (0)
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		deferred
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
			-- when the widget loose the focus.
		do
			add_command (Cmd_loose_focus, cmd, arg)
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

	remove_loose_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget loose the focus.
		do
			remove_command (Cmd_loose_focus)
		end

feature -- Implementation

	background_color_imp: EV_COLOR_IMP
			-- Color used for the background of the widget

	foreground_color_imp: EV_COLOR_IMP
			-- Color used for the foreground of the widget,
			-- usually the text.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this widget. The same than
			-- parent but with a different type.
		do
			if wel_parent = default_parent.item then
				Result := Void
			else
				Result ?= wel_parent
			end
		end

	on_first_display is
			-- Called by the top_level window when it is displayed
			-- for the first time.
		deferred
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
			execute_command (Cmd_get_focus, Void)
		end

	on_kill_focus is
			-- Wm_killfocus message
		do
			execute_command (Cmd_loose_focus, Void)
		end

feature -- Deferred features

	top_level_window_imp: WEL_WINDOW is
			-- Top level window that contains the current widget.
		deferred
		end

	set_top_level_window_imp (a_window: WEL_WINDOW) is
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
			-- Used by EV_SPLIT_AREA_IMP.
		deferred
		end

	invalidate is
			-- Used by EV_SPLIT_AREA_IMP
		deferred
		end

	wel_destroy is
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
