
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATO_G_O 

inherit

	SEPARATO_G_I
		
		export
			{NONE} all
		end;

	SEPARATOR_O
		rename
			make as separator_o_make
		end;

creation

	make

feature 

	make (a_separator_gadget: SEPARATOR_G) is
			-- Create an openlook separator gadget.
		
		local
			ext_name: ANY;
		do
			ext_name := a_separator_gadget.identifier.to_c;		
			screen_object := create_separator ($ext_name, a_separator_gadget.parent.implementation.screen_object)
		ensure
			is_horizontal
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
