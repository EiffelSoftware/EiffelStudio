
-- General widget implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class WIDGET_I 

feature 

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_button_motion_action

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_button_press_action

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_button_release_action

	add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_button_click_action

	set_multi_click_time (time: INTEGER) is
			-- Set time granted for clicking
		deferred
		end;

	get_multi_click_time: INTEGER is
			-- Get time granted for clicking
		deferred
		end;

	add_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_destroy_action

	add_enter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer enter the window.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_enter_action

	add_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is pressed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_key_press_action

	add_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is released.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_key_release_action

	add_leave_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer leave the window.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_leave_action

	add_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- add_pointer_motion_action

	background_color: COLOR is
			-- Background color of widget
		deferred
		end; -- background_color

	background_pixmap: PIXMAP is
			-- Background pixmap of widget
		deferred
		end; -- background_pixmap

	cursor: SCREEN_CURSOR is
			-- Cursor of current widget
		deferred
		end;

	destroy is
			-- Destroy screen widget implementation and all
			-- screen widget implementations of its children.
		deferred
		end; -- destroy

	grab (a_cursor: SCREEN_CURSOR) is
			-- Grab the mouse and the keyboard.
			-- If `cursor' is not void, the pointer will have the shape
			-- set by cursor during the grab.
		require
			widget_realized: realized
		deferred
		end;

	height: INTEGER is
			-- Height of widget
		deferred
		ensure
			height_large_enough: Result >= 0
		end; -- height

	hide is
			-- Make widget invisible on the screen.
		require
			widget_realized: realized
		deferred
		ensure
			not shown
		end; -- hide

	insensitive: BOOLEAN is
			-- Is current widget sensitive?
		deferred
		end; -- insensitive

	lower is
		-- lower current to the bottom of its
		-- peers stacking order
		deferred
		end;


	managed: BOOLEAN is
			-- Is there geometry managment on screen widget implementation
			-- performed by window manager of parent widget?
		deferred
		end; -- managed

	propagate_event is
			-- Propagate event to direct ancestor if no action
			-- is specified for event.
		require
			widget_realized: realized
		deferred
		end; -- propagate_event

	raise is
			--raise current to top of
			-- peer stacking order
		deferred
		end;

	real_x: INTEGER is
			-- Vertical position relative to root window
		deferred
		end; -- real_x

	real_y: INTEGER is
			-- Horizontal position relative to root window
		deferred
		end; -- real_y

	realize is
			-- Create screen window implementation and all
			-- screen window implementations of its children if `flag'.
		deferred
		ensure
			realized
		end; -- realize

	realized: BOOLEAN is
			-- Is screen window realized?
		deferred
		end; -- realized

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require
			a_translation_exists: not (a_translation = Void)
		deferred
		end; -- remove_action

	remove_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_button_motion_action

	remove_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_button_press_action

	remove_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_button_release_action

	remove_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_button_click_action

	remove_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current widget is destroyed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_destroy_action

	remove_enter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer enter the window.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_enter_action

	remove_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is pressed.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_key_press_action

	remove_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is released.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_key_release_action

	remove_leave_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer leave the window.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_leave_action

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved.
		require
			not_a_command_void: not (a_command = Void)
		deferred
		end; -- remove_pointer_motion_action

	screen: SCREEN_I is
			-- Screen of widget
		deferred
		ensure
			not (Result = Void)
		end; -- screen

	screen_object: POINTER is
			-- Screen object implementation of current widget
		deferred
		end; -- screen_object

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		require
			not_a_command_void: not (a_command = Void);
			a_translation_exists: not (a_translation = Void)
		deferred
		end; -- set_action

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		require
			argument_not_void: not (new_color = Void)
		deferred
		ensure
			background_color = new_color;
			(background_pixmap = Void)
		end; -- set_background_color

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background pixmap to `a_pixmap'.
		require
			argument_not_void: not (a_pixmap = Void)
		deferred
		ensure
			background_pixmap = a_pixmap;
			(background_color = Void)
		end; -- set_background_pixmap

	set_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set `cursor' of current widget to `a_cursor'.
		require
			cursor_not_void: not (a_cursor = Void);
			widget_realized: realized
		deferred
		end;

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		require
			height_large_enough: new_height >= 0
		deferred
		end; -- set_height

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		deferred
		ensure
			flag = insensitive
		end; -- set_insensitive

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		deferred
		ensure
			managed = flag
		end; -- set_managed

	set_no_event_propagation is
			-- Don't propagate event to direct ancestor.
		require
			widget_realized: realized
		deferred
		end; -- set_no_event_propagation

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		require
			width_large_enough: new_width >= 0;
			height_large_enough: new_height >= 0
		deferred
		end; -- set_size

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		require
			width_large_enough: new_width >= 0;
		deferred
		end; -- set_width

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		deferred
		end; -- set_x

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		deferred
		end; -- set_x_y

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		deferred
		end; -- set_y

	show is
			-- Make widget visible on the screen.
		require
			widget_realized: realized
		deferred
		ensure
			shown
		end; -- show

	shown: BOOLEAN is
			-- Is current widget visible?
		require
			widget_realized: realized
		deferred
		end; -- shown

	ungrab is
			-- Release the mouse and the keyboard from an earlier grab.
		require
			widget_realized: realized
		deferred
		end; -- ungrab

	unrealize is
			-- Destroy screen window implementation and all
			-- screen window implementations of its children if `flag'.
		deferred
		ensure
			not realized
		end; -- unrealize

	width: INTEGER is
			-- Width of widget
		deferred
		ensure
			width_large_enough: Result >= 0
		end; -- width

	x: INTEGER is
			-- Horizontal position relative to parent
		deferred
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		deferred
		end -- y

invariant

	(background_color = Void) or (background_pixmap = Void)

end -- class WIDGET_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
