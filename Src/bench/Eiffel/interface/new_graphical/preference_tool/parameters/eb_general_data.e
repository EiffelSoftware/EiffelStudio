indexing
	description: "All shared general attributes"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	acrobat_reader: STRING is
		do
			Result := string_resource_value ("acrobat_reader", "acrobat")
		end

	print_shell_command: STRING is
		do
			Result := string_resource_value ("print_shell_command", "lpr $target")
		end

	text_mode_is_windows: BOOLEAN is
		do
			Result := boolean_resource_value ("text_mode_is_windows", Platform_constants.is_windows)
		end

	tab_step: INTEGER is
		do
			Result := integer_resource_value ("tab_step", 4)
		end

	shell_editor: STRING is
		do
			Result := string_resource_value ("editor", "vi")
		end

	general_shell_command: STRING is
		do
			Result := string_resource_value ("shell_command", "xterm -geometry 80x40 -e vi +$line $target")
		end

	general_filter_name: STRING is
		do
			Result := string_resource_value ("filter_name", "PostScript")
		end

	general_filter_command: STRING is
		do
			Result := string_resource_value ("filter_command", "")
		end

	general_filter_path: STRING is
		do
			Result := string_resource_value ("filter_directory", clone (filter_path))
		end

	general_profile_path: STRING is
		do
			Result := string_resource_value ("profile_directory", clone (profile_path))
		end

	general_tmp_path: STRING is
		do
			Result := string_resource_value ("temporary_directory", clone (tmp_directory))
		end

	browsing_facilities: BOOLEAN is
		do
			Result := boolean_resource_value ("Highlight clickable areas", True)
		end

	show_starting_dialog: BOOLEAN is
		do
			Result := boolean_resource_value ("show_starting_dialog", True)
		end

feature -- Element change

	save_show_starting_dialog (new_value: BOOLEAN) is
		do
			set_boolean ("show_starting_dialog", new_value)
		end

end -- class EB_GENERAL_DATA
