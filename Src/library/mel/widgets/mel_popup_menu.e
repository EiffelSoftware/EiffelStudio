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
			is_menu_popup, is_menu_option, is_menu_pulldown, 
			set_menu_accelerator, set_menu_history, set_menu_help_widget,
			set_mnemonic, set_mnemonic_char_set, set_radio_behavior,
			rc_make
		redefine
			parent
		end

creation 
	make

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
			-- Create a motif popup menuwidget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			screen_object := 
				xm_create_popup_menu (a_parent.screen_object, 
					$widget_name, default_pointer, 0);
			!! parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add_without_parent (Current);
			set_default
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	parent: MEL_MENU_SHELL
			-- Parent of popup menu

feature -- Update

	set_menu_position (a_button_event: MEL_BUTTON_EVENT) is
			-- Set the menu position from `a_button_event'.
		require
			exists: not is_destroyed;
			button_event_not_void: a_button_event /= Void;
			button_press_event: a_button_event.is_button_press
		do
			xm_menu_position (screen_object, a_button_event.handle)	
		end;

feature {NONE} -- Implementation

	xm_create_popup_menu (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/RowColumn.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreatePopupMenu"
		end;

	xm_menu_position (a_widget: POINTER; an_event: POINTER) is
		external
			"C [macro <Xm/RowColumn.h>] (Widget, XButtonPressedEvent *)"
		alias
			"XmMenuPosition"
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
