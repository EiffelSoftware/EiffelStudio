indexing 
	description: "Most general notion of widget %
				% (i.e. user interface object)"
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

deferred class EV_WIDGET

feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is
		deferred
		end
		
	widget_make (par: EV_CONTAINER) is
			-- Create a widget with `par' as parent and
			-- call `set_default'. 
			-- This is a general initialization for 
			-- widgets and has to be called by all the 
			-- widgets with parents.
		require
			valid_parent: par /= Void
		do
			implementation.set_interface (Current)
			implementation.test_and_set_parent (par)
			implementation.parent_imp.add_child (implementation)
			implementation.build
			implementation.initialize_colors
			managed := par.manager
 		ensure
 			exists: not destroyed
		end

feature -- Access
	
	parent: EV_WIDGET is
			-- The parent of the Current widget
			-- If the widget is an EV_WINDOW without parent,
			-- this attribute will be `Void'
		require
			exists: not destroyed
		do
			if implementation.parent_imp /= Void then
				Result := implementation.parent_imp.interface
			else
				Result := Void
			end
		end
	
feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current widget destroyed?  
			-- (= implementation does not exist)
		do
			Result := (implementation = Void)
		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive to
			-- user actions?
			-- (If it is, events will not be dispatched
			-- to Current widget or any of its children)
		require
			exists: not destroyed
		do
			Result := implementation.insensitive
		end
	
	shown: BOOLEAN is
			-- Is current widget visible?
		require
			exists: not destroyed
		do
			Result := implementation.shown
		end
	
	managed: BOOLEAN
			-- Is the geometry of current widget managed by its 
			-- container? This is the case always unless 
			-- parent.manager = False (Always true except 
			-- when the container is EV_FIXED). This is 
			-- set in the procedure set_default
		
	automatic_resize: BOOLEAN is
			-- Is the widget resized automatically when
			-- the parent resize ? In this case,
			-- automatic_position has no effect.
			-- True by default
		require
			exists: not destroyed
		do
			Result := implementation.automatic_resize
		end

	automatic_position: BOOLEAN is
			-- Does the widget take a new position when
			-- the parent resize ?
			-- (If it does, its size doesn't changed).
			-- False by default
		require
			exists: not destroyed
		do
			Result := implementation.automatic_position
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		require
			exists: not destroyed
		do
			Result := implementation.background_color.interface
		ensure
			result_not_void: Result /= Void
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
			-- usually the text.
		require
			exists: not destroyed
		do
			Result := implementation.foreground_color.interface
		ensure
			result_not_void: Result /= Void
		end

feature -- Status setting

	destroy is
			-- Destroy actual screen object of Current
			-- widget and of all children.
		do
			if not destroyed then
				implementation.destroy
				remove_implementation
			end
		ensure
			destroyed: destroyed
		end

	hide is
		 	-- Make widget invisible on the screen.
		require
			exists: not destroyed
		do
			implementation.hide
		ensure
			not_shown: not shown
		end

	show is
		 	-- Make widget visible on the screen. (default)
		require
			exists: not destroyed
		do
			implementation.show
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
		do
			implementation.set_insensitive (flag)
		ensure
			flag = insensitive	
		end

	set_automatic_resize (flag: BOOLEAN) is
			-- Make `flag' the new `automatic_resize' state.
		require
			exists: not destroyed
		do
			implementation.set_automatic_resize (flag)
		ensure
			automatic_resize_set: automatic_resize = flag
		end

	set_automatic_position (flag: BOOLEAN) is
			-- Make `flag' the new `automatic_position' state.
		require
			exists: not destroyed
		do
			implementation.set_automatic_position (flag)
		ensure
			automatic_position_set: automatic_position = flag
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		require
			exists: not destroyed
			color_not_void: color /= Void
		do
			implementation.set_background_color (color)
		ensure
			background_color_set: background_color = color
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		require
			exists: not destroyed
			color_not_void: color /= Void
		do
			implementation.set_foreground_color (color)
		ensure
			foreground_color_set: foreground_color = color
		end

	-- What is this for?
