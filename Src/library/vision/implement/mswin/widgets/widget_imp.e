indexing
	description: "This class represents a MS_IMPwidget"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIDGET_IMP

inherit
	G_ANY_IMP

	W_MAN_GEN

	WIDGET_I

	BUTTONS_MANAGER_WINDOWS

	CURSOR_WIDGET_MANAGER

	VIRTUAL_KEYS_WINDOWS

	HASHABLE_WIDGET_WINDOWS

	GLOBAL_CURSOR_MANAGER

	ACTIONS_MANAGER_CONTROLLER_WINDOWS

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_HWND_CONSTANTS
		export
			{NONE} all
		end

	WEL_SWP_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_MK_CONSTANTS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

feature -- Access 

	parent: COMPOSITE_IMP;
			-- Parent widget

	screen: SCREEN_I is
			-- Screen of widget
		do
			Result := widget_manager.screen (widget_oui).implementation
		end;

	screen_object: POINTER is
			-- Screen object implementation of current widget
		do
			Result := wel_item
		end;

	owner: WIDGET is
			-- Corresponding widget
		do
			Result := widget_manager.implementation_to_oui (Current)
		end;

feature  -- Status report

	background_color: COLOR is
			-- Color used for the background.
		local
			wel_color: WEL_COLOR_REF
		do
			Result := private_background_color
			if Result = Void then
				!! Result.make
				!! wel_color.make_system (Color_btnface)
				Result.set_red (wel_color.red * 256)
				Result.set_green (wel_color.green * 256)
				Result.set_blue (wel_color.blue * 256)
			end
		end

	background_pixmap: PIXMAP;
			-- Pixmap used for the background

	cursor: SCREEN_CURSOR
			-- Screen cursor of current widget

	get_multi_click_time: INTEGER is
			-- Call to system resources
		do
			Result := double_click.double_click_time
		end;

	height: INTEGER is
			-- Height of widget
		do
			if exists then
				Result := wel_height
			else
				Result := private_attributes.height
			end
		end;

	client_height: INTEGER is
			-- Height of the client rectangle of current widget
		do
			if exists then
				Result := client_rect.height
			end
		end

	form_height: INTEGER is
			-- Height used by forms
		do
			Result := client_height
		end

	insensitive: BOOLEAN is
			-- Is current widget insensitive?
		do
			if exists then
				Result := not enabled
			else
				Result := private_attributes.insensitive
			end
		end;

	managed: BOOLEAN;
			-- Is current widget managed?

	realized: BOOLEAN is
			-- Is this widget realized?
		do
			Result := exists
		end;

	real_x: INTEGER is
			-- Horizontal position relative to corner of screen
		do
			if exists then
				Result := absolute_x
			else
				Result := private_attributes.x
			end
		end;

	real_y: INTEGER is
			-- Vertical position relative to corner of screen
		do
			if exists then
				Result := absolute_y
			else
				Result := private_attributes.y
			end
		end;

	shown: BOOLEAN
			-- Is current widget visible on the screen?
			-- |Motif like shown

	width: INTEGER is
			-- Width of widget
		do
			if exists then
				Result := wel_width
			else
				Result := private_attributes.width
			end
		end;

	client_width: INTEGER is
			-- Width of the client_rectangle of current widget
		do
			if exists then
				Result := client_rect.width
			end
		end

	form_width: INTEGER is
			-- Width used by forms
		do
			Result := client_width
		end

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			if exists then
				Result := wel_x
			else
				Result := private_attributes.x
			end
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			if exists then
				Result := wel_y
			else
				Result := private_attributes.y
			end
		end;

	screen_cursor: SCREEN_CURSOR_IMP;
			-- Screen cursor associated to current widget

	valid_background_pixmap (a_pixmap : PIXMAP): BOOLEAN is
			-- Is `a_pixmap' valid for current widget?
		do
			Result := False		
		end

	valid_background_color (a_color: COLOR): BOOLEAN is
			-- Is `a_color' valid for current widget?
		do
			Result := False
		end

