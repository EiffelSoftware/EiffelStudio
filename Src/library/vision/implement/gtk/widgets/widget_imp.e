indexing

	description: 
		"EiffelVision implementation of a gtk widget."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
--XX deferred class

class
	WIDGET_IMP
	
inherit
	WIDGET_I
	
	GTK_EXTERNALS
	GTK_CONSTANTS
	
	G_ANY_I
	W_MAN_GEN
		export
			{NONE} all
		end;
	
	
	
feature -- Access

	get_multi_click_time: INTEGER is
			-- Get time granted for clicking
		do
			check
				not_yet_implemented: False
			end
		end;

	background_color: COLOR is
			-- Background color of widget
		do
			check
				not_yet_implemented: False
			end

		end;

	background_pixmap: PIXMAP is
			-- Background pixmap of widget
		do
			check
				not_yet_implemented: False
			end

		end;

	cursor: SCREEN_CURSOR is
			-- Cursor of current widget
		do
			check
				not_yet_implemented: False
			end

		end;

	height: INTEGER is
			-- Height of widget
		do
			Result := c_gtk_widget_height (widget)
		end;

	real_x: INTEGER is
			-- Horizontal position relative to root window
		do
			check
				not_yet_implemented: False
			end

		end;

	real_y: INTEGER is
			-- Vertical position relative to root window
		do
			check
				not_yet_implemented: False
			end

		end;

	screen: SCREEN_I is
			-- Screen of widget
		do
			check
				not_yet_implemented: False
			end

		end;

	screen_object: POINTER is
			-- Screen object implementation of current widget
		do
			check
				not_yet_implemented: False
			end

		end;

	width: INTEGER is
			-- Width of widget
		do
			Result := c_gtk_widget_width (widget)			
		end;

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			check
				not_yet_implemented: False
			end

		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			check
				not_yet_implemented: False
			end

		end	
	

	widget_index: INTEGER;
			-- Widget index in window manager
	
feature -- Access (Not in oui)	
	
	widget_oui: WIDGET is
			-- Object user interface widget associated with current
			-- implementation
		do
			Result := widget_manager.widget_at (widget_index);
		end;
	
