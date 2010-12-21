note

	description:
		"Abstract notion of a dialog."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	DIALOG_IMP

inherit

	DIALOG_I
		rename
			is_cascade_grab as dialog_primary_application_modal,
			is_exclusive_grab as dialog_full_application_modal,
			is_no_grab as dialog_modeless,
			set_cascade_grab as set_dialog_primary_application_modal,
			set_exclusive_grab as set_dialog_full_application_modal,
			set_no_grab as set_dialog_modeless
		end;

	MEL_RECT_OBJ_RESOURCES;

	MEL_XT_FUNCTIONS;

	MEL_COMMAND;

	G_ANY_I

feature -- Access

	screen_object: POINTER
			-- C handle representing widget
		deferred
		end

	parent: MEL_DIALOG_SHELL
			-- Associated dialog shell
		deferred
		end;

	display: MEL_DISPLAY
			-- Associated display
		deferred
		end;

	is_stackable: BOOLEAN
			-- Is Current a stackable element?
			-- (No it is not)
		do
		end;

	is_popped_up: BOOLEAN;
			-- Is the popup widget popped up on screen ?

	is_shown: BOOLEAN
			-- Is current widget visible on the screen?
		do
			Result := parent.is_shown
		end;

	manage
			-- Manage dialog
		deferred
		end;

	unmanage
			-- Unmanage dialog
		deferred
		end;

	screen: SCREEN_I
			-- Associated screen
		deferred
		end

feature -- Status report

	title: STRING
			-- Application name to be displayed by
			-- the window manager
		do
			Result := parent.title
		end;

	widget_group: WIDGET
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		do
		end 

 	base_height: INTEGER
			-- Base for a progression of preferred heights
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred heights are `base_heights' plus
			-- integral multiples of `height_inc'
		do
			Result := parent.base_height
		end;

	base_width: INTEGER
			-- Base for a progression of preferred widths
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred widths are `base_heights' plus
			-- integral multiples of `width_inc'
		do
			Result := parent.base_width
		end;

	height_inc: INTEGER
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		do
			Result := parent.height_inc
		end;

	width_inc: INTEGER
			-- Increment for a progression of preferred
			-- widths for the window manager tu use in sizing
			-- widgets.
		do
			Result := parent.width_inc
		end;

	icon_mask: PIXMAP
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
		end;

	icon_pixmap: PIXMAP
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		do
		end;

	icon_x: INTEGER
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
			Result := parent.icon_x
		end; 

	icon_y: INTEGER
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		do
			Result := parent.icon_y
		end;

	max_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have
		do
			Result := parent.max_height
		end;

	max_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have
		do
			Result := parent.max_width
		end;

	min_aspect_x: INTEGER
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
			Result := parent.min_aspect_x
		end;

	min_aspect_y: INTEGER
			-- Denominator of minimum ration (X/Y) that
			-- application wishes widget instance to have
		do
			Result := parent.min_aspect_y
		end;

	min_height: INTEGER
			-- minimum height that application wishes widget
			-- instance to have
		do
			Result := parent.min_height
		end;

	min_width: INTEGER
			-- minimum width that application wishes widget
			-- instance to have
		do
			Result := parent.min_width
		end; 

	max_aspect_y: INTEGER
			-- Denominator of maximum ration (X/Y) that
			-- application wishes widget instance to have
		do
			Result := parent.max_aspect_y
		end;

	max_aspect_x: INTEGER
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		do
			Result := parent.max_aspect_x
		end;

	popdown
			-- Popdown popup shell.
		do
			if is_popped_up then
				unmanage;
				is_popped_up := False
			end
		end;

	popup
			-- Popup a popup shell.
		do
			if not is_popped_up then
				manage;
				is_popped_up := True
			end
		end;

