--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- OpenLook bulletin implementation.

indexing

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
		end

feature {NONE} -- External features

	create_bulletin (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end;
end


