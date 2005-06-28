indexing

	description:
		"All resouorces for the application.";
	date: "$Date$";
	revision: "$Revision$"

class TTY_RESOURCES

inherit
	SHARED_CONFIGURE_RESOURCES
	SHARED_EIFFEL_PROJECT
	TTY_CONSTANTS
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
			resource_parser: RESOURCE_PARSER
			test_file: RAW_FILE
			retried: BOOLEAN
			error_msg: STRING
		once
			if retried then
				error_msg := warning_messages.w_cannot_read_file (compiler_configuration)
			else
				create test_file.make (compiler_configuration)
				if test_file.exists and test_file.is_readable then
					create resource_parser
					resource_parser.parse_file (compiler_configuration, configure_resources)
				else
					error_msg := compiler_configuration.twin
					error_msg.append (Warning_messages.w_file_does_not_exist_execution_impossible)
				end
			end
			if error_msg /= Void then
				io.error.put_string (error_msg)
				error_occurred := True
			else
				error_occurred := False
			end
		rescue
			retried := True
			retry
		end

feature -- Status report

	error_occurred: BOOLEAN
			-- Did an error occur while reading the default preferences file ?
			
end -- class TTY_RESOURCES
