--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- RADIO_BOX_O: implementation of radio box.

indexing

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
		end

feature {NONE} -- External features

	create_radio_box (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

end

