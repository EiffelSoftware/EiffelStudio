note
	description: "[
		Manages the processing and ensuing error handling of a file.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_ERROR_MANAGED_FILE

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

feature -- Initialization

feature -- Access

	process_file (a_file_name: STRING; a_action: PROCEDURE [TUPLE [source: STRING; file: PLAIN_TEXT_FILE]])
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
