
-- MENU_B_O: Implementation of menu button.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MENU_B_O 

inherit

	MENU_B_I
		export
			{NONE} all
		end;

	MENU_B_R_O
		export
			{NONE} all
		end;

	BUTTON_O;

	FONTABLE_O
		rename
			resource_name as OfontList
		
		end

creation

	make
	
feature 

	make (a_menu_b: MENU_B) is
			-- Create a openlook menu button.
		local
			ext_name: ANY;
		do
			ext_name := a_menu_b.identifier.to_c;
			screen_object := create_menu_button ($ext_name, a_menu_b.parent.implementation.screen_object);
			a_menu_b.set_font_imp (Current)
		end

feature {NONE} -- External features

	create_menu_button (name: ANY; parent: POINTER): POINTER is
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
