indexing

	description: 
		"EiffelVision implementation of a motif widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	WIDGET_M 

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

	insensitive: BOOLEAN is
			-- Is current object sensitive?
		do
			Result := not is_sensitive
		end;

	background_color: COLOR is
			-- Color used for the background.
		local
			bg_color_x: COLOR_X
		do
			if private_background_color = Void then
				!! private_background_color.make;
				bg_color_x ?= private_background_color.implementation;
				--bg_color_x.set_pixel (xt_pixel (screen_object, "background"));
			end;
			Result := private_background_color;
		ensure
			color_exists: Result /= Void
		end;

	background_pixmap: PIXMAP is
			-- Pixmap used for the background
		local
			bg_pixmap_b: PIXMAP_X;
			ext_name: ANY
		do
			if private_background_pixmap = Void then
				!! private_background_pixmap.make;
				bg_pixmap_b ?= private_background_pixmap.implementation;		
				ext_name := ("backgroundPixmap").to_c;
				--bg_pixmap_b.set_default_pixmap (c_get_pixmap 
								--(screen_object, $ext_name))
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
			set_sensitive (not flag)
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
			cursor_implementation: SCREEN_CURSOR_X
		do
			cursor_implementation ?= a_cursor.implementation;
			if cursor /= Void then
				cursor_implementation.remove_object (Current)
			end;
			cursor := a_cursor;
			cursor_implementation ?= cursor.implementation;
			cursor_implementation.put_object (Current);
			--display_pointer := xt_display (screen_object);
			--x_define_cursor (display_pointer, xt_window (screen_object), cursor_implementation.cursor_id (screen));
			--x_flush (display_pointer)
		ensure
			cursor = a_cursor
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
			--| This will automatically update the
			--| the top_shadow, bottom_shadow
			--| and select color of Current widget.
		require
			a_color_exists: a_color /= Void
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
		do
			if private_background_pixmap /= Void then
				pixmap_implementation ?= private_background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				private_background_pixmap := Void
			end;
			if private_background_color /= Void then
				color_implementation ?= private_background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			private_background_color := a_color;
			color_implementation ?= a_color.implementation;
			--color_implementation.put_object (Current);
			--xm_change_bg_color (screen_object, color_implementation.pixel (screen))
		ensure
		--	background_set: background_color = a_color;
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background_pixmap to `a_pixmap'.
		require
			a_pixmap_exists: a_pixmap /= Void
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if private_background_color /= Void then
				color_implementation ?= private_background_color.implementation;
				color_implementation.remove_object (Current);
				private_background_color := Void
			end;
			if private_background_pixmap /= Void then
				pixmap_implementation ?= private_background_pixmap.implementation;
				pixmap_implementation.remove_object (Current)
			end;
			private_background_pixmap := a_pixmap;
			pixmap_implementation ?= background_pixmap.implementation;
			pixmap_implementation.put_object (Current);
			--ext_name := MbackgroundPixmap.to_c;
			--c_set_pixmap (screen_object, 
				--	pixmap_implementation.resource_pixmap (screen), 
				--	$ext_name)
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
		do
			set_override_translation (a_translation,
					x_event_vision_callback (a_command), argument)
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
		do
			add_destroy_callback (mel_vision_callback (a_command), 
					argument)
		end;

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		do
			add_event_handler (ButtonPressMask,
					x_button_vision_callback (a_command, number), argument)
		end;

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		do
			add_event_handler (ButtonReleaseMask,
					x_button_vision_callback (a_command, number), argument)
		end; 

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		local
			a_mask: POINTER
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
			if a_mask /= default_pointer then
				add_event_handler (a_mask, 
					x_event_vision_callback (a_command), argument)
			end
		end;

	add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked.
		do
			button_click_actions.add (number, a_command, argument)
		end;

	add_enter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer enter the window.
		do
			add_event_handler (EnterWindowMask,
					x_event_vision_callback (a_command), argument)
		end;

	add_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is pressed.
		do
			add_event_handler (KeyPressMask,
				x_event_vision_callback (a_command), argument)
		end;

	add_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when a key
			-- is released.
		do
			add_event_handler (KeyReleaseMask,
				x_event_vision_callback (a_command), argument)
		end;

	add_leave_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- pointer leave the window.
		do
			add_event_handler (LeaveWindowMask,	
				x_event_vision_callback (a_command), argument)
		end; 

	add_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved.
		do
			add_event_handler (PointerMotionMask,
				x_event_vision_callback (a_command), argument)
		end; 

feature -- Removal

	destroy (wid_list: LINKED_LIST [WIDGET]) is
			-- Destroy screen widget implementation and all
			-- screen widget implementations of its children
			-- contained in `wid_list;.
		do
			mel_destroy
		end; 

	remove_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current widget is destroyed.
		do
			remove_destroy_callback (mel_vision_callback (a_command), 
					argument)
		end;

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		do
			remove_override_translation (a_translation)
		end;

	remove_button_motion_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		local
			a_mask: POINTER
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
			if a_mask /= default_pointer then
				remove_event_handler (a_mask, 
					x_event_vision_callback (a_command), argument)
			end
		end; 

	remove_button_press_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is pressed.
		require
			not_a_command_void: a_command /= Void
		do
			remove_event_handler (ButtonPressMask,
					x_button_vision_callback (a_command, number), argument)
		end; 

	remove_button_release_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is released.
		do
			remove_event_handler (ButtonReleaseMask,
					x_button_vision_callback (a_command, number), argument)
		end; 

	remove_button_click_action (number: INTEGER; a_command: COMMAND; 
			argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- `number'-th mouse button is clicked.
		do
			button_click_actions.remove (number, a_command, argument)
		end;

	remove_enter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer enter the window.
		do
			remove_event_handler (EnterWindowMask,
					x_event_vision_callback (a_command), argument)
		end; 

	remove_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is pressed.
		do
			remove_event_handler (KeyPressMask,
				x_event_vision_callback (a_command), argument)
		end;

	remove_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when a key
			-- is released.
		do
			remove_event_handler (KeyReleaseMask,
				x_event_vision_callback (a_command), argument)
		end; 

	remove_leave_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when the
			-- pointer leave the window.
		do
			remove_event_handler (LeaveWindowMask,	
				x_event_vision_callback (a_command), argument)
		end; 

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to execute when the
			-- mouse is moved.
		do
			remove_event_handler (PointerMotionMask,
				x_event_vision_callback (a_command), argument)
		end; 

feature -- Update

	grab (a_cursor: SCREEN_CURSOR) is
			-- Grab the mouse and the keyboard.
			-- If `cursor' is not void, the pointer will have the shape
			-- set by cursor during the grab.
		require
			widget_realized: realized
		local
			a_cursor_implementation: SCREEN_CURSOR_X;
			void_pointer: POINTER
		do
			if (a_cursor = Void) then
				--c_grab (screen_object, void_pointer)
			else
				a_cursor_implementation ?= a_cursor.implementation;
				--c_grab (screen_object, a_cursor_implementation.cursor_id (screen))
			end
		end;

	ungrab is
			-- Release the mouse and the keyboard from an earlier grab.
		require
			widget_realized: realized
		
		do
			--c_ungrab (screen_object)
		end; 

feature {COLOR_X} -- Implementation

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_X;
		do
			color_implementation ?= background_color.implementation;
			--xm_change_bg_color (screen_object, color_implementation.pixel (screen))
		end;

feature {NONE} -- Implementation

	private_background_pixmap: PIXMAP;
			-- Pixmap used for background 
			-- (Void after creation)

	private_background_color: COLOR;
			-- Color used for the background.
			-- Void after creation.

feature {PIXMAP_X} -- Implementation

	update_background_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			ext_name: ANY;
			pixmap_implementation: PIXMAP_X;
		do
			--ext_name := MbackgroundPixmap.to_c;
		--	pixmap_implementation ?= background_pixmap.implementation;
			--c_set_pixmap (screen_object, pixmap_implementation.resource_pixmap (screen), $ext_name)
		end;

feature {SCREEN_CURSOR_X, ALL_CURS_X}

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
			display_pointer: POINTER;
			cursor_implementation: SCREEN_CURSOR_X
		do
			--display_pointer := xt_display (screen_object);
			--cursor_implementation ?= cursor.implementation;
			--x_define_cursor (display_pointer, 
			--			window, 
			--			cursor_implementation.cursor_id (screen));
			--x_flush (display_pointer)
		end;

feature {NONE} -- Implementation

	x_event_vision_callback (cmd: COMMAND): X_EVENT_CALLBACK is
			-- Convenience routine to create the xt
			-- callback handler for vision actions
		require
			non_void_cmd: cmd /= Void
		do
			!! Result.make (cmd)
		end;

	x_button_vision_callback (cmd: COMMAND; number: INTEGER): X_BUTTON_CALLBACK is
			-- Convenience routine to create the xt
			-- callback handler for vision actions
		require
			non_void_cmd: cmd /= Void
		do
			!! Result.make (cmd, number)
		end;

	mel_vision_callback (cmd: COMMAND): MEL_VISION_CALLBACK is
			-- Convenience routine to create the motif
			-- callback handler for vision actions
		require
			non_void_cmd: cmd /= Void
		do
			!! Result.make (cmd)
		end;

feature {NONE} -- Implementation
	
	click_actions_table: HASH_TABLE [BUTTON_CLICK_HAND_X, POINTER] is
			-- Table of click actions for all widgets
		once
			!! Result.make (2)
		end;

	button_click_actions: BUTTON_CLICK_HAND_X is
			-- Button click actions for Current widget
		do
			Result := click_actions_table.item (screen_object);
			if Result = Void then	
				!! Result.make;
				click_actions_table.put (Result, screen_object)
			end;
		ensure
			non_void_result: Result /= Void
		end
			

	mel_parent (a_widget: WIDGET; index: INTEGER): MEL_COMPOSITE is
			-- Retrieve mel parent from the widget manage for 
			-- `widget' using `index'
		local
			motif_decl: MOTIF_DECLARATOR
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

feature {NONE} -- External features

	c_ungrab (scr_obj: POINTER) is
		external
			"C"
		end; 

	c_grab (scr_obj, a_cursor: POINTER) is
		external
			"C"
		end; 

end -- class WIDGET_M

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
