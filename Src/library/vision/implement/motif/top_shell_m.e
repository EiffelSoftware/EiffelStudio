--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- TOP_SHELL_M: shell top level which is used in an application that needs
-- more than one shell root.

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOP_SHELL_M 

inherit

	TOP_SHELL_I
		export
			{NONE} all
		end;

	WM_SHELL_M;

	TOP_M

creation

	make

feature 

	make (a_top_shell: TOP_SHELL; application_class: STRING) is
			-- Create a motif top level shell.
		local
			ext_name_t_sh, ext_name_app_cl: ANY
		do
			ext_name_t_sh := to_c_if_not_void (a_top_shell.identifier);
			ext_name_app_cl := to_c_if_not_void (application_class);
			screen_object := xt_create_top_level_shell (a_top_shell.screen.implementation.screen_object, $ext_name_t_sh, $ext_name_app_cl);
			a_top_shell.set_wm_imp (Current)
		end

feature {NONE} -- External features

	xt_create_top_level_shell (scr_obj: POINTER; name1, name2: ANY): POINTER is
		external
			"C"
		end;

end

