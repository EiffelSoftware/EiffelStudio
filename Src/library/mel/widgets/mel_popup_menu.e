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
			mnemonic_char_set, is_radio_behavior, is_working_area, is_menu_bar,
			is_menu_popup, is_menu_option, is_menu_pulldown, 
			set_menu_accelerator, set_menu_history, set_menu_help_widget,
			set_mnemonic, set_mnemonic_char_set, 
			enable_radio_behavior, disable_radio_behavior, rc_make
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
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/RowColumn.h>"
		alias
			"XmCreatePopupMenu"
		end;

	xm_menu_position (a_widget: POINTER; an_event: POINTER) is
		external
			"C (Widget, XButtonPressedEvent *) | <Xm/RowColumn.h>"
		alias
			"XmMenuPosition"
		end;

end -- class MEL_POPUP_MENU


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

