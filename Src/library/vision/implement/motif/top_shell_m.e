
-- TOP_SHELL_M: shell top level which is used in an application that needs
-- more than one shell root.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOP_SHELL_M 

inherit

	TOP_SHELL_I
		export
			{NONE} all
		end;

	WM_SHELL_M
		rename
			c_set_pixmap as cc_set_pixmap
		end;

	TOP_M

creation

	make

feature 

	make (a_top_shell: TOP_SHELL; application_class: STRING) is
			-- Create a motif top level shell.
		local
			ext_name_t_sh, ext_name_app_cl: ANY
		do
			oui_top := a_top_shell;
			ext_name_t_sh := to_c_if_not_void (a_top_shell.identifier);
			ext_name_app_cl := to_c_if_not_void (application_class);
			screen_object := xt_create_top_level_shell (a_top_shell.screen.implementation.screen_object, $ext_name_t_sh, $ext_name_app_cl);
			a_top_shell.set_wm_imp (Current);
			xm_delete_window_protocol (a_top_shell.screen.implementation.screen_object, screen_object, Current, $delete_window_action);
		end

feature {NONE} -- External features

	xt_create_top_level_shell (scr_obj: POINTER; name1, name2: ANY): POINTER is
		external
			"C"
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
