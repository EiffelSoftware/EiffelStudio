indexing
	description: "EiffelVision widget, the parent of all EV class. %
				% Mswindows implementation."
	note: "The parent of a widget cannot be void, except for a  %
		%  window. Therefore, each feature that call the parent %
		%  here need to be redefine by EV_WINDOW to check if    %
		%  parent is `Void'"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_WIDGET_IMP
        
inherit
	EV_WIDGET_I

	WEL_WM_CONSTANTS        

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current widget destroyed?
		do
			Result := not wel_window.exists
		end
		
	insensitive: BOOLEAN is
			-- Is current widget insensitive?
       	do
            		Result := not wel_window.enabled
		end

	shown: BOOLEAN is
		do
			Result := wel_window.shown
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.set_insensitive (False)
			end
			wel_window.destroy
		end
	
	hide is
			-- Make widget invisible on the screen.
		do
			wel_window.hide
		end
	
	show is
		do
			wel_window.show
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
				wel_window.disable
			else
				wel_window.enable
			end
		end

feature -- Measurement
	
	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := wel_window.x
		end
	
	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := wel_window.y
		end
	
	width: INTEGER is
			-- Width of the widget
		do
			Result := wel_window.width
		end
	
	height: INTEGER is 
			-- Height of the widget
		do
			Result := wel_window.height
		end

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
				wel_window.set_width (new_width.max (minimum_width))
				parent_imp.child_width_changed (width, Current)
		end
		
	set_height (new_height: INTEGER) is
			-- Make `new_height' the new `height' and notify the
			-- parent of the change.
		do
			wel_window.set_height (new_height.max (minimum_height))
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

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		do
			wel_window.set_x (new_x)
		end
		
	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			wel_window.move (new_x, new_y)
		end
	
	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		do
			wel_window.set_y (new_y)
		end
	

feature -- Event - command association

	add_button_press_command (mouse_button: INTEGER; command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when `button' is pressed.
			-- Use the `Wm_lbuttondown', `Wm_mbuttondown' and `Wm_rbuttondown'
			-- windows events.
		local
			data_type: EV_BUTTON_EVENT_DATA
		do
			!! data_type.make
			inspect mouse_button 
				when 1 then
					add_command (Wm_lbuttondown, command, arguments, data_type)
				when 2 then
					add_command (Wm_mbuttondown, command, arguments, data_type)
				when 3 then
					add_command (Wm_rbuttondown, command, arguments, data_type)
				else
					io.putstring ("This button do not exists")
			end
		end
	
	add_button_release_command (mouse_button: INTEGER; command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when `button' is release.
			-- Use the `Wm_lbuttonup', `Wm_mbuttonup' and `Wm_rbuttonup' 
			-- windows events.
		local
			data_type: EV_BUTTON_EVENT_DATA
		do
			!! data_type.make
			inspect mouse_button
				when 1 then
					add_command (Wm_lbuttonup, command, arguments, data_type)
				when 2 then
					add_command (Wm_mbuttonup, command, arguments, data_type)
				when 3 then
					add_command (Wm_rbuttonup, command, arguments, data_type)
				else
					io.putstring ("This button do not exists")
			end
		end

	add_double_click_command (mouse_button: INTEGER;
				  command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be executed
			-- when button no 'mouse_button' is double clicked.
		local
			data_type: EV_BUTTON_EVENT_DATA
		do
			!! data_type.make
			inspect mouse_button
				when 1 then
					add_command (Wm_lbuttondblclk, command, arguments, data_type)
				when 2 then
					add_command (Wm_mbuttondblclk, command, arguments, data_type)
				when 3 then
					add_command (Wm_rbuttondblclk, command, arguments, data_type)
				else
					io.putstring ("This button do not exists")
			end
		end

	add_motion_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a motion notify command to the widget.
			-- Be careful, in this motion-notify, windows considers that
			-- pushing and releasing a button is a move ???
			-- Need to be fix, it shouldn't be like this.
			-- Use the `WM_mousemove' windows event
		local
			data_type: EV_MOTION_EVENT_DATA
		do
			!! data_type.make
			add_command (Wm_mousemove, command, arguments, data_type)
		end
	
	add_destroy_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the widget is destroyed.
		local
			data_type: EV_MOTION_EVENT_DATA
		do
			!! data_type.make
			add_command (Wm_destroy, command, arguments, data_type)
		end

	add_key_press_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a key press command to the widget.
			-- Use the `Wm_keydown' and the `Wm_char' windows event.
			-- The result will be this givent by `Wm_char', because the 
			-- other event give only a virtual key number and not
			-- the character corresponding to the key.
			-- We do not use add_command, because we have to put two command
			-- on the same `ev_wel_command'.
		local
			data_type: EV_KEY_EVENT_DATA
		do
			!! data_type.make
			add_command (Wm_char, command, arguments, data_type)
		end
	
	add_key_release_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a key release to the widget.
			-- Use the `Wm_keyup' windows event.
		local
			data_type: EV_KEY_EVENT_DATA
		do
			!! data_type.make
			add_command (Wm_keyup, command, arguments, data_type)
		end

	add_enter_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the mouse enter the widget.
			-- Use the `' windows event
		local
			data_type: EV_EVENT_DATA
		do
			!! data_type.make
				-- We must not use add_command here.
			add_command (Wm_setcursor, command, arguments, data_type)
		end
	
	add_leave_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the mouse leave the widget
			-- Use the `' windows event
		local
			data_type: EV_EVENT_DATA
		do
			!! data_type.make
				-- We must not use add_command here
			add_command (Wm_mousemove, command, arguments, data_type)
		end

	add_expose_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		do
		end

	remove_command (command_id: INTEGER) is
			-- Remove the command associated with
			-- 'command_id' from the list of actions for
			-- this context. If there is no command
			-- associated with 'command_id', nothing
			-- happens.
		do	
			-- Penser a faire un truc dans le genre
			-- si necessaire.	
			-- wel_window.disable_commands
		end

	add_command (messages: INTEGER; command: EV_COMMAND; arguments: EV_ARGUMENTS 
		     	ev_data: EV_EVENT_DATA) is
			-- Add a command to a widget that means create an ev_wel_command
			-- and put it to the wel_window of the widget.
			-- For the meaning of the message, see wel_wm_message.
			-- The argument can be `Void', in this case, there is 
			-- no argument passed to the command.
		require
			command_not_void: command /= Void
		local
			com: EV_COMMAND
			adapted_command: EV_WEL_COMMAND
		do
			if command.event_data /= Void then
				com := deep_clone (command)
			else	
				com := command
			end
			com.set_event_data (ev_data)
			!! adapted_command.make (com, arguments)
			wel_window.put_command (adapted_command, messages, arguments)
			wel_window.enable_commands
		end
	
	last_command_id: INTEGER
			-- Id of the last command added by feature
			-- 'add_command'

feature -- Implementation

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
			wel_window.move_and_resize (a_x, a_y, minimum_width.max(a_width), minimum_height.max (a_height), True)
		end

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			wel_window.resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end
	
feature {EV_WIDGET_IMP} -- Implementation
	
	wel_window: WEL_WINDOW is
			-- Actual WEL component
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
