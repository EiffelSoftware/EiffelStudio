indexing

	description: "Rectangle which displays an option menu when armed";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OPTION_B_O 

inherit

	OPTION_B_I;

	OPTION_B_R_O
		export
			{NONE} all
		end;

	BUTTON_O
		export
			{NONE} all
		end;

	FONTABLE_O
		rename
			resource_name as OfontList,
			screen_object as font_screen_object
		
		export
			{NONE} all
		end;

	ROW_COLUMN_R_O
		rename
			OmarginHeight as old_OmarginHeight,
			OmarginWidth as old_OmarginWidth
		export
			{NONE} all
		end

creation

	make
	
feature 

	make (an_option_menu: OPTION_B) is
			-- Create a openlook option menu button
			
		local
			ext_id: ANY;
		do
			ext_id := an_option_menu.identifier.to_c;
			screen_object := create_menu_button ($ext_id, an_option_menu.parent.implementation.screen_object);
			set_xt_boolean (screen_object, True, Odefault);
			an_option_menu.set_font_imp (Current);
			allow_recompute_size;
		end;

	attach_menu(a_menu : OPT_PULL) is
			--TO FIX  This routine is not used : to remove
		do
		end;

	selected_button: PUSH_B;
			-- Current Push Button selected in the option menu

   	set_selected_button (button: PUSH_B) is
			-- Set `selected_button' to `button'
		require else
	  		button_exists: not (button = Void)
 		local
			ext_name: ANY;
	   		do
			ext_name := Odefault.to_c;
			set_boolean (button.implementation.screen_object, True, $ext_name);
			selected_button := button;
			ensure then
	   		button.same (selected_button)
		end;

	title: STRING;

	set_title (s: STRING) is do end;

	remove_title is do end;

	title_width: INTEGER is do end;

feature {NONE}

	font_screen_object: POINTER is
			-- Pointer to the text who change its font
		do
			Result := screen_object
		end;

feature {NONE} -- External features

	create_menu_button (ident: POINTER; a_parent: POINTER): POINTER is
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
