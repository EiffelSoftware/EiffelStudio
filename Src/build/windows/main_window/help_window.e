
class HELP_WINDOW 

inherit

	EB_TOP_SHELL
		rename
			make as top_shell_create,
			destroy as old_destroy
		redefine
			set_geometry
		end
	HOLE
		redefine
			process_any
		select
			init_toolkit
		end
	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.help_wnd_width,
				Resources.help_wnd_height)
		end

feature {NONE}

	text: SCROLLED_T

	help_hole: HELP_WINDOW_HOLE

	target: WIDGET is
		do
			Result := text
		end

	close is 
		do
			destroy
		end

	destroy is
		do
			old_destroy
			help_hole.unregister
			unregister
		end

	make (a_screen: SCREEN) is
		local
			delete_com: DELETE_WINDOW
			exit_cmd: EXIT_EIFFEL_BUILD_CMD
			form, form1: FORM
			window_menu_bar: BAR
			file_category: MENU_PULL
			exit_tool_entry: PUSH_B
			exit_entry: PUSH_B
			menu_separator: THREE_D_SEPARATOR
		do
			register
			top_shell_create (Widget_names.help_window, a_screen)
			!! window_menu_bar.make (menu_names.menu_bar, Current)
			!! file_category.make (menu_names.file, window_menu_bar)
			!! exit_tool_entry.make (menu_names.exit_tool, file_category)
			!! exit_entry.make (menu_names.exit, file_category)
			!! form.make (Widget_names.form, Current)
			!! text.make (Widget_names.text, form)
			!! form1.make (Widget_names.form1, form)

			!! menu_separator.make (Widget_names.separator, form)
			!! help_hole.make (Current, form1)

			form.attach_top (menu_separator, 0)
			form.attach_left (menu_separator, 0)
			form.attach_right (menu_separator, 0)
			form.attach_top_widget (menu_separator, form1, 0)
			form.attach_left (form1, 0)
			form.attach_right (form1, 0)
			form.attach_bottom (text, 0)
			form.attach_left (text, 0)
			form.attach_right (text, 0)
			form.attach_top_widget (form1, text, 0)

			form1.attach_top (help_hole, 0)
			form1.attach_left (help_hole, 0)
			form1.attach_bottom (help_hole, 0)

			!!delete_com.make (Current)
			set_delete_command (delete_com)
			exit_tool_entry.add_activate_action (delete_com, Void) 
			!! exit_cmd
			exit_entry.add_activate_action (exit_cmd, Void)	
			initialize_window_attributes
			set_x_y (screen.x, screen.y)
		end

feature

	update_text (data: DATA) is
		require
			valid_data: data /= Void
		local
			mp: MOUSE_PTR
		do
			!! mp
			mp.set_watch_shape
			help_hole.set_full_symbol
			text.set_text (data.help_text)
			mp.restore
		end

	stone_type: INTEGER is
		do
			Result := Stone_types.any_type
		end

	process_any (dropped: STONE) is
		do
			update_text (dropped.data)
		end

end
