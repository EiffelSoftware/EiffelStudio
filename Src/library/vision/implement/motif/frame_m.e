--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif frame implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class FRAME_M 

inherit

	FRAME_I
		export
			{NONE} all
		end;

	FRAME_R_M
		export
			{NONE} all
		end;

	MANAGER_M

creation

	make

feature -- Creation

	make (a_frame: FRAME) is
			-- Create a motif frame.
		local
			ext_name_frame: ANY
		do
			ext_name_frame := a_frame.identifier.to_c;
			screen_object := create_frame ($ext_name_frame,
					a_frame.parent.implementation.screen_object);
		end

feature {NONE} -- External features

	create_frame (f_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

