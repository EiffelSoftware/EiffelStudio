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

        EV_GTK_EXTERNALS
	EV_GTK_TYPES_EXTERNALS
	EV_GTK_WIDGETS_EXTERNALS
	EV_GTK_GENERAL_EXTERNALS
	EV_GTK_CONTAINERS_EXTERNALS
        EV_GTK_CONSTANTS
	EV_GDK_EXTERNALS

	EV_GTK_ANY_IMP
		rename
			handle as widget
		end

	EV_GTK_OBJECT_MANAGER_IMP

feature {NONE} -- Initialization	

	widget_make (an_interface: EV_WIDGET) is
			-- This is a general initialization for 
			-- widgets and has to be called by all the 
			-- widgets with parents.
		do
			-- Set the interface
			interface := an_interface

			-- Initialize the datas
			set_default_options
			set_default_colors

			-- initialize the object handling.
			initialize_object_handling
		end

	initialize_object_handling is
			-- Register the widget in the hash table.
			-- And Connect `destroy' event to `destroy_signal_callback'
			-- function so that the Eiffel object is destroyed when the
			-- Gtk object is destroyed.
		local
			s: string
			ev_str: ANY
--			con_id: INTEGER
		do
			register_object (Current)

			-- Set a default destroy event.
 			-- connect gtk widget destroy signal to EV_WIDGET_IMP.destroy_signal_callback
			create s.make (0)
			s := "destroy"
			ev_str := s.to_c
							
			-- Connect the signal
			destroy_con_id := c_gtk_signal_connect (widget, $ev_str, $destroy_signal_callback, 
						   $Current, Default_pointer, 
						   Default_pointer, Default_pointer,
						   Default_pointer, 0, False, Default_pointer)
			check
				successfull_connect: destroy_con_id > 0
			end
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		do
			-- To be implemented in EV_WIDGET_I
		end

feature -- Access

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			Result := Current
		end

	cursor: EV_CURSOR is
			-- Cursor used currently on the widget.
		do
			if cursor_imp = Void then
				Result := Void
			else
				Result ?= cursor_imp.interface
			end
		end

	cursor_imp: EV_CURSOR_IMP

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		local
			r, g, b: INTEGER
		do
			c_gtk_widget_get_bg_color (widget, $r, $g, $b)
			create Result.make_rgb (r, g, b)
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget,
			-- usually the text.
		local
			r, g, b: INTEGER
		do
			c_gtk_widget_get_fg_color (widget, $r, $g, $b)
			create Result.make_rgb (r, g, b)
		end

	parent_imp: EV_CONTAINER_IMP
			-- Parent container of this widget. The same than
			-- parent but with a different type.
	
	resize_type: INTEGER
			-- How the widget resize itself in the cell
			-- 0 : no resizing, the widget move
			-- 1 : only the width changes
			-- 2 : only the height changes
			-- 3 : both width and height change

feature -- Status report

--	destroyed: BOOLEAN is
--			-- Is screen window destroyed?
-- 		do
--			Result := widget = Default_pointer
--		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
                do
                        Result := not c_gtk_widget_sensitive (widget)
		end

	shown: BOOLEAN is
			-- Is current widget visible in the parent?
                do
                        Result := c_gtk_widget_visible (widget)
		end

	displayed: BOOLEAN is
			-- Is current widget visible on the screen?
                do
                        Result := c_gtk_widget_displayed (widget)
		end

	horizontal_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget
		do
			Result := (resize_type = 1) or (resize_type = 3)	
		end

	vertical_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget
		do
			Result := (resize_type = 2) or (resize_type = 3)	
		end

	has_focus: BOOLEAN is
			-- Does the Current widget has the focus.
		do
			--| FIXME: alex 09221999. Create a feature
			--| in EV_WIDGET 'can_have_focus'. The postcondition
			--| of feature 'set_focus' will be
			--| 'can_have_focus (widget) implies has_focus (widget)'
			if c_gtk_widget_can_focus (widget) then
				Result := c_gtk_widget_has_focus (widget)
			else
				Result := True
			end
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation.
		local
			s: ANY
