--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Rectangle which display an option menu when armed.

indexing

	date: "$Date$";
	revision: "$Revision$"

class OPTION_B_M 

inherit

	OPTION_B_I;

	BUTTON_M
		export
			{NONE} all
		redefine
            text, set_text
		end;

	FONTABLE_M
		rename
			resource_name as MfontList,
			screen_object as font_screen_object
		export
			{NONE} all
		end;

	ROW_COLUMN_R_M
		rename
			MlabelString as old_MlabelString,
			MmarginHeight as old_MmarginHeight,
			MmarginWidth as old_MmarginWidth,
			Mmnemonic as old_Mmnemonic,
			MmnemonicCharSet as old_MmnemonicCharSet
		export
			{NONE} all
		end

creation

	make

feature 

	selected_button: BUTTON is
            -- Current Push Button selected in the option menu
		local
			ext_name: ANY
        do
			ext_name := MmenuHistory.to_c;
			Result ?= widget_manager.screen_object_to_oui (get_widget (screen_object, $ext_name))
        end;

    set_selected_button (button: BUTTON) is
            -- Set `selected_button' to `button'
        require else
            button_exists: not (button = Void)
		local
			ext_name: ANY
        do
			ext_name := MmenuHistory.to_c;
			set_widget (screen_object, button.implementation.screen_object, $ext_name) 
        ensure then
            button.same (selected_button)
        end;

	attach_menu (a_menu: OPT_PULL) is
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		require else
			menu_not_void: not (a_menu = Void)
		do
			xm_attach_menu (xm_option_button_gadget (screen_object), a_menu.implementation.screen_object)
		end;

	make (an_option_menu: OPTION_B) is
			-- Create a motif option menu button
		local
			ext_name: ANY
		do
			ext_name := an_option_menu.identifier.to_c;
			screen_object := create_option_b ($ext_name, an_option_menu.parent.implementation.screen_object);
			an_option_menu.set_font_imp (Current)
		end;

feature {NONE}

	font_screen_object: POINTER is
			-- Pointer to the text who change its font
		do
			Result := xm_option_label_gadget (screen_object)
		end;

feature 

	text: STRING is
			-- Label of button
		local
			ext_name: ANY
		do
			ext_name := MlabelString.to_c;
			Result := from_xm_string (xm_option_label_gadget (screen_object), $ext_name)
		end;

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require else
			not_text_void: not (a_text = Void)
		local
			ext_name, ext_name_text: ANY
		do
			ext_name := MlabelString.to_c;
			ext_name_text := a_text.to_c;
			to_left_xm_string (xm_option_label_gadget (screen_object), $ext_name_text, $ext_name)
		ensure then
			text.is_equal (a_text)
		end

feature {NONE} -- External features

	xm_option_label_gadget (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	create_option_b (i_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_option_button_gadget (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_attach_menu (value, scr_obj: POINTER) is
		external
			"C"
		end;

end

