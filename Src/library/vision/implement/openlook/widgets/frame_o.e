
-- OpenLook frame implementation.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FRAME_O 

inherit

	FRAME_I
		
		export
			{NONE} all
		end;

	FRAME_R_O
		export
			{NONE} all
		end;

	MANAGER_O

creation

	make
	
feature 

	make (a_frame: FRAME) is
			-- Create an openlook frame.
		
		local
			ext_name: ANY;
		do
			ext_name := a_frame.identifier.to_c;
			screen_object := create_frame ($ext_name,
					a_frame.parent.implementation.screen_object);
		end

feature {NONE} -- External features

	create_frame (name: ANY; parent: POINTER): POINTER is
		external
			"C"
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
