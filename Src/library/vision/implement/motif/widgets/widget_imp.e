indexing

	description: 
		"EiffelVision implementation of a motif widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	WIDGET_IMP

inherit

	G_ANY_I;

	W_MAN_GEN
		export
			{NONE} all
		end;

	MEL_WIDGET
		rename
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
		end

feature -- Access

	cursor: SCREEN_CURSOR;
			-- Cursor used

	get_multi_click_time: INTEGER is
			-- Multiclick time
		do
			Result := button_click_actions.multi_click_time
		end;

	screen: SCREEN_I is
			-- Associated screen 
		do
			Result := widget_manager.screen_i_using_index (widget_index)
		ensure
			valid_result: Result /= Void
		end; 

	widget_oui: WIDGET is
			-- Object user interface widget associated with current
			-- implementation
		do
			Result := widget_manager.widget_at (widget_index);
		end;

feature -- Status Report

	managed: BOOLEAN is
			-- Is the widget managed?
		do
			Result := is_managed
		end;

	insensitive: BOOLEAN is
			-- Is current object sensitive?
		do
			Result := not is_sensitive
		end;

	background_color: COLOR is
			-- Color used for the background.
		local
			bg_color_x: COLOR_IMP
		do
			if private_background_color = Void then
				!! private_background_color.make;
				bg_color_x ?= private_background_color.implementation;
				bg_color_x.set_default_pixel (mel_background_color,
						mel_screen.default_colormap);
				bg_color_x.increment_users
			end;
			Result := private_background_color;
		ensure
			color_exists: Result /= Void
		end;

	background_pixmap: PIXMAP is
			-- Pixmap used for the background
		local
			bg_pixmap_x: PIXMAP_IMP
		do
			if private_background_pixmap = Void then
				!! private_background_pixmap.make;
				bg_pixmap_x ?= private_background_pixmap.implementation;		
				bg_pixmap_x.set_default_pixmap (mel_background_pixmap);
				bg_pixmap_x.increment_users
			end;
			Result := private_background_pixmap
		end;

feature -- Status Setting

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		do
			if flag then
				mel_set_insensitive
			else
				set_sensitive 
			end
		ensure
			insensitive_equal_flag: insensitive = flag
		end;

	set_multi_click_time (time: INTEGER) is
			-- Set `multi_click_time' to `time'.
		do
			button_click_actions.set_multi_click_time (time)
		end;
	
	set_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set cursor label to `cursor_name'.
		require
			a_cursor_exists: a_cursor /= Void
		local
			display_pointer: POINTER;
			cursor_implementation: SCREEN_CURSOR_IMP
		do
			cursor_implementation ?= a_cursor.implementation;
			if cursor /= Void then
				cursor_implementation.decrement_users
			end;
			cursor := a_cursor;
			cursor_implementation ?= cursor.implementation;
			cursor_implementation.increment_users;
			cursor_implementation.allocate_cursor;
			define_cursor (cursor_implementation);
			display.flush
		ensure
			set: cursor = a_cursor
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
			--| This will automatically update the
			--| the top_shadow, bottom_shadow
			--| and select color of Current widget.
		require
			a_color_exists: a_color /= Void
		local
			color_implementation: COLOR_IMP
		do
			if private_background_color /= Void then
				color_implementation ?= private_background_color.implementation;
				color_implementation.decrement_users
			end;
			private_background_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.increment_users;
			color_implementation.allocate_pixel;
			set_background_color_from_imp (color_implementation);
		ensure
			background_set: background_color = a_color;
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background_pixmap to `a_pixmap'.
		require
			a_pixmap_exists: a_pixmap /= Void
		local
			pixmap_implementation: PIXMAP_IMP
		do
			if private_background_pixmap /= Void then
				pixmap_implementation ?= private_background_pixmap.implementation;
				pixmap_implementation.decrement_users
			end;
			private_background_pixmap := a_pixmap;
			pixmap_implementation ?= a_pixmap.implementation;
			pixmap_implementation.increment_users;
			mel_set_background_pixmap (pixmap_implementation)
		ensure
			background_pixmap_set: background_pixmap = a_pixmap;
		end;

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		do
			if flag then
				manage
			else
				unmanage
			end
		ensure
			managed_equal_flag: managed = flag 
		end; 

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		local
			list: VISION_COMMAND_LIST
		do
			!! list.make;
			set_translation (a_translation, list, Void);
			list.add_command (a_command, argument)
		end;

	set_widget_default is
			-- Set the widget default after creating 
			-- associated oui widget.
		do
		end

