indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_PARAMETERS

inherit
	EB_PARAMETERS
	EIFFEL_ENV
		rename
			filter_path as env_filter_path,
			profile_path as env_profile_path,
			tmp_directory as env_tmp_directory
		end

creation
	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create acrobat_reader.make ("acrobat_reader", rt, "acrobat");
			if not Platform_constants.is_windows then
				create print_shell_command.make ("print_shell_command", rt, "lpr $target");
				create text_mode.make ("text_mode", rt, "UNIX")
			else
				create text_mode.make ("text_mode", rt, "DOS")
			end
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
		end
feature -- Access

	acrobat_reader: EB_STRING_RESOURCE
	text_mode: EB_STRING_RESOURCE
	tab_step: EB_INTEGER_RESOURCE
	editor: EB_STRING_RESOURCE
	filter_path: EB_STRING_RESOURCE
	profile_path: EB_STRING_RESOURCE
	tmp_path: EB_STRING_RESOURCE
	shell_command: EB_STRING_RESOURCE
	filter_name: EB_STRING_RESOURCE
	filter_command: EB_STRING_RESOURCE
	print_shell_command: EB_STRING_RESOURCE
	browsing_facilities: EB_BOOLEAN_RESOURCE

end -- class EB_GENERAL_PARAMETERS
