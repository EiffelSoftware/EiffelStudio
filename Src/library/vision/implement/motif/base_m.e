--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif base implementation. 

indexing

	date: "$Date$";
	revision: "$Revision$"

class BASE_M 

inherit

	BASE_I
		export
			{NONE} all
		end;

	WM_SHELL_M;

	BASE_R_M
		export
			{NONE} all
		end;

	TOP_M

creation

	make

feature 

	make (a_base: BASE; application_class: STRING) is
		local
			ext_name_base, ext_name_appl: ANY
		do
-- FIXME (Cf notes)
			ext_name_base := to_c_if_not_void (a_base.identifier);
			ext_name_appl := to_c_if_not_void (application_class);
			screen_object:= xt_create_app_shell (a_base.screen.implementation.screen_object, $ext_name_base, $ext_name_appl);
			a_base.set_wm_imp (Current)
		end

feature {NONE} -- External features

	xt_create_app_shell (src_obj: POINTER; b_name, a_name: ANY): POINTER is
		external
			"C"
		end;

end

