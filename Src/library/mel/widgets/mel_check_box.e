indexing

	description:
			"A MEL_ROW_COLUMN that contains MEL_TOGGLE_BUTTONs.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CHECK_BOX

inherit
	MEL_ROW_COLUMN
		export
			{NONE} menu_accelerator, menu_history, menu_help_widget,
			mnemonic, mnemonic_char_set, is_popup_enabled, radio_behavior,
			is_working_area, is_menu_bar, is_menu_popup, is_menu_option,
			is_menu_pulldown, sub_menu, is_tear_off_enabled,
			set_menu_accelerator, set_menu_history,
			set_menu_help_widget, set_mnemonic, set_mnemonic_char_set, 
			set_popup_enabled, set_radio_behavior,
			set_sub_menu, set_tear_off_enabled
		redefine
			make
		end;

creation 
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif check box widget.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_check_box (a_parent.screen_object, $widget_name);
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		end;

feature {NONE} -- Implementation

	xm_create_check_box (a_parent, a_name: POINTER): POINTER is
		external
			"C"
		end;

end -- class MEL_CHECK_BOX

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
