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

	process_line (a_line: READABLE_STRING_32; a_number: NATURAL_32)
			-- <Precursor>
		local
			l_exp: like function_name_regexp
			l_line: STRING_32
			l_project_location: STRING_32
			l_file_location: STRING_32
			l_file_name: STRING_32
			l_function_name: STRING_32
			l_position: STRING_32
			l_line_string: STRING_32
			l_line_number: INTEGER
			l_is_error: BOOLEAN
			l_count: INTEGER
			i: INTEGER
		do
			l_count := a_line.count
				-- Use character 3
			if l_count > 3 then
				i := a_line.substring_index (once " : ", 3)
				if i > 0 then
						-- Filename
					l_file_name := a_line.substring (1, i - 1)
					l_line := a_line.substring (i + 3, l_count)
					string_general_left_adjust (l_line)

					i := l_file_name.last_index_of ('(', l_file_name.count)
					if i > 0 then
							-- Line/column
						l_position := l_file_name.substring (i, l_file_name.count)
						string_general_left_adjust (l_position)
						string_general_right_adjust (l_position)
						l_position.prune_all_leading ('(')
						l_position.prune_all_trailing (')')

						l_file_name.keep_head (i - 1)

						i := l_position.index_of (',', 1)
						if i > 1 and then i > l_position.count then
							l_line_string := l_position.substring (1, i - 1)
							string_general_right_adjust (l_line_string)
							--l_column_string := l_position.substring (i + 1, l_position.count)
							--l_column_string.left_adjust
						else
							l_line_string := l_position
						end
							-- Safe to use `as_string_8' for line numbers.
						if l_line_string.as_string_8.is_integer then
							l_line_number := l_line_string.to_integer
						end
					end
					string_general_left_adjust (l_file_name)
					string_general_right_adjust (l_file_name)

						-- Error status
					i := l_line.index_of (':', 1)
					if i > 0 then
							-- Before looking for "error", converting to STRING_8 is safe.
						l_is_error := l_line.as_string_8.substring_index_in_bounds (once "error", 1, i) > 0

						if attached l_file_name then
							l_exp := function_name_regexp
								-- Before looking for "F[0-9]+_[0-9]+", converting to STRING_8 is safe.
							l_exp.match (l_line.as_string_8)
							if l_exp.has_matched then
								l_function_name := l_exp.captured_substring (0)
							end
							l_project_location := system.project_location.location
							l_project_location.prune_all_trailing (operating_environment.directory_separator)
							l_count := l_project_location.count
							if l_file_name.count > l_count then
									-- Attempt to make path relative.
								l_file_location := l_file_name.substring (1, l_count)
								if
									l_project_location.is_valid_as_string_8 and then
									l_file_location.is_valid_as_string_8 and then
								 	l_file_location.is_case_insensitive_equal (l_project_location)
								then
									l_file_name.replace_substring (".", 1, l_count)
								end
							end
							file_name := l_file_name
							line_number := l_line_number
							is_error := l_is_error
							function_name := l_function_name
							message := l_line
							process_last_error
						end
					end
				end
			end
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
