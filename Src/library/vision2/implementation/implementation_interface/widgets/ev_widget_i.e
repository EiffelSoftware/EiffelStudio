indexing
	description: "General widget implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_WIDGET_I 


feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		deferred
		end
	
feature {EV_WIDGET} -- Initialization
		
	build is
			-- Called after the creation of the widget and after
			-- having stored the parent and the current object
			-- as the child of the parent. Many widget redefine
			-- this feature to give their size to the parent that
			-- adapts itself.
		do
			set_automatic_resize (True)
			set_automatic_position (False)
		end

feature -- Access

	interface: EV_WIDGET
			-- The interface of the current implementation
			-- Used to give the parent of a widget to the user
			-- and in the implementation of some widgets
	
	parent: EV_WIDGET is
			-- The parent of the Current widget
			-- If the widget is an EV_WINDOW without parent,
			-- this attribute will be `Void'
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			else
				Result := Void
			end
		end

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this widget. The same than
			-- parent but with a different type.
		deferred
		end

	automatic_resize: BOOLEAN
			-- Is the widget resized automatically when
			-- the parent resize ?  In this case,
			-- automatic_position has no effect.
			-- True by default.

	automatic_position: BOOLEAN
			-- Does the widget take a new position when
			-- the parent resize ?  
			-- (If it does, its size doesn't changed).  
			-- False by default.

feature -- Status Report

	destroyed: BOOLEAN is			
			-- Is Current widget destroyed?
		deferred
		end
	
	insensitive: BOOLEAN is
			-- Is current widget insensitive?
		require
			exists: not destroyed
		deferred
		end

	shown: BOOLEAN is
			-- Is current widget visible?
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	destroy is
			-- Destroy screen widget implementation.
		deferred
		ensure
			destroyed: destroyed
		end

	hide is
			-- Make widget invisible on the screen.
		require
			exists: not destroyed
		deferred
		ensure
			not_shown: not shown
		end
	
	show is
			-- Make widget visible on the screen.
		require
			exist: not destroyed
		deferred
		ensure
			shown: shown		
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
		require
			exists: not destroyed
		deferred
		ensure
			flag = insensitive
		end

	set_automatic_resize (state: BOOLEAN) is
			-- Make `state' the new `automatic_resize'.
		require
			exists: not destroyed
		do
			automatic_resize := state
		ensure
			automatic_resize_set: automatic_resize = state
		end

	set_automatic_position (state: BOOLEAN) is
			-- Make `state' the new `automatic_position'.
		require
			exists: not destroyed
		do
			automatic_position := state
		ensure
			automatic_position_set: automatic_position = state
		end


feature -- Measurement
	
	x: INTEGER is
			-- Horizontal position relative to parent
		require
			exists: not destroyed		
		deferred
		end

	y: INTEGER is
			-- Vertical position relative to parent
		require
			exists: not destroyed
		deferred
		end	

	width: INTEGER is
			-- Width of widget
		require
			exists: not destroyed
		deferred
		ensure
			Positive_width: Result >= 0
		end

	height: INTEGER is
			-- Height of widget
		require
			exists: not destroyed
		deferred
		ensure
			Positive_height: Result >= 0
		end
	
		minimum_width: INTEGER is
			-- Minimum width of widget
		require
			exists: not destroyed
		deferred
		ensure
			Positive_width: Result >= 0
		end

	minimum_height: INTEGER is
			-- Minimum height of widget
		require
			exists: not destroyed
		deferred
		ensure
			Positive_height: Result >= 0
		end

feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Make `new_width' the new `width'
			-- and `new_height' the new `height'.
		require
			exists: not destroyed
			Positive_width: new_width >= 0
			Positive_height_: new_height >= 0
		deferred
		ensure
			dimensions_set: dimensions_set (new_width, new_height)		
		end

	set_width (new_width :INTEGER) is
			-- Make `new_width' the new width.
		require
			exists: not destroyed
			Positive_width: new_width >= 0
		deferred
		ensure
			dimensions_set: dimensions_set (new_width, height)
		end
	
	set_height (new_height: INTEGER) is
			-- Make `new_height' the new.
		require
			exists: not destroyed
			Positive_height: new_height >= 0
		deferred
		ensure					
			dimensions_set: dimensions_set (width, new_height)
		end

	set_minimum_size (min_width, min_height: INTEGER) is
			-- Make `min_width' the new `minimum_width'
			-- and `min_height' the new `minimum_height'.
		 require
			exists: not destroyed
			a_min_large_enough: min_width >= 0
			height_large_enough: min_height >= 0
		deferred
		ensure
			min_width = min_width
			min_height = min_height
		end  
        
	set_minimum_width (min_width: INTEGER) is
			-- Make `min_width' the new `minimum_width'.
		require
			exists: not destroyed
			a_min_large_enough: min_width >= 0
		deferred
		ensure
			min_width = min_width    
		end  
	
	set_minimum_height (min_height: INTEGER) is
			-- Make `min_height' the new `minimum__height' .
		require
			exists: not destroyed
			height_large_enough: min_height >= 0
		deferred
		ensure
			min_height = min_height
		end

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		require
			exists: not destroyed
		deferred
		ensure
			x_set: x = new_x
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		require
			exists: not destroyed
		deferred
		ensure
		--XX	x_set: x = new_x	
		--XX	y_set: y = new_y	
		end

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		require
			exists: not destroyed
		deferred
		ensure
			y_set: y = new_y		
		end
	
	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget
		do
			Result := True
--			Result := (width = new_width or else width = minimum_width) and then (height = new_height or else height = minimum_height)
		end		
		
feature -- Event - command association
	
	add_button_press_command (mouse_button: INTEGER; command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- button no 'mouse_button' is pressed.
		require
			exists: not destroyed
		deferred
		end
	
	
	add_button_release_command (mouse_button: INTEGER; command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- button no 'mouse_button' is released.
		require
			exists: not destroyed
		deferred
		end
	
	add_double_click_command (mouse_button: INTEGER; command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- button no `mouse_button' is double clicked.
		require
			exists: not destroyed
		deferred
		end
			
	add_motion_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- mouse move.
		require
			exists: not destroyed
		deferred
		end
	
	add_destroy_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the widget is destroyed.
		require
			exists: not destroyed
		deferred
		end

	add_expose_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the widget has to be redrawn because it was exposed from
			-- behind another widget.
		require
			exists: not destroyed
		deferred
		end
	
	add_key_press_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- a key is pressed on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		deferred
		end
	
	add_key_release_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- a key is released on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		deferred
		end
	
	add_enter_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the cursor of the mouse enter the widget.
		require
			exists: not destroyed
		deferred
		end
	
	add_leave_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the cursor of the mouse leave the widget.
		require
			exists: not destroyed
		deferred
		end
	

	remove_command (command_id: INTEGER) is
			-- Remove the command associated with
			-- `command_id' from the list of actions for
			-- this context. If there is no command
			-- associated with `command_id', nothing
			-- happens.
		require
			exists: not destroyed
		deferred
		end
	
	last_command_id: INTEGER is
			-- Id of the last command added by feature
			-- `add_command'
		require		
			exists: not destroyed
		deferred
		end
	
feature -- Implementation

	test_and_set_parent (par: EV_CONTAINER) is
			-- Set the parent to `par.implementation'.
			-- It is not possible to change the parent,
			-- therefore, if there is already a parent,
			-- we don't do anything
		deferred
		end

	set_interface (the_interface: EV_WIDGET) is
			-- Set `interface' to `the_interface'
		require
			valid_interface: the_interface /= Void
		do
			interface := the_interface
		ensure
			interface_set: interface = the_interface
		end
	
end -- class EV_WIDGET_I

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

