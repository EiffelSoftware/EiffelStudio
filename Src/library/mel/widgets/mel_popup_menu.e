indexing

	description:
			"A MEL_ROW_COLUMN used as a popup menu."
	legal: "See notice at end of class.";
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

create 
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
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_POPUP_MENU


