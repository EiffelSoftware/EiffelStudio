
-- MENU_PULL_O: implementation of pulldown for menu buttons.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MENU_PULL_O 

inherit

	MENU_PULL_I
		export
			{NONE} all
		end;

	PULLDOWN_O
		redefine
			button
		end;

	PULLDOWN_R_O
		export
			{NONE} all
		end

creation

	make
	
feature 

	button: MENU_B;

 	make (a_pulldown: MENU_PULL) is
			-- Create an openlook pulldown menu.
		
		local
			ext_name: ANY;
		do
			!!button.make (a_pulldown.identifier,a_pulldown.parent);
			ext_name := OmenuPane.to_c;
			screen_object := get_widget (button.implementation.screen_object, $ext_name);
			abstract_menu := a_pulldown;
			menu_button := button
		end;

end 



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
