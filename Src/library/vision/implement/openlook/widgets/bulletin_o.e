
-- OpenLook bulletin implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BULLETIN_O 

inherit

	BULLETIN_I
		
		export
			{NONE} all
		end;

	MANAGER_O

creation

	make
	
feature 

	make (a_bulletin: BULLETIN) is
			-- Create a openlook bulletin.
		local
			ext_name: ANY;
		do
			ext_name := a_bulletin.identifier.to_c;
			screen_object := create_bulletin ($ext_name, a_bulletin.parent.implementation.screen_object);
		end;

	set_default_position (flag:boolean) is
		do
		end;


feature {NONE} -- External features

	create_bulletin (name: ANY; parent: POINTER): POINTER is
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
