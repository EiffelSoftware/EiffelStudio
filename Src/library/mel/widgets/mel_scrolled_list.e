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
			make_from_existing as list_make_from_existing
		export
			{NONE} list_make_from_existing
		redefine
			parent, clean_up
		end;

creation
	make_variable,
	make_constant,
	make_resize_if_possible,
	make_from_existing

feature -- Initialization

	make_variable (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled list with `is_list_size_policy_variable'
			-- set to True.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_list (a_parent.screen_object, $widget_name, default_pointer, 0);
			!! parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure then
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
			list_size_policy_set: is_list_size_policy_variable
		end;

	make_constant (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled list with a constant size.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_list_constant (a_parent.screen_object, $widget_name);
			!! parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
			list_size_policy_set: is_list_size_policy_constant
		end;

	make_resize_if_possible (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled list with an horizontal scrollbar if it's too large.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_list_resize (a_parent.screen_object, $widget_name);
			!! parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
			list_size_policy_set: is_list_size_policy_resize_if_possible
		end;

	make_from_existing (a_screen_object: POINTER; a_parent: MEL_COMPOSITE) is
			-- Create a motif widget from an existing widget.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			valid_parent: a_parent /= Void
		do
			!! parent.make_from_existing (xt_parent (a_screen_object), 
				a_parent);
			screen_object := a_screen_object;
			Mel_widgets.add (Current);
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent
		end

feature -- Access

	parent: MEL_SCROLLED_WINDOW;
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

feature {NONE} -- Implementation

	clean_up is
			-- Clean up the object.
		do
			parent.clean_up;
		end;

feature {NONE} -- Implementation

	xm_create_scrolled_list (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/List.h>"
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


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

