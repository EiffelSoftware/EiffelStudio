indexing

	description:
			"Shell widget meant to contain popup and popdown menu panes.";
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
			make
		end

creation
	make

feature {NONE} -- Initialization

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
			Mel_widgets.put (Current, screen_object);
			set_default
		end;

feature -- Status report

	button_font_list: MEL_FONT_LIST is
			-- Font list used for the button children
		require
			exists: not is_destroyed
		do
		end;

	default_font_list: MEL_FONT_LIST is
			-- Font list used for the children
		require
			exists: not is_destroyed
		do
		end;

	label_font_list: MEL_FONT_LIST is
			-- Font list used for the label children
		require
			exists: not is_destroyed
		do
		end;

feature -- Status setting

	set_button_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `button_font_list' to `a_font_list'.
		require
			exists: not is_destroyed
		do
		ensure
		end;

	set_label_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `label_font_list' to `a_font_list'.
	   require
			exists: not is_destroyed
		do
		ensure
		end;

feature {NONE} -- Implementation

	xm_create_menu_shell (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/MenuShell.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateMenuShell"
		end;

end -- class MEL_MENU_SHELL

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
