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

	EV_SIZEABLE_IMP

	EV_EVENT_HANDLER_IMP

	EV_WIDGET_EVENTS_CONSTANTS_IMP

	WEL_WM_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	widget_make (par: EV_CONTAINER) is
			-- This is a general initialization for 
			-- widgets and has to be called by all the 
			-- widgets with parents.
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			!! child_cell
			set_top_level_window_imp (par_imp.top_level_window_imp)
			par_imp.add_child (Current)
			plateform_build (par_imp)
			build
			par_imp.update_display
		end

	plateform_build (par: EV_CONTAINER_I) is
			-- Plateform dependant initializations.
		do
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

--	set_parent (par: EV_CONTAINER) is
--			-- Make `par' the new parent of the widget.
--			-- `par' can be Void then the parent is the screen.
--		do
--			parent_imp.remove_child (Current)
--			set_parent (par)
--			interface.widget_make (par)
--		end

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

	add_expose_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is exposed.
		do
			add_command (Cmd_expose, cmd, arg)
		end

	add_get_focus_command  (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget get the focus.
		do
			add_command (Cmd_get_focus, cmd, arg)
		end

	add_loose_focus_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
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

	remove_expose_commands is
			-- Empty the list of commands to be executed when
			-- the widget has to be redrawn because it was exposed from
			-- behind another widget.
		do
			remove_command (Cmd_expose)
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
			Result ?= parent
		end

	on_first_display is
			-- Called by the top_level window when it is displayed
			-- for the first time.
			-- Do nothing in general
		do
		end

feature {NONE} -- Implementation, mouse button events

	get_button_data (keys, x_pos, y_pos: INTEGER): EV_BUTTON_EVENT_DATA is
			-- Give the event data with the values `x_pos',
			-- `y_pos' and `keys'
		do
			!! Result.make
			Result.set_x (x_pos)
			Result.set_y (y_pos)
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_one_press, data)

		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_two_press, data)
		end
	
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_three_press, data)
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_one_release, data)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_two_release, data)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_three_release, data)
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_one_dblclk, data)
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_two_dblclk, data)
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
		local
			data: EV_BUTTON_EVENT_DATA
		do
			data := get_button_data (keys, x_pos, y_pos)
			execute_command (Cmd_button_three_dblclk, data)
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
		local
			data: EV_MOTION_EVENT_DATA
		do
			if cursor_on_widget.item /= Current then
				if cursor_on_widget.item /= Void then
					cursor_on_widget.item.on_mouse_leave
				end
				cursor_on_widget.replace (Current)
				on_mouse_enter
			end
			!! data.make
			data.set_x (x_pos)
			data.set_y (y_pos)
			execute_command (Cmd_motion_notify, data)
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

	on_char (character_code, key_data: INTEGER) is
		local
			data: EV_KEY_EVENT_DATA
		do
			!! data.make
			data.set_string (character_code.ascii_char.out)
			data.set_state (key_data)
			execute_command (Cmd_key_press, data)
		end

	on_key_up (virtual_key, key_data: INTEGER) is
		local
			data: EV_KEY_EVENT_DATA
		do
			!! data.make
			data.set_keyval (key_data)
			execute_command (Cmd_key_release, data)
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

feature {EV_WIDGET_IMP} -- WEL Implementation

	top_level_window_imp: WEL_WINDOW is
			-- Top level window that contains the current widget.
		deferred
		end

	set_top_level_window_imp (a_window: WEL_WINDOW) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		deferred
		end

feature -- Deferred features

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

	parent: WEL_WINDOW is
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
