indexing

	description:
			"Standard layout widget for an application's primary window.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MAIN_WINDOW

inherit

	MEL_MAIN_WINDOW_RESOURCES
		export
			{NONE} all
		end;

	MEL_SCROLLED_WINDOW
		redefine
			make,
			margin_height, margin_width, set_margin_height, set_margin_width
		end

creation
	make, 
	make_detailed,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create Current with `a_name' as `widget_name' and `a_parent' as `parent'.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_main_window (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

	make_detailed (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage, command_below, automatic_scrolling: BOOLEAN) is
			-- Create a motif main window widget with the command window
			-- located below or above the workspace and with or without
			-- automatic scrolling.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_main_window_detailed (a_parent.screen_object,
								$widget_name, command_below, automatic_scrolling);
			if do_manage then
				manage
			end
			Mel_widgets.add (Current);
			set_default
        ensure
            exists: not is_destroyed;
            parent_set: parent = a_parent;
            name_set: name.is_equal (a_name)
		end;

feature -- Status report

	command_window: MEL_OBJECT is
			-- Command window
		require
			exists: not is_destroyed
		do
			Result := get_xt_widget (screen_object, XmNcommandWindow)
		end;

	menu_bar: MEL_MENU_BAR is
			-- Menu bar
		require
			exists: not is_destroyed
		do
			Result ?= get_xt_widget (screen_object, XmNmenuBar)
		end;

	message_window: MEL_OBJECT is
			-- Message window
		require
			exists: not is_destroyed
		do
			Result := get_xt_widget (screen_object, XmNmessageWindow)
		end;

	is_command_above_workspace: BOOLEAN is
			-- Is the command window above the workspace?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNcommandWindowLocation) = XmCOMMAND_ABOVE_WORKSPACE
		end;

	margin_height: INTEGER is
			-- Margin at the height and the bottom side.
		do
			Result := get_xt_dimension (screen_object, XmNmainWindowMarginHeight)
		ensure then
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER is
			-- Margin at the right and the left side.
		do
			Result := get_xt_dimension (screen_object, XmNmainWindowMarginWidth)
		ensure then 
			margin_width_large_enough: Result >= 0
		end;

	is_separator_shown: BOOLEAN is
			-- Is a seprarator displayed between each component?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNshowSeparator)
		end;

feature -- Status setting

	set_command_window (a_widget: like command_window) is
			-- Set `command_window' to `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_exists: not a_widget.is_destroyed
		do
			set_xt_widget (screen_object, XmNcommandWindow, a_widget.screen_object)
		ensure
			command_window_set: a_widget = command_window
		end;

	set_menu_bar (a_menu_bar: like menu_bar) is
			-- Set `menu_bar' to `a_menu_bar'.
		require
			exists: not is_destroyed;
			a_menu_bar_exists: not a_menu_bar.is_destroyed
		do
			set_xt_widget (screen_object, XmNmenuBar, a_menu_bar.screen_object)
		ensure
			menu_bar_set: a_menu_bar = menu_bar
		end;

	set_message_window (a_widget: like message_window) is
			-- Set `message_window' to `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_exists: not a_widget.is_destroyed
		do
			set_xt_widget (screen_object, XmNmessageWindow, a_widget.screen_object)
		ensure
			message_window_set: a_widget = message_window
		end;

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require else
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNmainWindowMarginHeight, a_height)
		ensure then
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require else
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNmainWindowMarginWidth, a_width)
		ensure then
			margin_width_set: margin_width = a_width
		end;

	show_separator is
			-- Set `is_separator_shown' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowSeparator, True)
		ensure
			separator_is_shown: is_separator_shown 
		end;

	hide_separator is
			-- Set `is_separator_shown' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowSeparator, False)
		ensure
			separator_is_hidden: not is_separator_shown 
		end;

feature {NONE} -- Implementation

	xm_create_main_window (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/MainW.h>"
		alias
			"XmCreateMainWindow"
		end;

	xm_create_main_window_detailed (a_parent, a_name: POINTER; com_below, auto_scroll: BOOLEAN): POINTER is
		external
			"C"
		end;

end -- class MEL_MAIN_WINDOW


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

