
-- Motif information dialog implementation.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class INFO_D_M 

inherit

	INFO_D_I
		export
			{NONE} all
		end;

	MESSAGE_D_M
		undefine
			make
		redefine
            define_cursor_if_shell, undefine_cursor_if_shell
		select
			cc_set_pixmap
		end;

	DIALOG_M
        rename
		c_set_pixmap as c_c_set_pixmap,
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

	make (an_information_dialog: INFO_D) is
			-- Create a motif information dialog.
		local
			ext_name: ANY
		do
			ext_name := an_information_dialog.identifier.to_c;
			screen_object := create_info_d ($ext_name, an_information_dialog.parent.implementation.screen_object);
			an_information_dialog.set_dialog_imp (Current);
			forbid_resize
		end;

feature {NONE} -- External features

	create_info_d (name: ANY; scr_obj: POINTER): POINTER is
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
