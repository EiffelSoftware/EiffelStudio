indexing
	description: "All shared general attributes"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GENERAL_DATA

inherit
	SHARED_RESOURCES
	EIFFEL_ENV

feature -- Access

	acrobat_reader: STRING is
		do
			Result := resources.get_string ("acrobat_reader", "acrobat")
		end

	print_shell_command: STRING is
		do
			Result := resources.get_string ("print_shell_command", "lpr $target")
		end

	text_mode: STRING is
		do
			Result := resources.get_string ("text_mode", D_text_mode)
		end

	D_text_mode: STRING is
		do
			if Platform_constants.is_windows then
				Result := "DOS"
			else
				Result := "UNIX"
			end
		end

	tab_step: INTEGER is
		do
			Result := resources.get_integer ("tab_step", 4)
		end

	editor: STRING is
		do
			Result := resources.get_string ("editor", "vi")
		end

	general_filter_path: STRING is
		do
			Result := resources.get_string ("filter_directory", clone (filter_path))
		end

	general_profile_path: STRING is
		do
			Result := resources.get_string ("profile_directory", clone (profile_path))
		end

	general_tmp_path: STRING is
		do
			Result := resources.get_string ("temporary_directory", clone (tmp_directory))
		end

	general_shell_command: STRING is
		do
			Result := resources.get_string ("shell_command", "xterm -geometry 80x40 -e vi +$line $target")
		end

	general_filter_name: STRING is
		do
			Result := resources.get_string ("filter_name", "PostScript")
		end

	general_filter_command: STRING is
		do
			Result := resources.get_string ("filter_command", "")
		end

	browsing_facilities: BOOLEAN is
		do
			Result := resources.get_boolean ("Highlight clickable areas", True)
		end

end -- class EB_GENERAL_DATA
