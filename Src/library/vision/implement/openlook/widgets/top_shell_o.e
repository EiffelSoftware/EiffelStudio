
-- TOP_SHELL_O: shell top level which is used in an application that needs
-- more than one shell root.

indexing

	status: "See notice at end of class";
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
