indexing

	description:
			"Fundamental widget class that controls interaction between %
			%top-level windows and the window manager.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SHELL

inherit

	MEL_XT_SHELL_FUNCTIONS;

	MEL_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_COMPOSITE
		redefine
			real_x, real_y,
			make_from_existing,
			manage, unmanage, managed,
			clean_up_callbacks
		end

feature {NONE} -- Initialization

	make_from_existing (a_screen_object: POINTER) is
			-- Create a motif widget from an existing one.
		do
			screen_object := a_screen_object;
			check
				parent_exists: Mel_widgets.item (xt_parent (screen_object)) /= Void
			end;
			parent ?= Mel_widgets.item (xt_parent (screen_object));
			Mel_widgets.put (Current, screen_object)
				-- In fact, we should retrieve the screen pointer of the widget
				-- then retrieve the Eiffel screen according to that pointer.
				-- But this function is only useful with compound dialogs
				-- and they appear on the default_screen.
		end;

feature -- Status report

	allow_shell_resize: BOOLEAN is
			-- Can Current resize?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNallowShellResize)
		end;

	create_popup_child_proc is
			-- A procedure that creates a child widget.
			-- The procedure is only when the shell is poped up.
		require
			exists: not is_destroyed
		do
		end;

	geometry: STRING is
			-- Geometry
		require
			exists: not is_destroyed
		do
			Result := get_xt_string (screen_object, XmNgeometry)
		end;

	is_override_redirect: BOOLEAN is
			-- Is Current a temporary window used to redirect the keyboard focus?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNoverrideRedirect)
		end;

	is_save_under: BOOLEAN is
			-- Are obscured screen contents saved?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNsaveUnder)
		end;

	visual is
			-- Visual server, used when creating the widget.
		require
			exists: not is_destroyed
		do
		ensure
		end;

	real_x: INTEGER is
			-- Horizontal position relative to root window
		do
			Result := x
		end;

	real_y: INTEGER is
			-- Vertical position relative to root window
		do
			Result := y
		end;

	managed: BOOLEAN is True;
			-- Is managed?
			-- (Always true)

feature -- Status setting

	set_allow_shell_resize (b: BOOLEAN) is
			-- Set `allow_shell_resize' to `b'
		do
			set_xt_boolean (screen_object, XmNallowShellResize, b)
		ensure
			set: allow_shell_resize = b
		end;

	set_create_popup_child_proc is
			-- Set `create_popup_child_proc'.
		require
			exists: not is_destroyed
		do
		end;

	set_geometry (a_string: STRING) is
			-- Set `geometry' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_string (screen_object, XmNgeometry, a_string)
		ensure
			geometry_set: geometry.is_equal (a_string)
		end;

	set_override_redirect (b: BOOLEAN) is
			-- Set `is_override_redirect' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNoverrideRedirect, b)
		ensure
			override_redirect_enabled: is_override_redirect = b
		end;

	set_save_under (b: BOOLEAN) is
			-- Set `is_save_under' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNsaveUnder, b)
		ensure
			save_under_enabled: is_save_under = b
		end;

	set_visual is
			-- Set `visual'.
		require
			exists: not is_destroyed
		do
		ensure
		end;

	manage is
			-- Manage all children.
		do
		end;

	unmanage is
			-- Unmanage all children.
		do
		end;

feature -- Display

	popup_none is
			-- Popup without mouse pointer grab.
		require
			exists: not is_destroyed
		do
			xt_popup (screen_object, XtGrabNone)
		end;

	popup_non_exclusive is
			-- Popup with non exclusive mouse pointer grab.
		require
			exists: not is_destroyed
		do
			xt_popup (screen_object, XtGrabNonexclusive)
		end;

	popup_exclusive is
			-- Popup with exclusive mouse pointer grab.
		require
			exists: not is_destroyed
		do
			xt_popup (screen_object, XtGrabExclusive)
		end;

	popdown is
			-- Popdown.
		require
			exists: not is_destroyed
		do
			xt_popdown (screen_object);
		end;

feature -- Element change

	add_popup_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget is popped up using
			-- XtPopup ().
		require
			a_callback_not_void: a_callback /= Void;
		do
			add_callback (XmNpopupCallback, a_callback, an_argument);
		end;

	add_popdown_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget is popped down using
			-- XtPopdown ().
		require
			a_callback_not_void: a_callback /= Void;
		do
			add_callback (XmNpopdownCallback, a_callback, an_argument);
		end;

	add_wm_protocol_callback (atom: MEL_ATOM; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add callback `a_callback' that is specfied by protocol `atom'.
		require
			valid_atom: atom /= Void;
			a_callback_not_void: a_callback /= Void;
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_wm_protocol
					(screen_object, atom, a_callback_exec);
		end;

	add_wm_protocol (atom: MEL_ATOM) is
			-- Register protocol `atom'.
		require
			valid_atom: atom /= Void;
		do
			xm_add_wm_protocol (screen_object, atom.identifier)			
		end;

feature -- Removal

	remove_popup_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget is popped up using
			-- XtPopup ().
		require
			a_callback_not_void: a_callback /= Void;
		do
			remove_callback (XmNpopupCallback, a_callback, an_argument);
		end;

	remove_popdown_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget is popped down using
			-- XtPopdown ().
		require
			a_callback_not_void: a_callback /= Void;
		do
			remove_callback (XmNpopdownCallback, a_callback, an_argument);
		end;

	remove_wm_protocol_callback (atom: MEL_ATOM; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove callback `a_callback' that is specfied by protocol `atom'.
		require
			valid_atom: atom /= Void;
			a_callback_not_void: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.remove_wm_protocol
					(screen_object, atom, a_callback_exec);
		end;

feature {NONE} -- Implementation

	clean_up_callbacks is
			-- Remove callback structures associated with Current.
		do
			Mel_dispatcher.clean_up_shell (Current)
		end;

feature {NONE} -- External features

	xm_add_wm_protocol (w: POINTER; atom: POINTER) is
		external
			"C"
		end;

end -- class MEL_SHELL

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
