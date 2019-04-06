note
	description: "[
		A concrete error printer for displaying errors to the command line that follow the
		Microsoft standard for error reporting.
	
		* Standard errors will print:
		
		without context
		---------------
		<app name> : error|fatal error|warning <code>
		
		with context
		------------
		<app name> : error|fatal error|warning <code>: <context>
	
		* Errors concerning files and line numbers will print:
		
		without context
		---------------
		<file name>(<line number>) : error|fatal error|warning <code>
		
		with context
		------------
		<file name>(<line number>) : error|fatal error|warning <code>: <context>

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_CUI_PRINTER

inherit
	ERROR_PRINTER
	LOCALIZED_PRINTER

create
	default_create

feature -- Basic Operations

	print_error (a_err: ERROR_ERROR_INFO)
			-- Prints `a_err'
		do
				-- print name
			print_name (a_err)
			io.error.put_character (' ')
			io.error.put_string (msg_separator)

				-- print error code and level
			io.error.put_character (' ')
			print_level_code (a_err)

				-- print context			
			if a_err.description /= Void and then not a_err.description.is_empty then
				io.error.put_string (msg_separator)
				io.error.put_character (' ')
				localized_print_error (a_err.description)
			end
			io.error.put_new_line
		end

feature {NONE} -- Output

	print_name (a_error: ERROR_ERROR_INFO)
			-- Prints `a_error' name
		require
			a_error_attached: a_error /= Void
		local
			l_file_name: detachable READABLE_STRING_GENERAL
			l_ln: INTEGER
			l_cwd: STRING_32
			l_name: detachable STRING_32
		do
			l_ln := -1
			if attached {ERROR_FILE_ERROR_INFO} a_error as l_file_error then
				l_file_name := l_file_error.file_name
				l_ln := l_file_error.line_number
			elseif attached {ERROR_FILE_WARNING_INFO} a_error as l_file_warning then
				l_file_name := l_file_warning.file_name
				l_ln := l_file_warning.line_number
			else
				l_name := app_name
			end

			if l_file_name /= Void and then not l_file_name.is_empty then
				check l_ln_positive: l_ln >= 0 end

					-- Create relative path	for file names	
				l_cwd := ((create {EXECUTION_ENVIRONMENT}).current_working_path).name

				if {PLATFORM}.is_windows then
					if l_file_name.as_lower.starts_with (l_cwd.as_lower) then
						l_file_name := l_file_name.tail (l_file_name.count - l_cwd.count - 1)
					end
				else
					if l_file_name.starts_with (l_cwd) then
						l_file_name := l_file_name.tail (l_file_name.count - l_cwd.count - 1)
					end
				end

				create l_name.make (l_file_name.count + 7)
				l_name.append_string_general (l_file_name)
				if l_ln > 0 then
					l_name.append_character ('(')
					l_name.append (l_ln.out)
					l_name.append_character (')')
				end
			end

			if l_name /= Void and then not l_name.is_empty then
				localized_print_error (l_name)
			else
				check
					l_name_attached: l_name /= Void
					not_l_name_is_empty: not l_name.is_empty
				end
			end
		end

	print_level_code (a_err: ERROR_ERROR_INFO)
			-- Prints `a_err' level and code
		require
			a_err_attached: a_err /= Void
		do
			io.error.put_string (a_err.error_level_tag)
			io.error.put_character (' ')
			localized_print_error (a_err.code)
		end

feature {NONE} -- Implementation

	msg_separator: STRING = ":"
			-- Message separator

	app_name: STRING
			-- Application name
		require
			app_name_attached: (create {ARGUMENTS}).argument (0) /= Void
		local
			l_app: STRING
			l_slash: INTEGER
			l_dot: INTEGER
		once
			l_app := (create {ARGUMENTS}).argument (0)
			l_slash := l_app.last_index_of ((create {OPERATING_ENVIRONMENT}).directory_separator, l_app.count)
			if l_slash > 0 and then l_slash + 1 < l_app.count then
				l_app := l_app.substring (l_slash + 1, l_app.count)
				l_dot := l_app.last_index_of ('.', l_app.count)
				if l_dot > 1 then
					Result := l_app.substring (1, l_dot - 1)
				else
					Result := l_app
				end
			else
				Result := l_app.twin
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
