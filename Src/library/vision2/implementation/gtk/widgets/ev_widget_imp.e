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

	EV_GTK_TYPES_EXTERNALS
	EV_GTK_WIDGETS_EXTERNALS
	EV_GTK_GENERAL_EXTERNALS
	EV_GTK_CONTAINERS_EXTERNALS

        EV_GTK_CONSTANTS

feature {NONE} -- Initialization	

	widget_make (par: EV_CONTAINER) is
			-- This is a general initialization for 
			-- widgets and has to be called by all the 
			-- widgets with parents.
		local
			par_imp: EV_CONTAINER_IMP
			s: string
			ev_str: ANY
			con_id: INTEGER

		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			plateform_build (par_imp)
			--gtk_widget_show (widget)
			par_imp.add_child (Current)
			build

			-- connect gtk widget destroy signal to EV_WIDGET_IMP.destroy_signal_callback
			!!s.make (0)
			s := "destroy"
			ev_str ?= s.to_c
							
			-- Connect the signal
			con_id := c_gtk_signal_connect (widget, $ev_str, $destroy_signal_callback, 
						   $Current, Default_pointer, 
						   Default_pointer, Default_pointer,
						   Default_pointer, 0, False)
			check
				successfull_connect: con_id > 0
			end
		end

	plateform_build (par: EV_CONTAINER_I) is
			-- Plateform dependant initializations.
		do
			parent_imp ?= par
		end	

feature -- Access

	background_color: EV_COLOR_IMP is
			-- Color used for the background of the widget
		do
		end

	foreground_color: EV_COLOR_IMP is
			-- Color used for the foreground of the widget,
			-- usually the text.
		do
		end

	parent_imp: EV_CONTAINER_IMP
			-- Parent container of this widget. The same than
			-- parent but with a different type.
	
