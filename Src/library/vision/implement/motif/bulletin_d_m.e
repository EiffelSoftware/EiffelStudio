indexing

	description: "Motif bulletin dialog implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BULLETIN_D_M 

inherit

	BULLETIN_D_I;

	DIALOG_M;

	BULLETIN_M
		rename
			make as bulletin_make
		export
			{NONE} all
		undefine
			lower, raise, action_target,
			show, hide, shown, destroy_xt_widget
		redefine
			define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable
		end

creation

	make

feature {NONE} -- Creation

	make (a_bulletin_d: BULLETIN_D) is
			-- Create a motif bulletin dialog.
		local
			ext_name_bull: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name_bull := a_bulletin_d.identifier.to_c;
			screen_object := create_bulletin_d
					($ext_name_bull, 
					parent_screen_object (a_bulletin_d, widget_index));
			a_bulletin_d.set_dialog_imp (Current);
			forbid_resize
			action_target := screen_object;
		end;

	is_stackable: BOOLEAN is do end;

feature {NONE}

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require else
			a_cursor_exists: not (a_cursor = Void)
		do
			dialog_define_cursor_if_shell (a_cursor)
		end;

	undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		do
			dialog_undefine_cursor_if_shell
		end;

feature {NONE} -- External features

	create_bulletin_d (b_name: POINTER; scr_obj: POINTER): POINTER is
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
