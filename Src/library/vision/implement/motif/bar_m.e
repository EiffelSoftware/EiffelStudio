
-- Motif menu bar implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BAR_M 

inherit

	BAR_I
		export
			{NONE} all
		end;

	MENU_M

creation

	make

feature  -- Creation

	make (a_bar: BAR) is
			-- Create a motif bar menu.
		local
			ext_name_bar: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name_bar := a_bar.identifier.to_c;
			screen_object := create_bar ($ext_name_bar, 
						parent_screen_object (a_bar, widget_index));
			abstract_menu := a_bar
		end;

feature {NONE}

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
        local
            ext_name: ANY
		do
            ext_name := MmenuHelpWidget.to_c;
			Result ?= widget_manager.screen_object_to_oui (get_widget (screen_object, $ext_name))
		end;

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar.
		local
			ext_name: ANY
		do
			ext_name := MmenuHelpWidget.to_c;
			set_widget (screen_object, button.implementation.screen_object, $ext_name)
		ensure then
			help_button.same (button)
		end;


	allow_recompute_size  is
		do
			set_xt_boolean (screen_object, True, MresizeWidth);
			set_xt_boolean (screen_object, True, MresizeHeight);
		end;

	forbid_recompute_size  is
		do
			set_xt_boolean (screen_object, False, MresizeHeight);
			set_xt_boolean (screen_object, False, MresizeWidth);
		end;

feature {NONE} -- External features

	create_bar (b_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
