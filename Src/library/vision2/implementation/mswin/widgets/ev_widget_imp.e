indexing
	description: 
		"EiffelVision widget, the parent of all EV class. %
		% Mswindows implementation."
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
		do
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
		do
			Result := wel_window.x
		end
	
	y: INTEGER is
		do
			Result := wel_window.y
		end
	
	width: INTEGER is
		do
			Result := wel_window.width
		end
	
	height: INTEGER is 
		do
			Result := wel_window.height
		end
	
	maximum_height: INTEGER is
                        -- Maximum height that application wishes widget
                        -- instance to have
 		do
                        check
                                not_yet_implemented: False
                        end
		end	

	maximum_width: INTEGER is
                        -- Maximum width that application wishes widget
                        -- instance to have
 		do
                        check
                                not_yet_implemented: False
                        end
		end	


	minimum_width: INTEGER 
			-- Minimum width of widget, `0' by default
		

	minimum_height: INTEGER
			-- Minimum height of widget, `0' by default
		
	
feature -- Resizing

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		do
			wel_window.resize (minimum_width.max(new_width), minimum_height.max (new_height))
		end


	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and notify the parent of 
			-- the resize which must be bigger than the
			-- minimal size or nothing happens
		local
			temp_width, temp_height: INTEGER
		do
			temp_width := minimum_width.max(new_width)
			temp_height := minimum_height.max (new_height)
			wel_window.resize (temp_width, temp_height)
			if parent_imp /= Void then
				parent_imp.child_has_resized (temp_width, temp_height, Current)
			end
		end

	
	set_width (new_width :INTEGER) is
		local
			temp_width: INTEGER
		do
			temp_width := minimum_width.max(new_width)
			wel_window.set_width (temp_width)
			if parent_imp /= Void then
				parent_imp.child_has_resized (temp_width, height, Current)
			end
		end

		
	set_height (new_height: INTEGER) is
		local
			temp_height: INTEGER
		do
			temp_height := minimum_height.max(new_height)
			wel_window.set_height (temp_height)
			if parent_imp /= Void then
				parent_imp.child_has_resized (width, temp_height, Current)
			end
		end
	
	set_maximum_height (max_height: INTEGER) is
                        -- Set `maximum_height' to `max_height'.
		do
                        check
                                not_yet_implemented: False
                        end		
		end

    set_maximum_width (max_width: INTEGER) is
                        -- Set `maximum_width' to `max_width'.
		do
                        check
                                not_yet_implemented: False
                        end		
		end

    set_minimum_height (min_height: INTEGER) is
                        -- Set `minimum__height' to `min_height'.
		do
			minimum_height := min_height
			if parent_imp /= Void then
				parent_imp.child_minheight_changed (min_height)
			end
		end

    set_minimum_width (min_width: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
		do
			minimum_width := min_width
			if parent_imp /= Void then
				parent_imp.child_minwidth_changed (min_width)
			end

		end

	set_minimum_size (min_width, min_height: INTEGER) is
			-- set `minimum_width' to `min_width'
			-- set `minimum_height' to `min_height'
		do
			set_minimum_width (min_width)
			set_minimum_height (min_height)
		end


	set_x (new_x: INTEGER) is
		do
			wel_window.set_x (new_x)
		end
		
	set_x_y (new_x: INTEGER; new_y: INTEGER) is
		do
			wel_window.move (new_x, new_y)
		end
	
	set_y (new_y: INTEGER) is
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
				  command: EV_COMMAND; 
				  arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to 
			-- be executed when button no 'mouse_button' 
			-- is double clicked
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
	
	add_delete_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		do
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
			add_command (Wm_notify, command, arguments, data_type)
		end
	
	add_leave_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add a command that responds when the mouse leave the widget
			-- Use the `' windows event
		local
			data_type: EV_EVENT_DATA
		do
			!! data_type.make
			add_command (Wm_killfocus, command, arguments, data_type)
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
	

feature {EV_CONTAINER_IMP} -- Implementation
	
	set_parent_imp (p: EV_CONTAINER_IMP) is
		do
			parent_imp := p
		end

feature {NONE} -- Implementation
	
	parent_imp: EV_CONTAINER_IMP
			-- Container parent of this widget
	
feature {EV_WIDGET_IMP} -- Implementation
	
	wel_window: WEL_WINDOW is
			-- Actual WEL component
	        deferred
		end
	
end

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
