indexing

	description:
			"A MEL_ROW_COLUMN used as a popup menu.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_POPUP_MENU

inherit

	MEL_ROW_COLUMN
		rename
			make as rc_make
		export
			{NONE} menu_accelerator, menu_history, menu_help_widget, mnemonic,
			mnemonic_char_set, radio_behavior, is_working_area, is_menu_bar,
			is_menu_popup, is_menu_option, is_menu_pulldown, sub_menu,
			set_menu_accelerator, set_menu_history, set_menu_help_widget,
			set_mnemonic, set_mnemonic_char_set, set_radio_behavior,
			set_sub_menu, rc_make
		end

creation 
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif popup menuwidget.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_popup_menu (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			set_default
		end;

feature {NONE} -- Implementation

	xm_create_popup_menu (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/RowColumn.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreatePopupMenu"
		end;

end -- class MEL_POPUP_MENU

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
