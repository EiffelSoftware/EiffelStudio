indexing 
	description: "EiffelVision widget. Most general notion of%
				% widget (i.e. user interface object)."
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET

inherit
	EV_PND_SOURCE
		redefine
			implementation
		end

	EV_PND_TARGET
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the widget with `par' as parent.
		deferred
		end

	widget_make (par: EV_CONTAINER) is
			-- This is a general initialization for 
			-- widgets. It has to be called by all the 
			-- widgets.
		do
			implementation.widget_make (Current)
			if par /= Void then
				managed := par.manager
				implementation.set_parent (par)
			end
		ensure
 			exists: not destroyed
		end

feature -- Access

	parent: EV_CONTAINER is
			-- The parent of the Current widget
			-- Can be void.
		require
			exists: not destroyed
		do
			if implementation.parent_imp /= Void then
				Result ?= implementation.parent_imp.interface
			else
				Result := Void
			end
		end

feature -- Status report

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

	expandable: BOOLEAN is
			-- Does the widget expand its cell to take the
			-- size the parent would like to give to it.
		require
			exists: not destroyed
		do
			Result := implementation.expandable
		end

	horizontal_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- or the user want to resize the widget
		require
			exists: not destroyed
		do
			Result := implementation.horizontal_resizable	
		end

	vertical_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- or the user want to resize the widget
		require
			exists: not destroyed
		do
			Result := implementation.vertical_resizable	
		end

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		require
			exists: not destroyed
		do
			Result := implementation.background_color
		ensure
			valid_result: Result /= Void
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
			-- usually the text.
		require
			exists: not destroyed
		do
			Result := implementation.foreground_color
		ensure
			valid_result: Result /= Void
		end

feature -- Status setting

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
			-- Do nothing if the widget has no parent.
		require
			exists: not destroyed
			has_parent: implementation.has_parent
		do
			implementation.show
		ensure
			shown: (parent /= Void) implies shown
		end

	set_focus is
			-- Set focus to Current
		require
			exists: not destroyed
		do
			implementation.set_focus
		end

--	set_sensitive is
			-- Set current widget in sensitive mode.
			-- This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not dispatched to current
			-- widget and to all its children.
--		require
--			exists: not destroyed
--		do
--			implementation.set_insensitive (False)
--		ensure
--			insensitive = False
--		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode.
			-- This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.
		require
			exists: not destroyed
		do
			implementation.set_insensitive (flag)
		ensure
			insensitive	= flag
		end

	set_default_options is
			-- Initialize the options of the widget.
		require
			exists: not destroyed
		do
			implementation.set_default_options
		end

	set_default_colors is
			-- Initialize the colors of the widget
		require
			exists: not destroyed
		do
			implementation.set_default_colors
		end

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		require
			exists: not destroyed
		do
			implementation.set_default_minimum_size
		end

	set_expand (flag: BOOLEAN) is
			-- Make `flag' the new expand option.
		require
			exists: not destroyed
		do
			implementation.set_expand (flag)
		end

	set_horizontal_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		require
			exists: not destroyed
		do
			implementation.set_horizontal_resize (flag)
		ensure
			horizontal_resize_set: horizontal_resizable = flag
		end

	set_vertical_resize (flag: BOOLEAN) is
			-- Adapt `resize_type' to `flag'.
		require
			exists: not destroyed
		do
			implementation.set_vertical_resize (flag)
		ensure
			vertical_resize_set: vertical_resizable = flag
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		require
			exists: not destroyed
		do
			implementation.set_parent (par)
		ensure
			parent_set: parent = par
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		do
			implementation.set_background_color (color)
		ensure
			background_color_set: background_color = color
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		require
			exists: not destroyed
			valid_color: is_valid (color)
		do
			implementation.set_foreground_color (color)
		ensure
			foreground_color_set: foreground_color.equal_color(color)
		end

feature -- Measurement 
	
	x: INTEGER is
			-- Horizontal position relative to parent
		require
			exists: not destroyed
		do
			Result := implementation.x
		end

	y: INTEGER is
			-- Vertical position relative to parent
		require
			exists: not destroyed
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