feature -- Element change

	add_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current widget is destroyed.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (destroy_command);	
			if list = Void then
				!! list.make;
				set_destroy_callback (list, Void)
			end;
			list.add_command (a_command, argument)
		end;

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (event_command (ButtonPressMask));
			if list = Void then
				!! list.make;
				set_event_handler (ButtonPressMask, list, Void)
			end;
			list.add_command (number, a_command, argument)
		end;

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (event_command (ButtonReleaseMask));
			if list = Void then
				!! list.make;
				set_event_handler (ButtonReleaseMask, list, Void)
			end;
			list.add_command (number, a_command, argument)
		end; 

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		local
			a_mask: INTEGER;
			list: VISION_COMMAND_LIST
		do
			inspect number 
			when 1 then
				a_mask := Button1MotionMask
			when 2 then
				a_mask := Button2MotionMask
			when 3 then
				a_mask := Button3MotionMask
			when 4 then
				a_mask := Button4MotionMask
			when 5 then
				a_mask := Button5MotionMask
			else
			end
			if a_mask /= 0 then
				add_xt_event_command (a_mask, a_command, argument)
			end
		end;

	add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked.
		local
			actions: like button_click_actions;
		do
			actions := button_click_actions;
			actions.add (number, a_command, argument);
			if not actions.callback_added then
				actions.set_callback_added;
				add_button_press_action (1, actions, argument);
				add_button_press_action (2, actions, argument);
				add_button_press_action (3, actions, argument);
				add_button_release_action (1, actions, argument)
				add_button_release_action (2, actions, argument)
				add_button_release_action (3, actions, argument)
			end
		end;

	add_enter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer enter the window.
		do
			add_xt_event_command (EnterWindowMask, a_command, argument)
		end;

	add_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is pressed.
		do
			add_xt_event_command (KeyPressMask, a_command, argument)
		end;

	add_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is released.
		do
			add_xt_event_command (KeyReleaseMask, a_command, argument)
		end;

	add_leave_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer leave the window.
		do
			add_xt_event_command (LeaveWindowMask, a_command, argument)
		end; 

	add_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved.
		do
			add_xt_event_command (PointerMotionMask, a_command, argument)
		end; 

feature -- Removal

	destroy (wid_list: LINKED_LIST [WIDGET]) is
			-- Destroy screen widget implementation and all
			-- screen widget implementations of its children
			-- contained in `wid_list;.
		do
			if not click_actions_table.is_empty then
				from	
					wid_list.start
				until
					wid_list.after
				loop
					click_actions_table.remove (wid_list.item.implementation.screen_object);
					wid_list.forth
				end
			end;
			mel_destroy
		end; 

	remove_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current widget is destroyed.
		do
			remove_command (destroy_command, a_command, argument)
		end;

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		do
			remove_translation (a_translation)
		end;

	remove_button_motion_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		local
			a_mask: INTEGER
		do
			inspect number 
			when 1 then
				a_mask := Button1MotionMask
			when 2 then
				a_mask := Button2MotionMask
			when 3 then
				a_mask := Button3MotionMask
			when 4 then
				a_mask := Button4MotionMask
			when 5 then
				a_mask := Button5MotionMask
			else
			end
			if a_mask /= 0 then
				remove_command (event_command (a_mask), a_command, argument)
			end
		end; 

	remove_button_press_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (event_command (ButtonPressMask));
			if list /= Void then
				list.remove_command (number, a_command, argument)
			end
		end; 

	remove_button_release_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		local
			list: BUTTON_HAND_X
		do
			list := button_command (event_command (ButtonReleaseMask));
			if list /= Void then
				list.remove_command (number, a_command, argument)
			end
		end; 

	remove_button_click_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked.
		local
			actions: like button_click_actions;
		do
			actions := button_click_actions;
			actions.remove (number, a_command, argument)
		end;

	remove_enter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer enter the window.
		do
			remove_command (event_command (EnterWindowMask), a_command, argument)
		end; 

	remove_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is pressed.
		do
			remove_command (event_command (KeyPressMask), a_command, argument)
		end;

	remove_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is released.
		do
			remove_command (event_command (KeyReleaseMask), a_command, argument)
		end; 

	remove_leave_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer leave the window.
		do
			remove_command (event_command (LeaveWindowMask), a_command, argument)
		end; 

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved.
		do
			remove_command (event_command (PointerMotionMask), a_command, argument)
		end; 

feature -- Update

	grab (a_cursor: SCREEN_CURSOR) is
			-- Grab the mouse and the keyboard.
			-- If `cursor' is not void, the pointer will have the shape
			-- set by cursor during the grab.
		require
			widget_realized: realized
		local
			cursor_implementation: SCREEN_CURSOR_IMP;
		do
			if a_cursor /= Void then
				cursor_implementation ?= a_cursor.implementation
				cursor_implementation.allocate_cursor;
			end;
			grab_pointer (cursor_implementation)
		end;

	ungrab is
			-- Release the mouse and the keyboard from an earlier grab.
		require
			widget_realized: realized
		do
			ungrab_pointer
		end; 

