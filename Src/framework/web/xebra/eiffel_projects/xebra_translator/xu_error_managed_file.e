note
	description: "[
		Manages the processing and ensuing error handling of a file.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_ERROR_MANAGED_FILE

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

feature -- Initialization

feature -- Access

	process_file (a_file_name: STRING; a_action: PROCEDURE [ANY, TUPLE [source: STRING; file: PLAIN_TEXT_FILE]])
			-- Manages error handling of a file and processes `a_action' with it
			-- `a_file_name': The filename/path
			-- `a_action': The action which should be executed with the file
		require
			a_file_name_attached: attached a_file_name
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_action_attached: attached a_action
		local
			l_source: STRING
			l_file_name: STRING
			l_generic_file_name: FILE_NAME
			l_util: XU_FILE_UTILITIES
		do
			create l_util
			l_file_name := l_util.resolve_env_vars (a_file_name, True)
			create l_generic_file_name.make_from_string (l_file_name)
			if attached {PLAIN_TEXT_FILE} l_util.plain_text_file_read( l_generic_file_name ) as l_file then
				l_source := ""
				l_file.read_stream (l_file.count)
				l_source := l_file.last_string
				if not l_source [l_source.count].is_equal ('%N') then
					l_source.extend ('%N')
				end
				a_action.call ([l_source, l_file])
				l_util.close
			end

		end

end