feature -- Status setting

	destroy (wid_list: LINKED_LIST [WIDGET]) is
			-- Destroy screen widget implementation and all
			-- screen widget implementations of its children
			-- contained in wid_list
		local
			ww: WIDGET_IMP
		do
			from
				wid_list.start
			until
				wid_list.after
			loop
				ww ?= wid_list.item.implementation
				if ww /= Void then
					actions_manager_list.deregister (ww)
				end
				wid_list.forth
			end

			if exists then
				wel_destroy
			end
		end;

	get_focus is
			-- Get the focus.
		do
			if exists then
				wel_set_focus
			end
		end;

	grab (a_cursor: SCREEN_CURSOR) is
			-- Grab the mouse and the keyboard.
			-- If cursor is not Void, the pointer will have the shape
			-- set by cursor during the grab.
		local
			cursor_windows: SCREEN_CURSOR_IMP
		do
			if exists then
				wel_set_capture
			end;
			if a_cursor /= Void then
				cursor_windows ?= a_cursor.implementation;
				if cursor_windows /= Void and then cursor_windows.exists then
					cursor_windows.set
				end
				grabbed_cursor_implementation.replace (cursor_windows)
			end
		end;

	hide is
			-- Make widget invisible on the screen
		do
			if exists then
				wel_hide
			end
			shown := False
		end;

	realize is
			-- Realize the object.
		deferred
		end;

	raise is
			-- Raise current to top of peer stacking order
		do
			if exists then
				set_z_order (Hwnd_top)
				wel_set_focus
			end
		end;

	lower is
			-- Lower current to the bottom of peer stacking order
		do
			if exists then
				set_z_order (hwnd_bottom)
			end
		end;

	release_focus is
			-- Do nothing.
		do
		end;

	set_background_color (a_color: COLOR) is
			-- Set the background color to `a_color'
			-- We may need a call to UpdateWindow
		do
			private_background_color := a_color;
			if exists then
				invalidate
			end
		end;

	set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set the background pixmap
			-- but does nothing
		require else
			always_true: True
		do
			background_pixmap := a_pixmap
			if exists then
				invalidate
			end
		ensure then
			pixmap_set: valid_background_pixmap (a_pixmap) implies background_pixmap = a_pixmap
		end;

	set_cursor (a_cursor: SCREEN_CURSOR) is
			-- Set the cursor to `a_cursor'.
		do
			screen_cursor ?= a_cursor.implementation
		end;

	set_form_height (a_height: INTEGER) is
			-- Set the height used by forms.
		do
			if form_height /= a_height then
				private_attributes.set_height (a_height)
				if exists then
					wel_set_height (a_height)
				end;
			end
		end

	set_height (a_height: INTEGER) is
			-- Set height to `new_height'.
		do
			if private_attributes.height /= a_height then
				private_attributes.set_height (a_height)
				if exists then
					wel_set_height (a_height)
				end;
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end;

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		do
			private_attributes.set_insensitive (flag)
			if exists then
				if flag then
					disable
				else
					enable
				end
			end
		end;

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		local
			cw: COMPOSITE_IMP;
			i: INTEGER;
			c: ARRAY [WIDGET_IMP]
		do
			managed := flag;
			if parent /= Void and parent.realized and then parent.exists then
				if managed then
					if realized then
						if parent.wel_shown and not wel_shown then 
							wel_show
						end
						cw ?= Current;
						if cw /= Void then
							c := cw.children;
							from
								i := 1
							variant
								c.count + 1 - i
							until
								i > c.count
							loop
								if c.item (i).managed and not c.item (i).realized then
									c.item (i).realize
								end
								if c.item (i).managed then
									c.item (i).show
								end
								i := i + 1
							end
						end
					else
						realize
					end
				elseif exists and wel_shown then
					wel_hide
				end;
				parent.child_has_resized
			end
		end

	set_multi_click_time (new_time: INTEGER) is
			-- Set the double click time.
		do
			check
				valid_new_time: new_time > 0
			end
			double_click.set_double_click_time (new_time)
		end;

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to new_height,
			-- width to `new_width'.
		do
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				private_attributes.set_width (new_width)
				private_attributes.set_height (new_height)
				if exists then
					resize (new_width, new_height)
				end
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end;

	set_widget_default is
			-- Set the defaults for current widget.
		do
			if managed and then parent.realized then
				realize;
				parent.child_has_resized
			elseif parent.realized and then not managed then
				realize
				set_managed (False)
			end
		end;

	set_form_width (a_width: INTEGER) is
			-- Set the width for form.
		do
			if form_width /= a_width then
				private_attributes.set_width (a_width)
				if exists then
					wel_set_width (a_width)
				end
			end
		end

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (new_width)
				end;
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end;

	set_x (new_x: INTEGER) is
			-- Set `x' to `new_x'.
		do
			private_attributes.set_x (new_x)
			if exists then
				wel_set_x (new_x)
			end
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set `x' to `new_x', `y' to `new_y'.
		do
			private_attributes.set_y (new_y)
			private_attributes.set_x (new_x)
			if exists then
				wel_move (new_x, new_y)
			end
		end;

	set_y (new_y: INTEGER) is
			-- Set `y' to `new_y'.
		do
			private_attributes.set_y (new_y)
			if exists then
				wel_set_y (new_y)
			end
		end

	show is
			-- Show widget on screen.
		do
			if exists
			and then ((parent /= Void and then parent.wel_shown)
			or (parent = Void)) then 
				wel_show
			end
			shown := (parent /= Void and parent.shown) or (parent = Void)
		end

	ungrab is
			-- Release the mouse and the keyboard from an earlier grab.
		do
			if exists then
				wel_release_capture
			end;
			if grabbed_cursor_implementation.item /= Void then
				if grabbed_cursor_implementation.item.previous_cursor /= Void then
					grabbed_cursor_implementation.item.restore_previous
				end
				grabbed_cursor_implementation.replace (Void)
			end
		end;

	unrealize is
			-- Unrealize the widget
		do
			wel_destroy
		end;

