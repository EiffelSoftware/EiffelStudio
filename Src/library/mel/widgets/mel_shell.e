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

	MEL_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_COMPOSITE
		rename
			destroy as comp_destroy
		export
			{NONE} comp_destroy
		redefine
			real_x, real_y, make_from_existing,
			clean_up_callbacks
		end

	MEL_COMPOSITE
		redefine
			real_x, real_y, make_from_existing, 
			clean_up_callbacks, destroy
		select
			destroy
		end

feature -- Initialization

	make_from_existing (a_screen_object: POINTER; a_parent: MEL_COMPOSITE) is
			-- Create a mel widget from existing widget `a_screen_object'.
		do
			screen_object := a_screen_object;
			parent := a_parent;
			Mel_widgets.add_popup_shell (Current);
			set_default
		end;

feature -- Status report

	allow_shell_to_resize: BOOLEAN is
			-- Can Current be resized?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNallowShellResize)
		end;

	geometry: STRING is
			-- Geometry
		require
			exists: not is_destroyed
		do
			Result := get_xt_string_no_free (screen_object, XmNgeometry)
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

feature -- Status setting

	allow_shell_resize is
			-- Set `allow_shell_to_resize' to True.
		do
			set_xt_boolean (screen_object, XmNallowShellResize, True)
		ensure
			shell_resize_allowed: allow_shell_to_resize
		end;

	forbid_shell_resize is
			-- Set `allow_shell_to_resize' to False.
		do
			set_xt_boolean (screen_object, XmNallowShellResize, False)
		ensure
			shell_resize_forbidden: not allow_shell_to_resize
		end;

	set_geometry (a_string: STRING) is
			-- Set `geometry' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_allocated_string (screen_object, XmNgeometry, a_string)
		ensure
			geometry_set: geometry.is_equal (a_string)
		end;

	set_geometry_position (new_x, new_y: INTEGER) is
			-- Set the geometry position to `new_x' and
			-- `new_y'.
		local
			geo: STRING
		do
			!! geo.make (8);
			if new_x >= 0 then
				geo.extend ('+')
			end;
			geo.append_integer (new_x);
			if new_y >= 0 then
				geo.extend ('+')
			end;
			geo.append_integer (new_y);
			set_geometry (geo)
		end;

	enable_override_redirect is
			-- Set `is_override_redirect' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNoverrideRedirect, True)
		ensure
			override_redirect_enabled: is_override_redirect 
		end;

	disable_override_redirect is
			-- Set `is_override_redirect' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNoverrideRedirect, False)
		ensure
			override_redirect_disabled: not is_override_redirect 
		end;

	enable_save_under is
			-- Set `is_save_under' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNsaveUnder, True)
		ensure
			save_under_enabled: is_save_under 
		end;

	disable_save_under is
			-- Set `is_save_under' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNsaveUnder, False)
		ensure
			save_under_disabled: not is_save_under 
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

	destroy is
			-- Destroy the associated screen object.
		do
			comp_destroy;
			if parent /= Void then -- Not a top or application shell
				parent.remove_popup_child (Current)
			end
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

	xt_popup (a_popup_shell: POINTER; grab_kind: INTEGER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget, XtGrabKind)"
		alias
			"XtPopup"
		end;

	xt_popdown (a_popup_shell: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (Widget)"
		alias
			"XtPopdown"
		end;

	XtGrabNone: INTEGER is
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"XtGrabNone"
		end;

	XtGrabNonexclusive: INTEGER is
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"XtGrabNonexclusive"
		end;

	XtGrabExclusive: INTEGER is
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"XtGrabExclusive"
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
