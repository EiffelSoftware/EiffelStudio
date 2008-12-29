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
				io.error.put_string (a_err.description)
			end
			io.new_line
		end

feature {NONE} -- Output

	print_name (a_err: ERROR_ERROR_INFO)
			-- Prints `a_err' name
		require
			a_err_attached: a_err /= Void
		local
			l_file_err: ERROR_FILE_ERROR_INFO
			l_file_warn: ERROR_FILE_WARNING_INFO

			l_sep: CHARACTER
			l_cwd: STRING
			l_file_name: STRING
			l_path: STRING
			l_ln: INTEGER

			l_name: STRING
		do
			l_ln := -1
			l_file_err ?= a_err
			if l_file_err /= Void then
				l_file_name := l_file_err.file_name
				l_ln := l_file_err.line_number
			else
				l_file_warn ?= a_err
				if l_file_warn /= Void then
					l_file_name := l_file_warn.file_name
					l_ln := l_file_warn.line_number
				else
					l_name := app_name
				end
			end

			if l_file_name /= Void and then not l_file_name.is_empty then
				check
					l_ln_positive: l_ln >= 0
				end

				l_sep := (create {OPERATING_ENVIRONMENT}).directory_separator

					-- Create relative path	for file names	
				l_cwd := (create {EXECUTION_ENVIRONMENT}).current_working_directory.as_lower
				if l_cwd.item (l_cwd.count) /= l_sep then
					l_cwd.append_character (l_sep)
				end

				if l_cwd.count < l_file_name.count then
					l_path := l_file_name.substring (1, l_cwd.count).as_lower
					if l_path.is_equal (l_cwd) and then l_file_name.index_of (l_sep, l_path.count + 1) = 0 then
						l_file_name.keep_tail (l_file_name.count - l_path.count)
					end
				end

				create l_name.make (l_file_name.count + 7)
				l_name.append (l_file_name)
				if l_ln > 0 then
					l_name.append_character ('(')
					l_name.append (l_ln.out)
					l_name.append_character (')')
				end
			end

			check
				l_name_not_void: l_name /= Void
				not_l_name_is_empty: not l_name.is_empty
			end
			io.error.put_string (l_name)
		end

	print_level_code (a_err: ERROR_ERROR_INFO)
			-- Prints `a_err' level and code
		require
			a_err_attached: a_err /= Void
		do
			io.error.put_string (a_err.error_level_tag)
			io.error.put_character (' ')
			io.error.put_string (a_err.code)
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {ERROR_CUI_PRINTER}