-- 	grab (a_cursor: SCREEN_CURSOR) is
-- 			-- Grab the mouse and the keyboard , i.e.
-- 			-- channel all events to Current widget 
-- 			-- regardless of where they occur
-- 			-- If `cursor' is not void, the pointer 
-- 			-- will have `a_cursor' shape during the grab.
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			implementation.grab (a_cursor)
-- 		end

-- 	ungrab is
-- 			-- Release the mouse and the keyboard 
-- 			-- from an earlier grab.
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			implementation.ungrab
-- 		end 

feature -- Measurement 
	
	-- The coordinates are effective only if widget is inside a
	-- fixed container. Otherwise they are calculated 
	-- automatically by the container widget.

	x: INTEGER is
			-- Horizontal position relative to parent
		require
			exists: not destroyed
			unmanaged: not managed
		do
			Result := implementation.x
		end

	y: INTEGER is
			-- Vertical position relative to parent
		require
			exists: not destroyed
			unmanaged: not managed
		do
			Result := implementation.y
		end

	width: INTEGER is
			-- Width of the widget
		require
			exists: not destroyed
		do
			Result := implementation.width
		ensure
			Positive_width: Result >= 0
		end

	height: INTEGER is
			-- Height of the widget
		require
			exists: not destroyed
		do
			Result := implementation.height
		ensure
			Positive_height: Result >= 0
		end 
	
	minimum_width: INTEGER is
			-- Minimum width that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.minimum_width
		ensure
			Positive_height: Result >= 0
		end 
	
	minimum_height: INTEGER is
			-- Minimum height that application wishes widget
			-- instance to have
		require
			exists: not destroyed
		do
			Result := implementation.minimum_height
		ensure
			Positive_height: Result >= 0
		end 
	
-- 	-- Do we need this?
-- 	real_x: INTEGER is
-- 			-- Vertical position relative to root window
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			Result := implementation.real_x
-- 		end 
-- 	-- Do we need this?
-- 	real_y: INTEGER is
-- 			-- Horizontal position relative to root window
-- 		require
-- 			exists: not destroyed
-- 		do
-- 			Result := implementation.real_y
-- 		end 
-- 	-- Do we need this?
-- 	depth: INTEGER
			-- Depth of Current widget
			-- (top_shell's depth is 0, its child's depth is 1,...)

feature -- Resizing

	set_size (new_width: INTEGER; new_height: INTEGER) is
			-- Make `new_width' the new `width'
			-- and `new_height' the new `height'.
		require
			exists: not destroyed
			Positive_width: new_width >= 0
			Positive_height: new_height >= 0
		do
			implementation.set_size (new_width, new_height)
		ensure
			dimensions_set: implementation.dimensions_set (new_width, new_height)
		end 

	set_width (value :INTEGER) is
			-- Make `value' the new `width'.
		require
			exists: not destroyed
			Positive_width: value >= 0
		do
			implementation.set_width (value)
		ensure
			dimensions_set: implementation.dimensions_set (value, height)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new `height'.
		require
			exists: not destroyed
			Positive_height: value >= 0
		do
			implementation.set_height (value)
		ensure					
			dimensions_set: implementation.dimensions_set (width, value)
		end
	
	set_minimum_size (min_width, min_height: INTEGER) is
			-- Make `min_width' the new `minimum_width'
			-- and `min_height' the new `minimum_height'.
		require
			exists: not destroyed
			large_enough: min_height >= 0
			large_enough: min_width >= 0  
		do
			implementation.set_minimum_size (min_width, min_height)
		ensure
			 min_width = min_width
			 min_height = min_height
		end
		
	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
		require
			exists: not destroyed
			large_enough: value >= 0
		do
			implementation.set_minimum_width (value)
		ensure
			minimum_width_set: minimum_width = value
		end
        
	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum__height'.
		require
			exists: not destroyed
			large_enough: value >= 0
		do
			implementation.set_minimum_height (value)
		ensure
			minimum_height_set: minimum_height = value
		end

	set_x (value: INTEGER) is
			-- Put at horizontal position `value' relative
			-- to parent.
		require
			exists: not destroyed
			Unmanaged: not managed
		do
			implementation.set_x (value)
		ensure
			x_set: x = value
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		require
			exists: not destroyed
			Unmanaged: not managed
		do
			implementation.set_x_y (new_x, new_y)
		ensure
			x_set: x = new_x	
			y_set: y = new_y	
		end

	set_y (value: INTEGER) is
			-- Put at vertical position `value' relative
			-- to parent.
		require
			exists: not destroyed
			Unmanaged: not managed
		do
			implementation.set_y (value)
		ensure
			y_set: y = value		
		end