b: BOOLEAN
		do
			if not destroyed then
				if destroy_con_id > 0 then
					gtk_signal_disconnect (widget, destroy_con_id)
				end
				if gtk_is_widget (widget) then
					gtk_widget_destroy (widget)
				end
			end
			widget := Default_pointer
		end
	
	destroy_signal_callback is
			-- Called when the gtk widget is destroyed
			-- Remove reference to destroyed widget
		local
			obj: HASH_TABLE [EV_GTK_ANY_IMP, POINTER]
		do
			obj := objects
			unregister_object (Current)
			widget := Default_pointer
			interface.remove_implementation
		end

	hide is
			-- Make widget invisible on the screen.
                do
			if vbox_widget /= default_pointer then
				-- The widget is in `vbox_widget'.
	                        gtk_widget_hide (vbox_widget)
				gtk_widget_hide (widget)
			else
	                        gtk_widget_hide (widget)
			end
		end
	
	show is
			-- Make widget visible on the screen. (default)
		do
			if vbox_widget /= default_pointer then
				gtk_widget_show (widget)
				gtk_widget_show (vbox_widget)
			else
				gtk_widget_show (widget)
			end
		end

	set_focus is
			-- Set focus to Current
		do
			c_gtk_widget_grab_focus (widget)
		end

	set_capture is
			-- Grab all the mouse and keyboard events.
		do
			gtk_grab_add (widget)
		end

	gtk_grab_add (wid: POINTER) is
		external
			"C (GtkWidget *) | <gtk/gtk.h>"
		end

	release_capture is
			-- Ungrab all the mouse and keyboard events.
		do
			gtk_grab_remove (widget)
		end

	gtk_grab_remove (wid: POINTER) is
		external
			"C (GtkWidget *) | <gtk/gtk.h>"
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

--	set_expand (flag: BOOLEAN) is
--			-- Make `flag' the new expand option.
--		do
--			expandable := flag
--			if parent_imp /= Void then
--				parent_imp.child_packing_changed (Current)
--			end
--		end

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
				if (vbox_widget = default_pointer) then
					-- the widget is not contained in the boxes
					-- `vbox_widget' and `hbox_widget'.
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
				if (vbox_widget = default_pointer) then
					-- the widget is not contained in the boxes
					-- `vbox_widget' and `hbox_widget'.
					gtk_object_unref (widget)
				end
			end
		end

	set_cursor (cur: EV_CURSOR) is
			-- Make `cur' the cursor of the widget.
		local
			cursor_pointer: POINTER
		do
			if cur /= Void then
				cursor_imp ?= cur.implementation
				check
					cursor_implementation_exists: cursor_imp /= Void
				end
				cursor_pointer := cursor_imp.cursor
			else
				cursor_imp := Void
			end
					-- Disconnect previous callback if any
			if cursor_signal_tag /= 0 then
				gtk_signal_disconnect (widget, cursor_signal_tag)
			end 
				-- Call C function that initializes callback
				-- that sets the cursor on mouse entry to prevent
				-- Gtk assertion violation when setting a widgets
				-- cursor when its root window isn't shown
			
			

			cursor_signal_tag := c_gtk_widget_set_cursor (widget, cursor_pointer)
		end

	c_gtk_widget_set_cursor (wid: POINTER; cur: POINTER): INTEGER is
		external
			"C (GtkWidget *, GdkCursor *): EIF_INTEGER | %"gtk_eiffel.h%""
		end

	cursor_signal_tag: INTEGER
		-- Tag returned from Gtk used to disconnect `enter-notify' signal

	
	
	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'.
		do
			c_gtk_widget_set_bg_color (widget, color.red, color.green, color.blue)
			if (vbox_widget /= default_pointer and hbox_widget /= default_pointer) then
				c_gtk_widget_set_bg_color (vbox_widget, color.red, color.green, color.blue)
				c_gtk_widget_set_bg_color (hbox_widget, color.red, color.green, color.blue)
			end
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			c_gtk_widget_set_fg_color (widget, color.red, color.green, color.blue)
			if (vbox_widget /= default_pointer and hbox_widget /= default_pointer) then
				c_gtk_widget_set_fg_color (vbox_widget, color.red, color.green, color.blue)
				c_gtk_widget_set_fg_color (hbox_widget, color.red, color.green, color.blue)
			end
		end
	
