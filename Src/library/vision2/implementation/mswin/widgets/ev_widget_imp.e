indexing
	description: "EiffelVision widget, the parent of all EV class. %
				% Mswindows implementation."
	note: "The parent of a widget cannot be void, except for a  %
		%  window. Therefore, each feature that call the parent %
		%  here need to be redefine by EV_WINDOW to check if    %
		%  parent is `Void'"
	note: "We undefine all the features of WEL_WINDOW because all%
		% the Eiffel Vision objects will inherit from a final    %
		% wel_object, this will implement all the deferred features."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WIDGET_IMP
        
inherit
	EV_WIDGET_I

	EV_EVENT_HANDLER_IMP

	EV_WIDGET_EVENTS_CONSTANTS_IMP

	WEL_WM_CONSTANTS        

	WEL_WINDOW
		rename
				-- We rename the features that have different signature in
				-- Vision and in WEL.
			parent as wel_parent
		undefine
				-- We undefine all the features the are redefine later by
				-- Wel or Vision objects.
			destroy,
			destroy_item,
			width,
			height,
			minimal_width,
			minimal_height,
			maximal_width,
			maximal_height,
			move_and_resize,
			move,
			set_text,
			text_length,
			default_ex_style,
			set_default_window_procedure,
			call_default_window_procedure,
			process_message,
			remove_command,
			main_args,
			on_show,
			on_size,
			on_destroy,
			on_wm_destroy,
			on_set_cursor,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		redefine
			set_width,
			set_height
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

--	shown: BOOLEAN is
--		do
--			Result := shown
--		end

feature -- Status setting

--	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
--		deferred
--			if parent_imp /= Void then
--				parent_imp.set_insensitive (False)
--			end
--			{WEL_WINDOW} Precursor
--		end
	
--	hide is
--			-- Make widget invisible on the screen.
--		do
--			hide
--		end
	
--	show is
--		do
--			wel_window.show
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

feature -- Measurement
	
--	x: INTEGER is
			-- Horizontal position relative to parent
--		do
--			Result := wel_window.x
--		end
	
--	y: INTEGER is
			-- Vertical position relative to parent
--		do
--			Result := wel_window.y
--		end
	
--	width: INTEGER is
			-- Width of the widget
--		do
--			Result := wel_window.width
--		end
	
--	height: INTEGER is 
			-- Height of the widget
--		do
--			Result := wel_window.height
--		end

	minimum_width: INTEGER 
			-- Minimum width of widget, `0' by default
	
	minimum_height: INTEGER
			-- Minimum height of widget, `0' by default
	
feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and notify the parent of 
			-- the resize which must be bigger than the
			-- minimal size or nothing happens
		do
			set_width (new_width)
			set_height (new_height)
--			wel_window.resize (minimum_width.max(new_width), minimum_height.max (new_height))
--			notify_size_to_parent
		end
	
	set_width (new_width :INTEGER) is
			-- Make `new_width' the new width and notify the parent
			-- of the change.
		do
			{WEL_WINDOW} Precursor (new_width.max (minimum_width))
			parent_imp.child_width_changed (width, Current)
		end
		
	set_height (new_height: INTEGER) is
			-- Make `new_height' the new `height' and notify the
			-- parent of the change.
		do
			{WEL_WINDOW} Precursor (new_height.max (minimum_height))
			parent_imp.child_height_changed (new_height, Current)
		end
	
    set_minimum_height (min_height: INTEGER) is
			-- Make `min_height' the new `minimum__height' and
			-- notify the parent of the change. If this new minimum is
			-- bigger than the Current `height', the widget is resized.
		do
			minimum_height := min_height
			parent_imp.child_minheight_changed (min_height)
			if min_height > height then
				parent_ask_resize (width, min_height)
			end
		end

    set_minimum_width (min_width: INTEGER) is
			-- Make `min_width' the new `minimum_width' and
			-- notify the parent of the change. If this new minimum is
			-- bigger than the Current `width', the widget is resized.
		do
			minimum_width := min_width
			parent_imp.child_minwidth_changed (min_width)
			if min_width > width then
				parent_ask_resize (min_width, height)
			end
		end

--	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
--		do
--			wel_window.set_x (new_x)
--		end
		
	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			move (new_x, new_y)
		end
	
--	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
--		do
--			wel_window.set_y (new_y)
--		end
	

feature -- Event - command association

	add_button_press_command (mouse_button: INTEGER; a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when `button' is pressed.
			-- Use the `Wm_lbuttondown', `Wm_mbuttondown' and `Wm_rbuttondown'
			-- windows events.
		do
			inspect mouse_button 
				when 1 then
					add_command (Cmd_button_one_press, a_command, arguments)
				when 2 then
					add_command (Cmd_button_two_press, a_command, arguments)
				when 3 then
					add_command (Cmd_button_three_press, a_command, arguments)
				else
					io.putstring ("This button do not exists")
			end
		end
	
	add_button_release_command (mouse_button: INTEGER; a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when `button' is release.
			-- Use the `Wm_lbuttonup', `Wm_mbuttonup' and `Wm_rbuttonup' 
			-- windows events.
		do
			inspect mouse_button
				when 1 then
					add_command (Cmd_button_one_release, a_command, arguments)
				when 2 then
					add_command (Cmd_button_two_release, a_command, arguments)
				when 3 then
					add_command (Cmd_button_three_release, a_command, arguments)
				else
					io.putstring ("This button do not exists")
			end
		end

	add_double_click_command (mouse_button: INTEGER;
				  a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be executed
			-- when button no 'mouse_button' is double clicked.
		do
			inspect mouse_button
				when 1 then
					add_command (Cmd_button_one_dblclk, a_command, arguments)
				when 2 then
					add_command (Cmd_button_two_dblclk, a_command, arguments)
				when 3 then
					add_command (Cmd_button_three_dblclk, a_command, arguments)
				else
					io.putstring ("This button do not exists")
			end
		end

	add_motion_notify_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a motion notify command to the widget.
			-- Be careful, in this motion-notify, windows considers that
			-- pushing and releasing a button is a move ???
			-- Need to be fix, it shouldn't be like this.
			-- Use the `WM_mousemove' windows event
		do
			add_command (Cmd_motion_notify, a_command, arguments)
		end
	
	add_destroy_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the widget is destroyed.
		do
			add_command (Cmd_destroy, a_command, arguments)
		end

	add_key_press_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a key press command to the widget.
			-- Use the `Wm_keydown' and the `Wm_char' windows event.
			-- The result will be this givent by `Wm_char', because the 
			-- other event give only a virtual key number and not
			-- the character corresponding to the key.
			-- We do not use add_command, because we have to put two command
			-- on the same `ev_wel_command'.
		do
			add_command (Cmd_key_press, a_command, arguments)
		end
	
	add_key_release_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a key release to the widget.
			-- Use the `Wm_keyup' windows event.
		do
			add_command (Cmd_key_release, a_command, arguments)
		end

	add_enter_notify_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the mouse enter the widget.
			-- Use the `' windows event
		do
			add_command (Cmd_enter_notify, a_command, arguments)
		end
	
	add_leave_notify_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the mouse leave the widget
			-- Use the `' windows event
		do
			add_command (Cmd_leave_notify, a_command, arguments)
		end

	add_expose_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the widget is 
			-- exposed after having been hidden by the user or 
			-- behind a window.
		do
			add_command (Cmd_expose, a_command, arguments)
		end

	last_command_id: INTEGER
			-- Id of the last command added by feature
			-- 'add_command'

feature -- Implementation

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this widget. The same than
			-- parent but with a different type.
		do 
			Result ?= wel_parent
		ensure then
			parent_set: parent /= Void implies Result /= Void
		end

	test_and_set_parent (par: EV_CONTAINER) is
			-- Set the parent of the Current widget.
			-- Nothing to do on windows. The wel_parent
			-- is enough.
		do
		end

	set_minimum_size (min_width, min_height: INTEGER) is
			-- set `minimum_width' to `min_width'
			-- set `minimum_height' to `min_height'
		do
			set_minimum_width (min_width)
			set_minimum_height (min_height)
		end

	set_move_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Move and resize the widget. Only the parent can call this feature
			-- because it doesn't notify the parent of the change.
		do
			move_and_resize (a_x, a_y, minimum_width.max(a_width), minimum_height.max (a_height), True)
		end

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end

feature {NONE} -- Implementation for events handling

	initialize_list is
			-- Create the `command_list' and the `arguments_list'.
		do
				!! command_list.make (1, 18)
				!! argument_list.make (1, 18)
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
