--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif check box implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CHECK_BOX_M 

inherit

	CHECK_BOX_I
		export
			{NONE} all
		end;

	MANAGER_M

creation

	make

feature -- Creation

	make (a_check_box: CHECK_BOX) is
			-- Create a motif check_box.
		local
			ext_name_c_box: ANY
		do
			ext_name_c_box := a_check_box.identifier.to_c;
			screen_object := create_check_box ($ext_name_c_box,
						a_check_box.parent.implementation.screen_object)
		end

feature {NONE} -- External features

	create_check_box (cb_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