feature -- Element change

	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		do
			inspect number
			when 1 then 
				left_button_motion_actions.add (Current, a_command, argument)
			when 2 then 
				middle_button_motion_actions.add (Current, a_command, argument)
			when 3 then 
				right_button_motion_actions.add (Current, a_command, argument)
			end
		end;

	add_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- `number'-th mouse button is pressed.
		do
			inspect number
			when 1 then 
				left_button_press_actions.add (Current, a_command, argument)
			when 2 then 
				middle_button_press_actions.add (Current, a_command, argument)
			when 3 then
				right_button_press_actions.add (Current, a_command, argument)
			end
		end;

	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- `number'-th mouse button is released.
		do
			inspect number
			when 1 then 
				left_button_release_actions.add (Current, a_command, argument)
			when 2 then 
				middle_button_release_actions.add (Current, a_command, argument)
			when 3 then 
				right_button_release_actions.add (Current, a_command, argument)
			end
		end;

	add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- `number'-th mouse button is clicked.
		do
		end;

	add_resize_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- window resizes or moves.
		do
			resize_actions.add (Current, a_command, argument)
		end			

	add_enter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- pointer enter the window.
		do
			enter_actions.add (Current, a_command, argument)
		end;

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when
			-- the widget is exposed
		do
			expose_actions.add (Current, a_command, argument)
		end;

	add_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when a key
			-- is pressed.
		do
			key_press_actions.add (Current, a_command, argument)
		end;

	add_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when a key
			-- is released.
		do
			key_release_actions.add (Current, a_command, argument)
		end;

	add_leave_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- pointer leave the window.
		do
			leave_actions.add (Current, a_command, argument)
		end;

	add_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- mouse is moved.
		do
			pointer_motion_actions.add (Current, a_command, argument)
		end;

	add_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- widget is destroyed.
		do
			destroy_actions.add (Current, a_command, argument)
		end;

	add_map_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- widget is mapped.
		do
			map_actions.add (Current, a_command, argument)
		end

	add_unmap_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- widget is unmapped.
		do
			unmap_actions.add (Current, a_command, argument)
		end

	add_visible_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of actions to execute when the
			-- widget is unmapped.
		do
			visible_actions.add (Current, a_command, argument)
		end

	remove_map_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of actions to execute when the
			-- widget is mapped.
		do
			map_actions.remove (Current, a_command, argument)
		end

	remove_unmap_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of actions to execute when the
			-- widget is unmapped.
		do
			unmap_actions.remove (Current, a_command, argument)
		end

	remove_visible_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of actions to execute when the
			-- widget is unmapped.
		do
			visible_actions.remove (Current, a_command, argument)
		end

feature -- Removal

	remove_action (a_translation: STRING) is
			-- Remove a command according to the
			-- translation. See X windows reference guide.
		local
			translation: TRANSLATION_COMMAND;
			argument: ANY
			c: CURSOR
		do
			if translation_commands /= Void then
				from
					c := translation_commands.cursor
					translation_commands.start
				until
					translation_commands.off or else
					translation_commands.item.translation.is_equal (a_translation)
				loop
					translation_commands.forth
				end;
				if not translation_commands.off then
					translation := translation_commands.item;
					argument := translation.argument;
					if translation.key_action then
						remove_key_press_action (translation, argument)
					end;
					if translation.mouse_action then
						if translation.mouse_button /= 0 then
							if translation.direction_up then
								remove_button_release_action (translation.mouse_button, translation, argument)
							else
								remove_button_press_action (translation.mouse_button, translation, argument)
							end
						else
							if translation.direction_up then
								remove_button_release_action (1, translation, argument);
								remove_button_release_action (2, translation, argument);
								remove_button_release_action (3, translation, argument)
							else
								remove_button_press_action (1, translation, argument);
								remove_button_press_action (2, translation, argument);
								remove_button_press_action (3, translation, argument)
							end
						end
					else
						if translation.other_action then
							if translation.configure_action then
								remove_resize_action (translation, argument)
							elseif translation.map_action then
								remove_map_action (translation, argument)
							elseif translation.unmap_action then
								remove_unmap_action (translation, argument)
							elseif translation.visible_action then
								remove_visible_action (translation, argument)
							end
						end
					end
				end
				translation_commands.go_to (c)
			end
		end;

	remove_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when the
			-- mouse is moved while the `number'-th mouse button is pressed.
		do
			inspect number
			when 1 then 
				left_button_motion_actions.remove (Current, a_command, argument)
			when 2 then 
				middle_button_motion_actions.remove (Current, a_command, argument)
			when 3 then 
				right_button_motion_actions.remove (Current, a_command, argument)
			end
		end;

	remove_resize_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' with `argument' from the list of action
			-- to be executed when current area is resized.
		do
			resize_actions.remove (Current, a_command, arg)
		end

	remove_button_press_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when the
			-- `number'-th mouse button is pressed.
		do
			inspect number
			when 1 then 
				left_button_press_actions.remove (Current, a_command, argument)
			when 2 then 
				middle_button_press_actions.remove (Current, a_command, argument)
			when 3 then 
				right_button_press_actions.remove (Current, a_command, argument)
			end
		end;

	remove_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when the
			-- `number'-th mouse button is released.
		do
			inspect number
			when 1 then 
				left_button_release_actions.remove (Current, a_command, argument)
			when 2 then 
				middle_button_release_actions.remove (Current, a_command, argument)
			when 3 then 
				right_button_release_actions.remove (Current, a_command, argument)
			end
		end;

	remove_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when the
			-- `number'-th mouse button is clicked.
		do
		end;

	remove_destroy_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when the
			-- widget is destroyed.
		do
			destroy_actions.remove (Current, a_command, argument)
		end;

	remove_enter_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command from the list of actions to execute when the
			-- pointer enter the window.
		do
			enter_actions.remove (Current, a_command, argument)
		end;

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when
			-- the widget is exposed
		do
			expose_actions.remove (Current, a_command, argument)
		end;

	remove_key_press_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when a key
			-- is pressed.
		do
			key_press_actions.remove (Current, a_command, argument)
		end;

	remove_key_release_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when a key
			-- is released.
		do
			key_release_actions.remove (Current, a_command, argument)
		end;

	remove_leave_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command from the list of actions to execute when the
			-- pointer leave the window.
		do
			leave_actions.remove (Current, a_command, argument)
		end;

	remove_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove a_command to the list of actions to execute when the
			-- mouse is moved.
		do
			pointer_motion_actions.remove (Current, a_command, argument)
		end;

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set an action according to `a_translation'.
		local
			translation: TRANSLATION_COMMAND;
		do
			!! translation.make (a_translation, a_command, argument);
			remove_equivalent_translation (translation);
			if translation_commands = Void then
				!! translation_commands.make
			end;
			translation_commands.extend (translation);
			if translation.key_action then
				if translation.direction_up then
					add_key_release_action (translation, argument)
				else
					add_key_press_action (translation, argument)
				end
			end;
			if translation.mouse_action then
				if translation.mouse_button /= 0 then
					if translation.direction_up then
						add_button_release_action (translation.mouse_button, translation, argument)
					else
						add_button_press_action (translation.mouse_button, translation, argument)
					end
				else
					if translation.direction_up then
						add_button_release_action (1, translation, argument);
						add_button_release_action (2, translation, argument);
						add_button_release_action (3, translation, argument)
					else
						add_button_press_action (1, translation, argument);
						add_button_press_action (2, translation, argument);
						add_button_press_action (3, translation, argument)
					end
				end
			end;
			if translation.other_action then
				if translation.configure_action then
					add_resize_action (translation, argument)
				elseif translation.map_action then
					add_map_action (translation, argument)
				elseif translation.unmap_action then
					add_unmap_action (translation, argument)
				elseif translation.visible_action then
					add_visible_action (translation, argument)
				end
			end
		end;

