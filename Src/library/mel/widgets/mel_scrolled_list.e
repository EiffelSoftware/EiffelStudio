indexing

	description:
			"MEL_LIST as a child of a MEL_SCROLLED_WINDOW.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLLED_LIST

inherit

	MEL_LIST
		rename
			make as make_variable,
			make_from_existing as list_make_from_existing
		redefine
			make_variable, clean_up
		end;

creation
	make_variable,
	make_constant,
	make_resize_if_possible,
	make_from_existing

feature {NONE} -- Initialization

	make_variable (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled list.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_list (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			!! scrolled_window.make_from_existing (xt_parent (screen_object));
			set_default;
			if do_manage then
				manage
			end
		ensure then
			list_size_policy_set: is_list_size_policy_variable
		end;

	make_constant (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled list with a constant width.
		require
			a_name_exists: a_name /= Void
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_list_constant (a_parent.screen_object, $widget_name);
			Mel_widgets.put (Current, screen_object);
			!! scrolled_window.make_from_existing (xt_parent (screen_object));
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			list_size_policy_set: is_list_size_policy_constant
		end;

	make_resize_if_possible (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled list with an horizontal scrollbar if it's too large.
		require
			a_name_exists: a_name /= Void
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_list_resize (a_parent.screen_object, $widget_name);
			!! scrolled_window.make_from_existing (xt_parent (screen_object));
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			list_size_policy_set: is_list_size_policy_resize_if_possible
		end;

	make_from_existing (a_screen_object: POINTER) is
			-- Create a motif widget from an existing widget.
		require
			valid_a_screen_object: a_screen_object /= default_pointer
		do
			list_make_from_existing (a_screen_object);
			!! scrolled_window.make_from_existing (xt_parent (a_screen_object));
		end

feature -- Access

	scrolled_window: MEL_SCROLLED_WINDOW;
			-- Scrolled window

feature -- Status report

	is_scroll_bar_dirplay_policy_static: BOOLEAN is
			-- Is the scrollbar always displayed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy) = XmSTATIC
		end;

	is_list_size_policy_variable: BOOLEAN is
			-- Is the list size policy variable?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNlistSizePolicy) = XmVARIABLE
		end;

	is_list_size_policy_constant: BOOLEAN is
			-- Is the list size policy constant?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNlistSizePolicy) = XmCONSTANT
		end;

	is_list_size_policy_resize_if_possible: BOOLEAN is
			-- Is the list size policy "resizing if it's possible"?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNlistSizePolicy) = XmRESIZE_IF_POSSIBLE
		end;

feature -- Status setting

	set_scroll_bar_dirplay_policy_static is
			-- Set `is_scroll_bar_dirplay_policy_static'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy,  XmSTATIC)
		ensure
			policy_set: is_scroll_bar_dirplay_policy_static
		end;

	set_scroll_bar_dirplay_policy_as_needed is
			-- Unset `is_scroll_bar_dirplay_policy_static'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy,  XmAS_NEEDED)
		ensure
			policy_set: not is_scroll_bar_dirplay_policy_static 
		end;

feature -- Removal

	clean_up is
			-- Destroy the widget.
		do
			object_clean_up;
			scrolled_window.object_clean_up
		end;

feature {NONE} -- Implementation

	xm_create_scrolled_list (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/List.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateScrolledList"
		end;

	xm_create_scrolled_list_constant (a_parent: POINTER; a_name: POINTER): POINTER is
		external
			"C"
		end;

	xm_create_scrolled_list_resize (a_parent: POINTER; a_name: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_SCROLLEDLIST

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
