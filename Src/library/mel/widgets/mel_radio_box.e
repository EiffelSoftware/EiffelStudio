indexing

	description:
			"A MEL_ROW_COLUMN that contains MEL_TOGGLE_BUTTONs.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_RADIO_BOX

inherit

	MEL_ROW_COLUMN
		export
			{NONE} menu_accelerator, menu_history, menu_help_widget,
			mnemonic, mnemonic_char_set, is_popup_enabled, is_radio_behavior,
			is_working_area, is_menu_bar, is_menu_popup, is_menu_option,
			is_menu_pulldown, is_tear_off_enabled, set_menu_accelerator,
			set_menu_history, set_menu_help_widget, set_mnemonic,
			set_mnemonic_char_set, 
			enable_popup, disable_popup,
			enable_radio_behavior, disable_radio_behavior,
			set_tear_off_to_enabled, set_tear_off_to_disabled
		redefine
			make
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif radio box.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_radio_box (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Status setting

	enable_always_one is
			-- Set `is_radio_always_one' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNradioAlwaysOne, True)
		ensure
			radio_always_one: is_radio_always_one 
		end;

	disable_always_one is
			-- Set `is_radio_always_one' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNradioAlwaysOne, False)
		ensure
			radio_always_one: is_radio_always_one 
		end;

feature {NONE} -- Implementation

	xm_create_radio_box (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/RowColumn.h>"
		alias
			"XmCreateRadioBox"
		end;

end -- class MEL_RADIO_BOX


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

