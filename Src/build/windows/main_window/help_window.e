
class HELP_WINDOW 

inherit

	EB_TOP_SHELL
		rename
			make as top_shell_create,
			destroy as old_destroy
		redefine
			set_geometry
		end;
	HOLE
		redefine
			process_any
		select
			init_toolkit
		end;
	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.help_wnd_width,
				Resources.help_wnd_height)
		end;

feature {NONE}

	text: SCROLLED_T;

	help_hole: HELP_WINDOW_HOLE;

	target: WIDGET is
		do
			Result := text
		end;

	close is 
		do
			destroy
		end;

	destroy is
		do
			old_destroy;
			help_hole.unregister;
			unregister;
		end;

	make (a_screen: SCREEN) is
		local
			delete_com: DELETE_WINDOW;
			form, form1: FORM;
			close_b: CLOSE_WINDOW_BUTTON;
		do
			register;
			top_shell_create (Widget_names.help_window, a_screen);
			!! form.make (Widget_names.form, Current);
			!! text.make (Widget_names.text, form);
			!! form1.make (Widget_names.form1, form);

			!! help_hole.make (Current, form1);
			!! close_b.make (Current, form1);
			
			form.attach_top (form1, 2);
			form.attach_left (form1, 2);
			form.attach_right (form1, 2);
			form.attach_bottom (text, 2);
			form.attach_left (text, 2);
			form.attach_right (text, 2);
			form.attach_top_widget (form1, text, 2);

			form1.attach_top (help_hole, 0);
			form1.attach_top (close_b, 0);
			form1.attach_left (help_hole, 2);
			form1.attach_right (close_b, 2);
			form1.attach_bottom (help_hole, 2);
			form1.attach_bottom (close_b, 2);

			!!delete_com.make (Current);
			set_delete_command (delete_com);
			initialize_window_attributes;
			set_x_y (screen.x, screen.y)
		end;

feature

	update_text (data: DATA) is
		require
			valid_data: data /= Void
		local
			mp: MOUSE_PTR
		do
			!! mp;
			mp.set_watch_shape;
			help_hole.set_full_symbol;
			text.set_text (data.help_text);
			mp.restore
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.any_type
		end;

	process_any (dropped: STONE) is
		do
			update_text (dropped.data);
		end

end