feature -- Status setting

	set_title (a_title: STRING)
			-- Set `title' to `a_title'.
		do
			parent.set_title (a_title)
		end;

	set_parent_action (action: STRING; cmd: COMMAND; arg: ANY)
			-- Set the dialog shell action to `cmd' with `arg'
		local
			list: VISION_COMMAND_LIST
        do
			create list.make;
			parent.set_translation (action, list, arg);
			list.add_command (cmd, arg)
		end

	remove_parent_action (action: STRING)
			-- Remove `action' from the dialog shell
		do
			parent.remove_translation (action)
		end

	dialog_command_target
			-- Set the main object to the dialog shell.
		obsolete
			"Use `set_parent_action' instead"
		do
		end;

	widget_command_target
			-- Set the main object to the dialog.
		obsolete
			"Not necessary when using `set_parent_action'."
		do
		end;

	set_base_height (a_height: INTEGER)
			-- Set `base_height' to `a_height'. 
		do
			parent.set_base_height (a_height)
		end;

	set_base_width (a_width: INTEGER)
			-- Set `base_width' to `a_width'.
		do
			parent.set_base_height (a_width)
		end;

	set_height_inc (an_increment: INTEGER)
			-- Set `height_inc' to `an_increment'.
		do
			parent.set_height_inc (an_increment)
		end;

	set_width_inc (an_increment: INTEGER)
			-- Set `width_inc' to `an_increment'.
		do
			parent.set_width_inc (an_increment)
		end;

	set_icon_mask (a_mask: PIXMAP)
			-- Set `icon_mask' to `a_mask'.
		do
		end;

	set_icon_pixmap (a_pixmap: PIXMAP)
			-- Set `icon_pixmap' to `a_pixmap'.
		do
		end;

	set_icon_x (x_value: INTEGER)
			-- Set `icon_x' to `x_value'.
		do
			parent.set_icon_x (x_value)
		end;

	set_icon_y (y_value: INTEGER)
			-- Set `icon_y' to `y_value'.
		do
			parent.set_icon_y (y_value)
		end; 

	set_max_aspect_x (a_max: INTEGER)
			-- Set `max_aspect_x' to `a_max'.
		do
			parent.set_max_aspect_x (a_max)
		end;

	set_max_aspect_y (a_max: INTEGER)
			-- Set `max_aspect_y' to `a_max'.
		do
			parent.set_max_aspect_y (a_max)
		end;

	set_max_height (a_height: INTEGER)
			-- Set `max_height' to `a_height'.
		do
			parent.set_max_height (a_height)
		end;

	set_max_width (a_max: INTEGER)
			-- Set `max_width' to `a_max'.
		do
			parent.set_max_width (a_max)
		end;

	set_min_aspect_x (a_min: INTEGER)
			-- Set `min_aspect_x' to `a_min'.
		do
			parent.set_min_aspect_x (min_aspect_x)
		end;

	set_min_aspect_y (a_min: INTEGER)
			-- Set `min_aspect_y' to `a_min'.
		do
			parent.set_min_aspect_y (a_min)
		end;

	set_min_height (a_height: INTEGER)
			-- Set `min_height' to `a_height'.
		do
			parent.set_min_height (a_height)
		end;

	set_min_width (a_min: INTEGER)
			-- Set `min_width' to `a_min'.
		do
			parent.set_min_width (min_width)
		end;

	set_widget_group (a_widget: WIDGET)
			-- Set `widget_group' to `a_widget'.
		do
		end;

feature -- Element change

	allow_resize
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			parent.allow_shell_resize 
		end;

	forbid_resize
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			parent.forbid_shell_resize 
		end;

feature -- Display

	lower
			-- Lower the shell in the stacking order.
		do
			parent.raise
		end;

	raise
			-- Raise the shell to the top of the stacking order.
		do
			parent.raise
		end;

	hide
			-- Make widget invisible on the screen.
		do
			parent.hide
		end;

	show
			-- Make widget visible on the screen.
		do
			parent.show;
		end;

	destroy (wid_list: LINKED_LIST [WIDGET])
			-- Destroy screen widget implementation and all
			-- screen widget implementations of its children
			-- contained in `wid_list;.
		do
			popdown;
			mel_destroy
		end;

feature {NONE} -- Implementation

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR)
			-- Define `a_cursor' if the current widget is a shell.
		require
			a_cursor_not_void: a_cursor /= Void
		local
			cursor_implementation: SCREEN_CURSOR_IMP
		do
			cursor_implementation ?= a_cursor.implementation;
			cursor_implementation.allocate_cursor;
			define_cursor (cursor_implementation);
			display.flush
		end;

	undefine_cursor_if_shell
			-- Undefine the cursor if the current widget is a shell.
		do
			undefine_cursor;
			display.flush
		end;

	mel_destroy
			-- Destroy the associated MEL widget.
		deferred
		end;

	undefine_cursor
			-- Sets the cursor to Current window to its parent's
			-- cursor.
		deferred
		end;

	define_cursor (a_cursor: MEL_SCREEN_CURSOR)
			-- Define the cursor to be displayed to `a_cursor' if not
			-- Void. Otherwize, if `a_cursor' is Void then have
			-- the parent's cursor displayed in the Current window.
		require
			valid_cursor: a_cursor /= Void implies a_cursor.is_valid
		deferred
		end;

feature -- Execution

	execute (up: ANY)
		local
			bool_ref: BOOLEAN_REF
		do
			bool_ref ?= up;
			check
				non_void_bool_ref: bool_ref /= Void
			end;
			is_popped_up := bool_ref.item
		end;

feature {NONE} -- Implementation

	initialize (shell: MEL_SHELL)
			-- Initialize the current dialog
		do
			shell.forbid_shell_resize;
			shell.set_popup_callback (Current, True);
			shell.set_popdown_callback (Current, False);
		end;

	action_target: POINTER do end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DIALOG_IMP

