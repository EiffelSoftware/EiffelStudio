--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- TOP_SHELL_O: shell top level which is used in an application that needs
-- more than one shell root.

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOP_SHELL_O 

inherit

	TOP_SHELL_I
		
		export
			{NONE} all
		end;

	WM_SHELL_O;

	TOP_O

creation

	make
	
feature 

	make (a_top_shell: TOP_SHELL; application_class: STRING) is
			-- Create an openlook top level shell.
		
		local
			top_id, app_class: ANY;
		do
			top_id := to_c_if_not_void (a_top_shell.identifier);
			app_class := to_c_if_not_void (application_class);
			screen_object := xt_create_top_level_shell (a_top_shell.screen.implementation.screen_object, 
									$top_id, 
									$app_class);
			a_top_shell.set_wm_imp (Current);
			forbid_resize;
		end

feature {NONE} -- External features

	xt_create_top_level_shell (scr_obj: POINTER; top_id, app_class: ANY): POINTER is
		external
			"C"
		end;

end 
