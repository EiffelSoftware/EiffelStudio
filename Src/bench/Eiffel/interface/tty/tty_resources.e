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
	
	EIFFEL_ENV
	
	EB_SHARED_PREFERENCES

create 
	initialize

feature {NONE} -- Initialization

	initialize is
			-- Initialize the resource table.
		do
			internal_initialize
		end
		
	internal_initialize is
			-- Initialize the resource table.
			-- (By default, resources will be looked the `eifinit'
			-- directory in $ISE_EIFFEL, $HOME, and $ISE_DEFAULTS looking
			-- for file general and for platform specific files).
		local
			resource_table: RESOURCE_TABLE;
			resource_files_parser: RESOURCE_FILES_PARSER;
		once
			create resource_table.make (20)
			create resource_files_parser.make (Short_studio_name)
			setup_preferences
				
				-- Read `general' file
			resource_files_parser.parse_files (resource_table)
			initialize_resources (resource_table)

				-- Read `general.cfg' file
			resource_files_parser.set_extension ("cfg")
			resource_files_parser.parse_files (Configure_resources)

				-- Initialize directories in Eiffel Project
			Eiffel_project.set_filter_path (preferences.misc_data.general_filter_path)
			Eiffel_project.set_profile_path (preferences.misc_data.general_profile_path)
			Eiffel_project.set_tmp_directory (preferences.misc_data.general_tmp_path)
		end

feature -- Status report

	error_occurred: BOOLEAN
			-- Did an error occur while reading the default preferences file ?
	
feature {NONE} -- Initialization of resource categories

	initialize_resources (a_table: RESOURCE_TABLE) is
			-- Initialize all resources valid for the tty interface.
		do
--			General_resources.initialize (a_table)
--			Class_resources.initialize (a_table)
--			Feature_resources.initialize (a_table)
		end
		
	setup_preferences is
			-- Setup the preferences
		local
			l_prefs: PREFERENCES
			studio_prefs: EB_SHARED_PREFERENCES
		do
			create l_prefs.make_with_default_values_and_location (system_general, eiffel_preferences)			
			create studio_prefs.make_preferences (l_prefs)						
		end		

end -- class TTY_RESOURCES