feature -- Status report

	destroyed: BOOLEAN is
			-- Is screen window destroyed?
                do
                        Result := widget = Default_pointer
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
			if not destroyed then
	                        gtk_widget_destroy (widget)
			end
			widget := Default_pointer
		end
	
	destroy_signal_callback is
			-- Called when the gtk widget is destroyed
			-- Remove reference to destroyed widget
		do
			widget := Default_pointer
			interface.remove_implementation
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

	set_expand (flag: BOOLEAN) is
			-- Make `flag' the new expand option.
		do
			expandable := flag
			if parent_imp /= Void then
				parent_imp.child_expand_changed (Current)
			end
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
			if parent_imp /= Void then
				parent_imp.child_horiresize_changed (Current)
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
			if parent_imp /= Void then
				parent_imp.child_vertresize_changed (Current)
			end
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			check
				not_yet_implemented: False
			end
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			check
				not_yet_implemented: False
			end
		end
	
feature -- Measurement
	
	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := c_gtk_widget_x (widget) 
		end

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := c_gtk_widget_y (widget) 
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
			gtk_widget_set_usize (widget, new_width, new_height) 
--			c_gtk_widget_set_size (widget, new_width, new_height)
		end

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
			--XX Temporary implementation.
                do
			gtk_widget_set_usize (widget, new_width, -1) 
--			c_gtk_widget_set_size (widget, new_width, height)
		end
	
	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do
			gtk_widget_set_usize (widget, -1, new_height) 
--			c_gtk_widget_set_size (widget, width, new_height)
		end

        set_minimum_size (min_width, min_height: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
			-- Set `minimum__height' to `min_height'.
		do
			gtk_widget_set_usize (widget, min_width, min_height)
		end

        set_minimum_width (value: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
		do
			gtk_widget_set_usize (widget, value, -1) 
		end
	
        set_minimum_height (value: INTEGER) is
                        -- Set `minimum__height' to `min_height'.
		do
			gtk_widget_set_usize (widget, -1, value) 
		end

	set_x (value: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		do
                        set_x_y (value, y)
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			gtk_widget_set_uposition (widget, new_x, new_y)
		end

	set_y (value: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		do
                    set_x_y (x, value)
		end

feature -- Event - command association
	
	add_button_press_command (mouse_button: INTEGER; 
				  command: EV_COMMAND; 
				  arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data ("button_press_event", command, arguments, ev_data, mouse_button, False)
		end
	
	
	add_button_release_command (mouse_button: INTEGER; 
				    command: EV_COMMAND; 
				    arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data ("button_release_event", command, arguments, ev_data, mouse_button, False)
		end
	
	add_double_click_command (mouse_button: INTEGER; 
				  command: EV_COMMAND; 
				  arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data ("button_press_event", command, arguments, ev_data, mouse_button, True)
		end		
	
	add_motion_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_MOTION_EVENT_DATA!ev_data.make
			add_command_with_event_data ("motion_notify_event", command, arguments, ev_data, 0, False)
		end
	
	add_destroy_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		do
			add_command ("destroy", command, arguments)
		end
	
	add_expose_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_EXPOSE_EVENT_DATA!ev_data.make
			add_command_with_event_data ("expose_event", command, arguments, ev_data, 0, False)
		end
	
	add_key_press_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command_with_event_data ("key_press_event", command, arguments, ev_data, 0, False)
		end
			
	add_key_release_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command_with_event_data ("key_release_event", command, arguments, ev_data, 0, False)
		end	
	
	add_enter_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make-- temporary, craeta a correct object here XX
			add_command_with_event_data ("enter_notify_event", command, arguments, ev_data, 0, False)
		end
	
	add_leave_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, craeta a correct object here XX
			add_command_with_event_data ("leave_notify_event", command, arguments, ev_data, 0, False)
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
			-- 'add_command' or 'add_command_with_event_data'
	
feature -- Postconditions

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- On gtk, when the widget is not shown, the result is 0
		do
			Result := c_gtk_widget_minimum_size_set (widget, new_width, new_height) or else
				(not shown and then (minimum_width = 0 and minimum_height = 0))
		end		

	position_set (new_x, new_y: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
 			-- On gtk, when the widget is not shown, the result is -1
		do
			Result := c_gtk_widget_position_set (widget, new_x, new_y) or else
				(not shown and then (x = - 1 and y = - 1))
		end

feature {NONE} -- Implementation

	add_command_with_event_data (event: STRING; command: EV_COMMAND; 
		     arguments: EV_ARGUMENTS; ev_data: EV_EVENT_DATA;
		     mouse_button: INTEGER; double_click: BOOLEAN) is
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
		local
			ev_str: ANY
			ev_d_imp: EV_EVENT_DATA_IMP
			con_id: INTEGER
                do				
			ev_d_imp ?= ev_data.implementation
			check
				valid_event_data_implementation: ev_d_imp /= Void
			end
			ev_str := event.to_c
			con_id := c_gtk_signal_connect (
				widget,
				$ev_str,
				command.execute_address,
				$command,
				$arguments,
				$ev_data,
				$ev_d_imp,
				ev_d_imp.initialize_address,
				mouse_button,
				double_click
			)
			check
				successfull_connect: con_id > 0
			end
			last_command_id := con_id
		end
        
	add_command (event: STRING; command: EV_COMMAND; 
		     arguments: EV_ARGUMENTS) is
			-- Add `command' at the end of the list of
			-- actions to be executed when the 'event'
			-- happens `arguments' will be passed to
			-- `command' whenever it is invoked as a
			-- callback. 'arguments' can be Void, which
			-- means that no arguments are passed to the
			-- command. 
			
		require		
			valid_event: event /= Void
			valid_command: command /= Void
		local
			ev_str: ANY
			con_id: INTEGER
                do
			ev_str:= event.to_c
			con_id := c_gtk_signal_connect (
				widget,
				$ev_str,
				command.execute_address,
				$command,
				$arguments,
				Default_pointer,
				Default_pointer,
				Default_pointer,
				0,
				False
			)
			check
				successfull_connect: con_id > 0		
			end
			last_command_id := con_id
		end

feature {EV_WIDGET_IMP} -- Implementation
	
	widget: POINTER
                        -- pointer to the C structure representing this widget

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
