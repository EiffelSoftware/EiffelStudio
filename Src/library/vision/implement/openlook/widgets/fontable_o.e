--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class FONTABLE_O

inherit

	FONTABLE_X

feature {NONE}

	set_implement_font (resource_screen: POINTER) is
		local
			ext_name: ANY;
		do
			ext_name := resource_name.to_c;
			set_openlook_font (screen_object, resource_screen, $ext_name)
		end;

feature {NONE} -- External feature

	set_openlook_font (scr_obj, the_screen: POINTER; resource: ANY) is
		external
			"C"
		end; 

end