feature -- Implementation

	on_vision_mouse_enter is
			-- Vision message.
			-- The mouse entered current widget.
			-- Update the cursor_widget and send
			-- leave message if necessary.
		do
			if cursor_widget /= Current then
				if cursor_widget /= Void then
					cursor_widget.on_mouse_leave
				end;
				set_cursor_widget (Current);
				on_mouse_enter
			end;
		end

	private_background_color: COLOR;
			-- Color used for the background.
			-- Not set at creation

	absolute_x: INTEGER is
			-- Absolute x coordinate
		deferred
		end

	absolute_y: INTEGER is
			-- Absolute y coordinate
		deferred
		end

	client_rect: WEL_RECT is
			-- Client rectangle
		deferred
		end

	enable is
			-- Enable the widget.
		deferred
		end

	enabled: BOOLEAN is
			-- Is this widget enabled?
		deferred
		end

	disable is
			-- Disable the widget.
		deferred
		end

	exists: BOOLEAN is
			-- Does this widget exist?
		deferred
		end

	invalidate is
			-- Invalidate this widget.
		deferred
		end

	resize (new_width, new_height: INTEGER) is
			-- Resize widget to `new_width' and `new_height'
		deferred
		end

	wel_destroy is
			-- Destroy the window
		deferred
		end

	wel_hide is
			-- Hide the window
		deferred
		end

	wel_show is
			-- Show the window
		deferred
		end

	wel_width: INTEGER is
			-- Window width
		deferred
		end

	wel_height: INTEGER is
			-- Window height
		deferred
		end

	wel_text: STRING is
			-- Window text
		deferred
		end

	wel_set_text (a_text: STRING) is
			-- Set the window text
		deferred
		end

	wel_set_x (a_x: INTEGER) is
			-- Set `x' with `a_x'
		deferred
		end

	wel_set_y (a_y: INTEGER) is
			-- Set `y' with `a_y'
		deferred
		end

	wel_set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'
		deferred
		end

	wel_set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'
		deferred
		end

	wel_shown: BOOLEAN is
			-- Is the window shown?
		deferred
		end

	wel_parent: WEL_WINDOW is
			-- Parent window
		deferred
		end

	wel_move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
		deferred
		end

	wel_set_focus is
			-- Set the focus to `Current'
		deferred
		end

	wel_set_capture is
			-- Set the mouse capture to the `Current' window.
			-- Once the window has captured the mouse, all
			-- mouse input is directed to this window, regardless
			-- of wheter the cursor is over that window. Only
			-- one window can have the mouse capture at a time.
		deferred
		end

	wel_release_capture is
			-- Release the mouse capture after a call
			-- to `set_capture'.
		deferred
		end

	disable_default_processing is
			-- Prevent default_processing of a message by windows.
		deferred
		end

	set_z_order (z_order: POINTER) is
			-- Set the z-order of the window.
		deferred
		end

	wel_item: POINTER is
		deferred
		end

	wel_x: INTEGER is
			-- Window x position
		deferred
		end

	wel_y: INTEGER is
			-- Window y position
		deferred
		end

	on_mouse_leave is
			-- Mouse leave
		local
			cd: CONTEXT_DATA
		do
			if exists then
				!! cd.make (owner);
				leave_actions.execute (Current, cd)
			end
		end;

	on_mouse_enter is
			-- Mouse enter
		local
			cd: CONTEXT_DATA
		do
			!! cd.make (owner);
			enter_actions.execute (Current, cd)
		end;

feature {NONE} -- Implementation

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		require
			exists: exists
		local
			resize_data: RESIZE_CONTEXT_DATA
		do
			!! resize_data.make (owner, a_width, a_height, size_type)
			resize_actions.execute (Current, resize_data)
		end

	on_move (x_pos, y_pos: INTEGER) is
			-- Wm_move message.
			-- This message is sent after a window has been moved.
			-- `x_pos' specifies the x-coordinate of the upper-left
			-- corner of the client area of the window.
			-- `y_pos' specifies the y-coordinate of the upper-left
			-- corner of the client area of the window.
		require
			exists: exists
		do
			resize_actions.execute (Current, Void)
		end

	on_hide is
			-- Wm_showwindow message.
			-- Execute a visible command if appropriate.
		require
			exists: exists
		do
			visible_actions.execute (Current, Void)
		end

	on_show is
			-- Wm_showwindow message.
			-- Execute a visible command if appropriate.
		require
			exists: exists
		do
			visible_actions.execute (Current, Void)
		end

	on_vision_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- EiffelVision mouse move event
		local
			cd: MOTNOT_DATA
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			!! wp.make (x_pos, y_pos)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			!! cd.make (owner, x_pos, y_pos, e_x, e_y, buttons_state);
			pointer_motion_actions.execute (Current, cd)
		end;

	double_click: WEL_DOUBLE_CLICK is
			-- Windows double click
		once
			!! Result
		ensure
			result_exists: Result /= Void
		end;

	left_button_down_widget_implementation: CELL [WIDGET_IMP] is
			-- Widget down with left button implementation
		once
			!! Result.put (Void)
		ensure
			result_exists: Result /= Void
		end;

	middle_button_down_widget_implementation: CELL [WIDGET_IMP] is
			-- Widget down with middle button implementation
		once
			!! Result.put (Void)
		ensure
			result_exists: Result /= Void
		end;

	right_button_down_widget_implementation: CELL [WIDGET_IMP] is
			-- Widget down with right button implementation
		once
			!! Result.put (Void)
		ensure
			result_exists: Result /= Void
		end;

	left_button_down_widget: WIDGET_IMP is
			-- Widget down with left button
		do
			Result := left_button_down_widget_implementation.item
		end;

	middle_button_down_widget: WIDGET_IMP is
			-- Widget down with middle button
		do
			Result := middle_button_down_widget_implementation.item
		end;

	right_button_down_widget: WIDGET_IMP is
			-- Widget down with right button
		do
			Result := right_button_down_widget_implementation.item
		end;

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mousemove message
		do
			on_vision_mouse_enter
			if flag_set (keys, Mk_lbutton) then
					on_lbutton_move (keys, x_pos, y_pos)
			elseif flag_set (keys, Mk_mbutton) then
					on_mbutton_move (keys, x_pos, y_pos)
			elseif flag_set (keys, Mk_rbutton) then
					on_rbutton_move (keys, x_pos, y_pos)
			end
			on_vision_mouse_move (keys, x_pos, y_pos)
		end;

	on_lbutton_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse moves with the left button dowm
		local
			cd: MOTNOT_DATA
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			!! wp.make (x_pos, y_pos)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			!! cd.make (widget_oui, x_pos, y_pos, e_x, e_y, buttons_state)
			left_button_motion_actions.execute (Current, cd)
			--left_button_motion_actions.execute (left_button_down_widget, cd)
		end;

	on_mbutton_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse moves with the middle button dowm
		local
			cd: MOTNOT_DATA
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			!! wp.make (x_pos, y_pos)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			!! cd.make (widget_oui, x_pos, y_pos, e_x, e_y, buttons_state)
			middle_button_motion_actions.execute (Current, cd)
		end;

	on_rbutton_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse moves with the right button dowm
		local
			cd: MOTNOT_DATA
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			!! wp.make (x_pos, y_pos)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			!! cd.make (widget_oui, x_pos, y_pos, e_x, e_y, buttons_state)
			right_button_motion_actions.execute (Current, cd)
			--right_button_motion_actions.execute (right_button_down_widget, cd)
		end;

	on_left_button_down (keys, a_x, a_y: INTEGER) is
			-- Wm_lbuttondown message
			-- See class WEL_IMPK_CONSTANTS for `keys' value
		local
			cd: BTPRESS_DATA;
			k: KEYBOARD_WINDOWS
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			!! wp.make (a_x, a_y)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			left_button_down_implementation.set_item (true);
			left_button_down_widget_implementation.replace (Current);
			!! k.make_from_mouse_state (keys)
			!! cd.make (owner, a_x, a_y, e_x, e_y, 1, buttons_state, k);
			left_button_press_actions.execute (Current, cd)
		end;

	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Wm_lbuttonup message
			-- See class WEL_IMPK_CONSTANTS for `keys' value
		local
			cd: BUTREL_DATA;
			k: KEYBOARD_WINDOWS
			w: WIDGET_IMP
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			w := left_button_down_widget
			!! wp.make (a_x, a_y)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			left_button_down_implementation.set_item (false);
			left_button_down_widget_implementation.replace (void);
			!! k.make_from_mouse_state (keys)
			!! cd.make (owner, a_x, a_y, e_x, e_y, 1, buttons_state, k);
			left_button_release_actions.execute (Current, cd)
		end;

	on_right_button_down (keys, a_x, a_y: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_IMPK_CONSTANTS for `keys' value
		local
			cd: BTPRESS_DATA;
			k: KEYBOARD_WINDOWS
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
		do
			!! wp.make (a_x, a_y)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			right_button_down_implementation.set_item (true);
			right_button_down_widget_implementation.replace (Current);
			!! k.make_from_mouse_state (keys)
			!! cd.make (owner, a_x, a_y, e_x, e_y, 3, buttons_state, k);
			right_button_press_actions.execute (Current, cd)
		end;

	on_right_button_up (keys, a_x, a_y: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_IMPK_CONSTANTS for `keys' value
		local
			cd: BUTREL_DATA;
			k: KEYBOARD_WINDOWS
			wp: WEL_POINT
			e_x, e_y: INTEGER
			ww: WEL_WINDOW
			w: WIDGET_IMP
		do
			w := right_button_down_widget
			!! wp.make (a_x, a_y)
			ww ?= Current
			wp.client_to_screen (ww)
			e_x := wp.x
			e_y := wp.y
			right_button_down_implementation.set_item (true);
			!! k.make_from_mouse_state (keys)
			!! cd.make (owner, a_x, a_y, e_x, e_y, 3, buttons_state, k);
			right_button_down_widget_implementation.replace (void);
			right_button_release_actions.execute (Current, cd)
		end;

	on_key_down (code, flags: INTEGER) is
			-- Respond to a wm_key_down message.
		local
			cd: KYPRESS_DATA
			k: KEYBOARD_WINDOWS
		do
			check
				code_large_enough: code >= virtual_keys.lower
				code_small_enough: code <= virtual_keys.upper
			end
			!! k.make_from_key_state
			!! cd.make (owner, code, virtual_keys @ code, k);
			key_press_actions.execute (Current, cd)
		end;

	on_key_up (code, flags: INTEGER) is
			-- Respond to a wm_key_up message.
		local
			cd: KEYREL_DATA
			k: KEYBOARD_WINDOWS
		do
			check
				code_large_enough: code >= virtual_keys.lower
				code_small_enough: code <= virtual_keys.upper
			end
			!! k.make_from_key_state
			!! cd.make (owner, code, virtual_keys @ code, k);
			key_release_actions.execute (Current, cd)
		end;

	on_destroy is
			-- The window is about be to destroyed.
		local
			cd: CONTEXT_DATA
		do
			!! cd.make (owner);
			destroy_actions.execute (Current, cd)
		end;

	on_set_cursor (hit_code: INTEGER) is
			-- Wm_setcursor
		local 
			scw: SCREEN_CURSOR_IMP
		do
			scw := grabbed_cursor
			if scw /= Void then
				scw.set
			else
				scw := screen_cursor
				if scw /= Void then
					scw.set
					disable_default_processing
				else
					scw := global_cursor_windows
					if scw /= Void then
						scw.set
					end
				end
			end
		end;

	grabbed_cursor: SCREEN_CURSOR_IMP is
			-- Grabbed screen cursor
		do
			Result := grabbed_cursor_implementation.item
		end;

	grabbed_cursor_implementation: CELL [SCREEN_CURSOR_IMP] is
			-- Grabbed cursor implementation
		once
			!! Result.put (Void)
		ensure
			result_exists: Result /= Void
		end;

	translation_commands: LINKED_LIST [TRANSLATION_COMMAND];
			-- Translation commands

	remove_equivalent_translation (tr: TRANSLATION_COMMAND) is
			-- Remove an equivalent translation.
		local
			translation: TRANSLATION_COMMAND;
			argument: ANY
		do
			if translation_commands /= Void then
				from
					translation_commands.start
				until
					translation_commands.off
				loop
					if (translation_commands.item.equiv (tr)) then
						translation := translation_commands.item;
						argument := translation.argument;
						if translation.key_action then
							remove_key_press_action (translation, argument)
						end;
						if translation.mouse_action then
							if translation.mouse_button /= 0 then
								if translation.direction_up then
									remove_button_release_action (translation.mouse_button, translation, argument)
								else
									remove_button_press_action (translation.mouse_button, translation, argument)
								end
							else
								if translation.direction_up then
									remove_button_release_action (1, translation, argument);
									remove_button_release_action (2, translation, argument);
									remove_button_release_action (3, translation, argument)
								else
									remove_button_press_action (1, translation, argument);
									remove_button_press_action (2, translation, argument);
									remove_button_press_action (3, translation, argument)
								end
							end
						end
					end;
					translation_commands.forth
				end
			end
		end;

	widget_oui: WIDGET is
			-- Object user interface widget associated with
			-- current implementation
		do
			Result := widget_manager.implementation_to_oui (Current)
		end;

	widget_index: INTEGER;
			-- Widget index in widget manager

	set_widget_index (index: INTEGER) is
			-- Set widget_index to index
		do
			widget_index := index
		end;

	clean_up is
			-- Clean up current widget.
		do
		end;

	private_attributes: PRIVATE_ATTRIBUTES_WINDOWS
			-- Private attributes

	old_cursor_id: POINTER;
			-- the cursor id as it was before a grab.

	Id_default: INTEGER is 0;
			-- Identifier used for WEL

	class_background, background_brush: WEL_BRUSH is
			-- Default background.
		local
			pixmap_color: PIXMAP_IMP
			windows_color: COLOR_IMP
			wel_window: WEL_WINDOW
			wel_client_dc: WEL_CLIENT_DC
			wel_bitmap: WEL_BITMAP
		do
			wel_window ?= Current
			if background_pixmap /= Void
			and then wel_window /= Void and then wel_window.exists
			then
				pixmap_color ?= background_pixmap.implementation
				!! wel_client_dc.make (wel_window)
				wel_client_dc.get
				!! wel_bitmap.make_by_dib (wel_client_dc, pixmap_color.dib, dib_rgb_colors)
				!! Result.make_by_pattern (wel_bitmap)
				wel_client_dc.release
			elseif private_background_color = Void then
				!! Result.make_by_sys_color (Color_btnface + 1)
			else
				windows_color ?= private_background_color.implementation
				Result := windows_color.brush
			end	
		end

invariant
	private_attribute_exist: private_attributes /= Void

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