feature -- Measurement
	
	x: INTEGER is
			-- Horizontal position relative to parent.
		do
			Result := c_gtk_widget_x (widget) 
		end

	y: INTEGER is
			-- Vertical position relative to parent.
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

 	string_from_accelerator (accel: EV_ACCELERATOR): STRING is
 			-- Return a string which correspond to the value of the accelerator.
 			-- Ex: for shift: True, alt: False, control: True, code: an_integer
 			--		The result would be "shift_control_'an_integer'"
 		require
 			accel_exists: accel /= Void
 		do
 			Result := ""
 			if accel.shift_key then
 				Result.append ("shift_")
 			end
 			if accel.control_key then
 				Result.append ("alt_")
 			end
 			if accel.shift_key then
 				Result.append ("control_")
 			end
 			Result.append (accel.keycode.out)
 		ensure
 			correct_result: not Result.is_equal ("")
 		end

	add_accelerator_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when `acc' is completed by the user.
 		local
 			signal_name: STRING
 			a: ANY
 			i: INTEGER
 		do
 			-- First we create a new signal:
 			-- 1. the signal name depending on the accelerator values.
 			signal_name := string_from_accelerator (acc)
 			a := signal_name.to_c
 			-- 2. Add the signal to the widget.
 			-- Before adding the signal to the GtkWidget,
 			-- test if the accelerator already exists or not otherwise
 			-- there is no need to re-register it. (Done in the c funtion).
 			i := c_gtk_object_class_user_signal_new (widget, $a)
 			check
 				new_signal_added: i > 0
 			end
 
 			-- Second, We create an accelerator for the widget.
 			c_gtk_widget_add_accelerator (widget, $a, acc.keycode ,acc.shift_key, acc.control_key, acc.alt_key)
 
 			-- Third, we connect the command to the signal.
 			i := c_gtk_signal_connect (widget,
 					$a,
 					cmd.execute_address,
 					$cmd,
 					$arg,
 					Default_pointer,
 					Default_pointer,
 					Default_pointer,
 					0,
 					False,
 					Default_pointer)
 			check
 				callback_connected: i > 0
 			end
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
			add_command_with_event_data (widget, "button_press_event", cmd, arg, ev_data, mouse_button, False, default_pointer)
		end
	
	add_button_release_command (mouse_button: INTEGER; cmd: EV_COMMAND; 
				    arg: EV_ARGUMENT) is
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "button_release_event", cmd, arg, ev_data, mouse_button, False, default_pointer)
		end
	
	add_double_click_command (mouse_button: INTEGER; cmd: EV_COMMAND; 
				  arg: EV_ARGUMENT) is
		require else
			mouse_button_ok: (mouse_button >=1 and mouse_button<=3)
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_BUTTON_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "button_press_event", cmd, arg, ev_data, mouse_button, True, default_pointer)
		end		
	
	add_motion_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_MOTION_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "motion_notify_event", cmd, arg, ev_data, 0, False, default_pointer)
		end
	
	add_destroy_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		do
			add_command (widget, "destroy", cmd, arg, default_pointer)
		end
	
	add_expose_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_EXPOSE_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "expose_event", cmd, arg, ev_data, 0, False, default_pointer)
		end
	
	add_key_press_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "key_press_event", cmd, arg, ev_data, 0, False, default_pointer)
		end
			
	add_key_release_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_KEY_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "key_release_event", cmd, arg, ev_data, 0, False, default_pointer)
		end	
	
	add_enter_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA
		do
			!EV_EVENT_DATA!ev_data.make-- temporary, create a correct object here XX
			add_command_with_event_data (widget, "enter_notify_event", cmd, arg, ev_data, 0, False, default_pointer)
		end
	
	add_leave_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data (widget, "leave_notify_event", cmd, arg, ev_data, 0, False, default_pointer)
		end

	add_get_focus_command  (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget get the focus.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data (widget, "focus_in_event", cmd, arg, ev_data, 0, False, default_pointer)
		end

	add_lose_focus_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget lose the focus.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_EVENT_DATA!ev_data.make  -- temporary, create a correct object here XX
			add_command_with_event_data (widget, "focus_out_event", cmd, arg, ev_data, 0, False, default_pointer)
		end

--	add_display_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed
--			-- when the widget has been displayed on the screen.
--		local
--			ev_data: EV_EVENT_DATA		
--		do
--			add_command (widget, "show", cmd, arg, default_pointer)
--		end

--	add_hide_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add `cmd' to the list of commands to be executed
--			-- when the widget has been hidden.
--		local
--			ev_data: EV_EVENT_DATA		
--		do
--			add_command (widget, "hide", cmd, arg, default_pointer)
--		end

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
				remove_commands (widget, button_one_press_event_id)
			when 2 then
				remove_commands (widget, button_two_press_event_id)
			when 3 then
				remove_commands (widget, button_three_press_event_id)
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
				remove_commands (widget, button_one_release_event_id)
			when 2 then
				remove_commands (widget, button_two_release_event_id)
			when 3 then
				remove_commands (widget, button_three_release_event_id)
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
				remove_commands (widget, button_one_double_click_event_id)
			when 2 then
				remove_commands (widget, button_two_double_click_event_id)
			when 3 then
				remove_commands (widget, button_three_double_click_event_id)
			end
		end

	remove_motion_notify_commands is
			-- Empty the list of commands to be executed when
			-- the mouse move.
		do
			remove_commands (widget, motion_notify_event_id)
		end

	remove_destroy_commands is
			-- Empty the list of commands to be executed when
			-- the widget is destroyed.
		do
			remove_commands (widget, destroy_id)
		end

	remove_expose_commands is
			-- Empty the list of commands to be executed when
			-- the widget has to be redrawn because it was exposed from
			-- behind another widget.
		do
			remove_commands (widget, expose_event_id)
		end

	remove_key_press_commands is
			-- Empty the list of commands to be executed when
			-- a key is pressed on the keyboard while the widget has the
			-- focus.
		do
			
			remove_commands (widget, key_press_event_id)
		end

	remove_key_release_commands is
			-- Empty the list of commands to be executed when
			-- a key is released on the keyboard while the widget has the
			-- focus.
		do
			remove_commands (widget, key_release_event_id)
		end

	remove_enter_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse enter the widget.
		do
			remove_commands (widget, enter_notify_event_id)
		end

	remove_leave_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse leave the widget.
		do
			remove_commands (widget, leave_notify_event_id)
		end

	remove_get_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget get the focus.
		do
			remove_commands (widget, focus_in_event_id)
		end

	remove_lose_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget lose the focus.
		do
			remove_commands (widget, focus_out_event_id)
		end

--	remove_display_commands is
--			-- Empty the list of commands to be executed when
--			-- the widget lose the focus.
--		do
--			remove_commands (widget, show_id)
--		end

--	remove_hide_commands is
--			-- Empty the list of commands to be executed when
--			-- the widget lose the focus.
--		do
--			remove_commands (widget, hide_id)
--		end

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

feature -- Implementation
	
--	widget: POINTER
                        -- pointer to the C structure representing this widget
			--| no more needed because it is now inherited from EV_GTK_ANY_IMP.		
	vbox_widget: POINTER
                        -- pointer to the C structure representing the
			-- vbox in which the widget will be in.
			-- we need this vbox only to allow
			-- vertical resizing options

	hbox_widget: POINTER
                        -- pointer to the C structure representing the
			-- hbox in which the widget will be in.
			-- we need this hbox only to allow
			-- vertical resizing options

	set_vbox_widget (box_wid: POINTER) is
			-- sets `vbox_widget' to `box_wid'
		do
			vbox_widget := box_wid
		end

	set_hbox_widget (box_wid: POINTER) is
			-- sets `hbox_widget' to `box_wid'
		do
			hbox_widget := box_wid
		end

	destroy_con_id: INTEGER
			-- 
end -- class EV_WIDGET_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
