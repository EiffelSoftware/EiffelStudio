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

	EV_PND_SOURCE_IMP

	EV_PND_TARGET_IMP

        EV_GTK_EXTERNALS
	EV_GTK_TYPES_EXTERNALS
	EV_GTK_WIDGETS_EXTERNALS
	EV_GTK_GENERAL_EXTERNALS
	EV_GTK_CONTAINERS_EXTERNALS
        EV_GTK_CONSTANTS

feature {NONE} -- Initialization	

	widget_make (an_interface: EV_WIDGET) is
			-- This is a general initialization for 
			-- widgets and has to be called by all the 
			-- widgets with parents.
		local
			s: string
			ev_str: ANY
			con_id: INTEGER
		do
			-- Set the interface
			interface := an_interface

			-- Initialize the datas
			set_default_options
			set_default_colors

			-- Set a default destroy event.
 			-- connect gtk widget destroy signal to EV_WIDGET_IMP.destroy_signal_callback
			!!s.make (0)
			s := "destroy"
			ev_str := s.to_c
							
			-- Connect the signal
			con_id := c_gtk_signal_connect (widget, $ev_str, $destroy_signal_callback, 
						   $Current, Default_pointer, 
						   Default_pointer, Default_pointer,
						   Default_pointer, 0, False)
			check
				successfull_connect: con_id > 0
			end
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		do
			-- To be implemented in EV_WIDGET_I
		end

