
-- OpenLook bulletin dialog implementation.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BULLETIN_D_O 

inherit

	BULLETIN_D_I;

	DIALOG_O;

	BULLETIN_O
		rename
			make as bulletin_o_make
		export
			{NONE} all
		undefine
			real_x, real_y, set_managed,
			define_cursor_if_shell,
			undefine_cursor_if_shell
		end;

creation

	make
	
feature 

	make (a_bulletin_d: BULLETIN_D) is
			-- Create a openlook bulletin dialog.
		local
			ext_name: ANY;
		do
			!!is_poped_up_ref;
			ext_name := a_bulletin_d.identifier.to_c;
			screen_object := create_bulletin_d ($ext_name, a_bulletin_d.parent.implementation.screen_object);
			a_bulletin_d.set_dialog_imp (Current);
			forbid_resize;
			initialize (a_bulletin_d)
		end

feature {NONE} -- External features

	create_bulletin_d (name: ANY; parent: POINTER): POINTER is
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
