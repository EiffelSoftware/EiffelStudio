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
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

