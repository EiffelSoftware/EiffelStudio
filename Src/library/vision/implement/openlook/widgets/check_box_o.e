--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OpenLook check box implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CHECK_BOX_O 

inherit

	CHECK_BOX_I
		export
			{NONE} all
		end;

	MANAGER_O

creation

	make
	
feature 

	make (a_check_box: CHECK_BOX) is
			-- Create a openlook check_box.
		local
			ext_name: ANY;
		do
			ext_name := a_check_box.identifier.to_c;
			screen_object := create_check_box ($ext_name,
						a_check_box.parent.implementation.screen_object)
		end

feature {NONE} -- External features

	create_check_box (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end;

end 
