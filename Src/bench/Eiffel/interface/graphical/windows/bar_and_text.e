
-- Model for workbench windows

deferred class BAR_AND_TEXT

inherit

	TOOL_W
		redefine
			save_command
		end;
	TOP_SHELL
		rename
			make as shell_make
		end

feature

	make (a_screen: SCREEN) is
			-- Create an assembly tool.
		do
			shell_make (tool_name, a_screen);
			!!global_form.make (new_name, Current);
			build_widgets;
			set_icon_pixmap (hole.symbol);
			set_icon_name (tool_name);
			realize;
			transporter_init
		end;

	global_form: FORM;

	hole: HOLE;
			-- Hole caracterizing current

	edit_bar, format_bar: FORM;
			-- Main and format menu bars

	build_widgets is
			-- Build system widget.
		do
			set_size (440, 500);
				!!text_window.make (new_name, global_form, Current);
				!!edit_bar.make (new_name, global_form);
				build_edit_bar;
				!!format_bar.make (new_name, global_form);
				build_format_bar;
				text_window.set_last_format (default_format);
			attach_all
		end;

	showtext_command: SHOW_TEXT;
			-- Command to show text od text window's root stone,
			-- default format by default
	default_format: FORMATTER is do Result := showtext_command end;
	open_command: OPEN_FILE;
	save_command: SAVE_FILE;
	save_as_command: SAVE_AS_FILE;
	change_font_command: CHANGE_FONT;
	search_command: SEARCH_STRING;
	quit_command: QUIT_FILE;

	type_teller: LABEL_G;
			-- To tell what type of element we are dealing with

	clean_type is
			-- Clean what's said in the type teller window.
		do
			type_teller.set_text (" ")
		end;

	tell_type (a_type_name: STRING) is
			-- Display `a_type_name' in type teller.
		do
			type_teller.set_text (a_type_name)
		end;

	build_edit_bar is
			-- Build top bar: editing commands.
		do
				!!hole.make (edit_bar, Current);
				!!open_command.make (edit_bar, text_window);
				!!save_command.make (edit_bar, text_window);
				!!save_as_command.make (edit_bar, text_window);
				!!type_teller.make (new_name, edit_bar);
					type_teller.set_center_alignment;
				!!search_command.make (edit_bar, text_window);
				!!change_font_command.make (edit_bar, text_window);
				!!quit_command.make (edit_bar, text_window);
					edit_bar.attach_left (hole, 0);
					edit_bar.attach_top (hole, 0);
					edit_bar.attach_left_widget (hole, open_command, 25);
					edit_bar.attach_top (open_command, 0);
					edit_bar.attach_left_widget (open_command, save_command, 0);
					edit_bar.attach_top (save_command, 0);
					edit_bar.attach_left_widget (save_command, save_as_command, 0);
					edit_bar.attach_top (save_as_command, 0);
					clean_type;
					edit_bar.attach_left_widget (save_as_command, type_teller, 0);
					edit_bar.attach_top (type_teller, 0);
					edit_bar.attach_right_widget (search_command, type_teller, 0);
					edit_bar.attach_bottom (type_teller, 0);
					edit_bar.attach_top (search_command, 0);
					edit_bar.attach_right_widget (change_font_command, search_command, 25);
					edit_bar.attach_top (change_font_command, 0);
					edit_bar.attach_right_widget (quit_command, change_font_command, 25);
					edit_bar.attach_top (quit_command, 0);
					edit_bar.attach_right (quit_command, 0);
		end;

	build_format_bar is
			-- Build bottom bar: formatting commands.
		do
		end;

	attach_all is
			-- Attach menu bar and windows below together.
		do
			global_form.attach_left (edit_bar, 0);
			global_form.attach_right (edit_bar, 0);
			global_form.attach_top (edit_bar, 0);

			global_form.attach_left (text_window, 0);
			global_form.attach_right (text_window, 0);
			global_form.attach_bottom_widget (format_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, text_window, 0);

			global_form.attach_left (format_bar, 0);
			global_form.attach_right (format_bar, 0);
			global_form.attach_bottom (format_bar, 0);
		end

end -- class BAR_AND_TEXT
