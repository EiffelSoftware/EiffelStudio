indexing

	description:
			"A MEL_ROW_COLUMN used as a pulldown menu pane.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PULLDOWN_MENU

inherit

	MEL_ROW_COLUMN
		rename
			make as row_column_make
		export
			{NONE}  menu_accelerator, menu_help_widget, menu_history, mnemonic,
			mnemonic_char_set, is_popup_enabled, is_radio_behavior, is_working_area,
			is_menu_bar, is_menu_popup, is_menu_option, is_menu_pulldown,
			row_column_make, set_menu_accelerator, set_menu_history, 
			set_menu_help_widget, set_mnemonic, set_mnemonic_char_set, 
			enable_popup, disable_popup,
			enable_radio_behavior, disable_radio_behavior,
			set_tear_off_to_enabled, set_tear_off_to_disabled
		redefine
			parent
		end

creation 
	make,
	build_pulldown_menu,
	build_pulldown_menu_gadget

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_ROW_COLUMN) is
			-- Create a motif pulldown menu in `a_parent'.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed;
			is_menu_parent: a_parent.is_menu
		local
			widget_name: ANY;
			parent_so: POINTER
		do
			widget_name := a_name.to_c;
			screen_object := xm_create_pulldown_menu 
					(a_parent.screen_object, $widget_name, default_pointer, 0);
			parent_so := xt_parent (screen_object);
			if a_parent.is_menu_pulldown or else 
				a_parent.is_menu_popup 
			then
				!! parent.make_from_existing (parent_so, a_parent.parent)
			else
				!! parent.make_from_existing (parent_so, a_parent)
			end;
			Mel_widgets.add_without_parent (Current); 
					-- Don't check the parent consistency
			set_default
		ensure
			exists: not is_destroyed;
			name_set: name.is_equal (a_name);
			if_popup_or_pullodwn_parent_check: (a_parent.is_menu_popup or else
					a_parent.is_menu_pulldown) implies 
						parent.parent = a_parent.parent;
			if_not_popup_or_pullown_parent_check: (a_parent.is_menu_bar or else
					a_parent.is_menu_option) implies parent.parent = a_parent;
		end;

	build_pulldown_menu (a_name: STRING; a_parent: MEL_ROW_COLUMN) is
			-- Create a pulldown with `a_parent' and automatically
			-- create a cascade with name `a_name' and parent `a_parent'.
			-- Also, attach pulldown to the cascade button.
		require
			name_exists: a_name /= Void;
			is_menu_parent: a_parent.is_menu
		local
			a_cascade: MEL_CASCADE_BUTTON
		do
			make ("_pulldown", a_parent);
			!! a_cascade.make (a_name, a_parent, True);
			a_cascade.set_sub_menu (Current)
		ensure
			exists: not is_destroyed;
			name_set: name.is_equal ("_pulldown")
			if_popup_or_pullodwn_parent_check: (a_parent.is_menu_popup or else
					a_parent.is_menu_pulldown) implies 
						parent.parent = a_parent.parent;
			if_not_popup_or_pullown_parent_check: (a_parent.is_menu_bar or else
					a_parent.is_menu_option) implies parent.parent = a_parent;
		end;

	build_pulldown_menu_gadget (a_name: STRING; a_parent: MEL_ROW_COLUMN) is
			-- Create a pulldown with `a_parent' and automatically
			-- create a cascade gadget with name `a_name' and parent `a_parent'.
			-- Also, attach pulldown to the cascade gadget button.
		require
			name_exists: a_name /= Void;
			is_menu_parent: a_parent.is_menu
		local
			a_cascade: MEL_CASCADE_BUTTON_GADGET
		do
			make ("_pulldown", a_parent);
			!! a_cascade.make (a_name, a_parent, True);
			a_cascade.set_sub_menu (Current)
		ensure
			exists: not is_destroyed;
			name_set: name.is_equal ("_pulldown")
			if_popup_or_pullodwn_parent_check: (a_parent.is_menu_popup or else
					a_parent.is_menu_pulldown) implies 
						parent.parent = a_parent.parent;
			if_not_popup_or_pullown_parent_check: (a_parent.is_menu_bar or else
					a_parent.is_menu_option) implies parent.parent = a_parent;
		end;

feature -- Access

	parent: MEL_MENU_SHELL 
			-- Actual parent of pulldown menu 

feature {NONE} -- Implementation

	xm_create_pulldown_menu (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/RowColumn.h>"
		alias
			"XmCreatePulldownMenu"
		end;

end -- class MEL_PULLDOWN_MENU


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

