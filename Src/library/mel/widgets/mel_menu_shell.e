indexing

	description:
		"Shell widget meant to contain popup and popdown menu panes. %
		%This is an opaque class for menus and callbacks should not be %
		%added to this class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MENU_SHELL

inherit

	MEL_MENU_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_OVERRIDE_SHELL
		redefine
			make, make_from_existing
		end

creation
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif menu shell widget.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			check
				same_screen_as_parent: screen = parent.screen
			end;
			screen_object := xm_create_menu_shell 
						(a_parent.screen_object, $widget_name, 
						default_pointer, 0);
			Mel_widgets.add_popup_shell (Current);
			set_default
		end;

	make_from_existing (a_screen_object: POINTER; a_parent: MEL_COMPOSITE) is
			-- Create a mel widget from existing widget `a_screen_object'.
		do
			screen_object := a_screen_object;
			parent := a_parent;
			a_parent.add_popup_child (Current);
			set_default
		end;

feature -- Status report

	button_font_list: MEL_FONT_LIST is
			-- Font list used for the button children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNbuttonFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid
			Result_is_shared: Result.is_shared
		end;

	default_font_list: MEL_FONT_LIST is
			-- Font list used for the children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNdefaultFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	label_font_list: MEL_FONT_LIST is
			-- Font list used for the label children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNlabelFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

feature -- Status setting

	set_button_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `button_font_list' to `a_font_list'.
		require
			exists: not is_destroyed;
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNbuttonFontList, a_font_list)
		end;

	set_label_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `label_font_list' to `a_font_list'.
		require
			exists: not is_destroyed
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid

		do
			set_xm_font_list (screen_object, XmNlabelFontList, a_font_list)
		end;

feature {NONE} -- Implementation

	xm_create_menu_shell (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/MenuShell.h>"
		alias
			"XmCreateMenuShell"
		end;

end -- class MEL_MENU_SHELL


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

