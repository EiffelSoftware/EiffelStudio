
-- RADIO_BOX_O: implementation of radio box.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class RADIO_BOX_O 

inherit

	RADIO_BOX_I
		
		export
			{NONE} all
		end;

	MANAGER_O

creation

	make
	
feature 

	make (a_radio_box: RADIO_BOX) is
			-- Create an openlook radio_box.
		
		local
			ext_name: ANY;
		do
			ext_name := a_radio_box.identifier.to_c;		
			screen_object := create_radio_box ($ext_name,
					a_radio_box.parent.implementation.screen_object);
		end;

	set_always_one (f: BOOLEAN) is do end;

feature {NONE} -- External features

	create_radio_box (name: ANY; parent: POINTER): POINTER is
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
