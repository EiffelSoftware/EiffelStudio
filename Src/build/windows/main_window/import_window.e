

class IMPORT_WINDOW 

inherit

	FORM_D
		rename
			make as form_d_create
		undefine
			init_toolkit
		end;

	STORAGE_INFO
		export
			{NONE} all
		end;

	CONTEXT_SHARED
		export
			{NONE} all
		end;

	COMMAND
		export
			{NONE} all
		end;

	COMMAND_ARGS
		export
			{NONE} all
		end;

	WINDOWS
		export
			{NONE} all
		end


creation

	make

	
feature 

	file_selec: FILE_SELEC;

	entire_application: TOGGLE_B;
	interface, groups, commands, translations: TOGGLE_B;

	make (a_name: STRING; a_parent: COMPOSITE) is
		local
			separator: SEPARATOR;
			import_cmd: IMPORT_CMD;
		do
			form_d_create (a_name, a_parent);
			!!file_selec.make ("File selection box", Current);

			!!entire_application.make ("Entire application", Current);
			!!interface.make ("Interface", Current);
			!!groups.make ("Groups", Current);
			!!commands.make ("Commands", Current);
			!!translations.make ("Translations", Current);

			!!import_cmd;

			file_selec.hide_help_button;
			file_selec.add_ok_action (import_cmd, Current);
			file_selec.add_cancel_action (Current, Second);
			set_exclusive_grab;
			file_selec.set_directory_selection;
			file_selec.hide_file_selection_list;
			file_selec.hide_file_selection_label;

			!!separator.make ("Separator", Current);
			separator.set_single_line;
			separator.set_horizontal (False);

			entire_application.add_release_action (Current, entire_application);
			interface.add_release_action (Current, interface);
			groups.add_release_action (Current, groups);
			commands.add_release_action (Current, commands);
			translations.add_release_action (Current, translations);

			attach_top (file_selec, 0);
			attach_top (entire_application, 30);
			attach_top_widget (entire_application, interface, 20);
			attach_top_widget (interface, groups, 10);
			attach_top_widget (groups, commands, 10);
			attach_top_widget (commands, translations, 10);

			attach_top (separator, 3);
			attach_bottom (separator, 3);

			attach_bottom (file_selec, 0);

			attach_left (file_selec, 0);
			attach_left_widget (file_selec, separator, 5);
			attach_left_widget (separator, entire_application, 5);
			attach_left_widget (separator, interface, 5);
			attach_left_widget (separator, groups, 5);
			attach_left_widget (separator, commands, 5);
			attach_left_widget (separator, translations, 5);
		end;

	
feature {NONE}

	execute (argument: ANY) is
		do
			if argument = second then
				popdown;
			elseif entire_application.state then
				interface.arm;
				groups.arm;
				commands.arm;
				translations.arm;
			elseif argument = interface then
				if interface.state then
					groups.arm;
				end;
			elseif argument = groups then
				if not groups.state and then interface.state then
					groups.arm
				end;
			end;
		end;

end
