indexing

	description: 
		"EiffelVision widget, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
        EV_WIDGET_IMP
        
inherit
        EV_WIDGET_I
        
        EV_GTK_EXTERNALS
        EV_GTK_CONSTANTS
	

feature -- Status report

	destroyed: BOOLEAN is
			-- Is screen window destroyed?
                do
                        Result := widget = default_pointer
 		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
                do
                        Result := not c_gtk_widget_sensitive (widget)
		end

	shown: BOOLEAN is
			-- Is current widget visible?
                do
                        Result := c_gtk_widget_visible (widget)
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation.
                do
                        gtk_widget_destroy (widget)
			widget := Default_pointer
		end

	hide is
			-- Make widget invisible on the screen.
                do
                        gtk_widget_hide (widget)
		end
	
	show is
			-- Make widget visible on the screen. (default)
		do
			gtk_widget_show (widget)
			c_gtk_widget_show_children (widget)
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
			gtk_widget_set_sensitive (widget, not flag)
		end
	
feature -- Measurement
	
	x: INTEGER is
			-- Horizontal position relative to parent
		do
                        check
                                not_yet_implemented: False
                        end
		end

	y: INTEGER is
			-- Vertical position relative to parent
		do
                        check
                                not_yet_implemented: False
                        end
		end	

	width: INTEGER is
			-- Width of widget
		do
			Result := c_gtk_widget_width (widget)
		end

	height: INTEGER is
			-- Height of widget
                do
                        Result := c_gtk_widget_height (widget)
		end
	
        maximum_width: INTEGER is
                        -- Maximum width that application wishes widget
                        -- instance to have
 		do
                        check
                                not_yet_implemented: False
                        end
		end	
	
	maximum_height: INTEGER is
                        -- Maximum height that application wishes widget
                        -- instance to have
 		do
                        check
                                not_yet_implemented: False
                        end
		end	

	minimum_width: INTEGER is
			-- Minimum width of widget
		do
                        Result := c_gtk_widget_minimum_width (widget)
		end	

	minimum_height: INTEGER is
			-- Minimum height of widget
		do
                        Result := c_gtk_widget_minimum_height (widget)
		end	
	
feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
                do
                        c_gtk_widget_set_size (widget, new_width, new_height)
		end

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
                do
                        c_gtk_widget_set_size (widget, new_width, -1)
		end
	
	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do
                        c_gtk_widget_set_size (widget, -1, new_height)
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

        set_minimum_size (min_width, min_height: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
			-- Set `minimum__height' to `min_height'.
		do
			gtk_widget_set_usize (widget, min_width, min_height) 
		end

        set_minimum_width (min_width: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
		do
			gtk_widget_set_usize (widget, min_width, -1) 
		end
	
        set_minimum_height (min_height: INTEGER) is
                        -- Set `minimum__height' to `min_height'.
		do
			gtk_widget_set_usize (widget, -1, min_height) 
		end

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		do
                        check
                                not_yet_implemented: False
                        end
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			gtk_widget_set_uposition (widget, new_x, new_y)
		end

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		do
                        check
                                not_yet_implemented: False
                        end
		end

feature -- Event - command association
	
	add_button_press_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command ("button_press_event", command, arguments, ev_data)
		end
	
	
	add_button_release_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command ("button_release_event", command, arguments, ev_data)
		end
			
	add_motion_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_MOTION_EVENT_DATA!ev_data.make
			add_command ("motion_notify_event", command, arguments, ev_data)
		end
	
	add_delete_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make-- temporary, craeta a correct object here XX
			add_command ("delete_event", command, arguments, ev_data)
		end
	
	add_key_press_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command ("key_press_event", command, arguments, ev_data)
		end
			
	add_key_release_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command ("key_press_event", command, arguments, ev_data)
		end	
	
	add_enter_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make-- temporary, craeta a correct object here XX
			add_command ("enter_notify_event", command, arguments, ev_data)
		end
	
	add_leave_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, craeta a correct object here XX
			add_command ("leave_notify_event", command, arguments, ev_data)
		end
	


	remove_command (command_id: INTEGER) is
			-- Remove the command associated with
			-- 'command_id' from the list of actions for
			-- this context. If there is no command
			-- associated with 'command_id', nothing
			-- happens.
		do		
			gtk_signal_disconnect (widget, command_id)
		end
	
	last_command_id: INTEGER
			-- Id of the last command added by feature
			-- 'add_command'
	

feature {NONE} -- Implementation

	add_command (event: STRING; command: EV_COMMAND; 
		     arguments: EV_ARGUMENTS; ev_data: EV_EVENT_DATA) is
			-- Add `command' at the end of the list of
			-- actions to be executed when the 'event'
			-- happens `arguments' will be passed to
			-- `command' whenever it is invoked as a
			-- callback. 'arguments' can be Void, which
			-- means that no arguments are passed to the
			-- command. 'ev_data' is an empty object 
			-- which will be filled by gtk (in C library) 
			-- when the event happens.
		require		
			valid_event: event /= Void
			valid_command: command /= Void
			valid_event_data: ev_data /= Void
		local
			a: ANY
			arg: EV_ARGUMENTS
			ev_d_imp: EV_EVENT_DATA_IMP
                do
			-- To avoid sharing argument for different
			-- commands. (We should share everything else 
			-- though, FIX THIS!)
			
			if arguments /= Void then
				if arguments.data /= Void then
					arg := deep_clone (arguments)
				else
					arg := arguments
				end
				arg.set_data (ev_data)
			end
				
			ev_d_imp ?= ev_data.implementation
			check
				valid_event_data_implementation: ev_d_imp /= Void
			end
			a := event.to_c
			-- check if to use gtk signals or x events
			last_command_id := 
				c_gtk_signal_connect (widget,
						      $a,
						      command.execute_address,
						      $command,
						      $arg,
						      $ev_d_imp,
						      ev_d_imp.initialize_address)
		end
        
	
feature {EV_WIDGET_IMP} -- Implementation
	
	widget: POINTER
                        -- pointer to the C structure representing this widget





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
