
-- WORKING_D_M: implementation of working dialog.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class WORKING_D_M 

inherit

	WORKING_D_I
		export
			{NONE} all
		end;

	MESSAGE_D_M
		undefine
			make
		redefine
			define_cursor_if_shell, undefine_cursor_if_shell
		end;

	DIALOG_M
		
creation

	make

feature {ALL_CURS_X}

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require else
			a_cursor_exists: a_cursor /= Void
		do
			dialog_define_cursor_if_shell (a_cursor)
		end;

	undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		do
			dialog_undefine_cursor_if_shell
		end;

feature 

	make (a_working_dialog: WORKING_D) is
			-- Create a motif working dialog.
		local
			ext_name: ANY
		do
			ext_name := a_working_dialog.identifier.to_c;
			screen_object := create_working_d ($ext_name, a_working_dialog.parent.implementation.screen_object);
			a_working_dialog.set_dialog_imp (Current);
			forbid_resize
			action_target := screen_object;
		end

feature {NONE} -- External features

	create_working_d (d_name: ANY; scr_obj: POINTER): POINTER is
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
