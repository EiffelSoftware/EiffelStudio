note
	description: "[
		Analyzes the C compilation output from Microsoft's C/C++ compiler to produce results.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_MSC_OUTPUT_ANALYZER

inherit
	ES_C_COMPILER_OUTPUT_ANALYZER

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Helpers

	file_utilities: FILE_UTILITIES
			-- Access to general file utilities.
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Basic operations

	process_line (a_line: READABLE_STRING_8; a_number: INTEGER)
			-- <Precursor>
		local
			l_line: STRING
			l_project_location: STRING
			l_file_name: STRING
			l_position: STRING
			l_line_string: STRING
			l_line_number: INTEGER
			l_is_error: BOOLEAN
			l_count: INTEGER
			i: INTEGER
		do
			l_count := a_line.count
				-- Use character 3
			if l_count > 3 then
				i := a_line.index_of (':', 3)
				if i > 0 then
						-- Filename
					l_file_name := a_line.substring (1, i - 1)
					l_line := a_line.substring (i + 1, l_count)
					l_line.left_adjust

					i := l_file_name.last_index_of ('(', l_file_name.count)
					if i > 0 then
							-- Line/column
						l_position := l_file_name.substring (i, l_file_name.count)
						l_position.left_adjust
						l_position.right_adjust
						l_position.prune_all_leading ('(')
						l_position.prune_all_trailing (')')

						l_file_name.keep_head (i - 1)

						i := l_position.index_of (',', 1)
						if i > 1 and then i > l_position.count then
							l_line_string := l_position.substring (1, i - 1)
							l_line_string.right_adjust
							--l_column_string := l_position.substring (i + 1, l_position.count)
							--l_column_string.left_adjust
						else
							l_line_string := l_position
						end
						if l_line_string.is_integer then
							l_line_number := l_line_string.to_integer
						end
					end
					l_file_name.left_adjust
					l_file_name.right_adjust

						-- Error status
					i := l_line.index_of (':', 1)
					if i > 0 then
						l_is_error := l_line.substring_index_in_bounds ("error", 1, i) > 0
						l_line.remove_head (i + 1)
						l_line.left_adjust

						if attached l_file_name and then not l_line.is_empty then
							l_project_location := system.project_location.location
							l_project_location.prune_all_trailing (operating_environment.directory_separator)
							l_count := l_project_location.count
							if l_file_name.count > l_count then
									-- Attempt to make path relative.
								if l_file_name.substring (1, l_count).is_case_insensitive_equal (l_project_location) then
									l_file_name.replace_substring (".", 1, l_count)
								end
							end
							file_name := l_file_name
							line_number := l_line_number
							is_error := l_is_error
							message := l_line
							process_last_error
						end
					end
				end
			end
		end

;note
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
