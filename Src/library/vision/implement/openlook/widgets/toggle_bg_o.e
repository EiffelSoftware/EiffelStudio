indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_BG_O 

inherit

	TOGGLE_BG_I
		
		export
			{NONE} all
		end;

	TOGGLE_B_O
		rename
			make as toggle_b_o_make
		end;

creation

	make
	
feature 

	make (a_toggle_bg: TOGGLE_BG) is
			-- Create a openlook toggle button.
		
		local
			ext_name: ANY;
		do
			ext_name := a_toggle_bg.identifier.to_c;		
			screen_object := create_toggle_b ($ext_name, a_toggle_bg.parent.implementation.screen_object);
			a_toggle_bg.set_font_imp (Current);
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