feature {COLOR_IMP} -- Implementation

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_IMP;
		do
			color_implementation ?= private_background_color.implementation;
			color_implementation.allocate_pixel;
			set_background_color_from_imp (color_implementation)
		end;

feature {RESOURCE_X} -- Implementation

	private_background_pixmap: PIXMAP;
			-- Pixmap used for background 
			-- (Void after creation)

	private_background_color: COLOR;
			-- Color used for the background.
			-- Void after creation.

feature {PIXMAP_IMP} -- Implementation

	update_background_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			pixmap_implementation: PIXMAP_IMP
		do
			pixmap_implementation ?= private_background_pixmap.implementation;
			mel_set_background_pixmap (pixmap_implementation)
		end;

feature {SCREEN_CURSOR_IMP, ALL_CURS_X}

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require
			a_cursor_exists: a_cursor /= Void
		do
		end;

	undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		do
		end; 
	
	update_cursor is
			-- Update the X cursor after a change inside the Eiffel cursor.
		local
			cursor_implementation: SCREEN_CURSOR_IMP
		do
			cursor_implementation ?= cursor.implementation;
			cursor_implementation.allocate_cursor;
			define_cursor (cursor_implementation);
			display.flush
		end;

feature {NONE} -- Implementation
	
	click_actions_table: HASH_TABLE [BUTTON_CLICK_HAND_X, POINTER] is
			-- Table of click actions for all widgets
		once
			!! Result.make (1)
		end;

	button_click_actions: BUTTON_CLICK_HAND_X is
			-- Button click actions for Current widget
		local
			list: VISION_COMMAND_LIST
		do
			Result := click_actions_table.item (screen_object);
			if Result = Void then	
				!! Result.make;
				click_actions_table.put (Result, screen_object)
			end;
		ensure
			non_void_result: Result /= Void
		end;

	mel_parent (a_widget: WIDGET; index: INTEGER): MEL_COMPOSITE is
			-- Retrieve mel parent from the widget manage for 
			-- `widget' using `index'
		do
			Result ?= widget_manager.parent_using_index
						(a_widget, index - 1).implementation
		ensure
			valid_result: Result /= Void
		end;

	parent_screen_object (a_widget: WIDGET; index: INTEGER): POINTER is
			-- Retrieve parent screen object from the widget manager 
			-- `widget' using `index'
		do
			Result := widget_manager.parent_using_index
						(a_widget, index - 1).implementation.screen_object
		ensure
			valid_result: Result /= default_pointer
		end;

	widget_index: INTEGER;
			-- Widget index in window manager

	set_widget_index (index: INTEGER) is
			-- Set widget_index to `index'.
		do
			widget_index := index
		end;

feature {WIDGET_IMP} -- Implementation

	remove_command (cmd_exec: MEL_COMMAND_EXEC; a_command: COMMAND; an_argument: ANY) is
			-- Add the EiffelVision command to the mel command list
			-- for event mask `mask'.
		local
			list: VISION_COMMAND_LIST
		do
			if cmd_exec /= Void then
				list ?= cmd_exec.command;
				if list /= Void then
					list.remove_command (a_command, an_argument)
				end
			end;
		end;

	vision_command_list (mel_cmd_exec: MEL_COMMAND_EXEC): VISION_COMMAND_LIST is
			-- Get the vision command list from `mel_cmd_exec'
		do
			if mel_cmd_exec /= Void then
				Result ?= mel_cmd_exec.command
			end
		end;

	button_command (mel_cmd_exec: MEL_COMMAND_EXEC): BUTTON_HAND_X is
			-- Get the vision command list from `mel_cmd_exec'
		do
			if mel_cmd_exec /= Void then
				Result ?= mel_cmd_exec.command
			end
		end;

	add_xt_event_command (a_mask: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Add the EiffelVision command to the mel command list
			-- for event mask `mask'.
		local
			list: VISION_COMMAND_LIST
		do
			list := vision_command_list (event_command (a_mask));	
			if list = Void then
				!! list.make;
				set_event_handler (a_mask, list, an_argument)
			end;
			list.add_command (a_command, an_argument)
		end;

feature {NONE} -- Implementation

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		require
			valid_color_imp: color_imp /= Void and color_imp.is_valid
		do
			mel_set_background_color (color_imp);	
		end;

end -- class WIDGET_IMP

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

