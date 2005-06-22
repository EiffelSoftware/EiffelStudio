indexing

	description:
		"All resouorces for the application.";
	date: "$Date$";
	revision: "$Revision$"

class TTY_RESOURCES

inherit
	SHARED_CONFIGURE_RESOURCES
	SHARED_EIFFEL_PROJECT
	EB_CONSTANTS
	EIFFEL_ENV

create 
	initialize

feature {NONE} -- Initialization

	initialize is
			-- Initialize resource table
		do
			internal_initialize
		end

	internal_initialize is
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
					else
						error_occurred := True
						error_msg := system_general.twin
						error_msg.append (Warning_messages.w_file_does_not_exist_execution_impossible)
					end
				else
					error_occurred := True
					error_msg := Warning_messages.w_Environment_not_initialized
				end
			end
			if error_msg /= Void then
				io.error.put_string (error_msg)
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	error_occurred: BOOLEAN
			-- Did an error occur while reading the default preferences file ?
			
end -- class TTY_RESOURCES
