
-- Motif bulletin dialog implementation.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BULLETIN_D_M 

inherit

	BULLETIN_D_I;

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
		redefine
			set_title, title
		end;

	BULLETIN_M
		rename
			xt_parent as b_xt_parent
		export
			{NONE} all
		undefine
			make
		redefine
           	 	define_cursor_if_shell, undefine_cursor_if_shell,
			is_stackable
		end

creation

	make

feature -- Creation

    make (a_bulletin_d: BULLETIN_D) is
            -- Create a motif bulletin dialog.
        local
            ext_name_bull: ANY
        do
            ext_name_bull := a_bulletin_d.identifier.to_c;
            screen_object := create_bulletin_d
			($ext_name_bull, a_bulletin_d.parent.implementation.screen_object);
            a_bulletin_d.set_dialog_imp (Current);
            forbid_resize
        end;

	is_stackable: BOOLEAN is do end;

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		require else
			not_a_title_void: not (a_title = Void)
		local
			ext_name, ext_name_title: ANY
		do
			ext_name_title := a_title.to_c;
			ext_name := Mtitle.to_c;
			m_wm_shell_set_string (xt_parent(screen_object), $ext_name_title,
$ext_name)
		end;

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		local
			ext_name: ANY
		do
			ext_name := Mtitle.to_c;
			Result := m_wm_shell_get_string (xt_parent (screen_object), $ext_name)
		end;


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

	create_bulletin_d (b_name: ANY; scr_obj: POINTER): POINTER is
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
