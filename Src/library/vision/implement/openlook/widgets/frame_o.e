--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OpenLook frame implementation.

indexing

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

