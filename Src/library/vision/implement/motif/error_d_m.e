--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                     (805) 685-1006                          --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Motif error dialog implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

class ERROR_D_M 

inherit

	ERROR_D_I
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
		rename
			xt_window as d_xt_window,
			x_define_cursor as d_x_define_cursor,
			set_boolean as d_set_boolean,
			xt_unmanage_child as d_xt_unmanage_child,
			xt_manage_child as d_xt_manage_child,
			x_flush as d_x_flush,
			xt_display as d_xt_display
		export
			{NONE}
				d_xt_window, d_x_define_cursor,
				d_set_boolean, d_xt_unmanage_child, d_x_flush,
				d_xt_manage_child, d_xt_display
		end

creation

	make

feature -- Creation

	make (an_error_dialog: ERROR_D) is
			-- Create a motif error dialog.
		local
			ext_name: ANY
		do
			ext_name := an_error_dialog.identifier.to_c;
			screen_object := create_error_d ($ext_name,
					an_error_dialog.parent.implementation.screen_object);
			an_error_dialog.set_dialog_imp (Current);
			forbid_resize
		end;

feature {ALL_CURS_X}

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

	create_error_d (d_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end

