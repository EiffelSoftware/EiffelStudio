indexing

	description: "Rectangle which displays an option menu when armed";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OPTION_B_M 

inherit

	OPTION_B_I;

	BUTTON_M
		rename
			set_size as button_set_size,
			set_height as button_set_height,
			set_width as button_set_width
		export
			{NONE} all
		redefine
			text, set_text, allow_recompute_size,
			forbid_recompute_size
		end;

	BUTTON_M
		export
			{NONE} all
		redefine
			text, set_text, set_size, set_height, set_width, allow_recompute_size,
			forbid_recompute_size
		select
			set_size, set_height, set_width
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

feature {NONE} -- Creation

	make (an_option_menu: OPTION_B; man: BOOLEAN) is
			-- Create a motif option menu button
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := an_option_menu.identifier.to_c;
			screen_object := create_option_b ($ext_name, 
					parent_screen_object (an_option_menu, widget_index),
					man);
			an_option_menu.set_font_imp (Current);
		end;

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
			set_widget (screen_object, button.implementation.screen_object, $ext_name);
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

feature {NONE}

	font_screen_object: POINTER is
			-- Pointer to the text who change its font
		do
			Result := xm_option_button_gadget (screen_object)
		end;

feature

	add_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end

	add_release_action (a_command: COMMAND; argument: ANY) is
		do
		end

	add_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_activate_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_release_action (a_command: COMMAND; argument: ANY) is
		do
		end

	remove_arm_action (a_command: COMMAND; argument: ANY) is
		do
		end

feature 

	text: STRING is
			-- Label of button
		local
			ext_name: ANY
		do
			ext_name := MlabelString.to_c;
			Result := from_xm_string (button_widget, $ext_name)
		end;

	set_text (a_text: STRING) is
			-- Set button text to `a_text'.
		require else
			not_text_void: not (a_text = Void)
		local
			ext_name, ext_name_text: ANY
		do
			xt_unmanage_child (button_widget);
			ext_name := MlabelString.to_c;
			ext_name_text := a_text.to_c;
			to_left_xm_string (button_widget, ext_name_text, ext_name);
			xt_manage_child (button_widget);
		ensure then
			text.is_equal (a_text)
		end;


	title: STRING is
			-- title of option button
		local
			ext_name: ANY
		do
			ext_name := MlabelString.to_c;
			Result := from_xm_string (title_widget, $ext_name);
		end;

	set_title (a_title: STRING) is
			-- Set option button title to `a_title'.
		require else
			not_title_void: not (a_title = Void)
		local
			ext_name, ext_name_title: ANY
		do
			xt_unmanage_child (title_widget);
			ext_name := MlabelString.to_c;
			ext_name_title := a_title.to_c;
			to_left_xm_string (title_widget, ext_name_title, ext_name);
			xt_manage_child (title_widget);
		ensure then
			title.is_equal (a_title)
		end;

	remove_title is
		local
			no_title: STRING;
			ext_name, ext_name_title: ANY
		do
			no_title := "";
			ext_name := MlabelString.to_c;
			ext_name_title := no_title.to_c;
			to_left_xm_string (title_widget, ext_name_title, ext_name);
		end;

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		require else
			height_large_enough: new_height >= 0
		local
			ext_name: ANY
		do
			ext_name := Mheight.to_c;
			set_dimension (button_widget, new_height, $ext_name);
			button_set_height (new_height);
		end;


	set_size (new_width: INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		require else
			width_large_enough: new_width >= 0;
			height_large_enough: new_height >= 0
		local
			ext_name_Mw, ext_name_Mh: ANY;
			nw, nh: INTEGER;
		do
			ext_name_Mw := Mwidth.to_c;
			ext_name_Mh := Mheight.to_c;
			nw := new_width;
			nh := new_height;
			if not title.empty then
				set_dimension (button_widget, nw - title_width, $ext_name_Mw);
			else
				set_dimension (button_widget, nw, $ext_name_Mw);
			end;
			set_dimension (button_widget, new_height, $ext_name_Mh);
			button_set_size (nw, nh);
		end;

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		require else
			width_large_enough: new_width >= 0;
		local
			ext_name_Mw: ANY
		do
			ext_name_Mw := Mwidth.to_c;
			set_dimension (button_widget, new_width, $ext_name_Mw); 
			button_set_width (new_width);
		end;

	
	allow_recompute_size is
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		do
			set_xt_boolean (button_widget, True, MrecomputeSize);
			set_xt_boolean (screen_object, True, MresizeWidth);
			set_xt_boolean (screen_object, True, MresizeHeight);
		end;

	
	forbid_recompute_size is
			-- DisAllow current button to recompute its  size according to
			-- some changes on its text.
		do
			set_xt_boolean (button_widget, False, MrecomputeSize);
			set_xt_boolean (screen_object, False, MresizeWidth);
			set_xt_boolean (screen_object, False, MresizeHeight);
		end;

	title_width: INTEGER is
		local
			ext_name_Mw: ANY
		do
			ext_name_Mw := Mwidth.to_c;
			Result := get_dimension (title_widget, $ext_name_Mw); 
		end;

feature {NONE}

	button_widget: POINTER is
		do
			Result := xm_option_button_gadget (screen_object);
		end;

	title_widget: POINTER is
		do
			Result := xm_option_label_gadget (screen_object);
		end;

feature {NONE} -- External features

	xm_option_label_gadget (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	create_option_b (i_name: POINTER; scr_obj: POINTER; 
			man: BOOLEAN): POINTER is
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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