feature -- Resizing

	set_size (new_width: INTEGER; new_height: INTEGER) is
			-- Make `new_width' the new `width'
			-- and `new_height' the new `height'.
			-- widget must be unmanaged.
		require
			exists: not destroyed
			Unmanaged: not managed
			Positive_width: new_width >= 0
			Positive_height: new_height >= 0
		do
			implementation.set_size (new_width, new_height)
		ensure
			dimensions_set: implementation.dimensions_set (new_width, new_height)
		end 

	set_width (value :INTEGER) is
			-- Make `value' the new `width'.
			-- widget must be unmanaged.
		require
			exists: not destroyed
			Unmanaged: not managed
			Positive_width: value >= 0
		do
			implementation.set_width (value)
		ensure
			dimensions_set: implementation.dimensions_set (value, height)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new `height'.
			-- widget must be unmanaged.
		require
			exists: not destroyed
			Unmanaged: not managed
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
			minimum_dimension_set: implementation.minimum_dimensions_set (min_width, min_height)
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
		require
			exists: not destroyed
			large_enough: value >= 0
		do
			implementation.set_minimum_width (value)
		ensure
			minimum_width_set: implementation.minimum_width_set (value)
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
		require
			exists: not destroyed
			large_enough: value >= 0
		do
			implementation.set_minimum_height (value)
		ensure
			minimum_height_set: implementation.minimum_height_set (value)
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
			x_y_set: implementation.position_set (new_x, new_y)
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
			x_set: implementation.x_set (value)
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
			y_set: implementation.y_set (x)		
		end

feature -- Event - command association

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_button_press_command (mouse_button, cmd, arg)
		end

--	get_button_press_commands (mouse_button: INTEGER): LINKED_LIST[EV_COMMAND] is
--			-- Return the list of commands to be executed when
	--		-- button number 'mouse_button' is pressed.
	--	require
	--		exists: not destroyed
	--	do
	--		implementation.get_button_press_commands (mouse_button)
	--	end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		require
			exists: not destroyed
			valid_command: cmd /= Void
			valid_command_type: -- is_type_button (cmd)
		do
			implementation.add_button_release_command (mouse_button, cmd, arg)
		end

	add_double_click_command (mouse_button: INTEGER;
			  cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed 
			-- when button number `mouse_button' is double
			-- clicked.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_double_click_command (mouse_button, cmd, arg)
		end

	add_motion_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when mouse move.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_motion_notify_command (cmd, arg)
		end

	add_destroy_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget is destroyed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_destroy_command (cmd, arg)
		end	

	add_key_press_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a key is pressed on the keyboard while the
			-- widget has the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_key_press_command (cmd, arg)
		end	

	add_key_release_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a key is released on the keyboard while the
			-- widget has the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_key_release_command (cmd, arg)
		end	

	add_enter_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the cursor of the mouse enter the widget.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_enter_notify_command (cmd, arg)
		end	

	add_leave_notify_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the cursor of the mouse leave the widget.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_leave_notify_command (cmd, arg)
		end	

	add_get_focus_command  (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget get the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_get_focus_command (cmd, arg)
		end

	add_lose_focus_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget loose the focus.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_lose_focus_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		require
			exists: not destroyed
		do
			implementation.remove_button_press_commands (mouse_button)
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		require
			exists: not destroyed
		do
			implementation.remove_button_release_commands (mouse_button)
		end

	remove_double_click_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is double clicked.
		require
			exists: not destroyed
		do
			implementation.remove_double_click_commands (mouse_button)
		end

	remove_motion_notify_commands is
			-- Empty the list of commands to be executed when
			-- the mouse move.
		require
			exists: not destroyed
		do
			implementation.remove_motion_notify_commands
		end

	remove_destroy_commands is
			-- Empty the list of commands to be executed when
			-- the widget is destroyed.
		require
			exists: not destroyed
		do
			implementation.remove_destroy_commands
		end

	remove_key_press_commands is
			-- Empty the list of commands to be executed when
			-- a key is pressed on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		do
			implementation.remove_key_press_commands
		end

	remove_key_release_commands is
			-- Empty the list of commands to be executed when
			-- a key is released on the keyboard while the widget has the
			-- focus.
		require
			exists: not destroyed
		do
			implementation.remove_key_release_commands
		end

	remove_enter_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse enter the widget.
		require
			exists: not destroyed
		do
			implementation.remove_enter_notify_commands
		end

	remove_leave_notify_commands is
			-- Empty the list of commands to be executed when
			-- the cursor of the mouse leave the widget.
		require
			exists: not destroyed
		do
			implementation.remove_leave_notify_commands
		end

	remove_get_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget get the focus.
		require
			exists: not destroyed
		do
			implementation.remove_get_focus_commands
		end

	remove_lose_focus_commands is
			-- Empty the list of commands to be executed when
			-- the widget lose the focus.
		require
			exists: not destroyed
		do
			implementation.remove_lose_focus_commands
		end
	
feature -- Implementation

	implementation: EV_WIDGET_I
			-- Implementation of Current widget

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
