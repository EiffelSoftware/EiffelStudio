indexing

	description:
		"Resource category for general resources.";
	date: "$Date$";
	revision: "$Revision$"

class GENERAL_CATEGORY

inherit
	RESOURCE_CATEGORY;
	EIFFEL_ENV
		rename
			filter_path as env_filter_path,
			profile_path as env_profile_path,
			tmp_directory as env_tmp_directory
		end

create
	make


feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			create users.make;
			create modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			if Platform_constants.is_windows then
				create regular_button.make ("regular_button_in_toolbar", rt, False)
			end
			create close_button.make ("close_button_in_every_tool", rt, False)
			create acrobat_reader.make ("acrobat_reader", rt, "acrobat");
			if Platform_constants.is_windows then
				create tab_step.make ("tab_step", rt, 4);
			end
			create editor.make ("editor", rt, "vi");
			create filter_path.make ("filter_directory", rt, clone (env_filter_path));
			create profile_path.make ("profile_directory", rt, clone (env_profile_path));
			create tmp_path.make ("temporary_directory", rt, clone (env_tmp_directory));
			create shell_command.make ("shell_command", rt, "xterm -geometry 80x40 -e vi +$line $target");
			create filter_name.make ("filter_name", rt, "PostScript");
			create filter_command.make ("filter_command", rt, "");
			create browsing_facilities.make ("Highlight clickable areas", rt, True);
			create history_size.make ("history_size", rt, 10)
			create default_window_position.make ("default_window_position", rt, False);
			create window_free_list_number.make ("window_free_list_number", rt, 2);
			create color_list.make ("color_list", rt, <<"black", "white", "red", "blue", "green", "yellow", "brown", "cyan">>);
			if not Platform_constants.is_windows then
				create print_shell_command.make ("print_shell_command", rt, "lpr $target");
				create text_mode.make ("text_mode", rt, "UNIX")
			else
				create text_mode.make ("text_mode", rt, "DOS")
			end;
			create motif_1_2.make ("motif_1_2", rt, False)
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	regular_button: BOOLEAN_RESOURCE;
	close_button: BOOLEAN_RESOURCE
	acrobat_reader: STRING_RESOURCE;
	tab_step: INTEGER_RESOURCE;
	editor: STRING_RESOURCE;
	filter_path: STRING_RESOURCE;
	profile_path: STRING_RESOURCE;
	tmp_path: STRING_RESOURCE;
	print_shell_command: STRING_RESOURCE;
	filter_name: STRING_RESOURCE;
	filter_command: STRING_RESOURCE;
	browsing_facilities: BOOLEAN_RESOURCE;
	history_size: INTEGER_RESOURCE;
	default_window_position: BOOLEAN_RESOURCE;
	window_free_list_number: INTEGER_RESOURCE;
	color_list: ARRAY_RESOURCE;
	shell_command: STRING_RESOURCE
	text_mode: STRING_RESOURCE
	motif_1_2: BOOLEAN_RESOURCE

end -- class GENERAL_CATEGORY
