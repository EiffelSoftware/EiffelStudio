--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif bulletin implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BULLETIN_M 

inherit

	BULLETIN_I
		export
			{NONE} all
		end;

    MANAGER_M;

    BULLETIN_R_M
        export
            {NONE} all
        end

creation

	make

feature 

	make (a_bulletin: BULLETIN) is
			-- Create a motif bulletin.
		local
			ext_name_bull: ANY
		do
			ext_name_bull := a_bulletin.identifier.to_c;
			screen_object := create_bulletin ($ext_name_bull, a_bulletin.parent.implementation.screen_object);
		end;

feature {NONE} -- External features

	create_bulletin (b_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

