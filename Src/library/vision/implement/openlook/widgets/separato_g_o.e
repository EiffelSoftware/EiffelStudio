--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class SEPARATO_G_O 

inherit

	SEPARATO_G_I
		
		export
			{NONE} all
		end;

	SEPARATOR_O
		rename
			make as separator_o_make
		end;

creation

	make

feature 

	make (a_separator_gadget: SEPARATOR_G) is
			-- Create an openlook separator gadget.
		
		local
			ext_name: ANY;
		do
			ext_name := a_separator_gadget.identifier.to_c;		
			screen_object := create_separator ($ext_name, a_separator_gadget.parent.implementation.screen_object)
		ensure
			is_horizontal
		end;

end 
