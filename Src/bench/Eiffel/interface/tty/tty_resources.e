indexing

	description:
		"All resouorces for the application.";
	date: "$Date$";
	revision: "$Revision$"

class TTY_RESOURCES

inherit
	TTY_CONSTANTS

	SHARED_CONFIGURE_RESOURCES

	SHARED_EIFFEL_PROJECT

creation 
	initialize

feature {NONE} -- Initialization

	initialize is
			-- Initialize the resource table.
			-- (By default, resources will be looked the `eifinit'
			-- directory in $ISE_EIFFEL, $HOME, and $ISE_DEFAULTS looking
			-- for file general and for platform specific files).
		local
			resource_table: RESOURCE_TABLE;
			resource_files_parser: RESOURCE_FILES_PARSER;
		once
			create resource_table.make (20)
			create resource_files_parser.make ("bench")
				
				-- Read `general' file
			resource_files_parser.parse_files (resource_table)
			initialize_resources (resource_table)

				-- Read `general.cfg' file
			resource_files_parser.set_extension ("cfg")
			resource_files_parser.parse_files (Configure_resources)

				-- Initialize directories in Eiffel Project
			Eiffel_project.set_filter_path (General_resources.filter_path.value)
			Eiffel_project.set_profile_path (General_resources.profile_path.value)
			Eiffel_project.set_tmp_directory (General_resources.tmp_path.value)
		end

feature -- Status report

	error_occurred: BOOLEAN
			-- Did an error occur while reading the default preferences file ?
	
feature {NONE} -- Initialization of resource categories

	initialize_resources (a_table: RESOURCE_TABLE) is
			-- Initialize all resources valid for the tty interface.
		do
			General_resources.initialize (a_table)
			Class_resources.initialize (a_table)
			Feature_resources.initialize (a_table)
		end

end -- class TTY_RESOURCES