feature {SCREEN_CURSOR_IMP, ALL_CURS_X} -- Not in oui
--XX
	define_cursor (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require
			a_cursor_exists: a_cursor /= Void
		do
		end;
	
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
		do
			define_cursor (cursor);
--XX			display.flush
		end;
	
feature {COLOR_IMP} -- Implementation (not in oui)

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_IMP;
		do
			color_implementation ?= private_background_color.implementation;
			color_implementation.allocate_pixel;
--XX			set_background_color_from_imp (color_implementation)
		end;

feature {RESOURCE_X} -- Implementation (not in oui)

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
--XX			mel_set_background_pixmap (pixmap_implementation)
		end;
	
feature -- Status report

	realized: BOOLEAN is
			-- Is screen window realized?
		do
			Result := c_gtk_widget_realized (widget)
		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
		do
			Result := not c_gtk_widget_sensitive (widget)			
		end

	managed: BOOLEAN is
			-- Is there geometry managment on screen
			-- widget implementation performed by window
			-- manager of parent widget?
		
			-- No real use in GTK ???
		do
			Result := managed_imp
		end
	
	
	

	shown: BOOLEAN is
			-- Is current widget visible?
		do
			Result := c_gtk_widget_visible (widget)
		end

	clean_up is
			-- Clean up data information for destroyed widget.
		do
			check
				not_yet_implemented: False
			end

		end
	
	
feature -- Status setting
	
	

	lower is
		-- lower current to the bottom of its
		-- peers stacking order
		do
			check
				not_yet_implemented: False
			end

		end

	hide is
		do
			gtk_widget_hide (widget)
		end

	destroy (wid_list: LINKED_LIST [WIDGET]) is
		-- The argument not used yet
		do
			gtk_widget_destroy (widget)
		end

	grab (a_cursor: SCREEN_CURSOR) is
			-- Grab the mouse and the keyboard.
			-- If `cursor' is not void, the pointer will have the shape
			-- set by cursor during the grab.
		do
			check
				not_yet_implemented: False
			end

		end;

	propagate_event is
			-- Propagate event to direct ancestor if no action
			-- is specified for event. 
		do
			check
				not_yet_implemented: False
			end

		end

	raise is
			-- Raise current to top of peer stacking order
		do
			check
				not_yet_implemented: False
			end

		end

	realize is
			-- Create screen window implementation and all
			-- screen window implementations of its children if `flag'.
		do
			gtk_widget_realize (widget)
			show  -- Realize in GTK does not automatically show the widget
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		do
			gtk_widget_set_sensitive (widget, not flag)
		end

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget
			-- implementation, by window manager of parent
			-- widget if `flag', disable it otherwise.
		
			-- No use in GTK??
		do
			managed_imp := flag
		end

	set_no_event_propagation is
			-- Don't propagate event to direct ancestor.
		do
			check
				not_yet_implemented: False
			end

		end

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		do
			gtk_widget_set_usize (widget, new_width, new_height)
		end

	set_widget_default is
			-- Set the widget default after creating 
			-- associated oui widget.
		do
		end

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		do
			gtk_widget_set_usize (widget, new_width, height)			
		end

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x' relative
			-- to parent.
		do
			check
				not_yet_implemented: False
			end

		end

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			gtk_widget_set_uposition (widget, new_x, new_y)
		end

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y' relative
			-- to parent.
		do
			check
				not_yet_implemented: False
			end

		end
	
	show is
		do
			if managed then
				gtk_widget_show (widget)
			end
		end


	ungrab is
			-- Release the mouse and the keyboard from an earlier grab.
		do
			check
				not_yet_implemented: False
			end

		end

	unrealize is
			-- Destroy screen window implementation and all
			-- screen window implementations of its children if `flag'.
		do
			gtk_widget_unrealize (widget)
		end
	
	
	feature -- Status Report

	foreground_color: COLOR is
			-- Color used for the foreground_color
		local
			fg_color_x: COLOR_IMP
		do
-- 			if private_foreground_color = Void then
-- 				!! private_foreground_color.make;
-- 				fg_color_x ?= private_foreground_color.implementation;
-- 				fg_color_x.set_default_pixel (mel_foreground_color, 
-- 						mel_screen.default_colormap);
-- 				fg_color_x.increment_users
-- 			end;
-- 			Result := private_foreground_color;
		end;

feature -- Status Setting

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		local
			color_implementation: COLOR_IMP;
			ext_name: ANY;
			pixel: POINTER
		do
			if private_foreground_color /= Void then
				color_implementation ?= private_foreground_color.implementation;
				color_implementation.decrement_users;
			end;
			private_foreground_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.increment_users;
			color_implementation.allocate_pixel;
--XX			mel_set_foreground_color (color_implementation)
		end;

feature {COLOR_IMP} -- Implementation

	private_foreground_color: COLOR;
			-- Foreground_color colour

	update_foreground_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_IMP
		do
			color_implementation ?= private_foreground_color.implementation;
			color_implementation.allocate_pixel;
--XXX			mel_set_foreground_color (color_implementation);
		end

	
feature -- Element change	
	
	set_widget_index (index: INTEGER) is
			-- Set widget_index to `index'.
		do
			widget_index := index
		end;

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when
			-- `a_translation' occurs.  `a_translation' is
			-- specified with Xtoolkit convention.
		do
			check
				not_yet_implemented: False
			end
		end;

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		do
			check
				not_yet_implemented: False
			end
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set background pixmap to `a_pixmap'.
		do
			check
				not_yet_implemented: False
			end
		end;

	set_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set `cursor' of current widget to `a_cursor'.
		do
			check
				not_yet_implemented: False
			end
		end;

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do
			gtk_widget_set_usize (widget, width, new_height)	
		end;

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when the `number'-th mouse button
			-- is pressed.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when the `number'-th mouse button
			-- is released.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when the `number'-th mouse button
			-- is clicked
		do
			check
				not_yet_implemented: False
			end
		end;

	set_multi_click_time (time: INTEGER) is
			-- Set time granted for clicking
		do
			check
				not_yet_implemented: False
			end
		end;

	add_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when current widget is destroyed.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_enter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when the pointer enter the window.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when a key is pressed.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when a key is released.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_leave_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when the pointer leave the window.
		do
			check
				not_yet_implemented: False
			end
		end;

	add_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to
			-- execute when the mouse is moved.
		do
			check
				not_yet_implemented: False
			end
		end;

feature -- Removal

	remove_action (a_translation: STRING) is
			-- Remove the command executed when
			-- `a_translation' occurs.  Do nothing if no
			-- command has been specified.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to
			-- execute when the mouse is moved while the
			-- `number'-th mouse button is pressed.

		do
			check
				not_yet_implemented: False
			end
		end;

	remove_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to
			-- execute when the `number'-th mouse button
			-- is pressed.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to
			-- execute when the `number'-th mouse button
			-- is released.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to
			-- execute when the `number'-th mouse button
			-- is clicked.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action
			-- to execute when current widget is
			-- destroyed.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_enter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action
			-- to execute when the pointer enter the
			-- window.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to
			-- execute when a key is pressed.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to
			-- execute when a key is released.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_leave_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action
			-- to execute when the pointer leave the
			-- window.
		do
			check
				not_yet_implemented: False
			end
		end;

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to
			-- execute when the mouse is moved.
		do
			check
				not_yet_implemented: False
			end
		end;
	
feature {WIDGET_IMP}

	widget: POINTER
			-- pointer to the C structure representing this widget

	set_parent (new_parent: COMPOSITE_IMP) is
		do
			parent := new_parent
		end
	
feature {NONE} -- Implementation
	

	parent: WIDGET_IMP
			-- containing widget	
	
	managed_imp: BOOLEAN
			-- managed flag
	
	common_widget_make (man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Common things for creation of all widgets
			-- setting widget index, adding widget to parent, 
			-- setting the manager attribute
		local
			c: COMPOSITE_IMP
		do
			c ?= oui_parent.implementation;
			
			check
				valid_composite: c /= Void
			end
			widget_index := widget_manager.last_inserted_position
			c.add_widget (Current)
			set_managed (man)
		end
	
		
feature {NONE} -- Implementation
	
	c_widget_of_push_b (p: PUSH_B): POINTER is 
			-- C pointer to the widget of p
		require
			not_void: p /= Void
		local
			imp: PUSH_B_IMP
		do
			imp ?= p.implementation
			Result := imp.widget
		end
	
	c_widget_of_label (l: LABEL): POINTER is 
			-- C pointer to the widget of l
		require
			not_void: l /= Void
		local
			imp: LABEL_IMP
		do
			imp ?= l.implementation
			Result := imp.widget
		end
	

invariant

	widget_valid: widget /= default_pointer

end

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

