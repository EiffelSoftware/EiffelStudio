indexing
	description	: "Command to execute an external wizard to create a new project"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_PROJECT_WIZARD

inherit
	EB_EXTERNAL_WIZARD
	
	EIFFEL_ENV
		export
			{NONE} all
		end

create
	make,
	make_with_file

feature {NONE} -- Initialization

	make_with_file (a_filename: FILE_NAME) is
			-- Load the command from the description file named
			-- `a_filename'.
			--
			-- The file should contain the following lines:
			-- Name=".."
			--
		require
			valid_filename: a_filename /= Void and then not a_filename.is_empty
		local
			file: PLAIN_TEXT_FILE
			entry: ARRAY [STRING]
		do
			create file.make (a_filename)
			from
				file.open_read
			until
				file.end_of_file
			loop
				file.readline
				entry := analyse_line (file.last_string)
				if entry /= Void then
					if (entry @ 1).is_equal ("name") then
						set_name (entry @ 2)
					elseif (entry @ 1).is_equal ("description") then
						set_description (wrap_word (entry @ 2, 70))
					elseif (entry @ 1).is_equal ("location") then
						location := clone(New_project_wizards_path)
						location.extend (entry @ 2)
					elseif (entry @ 1).is_equal ("platform") then
						target_platform := clone (entry @ 2)
						target_platform.to_lower
					end
				end
			end
			file.close
		ensure
			location_is_set: location /= Void and then not location.is_empty
		end

feature -- Access

	name: STRING
			-- Name of the wizard ("WEL Wizard" for example).

	description: STRING
			-- Description for this wizard.

	target_platform: STRING
			-- Target platform for this wizard: "all" for all platform, "windows" for windows, ...

	target_platform_supported: BOOLEAN is
			-- Is the target platform supported by the current platform?
		do
			Result := target_platform.is_equal ("all") or else 
				Eiffel_platform.is_equal (target_platform)
		end

feature -- Status Setting

	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		do
			name := a_name
		end

	set_description (a_description: STRING) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		end

feature {NONE} -- Implementation

	wrap_word (a_string: STRING; a_margin: INTEGER): STRING is
			-- Return a copy of `a_string', with a maximum of `a_margin' characters per line.
		local
			original: STRING
			last_space_index: INTEGER
		do
			create Result.make (0)
			from
				original := clone (a_string)
			until
				original.count < a_margin
			loop
				last_space_index := original.last_index_of (' ', a_margin)
				Result.append (original.substring (1, last_space_index - 1))
				Result.append ("%N")
				original := original.substring (last_space_index + 1, original.count)
			end
			Result.append (original)
		end

feature {NONE} -- Constants

	New_project_wizards_path: DIRECTORY_NAME is
		once
			Result := clone (Wizards_path)
			Result.extend ("new_projects")
		end

	Additional_parameters: STRING is
		do
			Result := "Ace=%"<ACE>%"%NDirectory=%"<DIRECTORY>%"%NCompilation=%"<COMPILATION>%""
		end

end -- class EB_NEW_PROJECT_WIZARD