feature -- Comparison

	same (other: like Current): BOOLEAN is
			-- Does Current widget and `other' correspond
			-- to the same screen object?
		require
			other_exists: other /= Void
		do
			Result := other.implementation = implementation
		end

feature -- Event - command association
	
	add_button_press_command (mouse_button: INTEGER; 
		  command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- button no 'mouse_button' is pressed.
		require
			exists: not destroyed
		do
			implementation.add_button_press_command (mouse_button,
								 command, arguments)
		end
	
	
	add_button_release_command (mouse_button: INTEGER;
		    command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- button no 'mouse_button' is released.
		require
			exists: not destroyed
		do
			implementation.add_button_release_command (mouse_button,
								   command, arguments)
		end
	
	add_double_click_command (mouse_button: INTEGER;
				  command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- button no `mouse_button' is double clicked.
		require
			exists: not destroyed
		do
			implementation.add_double_click_command (mouse_button,
								 command, arguments)
		end
	
	add_motion_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when
			-- mouse move.
		require
			exists: not destroyed
		do
			implementation.add_motion_notify_command (command, 
								  arguments)
		end
	
	add_destroy_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the widget is destroyed.
		require
			exists: not destroyed
		do
			implementation.add_destroy_command (command, 
							   arguments)
		end	
	
	add_expose_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the widget has to be redrawn because it was exposed from
			-- behind another widget.
		require
			exists: not destroyed
		do
			implementation.add_expose_command (command, 
							      arguments)
		end	
	
	add_key_press_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- a key is pressed on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		do
			implementation.add_key_press_command (command, 
							      arguments)
		end	
	
	add_key_release_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- a key is released on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		do
			implementation.add_key_release_command (command, 
								arguments)
		end	
	
	add_enter_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the cursor of the mouse enter the widget.
		require
			exists: not destroyed
		do
			implementation.add_enter_notify_command (command, 
								 arguments)
		end	
	
	add_leave_notify_command (command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add `command' to the list of commands to be executed when 
			-- the cursor of the mouse leave the widget.
		require
			exists: not destroyed
		do
			implementation.add_leave_notify_command (command, 
								 arguments)
		end	

	remove_command (command_id: INTEGER) is
			-- Remove the command associated with `command_id' from the
			-- list of actions for this context. If there is no command
			-- associated with `command_id', nothing happens.
		require
			exists: not destroyed
		do
			implementation.remove_command (command_id)
		end
		
	last_command_id: INTEGER is
			-- Id of the last command added by feature `add_command'
		require		
			exists: not destroyed
		do
			Result := implementation.last_command_id
		end
	
feature -- Implementation

	implementation: EV_WIDGET_I
			-- Implementation of Current widget

feature {NONE} -- Implementation
	
	remove_implementation is
			-- Remove implementation of Current widget.
		do
			implementation := Void
		ensure
			void_implementation: implementation = Void
		end

invariant

  --XX      Widget_Positive_depth:  depth >= 0

end -- class EV_WIDGET

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
