
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class DIALOG_M 

inherit

	G_ANY_M
		export
			{NONE} all
		end;

	WM_SHELL_M
		export
			{NONE} all
		redefine
			title, set_title
		end;

	DIALOG_R_M
		export
			{NONE} all
		end;

	DIALOG_I
		
feature 

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		local
			ext_name_shell: ANY
		do
			ext_name_shell := MallowShellResize.to_c;
			d_set_boolean (d_xt_parent (screen_object), 
					True,
					$ext_name_shell)
		end;

feature {NONE}

	dialog_define_cursor_if_shell (cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require
			a_cursor_exists: not (cursor = Void)
		local
			display_pointer: POINTER;
			window, void_pointer: POINTER;
			cursor_implementation: SCREEN_CURSOR_X
		do
			window := d_xt_window (screen_object);
			if window /= void_pointer then
				display_pointer := d_xt_display (screen_object);
				cursor_implementation ?= cursor.implementation;
				d_x_define_cursor (display_pointer, 
							window, 
							cursor_implementation.cursor_id (screen));
				d_x_flush (display_pointer)
			end
		end;

	dialog_undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		local
			display_pointer, void_pointer: POINTER;
			window: POINTER
		do
			window := d_xt_window (screen_object);
			if window /= void_pointer then
				display_pointer := d_xt_display (screen_object);
				d_x_undefine_cursor (display_pointer, window);
				d_x_flush (display_pointer)
			end
		end;

feature 

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		local
			ext_name_shell: ANY
		do
			ext_name_shell := MallowShellResize.to_c;
			d_set_boolean (d_xt_parent (screen_object), 
						False,
						$ext_name_shell)
		end;

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		local
			ext_name: ANY
		do
			ext_name := MdialogTitle.to_c;
			Result := m_wm_shell_get_string (d_xt_parent (screen_object), 
						$ext_name)
		end;

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		require else
			not_a_title_void: not (a_title = Void)
		local
			ext_name, ext_name_title: ANY
		do
			ext_name_title := a_title.to_c;
			ext_name := MdialogTitle.to_c;
			m_wm_shell_set_string (d_xt_parent(screen_object), 
					$ext_name_title,
					$ext_name)
		end;

feature {NONE}

	grab_type: INTEGER;
			-- Type of grab
	
feature 

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		do
			Result := grab_type = 2
		end;

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		do
			Result := grab_type = 1
		end;

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		do
			Result := grab_type = 0
		end;

	is_poped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		obsolete "Use is_popped_up instead, corrected feature spelling."
		do
			Result :=  c_is_poped_up (xt_parent (screen_object))
		end;

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		do
			Result :=  c_is_poped_up (xt_parent (screen_object))
		end;

	lower is
			-- Lower the shell in the stacking order.
		local
			window, display_pointer, void_pointer: POINTER
		do
			window := d_xt_window (d_xt_parent (screen_object));
			if window /= void_pointer then
				display_pointer := d_xt_display (d_xt_parent (screen_object));
				d_x_lower_window (display_pointer, window)
			end
		end;

	popdown is
			-- Popdown popup shell.
		do
			if is_popped_up then
				xt_unmanage_child (screen_object)
			end
		ensure then
			not is_popped_up
		end;

	popup is
			-- Popup a popup shell.
		do
			if not is_popped_up then
				xt_manage_child (screen_object);
				c_add_grab (xt_parent (screen_object), grab_type)
			end
		ensure then
			is_popped_up
		end;

	raise is
			-- Raise the shell to the top of the stacking order.
		local
            window, display_pointer, void_pointer: POINTER
		do
			window := xt_window (xt_parent (screen_object));
			if window /= void_pointer then
				display_pointer := xt_display (xt_parent (screen_object));
				x_raise_window (display_pointer, window)
			end
		end;


feature 

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		do
			grab_type := 2
		ensure then
			is_cascade_grab
		end; -- set_cascade_grab

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		do
			grab_type := 1
		ensure then
			is_exclusive_grab
		end; -- set_exclusive_grab

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		do
			grab_type := 0
		ensure then
			is_no_grab
		end

feature

	dialog_command_target is
		do
			action_target := d_xt_parent (screen_object);
		ensure then
			target_correct: action_target = d_xt_parent (screen_object);
		end;

	widget_command_target is
		do
			action_target := screen_object;
		ensure then
			target_correct: action_target = screen_object;
		end;

	action_target: POINTER;

feature {NONE} -- External features

	d_set_boolean (value1: POINTER; value2: BOOLEAN; s_name: ANY) is
		external
			"C"
		alias
			"set_boolean"
		end;

	d_x_raise_window (dspl_pointer, wndw: POINTER) is
		external
			"C"
		alias
			"x_raise_window"
		end;

	d_c_add_grab (value: POINTER; grab_type_val: INTEGER) is
		external
			"C"
		alias
			"c_add_grab"
		end;

	d_xt_manage_child (scr_obj: POINTER) is
		external
			"C"
		alias
			"xt_manage_child"
		end;

	d_xt_unmanage_child (scr_obj: POINTER) is
		external
			"C"
		alias
			"xt_unmanage_child"
		end;

	d_x_lower_window (dspl_pointer, wndw: POINTER) is
		external
			"C"
		alias
			"x_lower_window"
		end;

	d_c_is_poped_up (value: POINTER): BOOLEAN is
		external
			"C"
		alias
			"c_is_poped_up"
		end;

	d_x_undefine_cursor (dspl_pointer, wndw: POINTER) is
		external
			"C"
		alias
			"x_undefine_cursor"
		end;

	d_xt_window (scr_obj: POINTER): POINTER is
		external
			"C"
		alias
			"xt_window"
		end;

	d_xt_display (scr_obj: POINTER): POINTER is
		external
			"C"
		alias
			"xt_display"
		end;

	d_x_flush (dspl_pointer: POINTER) is
		external
			"C"
		alias
			"x_flush"
		end;

	d_x_define_cursor (dspl_pointer, wndw, curs_id: POINTER) is
		external
			"C"
		alias
			"x_define_cursor"
		end;

	d_xt_parent (scr_obj: POINTER): POINTER is
		external
			"C"
		alias
			"xt_parent"
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