feature -- Access

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		local
			r, g, b: INTEGER
		do
			c_gtk_widget_get_bg_color (widget, $r, $g, $b)
			!!Result.make_rgb (r, g, b)
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget,
			-- usually the text.
		local
			r, g, b: INTEGER
		do
			c_gtk_widget_get_fg_color (widget, $r, $g, $b)
			!!Result.make_rgb (r, g, b)
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

	set_focus is
			-- Set focus to Current
		do
				-- to be tested
			gtk_widget_grab_focus (widget)
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
				parent_imp.child_packing_changed (Current)
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
				parent_imp.child_packing_changed (Current)
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
				parent_imp.child_packing_changed (Current)
			end
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
			-- Before to remove the widget from the
			-- container, we increment the number of
			-- reference on the object otherwise gtk
			-- destroyed the object. And after having
			-- added the object to another container,
			-- we remove this supplementary reference.
		local
			par_imp: EV_CONTAINER_IMP
		do
			-- if the widget had a parent, we remove it:
			if parent_imp /= Void then
				if (box_widget = default_pointer) then
					-- the widget is not contained in a box.
					gtk_object_ref (widget)
				end
				parent_imp.remove_child (Current)
				parent_imp := Void
			end
			-- if the new parent is not Void:
			if par /= Void then
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				parent_imp ?= par_imp
				par_imp.add_child (Current)
				show
				if (box_widget = default_pointer) then
					-- the widget is not contained in a box.
					gtk_object_unref (widget)
				end
			end
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			c_gtk_widget_set_bg_color (widget, color.red, color.green, color.blue)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			c_gtk_widget_set_fg_color (widget, color.red, color.green, color.blue)
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
			c_gtk_widget_set_size (widget, new_width, new_height)
		end

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
			--XX Temporary implementation.
                do
			set_size (new_width, height)
		end
	
	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do
			set_size (width, new_height)
		end

        set_minimum_size (min_width, min_height: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
			-- Set `minimum_height' to `min_height'.
		do
			gtk_widget_set_usize (widget, min_width, min_height)
		end

        set_minimum_width (value: INTEGER) is
                        -- Set `minimum_width' to `min_width'.
		do
			gtk_widget_set_usize (widget, value, -2) 
		end
	
        set_minimum_height (value: INTEGER) is
                        -- Set `minimum_height' to `min_height'.
		do
			gtk_widget_set_usize (widget, -2, value) 
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

feature -- Accelerators - command association

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
		do
		end

	remove_accelerator_commands (acc: EV_ACCELERATOR) is
			-- Empty the list of commands to be executed when
			-- `acc' is completed by the user.
		do
		end

feature -- Event - command association
	
	add_button_press_command (mouse_button: INTEGER; cmd: EV_COMMAND; 
			arg: EV_ARGUMENT) is
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data ("button_press_event", cmd, arg, ev_data, mouse_button, False)
		end
	
	add_button_release_command (mouse_button: INTEGER; cmd: EV_COMMAND; 
				    arg: EV_ARGUMENT) is
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data ("button_release_event", cmd, arg, ev_data, mouse_button, False)
		end
	
	add_double_click_command (mouse_button: INTEGER; cmd: EV_COMMAND; 
				  arg: EV_ARGUMENT) is
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data ("button_press_event", cmd, arg, ev_data, mouse_button, True)
		end		
	
	add_motion_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_MOTION_EVENT_DATA!ev_data.make
			add_command_with_event_data ("motion_notify_event", cmd, arg, ev_data, 0, False)
		end
	
	add_destroy_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		do
			add_command ("destroy_event", cmd, arg)
		end
	
	add_expose_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_EXPOSE_EVENT_DATA!ev_data.make
			add_command_with_event_data ("expose_event", cmd, arg, ev_data, 0, False)
		end
	
	add_key_press_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command_with_event_data ("key_press_event", cmd, arg, ev_data, 0, False)
		end
			
	add_key_release_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command_with_event_data ("key_release_event", cmd, arg, ev_data, 0, False)
		end	
	
	add_enter_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_EVENT_DATA!ev_data.make-- temporary, create a correct object here XX
			add_command_with_event_data ("enter_notify_event", cmd, arg, ev_data, 0, False)
		end
	
	add_leave_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data ("leave_notify_event", cmd, arg, ev_data, 0, False)
		end

	add_get_focus_command  (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget get the focus.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data ("focus_in_event", cmd, arg, ev_data, 0, False)
		end

	add_lose_focus_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget lose the focus.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data ("focus_out_event", cmd, arg, ev_data, 0, False)
		end

feature -- Event -- removing command association

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		do
			inspect
				mouse_button
			when 1 then
				remove_commands (button_one_press_event_id)
			when 2 then
				remove_commands (button_two_press_event_id)
			when 3 then
				remove_commands (button_three_press_event_id)
			end
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		do
			inspect
				mouse_button
			when 1 then
				remove_commands (button_one_release_event_id)
			when 2 then
				remove_commands (button_two_release_event_id)
			when 3 then
				remove_commands (button_three_release_event_id)
			end
		end

	remove_double_click_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is double clicked.
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		do
			inspect
				mouse_button
			when 1 then
				remove_commands (button_one_double_click_event_id)
			when 2 then
				remove_commands (button_two_double_click_event_id)
			when 3 then
				remove_commands (button_three_double_click_event_id)
			end
		end

	remove_motion_notify_commands is
			-- Empty the list of commands to be executed when
			-- the mouse move.
		do
			remove_commands (motion_notify_event_id)
		end

	remove_destroy_commands is
			-- Empty the list of commands to be executed when
			-- the widget is destroyed.
		do
			remove_commands (destroy_event_id)
		end

	remove_expose_commands is
			-- Empty the list of commands to be executed when
			-- the widget has to be redrawn because it was exposed from
			-- behind another widget.
		do
			remove_commands (expose_event_id)
		end

	remove_key_press_commands is
			-- Empty the list of commands to be executed when
			-- a key is pressed on the keyboard while the widget has the
			-- focus.
		do
			
			remove_commands (key_press_event_id)
		end

	remove_key_release_commands is
			-- Empty the list of commands to be executed when
			-- a key is released on the keyboard while the widget has the
			-- focus.
		do
			remove_commands (key_release_event_id)
		end

	remove_enter_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse enter the widget.
		do
			remove_commands (enter_notify_event_id)
		end

	remove_leave_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse leave the widget.
		do
			remove_commands (leave_notify_event_id)
		end

	remove_get_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget get the focus.
		do
			remove_commands (focus_in_event_id)
		end

	remove_lose_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget lose the focus.
		do
			remove_commands (focus_out_event_id)
		end

feature -- Postconditions
	
	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		-- XXXXXXXXXXXXXXXXXXXXXX fix
		do
                       Result := (width = new_width or else width = minimum_width or else (not shown and width = 1)) and then
                                 (height = new_height or else height = minimum_height or else (not shown and height = 1))
                       Result := True
		end		

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

feature {EV_WIDGET_IMP} -- Implementation
	
	widget: POINTER
                        -- pointer to the C structure representing this widget
	box_widget: POINTER
                        -- pointer to the C structure representing the
			-- box in which the widget will be in.
			-- we need this vbox or hbox only to allow
			-- vertical or horizontal resizing options

	set_box_widget (box_wid: POINTER) is
			-- sets `box_widget' to `box_wid'
		do
			box_widget := box_wid
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
