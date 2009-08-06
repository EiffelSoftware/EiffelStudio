note
	description: "[
		Interface for json config file readers
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XU_JSON_READER [G]

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

feature -- Processing

	process_file (a_file: STRING): detachable G
			-- Parses the file and invokes check_values to validate and read the values into G
		require
			a_file_attached: a_file /= Void
			a_file_not_empty: a_file /= Void
		local
			l_parser: XU_JSON_PARSER
			l_util: XU_FILE_UTILITIES
		do
			create l_util
			if attached {STRING} l_util.text_file_read_to_string (a_file) as l_content then
				create l_parser
				Result := check_value (l_parser.parse (l_content, a_file), a_file)
			end
		end


	check_value (a_value: detachable JSON_VALUE; a_filename: STRING): detachable G
			-- Reads the values from JSON_VALUE into G and checks for errors
		require
			a_filename_attached: a_filename /= Void
		deferred
		ensure
			not_result_but_errors: Result = Void implies error_manager.has_errors
		end
end

