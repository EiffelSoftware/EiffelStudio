
-- OVERRIDE_S_M: implementation of override shell

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class OVERRIDE_S_M 

inherit

	OVERRIDE_S_I
		export
			{NONE} all
		end;

	POPUP_S_M;

creation

	make

feature 

	make (an_override_shell: OVERRIDE_S) is
			-- Create an override shell.
		local
			ext_name: ANY
		do
			!!is_poped_up_ref;
			ext_name := an_override_shell.identifier.to_c;
			screen_object := xt_create_override_shell ($ext_name,
					an_override_shell.parent.implementation.screen_object);
			initialize (an_override_shell);
		end;

	

feature {NONE} -- External features

	xt_create_override_shell (o_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
