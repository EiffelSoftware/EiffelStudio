
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FILE_SEL_D_M 

inherit

	FILE_SEL_D_I
		export
			{NONE} all
		end;

	DIALOG_M
        rename
		c_set_pixmap as cc_set_pixmap,
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
        end;

	FILE_SELEC_M
		rename 
			xt_parent as f_xt_parent
		undefine
			make
		redefine
			define_cursor_if_shell, undefine_cursor_if_shell,
			set_x, set_y, set_x_y
		end
		
creation

	make

feature -- Creation

	make (a_file_select_dialog: FILE_SEL_D) is
			-- Create a motif file selection dialog.
		local
			ext_name: ANY
		do
			ext_name := a_file_select_dialog.identifier.to_c;
			screen_object := create_file_select_d ($ext_name,
					a_file_select_dialog.parent.implementation.screen_object);
			a_file_select_dialog.set_dialog_imp (Current);
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

feature 

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		local
			ext_name_Mx: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, y)
			else
				if shown then
					ext_name_Mx := Mx.to_c;
					set_posit (screen_object, new_x, $ext_name_Mx)
				else
					xt_move_widget (screen_object, new_x, y)
				end
			end
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		local
			ext_name_Mx, ext_name_My: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, new_y)
			else
				if shown then
					ext_name_Mx := Mx.to_c;
					ext_name_My := My.to_c;
					set_posit (screen_object, new_x, $ext_name_Mx);
					set_posit (screen_object, new_y, $ext_name_My);
				else
					xt_move_widget (screen_object, new_x, new_y)
				end
			end;
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		local
			ext_name_My: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, x, new_y)
			else
				if shown then
					ext_name_My := My.to_c;
					set_posit (screen_object, new_y, $ext_name_My);
				else
					xt_move_widget (screen_object, x, new_y)
				end
			end
		end;


feature {NONE} -- External features

	create_file_select_d (d_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

    xt_move_widget (scr_obj: POINTER; x_value, y_value: INTEGER) is
        external
            "C"
        end;

    xt_set_geometry (scr_obj: POINTER; x_value, y_value: INTEGER) is
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
