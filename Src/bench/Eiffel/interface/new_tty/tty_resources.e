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
	EB_CONSTANTS

creation 
	initialize

feature {NONE} -- Initialization

	initialize is
			-- Initialize the resource table.
			-- (By default, resources will be looked the `eifinit'
			-- directory in $ISE_EIFFEL, $HOME, and $ISE_DEFAULTS looking
			-- for file general and for platform specific files).
		local
			resource_files_parser: RESOURCE_FILES_PARSER;
			test_file: RAW_FILE
			retried: BOOLEAN
			error_msg: STRING
		once
			if retried then
				error_occurred := True
				check
					system_general /= Void
						-- if system_general is void, no exception should be thown.
				end
				error_msg := warning_messages.w_cannot_read_file (system_general)
			else
				if system_general /= Void then
					create test_file.make (system_general)
					if test_file.exists then
						create resource_files_parser.make (short_studio_name)
						resource_files_parser.set_extension ("cfg")
						resource_files_parser.parse_files (Configure_resources)
		
							-- Initialize directories in Eiffel Project
						Eiffel_project.set_filter_path (general_filter_path)
						Eiffel_project.set_profile_path (general_profile_path)
						Eiffel_project.set_tmp_directory (general_tmp_path)
					else
						error_occurred := True
						error_msg := clone(system_general)
						error_msg.append (Warning_messages.w_file_does_not_exist_execution_impossible)
					end
				else
					error_occurred := True
					error_msg := Warning_messages.w_Environment_not_initialized
				end
			end
			if error_msg /= Void then
				io.error.putstring (error_msg)
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	error_occurred: BOOLEAN
			-- Did an error occur while reading the default preferences file ?
			
end -- class TTY_RESOURCES
