indexing
	description: "Help project."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HELP_PROJECT

inherit
	EXECUTION_ENVIRONMENT
	
	SHARED_OBJECTS

feature -- Initialization

	make (a_loc: DIRECTORY; a_name: STRING; a_toc: TABLE_OF_CONTENTS) is
			-- Create new help project in location `a_loc' with name `a_name'.
			-- Build `table_of_contents' from contents of `a_toc'.
		require
			name_not_void: a_name /= Void
			directory_valid: a_loc /= Void and a_loc.exists
			toc_not_void: a_toc /= Void
		do
			name := a_name
			location := a_loc
			toc := a_toc
			initialize
		end
		
feature -- Initialization

	initialize is
			-- Initialize	
		do
			if help_directory.exists then
				help_directory.recursive_delete
			end
			help_directory.create_dir
			build_table_of_contents
			create settings.make (Current)	
		end

feature -- Access

	name: STRING
			-- Help Project Name
		
	location: DIRECTORY
			-- Help Project location once compiled
	
	toc: TABLE_OF_CONTENTS
	
	title: STRING
			-- Help Project Title
	
	settings: HELP_PROJECT_SETTINGS_FILE
			-- File containing full project setting

	project_file: PLAIN_TEXT_FILE is
			-- Saved project file
		deferred
		end
	
feature -- Status Setting

	set_title (a_title: STRING) is
			-- Set `title'
		do
			title := a_title
		end

feature {HELP_GENERATOR} -- File

	compiled_filename_extension: STRING is
			-- Extension for created project
		deferred
		end

	project_filename_extension: STRING is
			-- Extension for created project
		deferred
		end

	toc_filename_extension: STRING is
			-- Extension for table of contents
		deferred
		end

	help_directory: DIRECTORY is
			-- Help directory
		once
			create Result.make (Shared_constants.Application_constants.Temporary_help_directory)
		end
		
	full_toc_text: STRING is
			-- Full text of TOC
		deferred
		end		

feature -- Commands

	build_table_of_contents is
			-- Build new `table_of contents' from `a_dir'
		require
			valid_toc: toc /= Void
		deferred
		end

	generate is
			-- Generate
		deferred			
		end		
	
feature {HELP_PROJECT_SETTINGS_FILE, HELP_TABLE_OF_CONTENTS} -- Implementation

	project_file_name: FILE_NAME is
			-- Name for generated project file
		do
			create Result.make_from_string (help_directory.name)
			Result.extend (name)
			Result.add_extension (project_filename_extension)	
		end
		
	compiled_file_name: FILE_NAME is
			-- Compiled file name
		do
			create Result.make_from_string (help_directory.name)
			Result.extend (name)
			Result.add_extension (compiled_filename_extension)	
		end
			
	toc_file_name: FILE_NAME is
			-- Table of Contents file name
		do
			create Result.make_from_string (help_directory.name)
			Result.extend (name)
			Result.add_extension (toc_filename_extension)	
		end

	error_file_name: FILE_NAME is
			-- Error/Log file
		do
			create Result.make_from_string (help_directory.name)
			Result.extend ("log.txt")
		end

	image_file_types: ARRAYED_LIST [STRING] is
			-- Image file types
		once
			create Result.make (4)
			Result.compare_objects
			Result.extend ("png")
			Result.extend ("gif")
			Result.extend ("jpg")
			Result.extend ("bmp")
			Result.extend ("css")
		end		

invariant
	has_name: name /= Void
	has_settings_file: settings /= Void
	has_location: location /= Void

end -- class HELP_PROJECT
