indexing
	description: "EiffelVision widget, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_I 

inherit
	EV_PND_SOURCE_I

	EV_PND_TARGET_I

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		deferred
		end

feature {EV_WIDGET} -- Initialization

	widget_make (an_interface: EV_WIDGET) is
			-- Creation of the widget.
		require
			valid_interface: an_interface /= Void
		deferred
		end

 feature -- Access

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this widget. The same than
			-- parent but with a different type.
		require
			exists: not destroyed
		deferred
		end

	expandable: BOOLEAN
			-- Does the widget expand its cell to take the
			-- size the parent would like to give to it.

	resize_type: INTEGER
			-- How the widget resize itself in the cell
			-- 0 : no resizing, the widget move
			-- 1 : only the width changes
			-- 2 : only the height changes
			-- 3 : both width and height change

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		require
			exists: not destroyed
		deferred
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget,
			-- usually the text.
		require
			exists: not destroyed
		deferred
		end

feature -- Status Report

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

	horizontal_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget
		require
			exists: not destroyed
		do
			Result := (resize_type = 1) or (resize_type = 3)	
		end

	vertical_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget
		require
			exists: not destroyed
		do
			Result := (resize_type = 2) or (resize_type = 3)	
		end

feature -- Status setting

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
			has_parent: has_parent
		deferred
		ensure
			shown: shown		
		end

	set_focus is
			-- Set focus to Current
		require
			exists: not destroyed
		deferred
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

	set_default_options is
			-- Initialize the options of the widget.
		require
			exists: not destroyed
		do
			set_expand (True)
			set_vertical_resize (True)
			set_horizontal_resize (True)
		end

	set_default_colors is
			-- Initialize the colors of the widget
		require
			exists: not destroyed
		local
			default_colors: EV_DEFAULT_COLORS
		do
			!! default_colors
			set_background_color (default_colors.default_background_color)
			set_foreground_color (default_colors.default_foreground_color)
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		require
			exists: not destroyed
		deferred
		end

	set_expand (flag: BOOLEAN) is
			-- Make `flag' the new expand option.
		require
			exists: not destroyed
		deferred	
		ensure
			expand_set: expandable = flag
		end

	set_horizontal_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		require
			exists: not destroyed
		deferred
		ensure
			horizontal_resize_set: horizontal_resizable = flag
		end

	set_vertical_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		require
			exists: not destroyed
		deferred
		ensure
			vertical_resize_set: vertical_resizable = flag
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		deferred
		ensure
			parent_set: parent_set (par)
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		deferred
		ensure
			background_color_set: background_color.equal_color(color)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		deferred
		ensure
			foreground_color_set: foreground_color.equal_color(color)
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

	set_width (value :INTEGER) is
			-- Make `value' the new width.
		require
			exists: not destroyed
			Positive_width: value >= 0
		deferred
		ensure
			dimensions_set: dimensions_set (value, height)
		end
	
	set_height (value: INTEGER) is
			-- Make `value' the new.
		require
			exists: not destroyed
			Positive_height: value >= 0
		deferred
		ensure					
			dimensions_set: dimensions_set (width, value)
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
			minimum_dimension_set: minimum_dimensions_set (min_width, min_height)
		end  
        
	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
		require
			exists: not destroyed
			a_min_large_enough: value >= 0
		deferred
		ensure
			minimum_width_set: minimum_width_set (value)
		end  
	
	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' .
		require
			exists: not destroyed
			height_large_enough: value >= 0
		deferred
		ensure
			minimum_height_set: minimum_height_set (value)
		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		require
			exists: not destroyed
		deferred
		ensure
			x_y_set: position_set (new_x, new_y)
		end

	set_x (value: INTEGER) is
			-- Put at horizontal position `value' relative
			-- to parent.
		require
			exists: not destroyed
		deferred
		ensure
			x_set: x_set (value)
		end

	set_y (value: INTEGER) is
			-- Put at vertical position `value' relative
			-- to parent.
		require
			exists: not destroyed
		deferred
		ensure
			y_set: y_set (value)		
		end

feature -- Assertions
	
	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		deferred
		end		

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		-- When the widget is not shown, the result is 0
		deferred
		end		

	minimum_width_set (value: INTEGER): BOOLEAN is
			-- Send -1 not to test the height
		do
			Result := minimum_dimensions_set (value, -1)
		end

	minimum_height_set (value: INTEGER): BOOLEAN is
			-- Send -1 not to test width.
		do
			Result := minimum_dimensions_set (-1, value)
		end

	position_set (new_x, new_y: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		-- When the widget is not shown, the result is -1
		deferred
		end

	x_set (value: INTEGER): BOOLEAN is
		do
			Result := position_set (value, -1)
		end

	y_set (value: INTEGER): BOOLEAN is
		do
			Result := position_set (-1, value)
		end

	has_parent: BOOLEAN is
			-- True if the widget has a parent, False otherwise
		do
			Result := parent_imp /= void
		end

	parent_set (par: EV_CONTAINER): BOOLEAN is
		local
			wid: EV_CONTAINER
		do
			if parent_imp /= Void then
				wid ?= parent_imp.interface
				Result := wid = par
			else
				Result := par = Void
			end
		end

feature -- Event - command association

	add_double_click_command (mouse_button: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button no `mouse_button' is double clicked.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_motion_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when mouse move.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_destroy_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is destroyed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_key_press_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a key is pressed on the keyboard while the
			-- widget has the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_key_release_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a key is released on the keyboard while the
			-- widget has the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_enter_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the cursor of the mouse enter the widget.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_leave_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the cursor of the mouse leave the widget.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_get_focus_command  (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget get the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_lose_focus_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget loose the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		require
			exists: not destroyed
		deferred
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		require
			exists: not destroyed
		deferred
		end

	remove_double_click_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is double clicked.
		require
			exists: not destroyed
		deferred
		end

	remove_motion_notify_commands is
			-- Empty the list of commands to be executed when
			-- the mouse move.
		require
			exists: not destroyed
		deferred
		end

	remove_destroy_commands is
			-- Empty the list of commands to be executed when
			-- the widget is destroyed.
		require
			exists: not destroyed
		deferred
		end

	remove_key_press_commands is
			-- Empty the list of commands to be executed when
			-- a key is pressed on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		deferred
		end

	remove_key_release_commands is
			-- Empty the list of commands to be executed when
			-- a key is released on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		deferred
		end

	remove_enter_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse enter the widget.
		require
			exists: not destroyed
		deferred
		end

	remove_leave_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse leave the widget.
		require
			exists: not destroyed
		deferred
		end

	remove_get_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget get the focus.
		require
			exists: not destroyed
		deferred
		end

	remove_lose_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget lose the focus.
		require
			exists: not destroyed
		deferred
		end
	
invariant

--	backgound_color_not_void: background_color /= Void
--	foreground_color_not_void: foreground_color /= Void
	good_resize_type: resize_type >= 0 and resize_type <= 3
	
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

