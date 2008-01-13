indexing
	description: "A specialized version of {ERROR_DISPLAYER} to display errors in a format readable by external tools."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECL_ERROR_DISPLAYER

inherit
	ERROR_DISPLAYER

	OUTPUT_WINDOW_USER
		rename
			make as make_base
		export
			{NONE} all
		end

	SHARED_ERROR_TRACER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like application_name; a_window: like output_window) is
			-- Initialize error displayer using an output window `a_window' and a application name `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_window_attached: a_window /= Void
		do
			application_name := a_name
			make_base (a_window)
		ensure
			application_name_set: application_name = a_name
			output_window_set: output_window = a_window
		end

feature -- Access

	application_name: STRING assign set_application_name
			-- Name of application to use when displaying errors

feature -- Element change

	set_application_name (a_name: like application_name) is
			-- Set `application_name' with `a_name'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			application_name := a_name
		ensure
			application_name_set: application_name = a_name
		end

feature -- Output

	trace_warnings (a_handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		local
			l_warnings: LIST [ERROR]
		do
			l_warnings := a_handler.warning_list
			if not l_warnings.is_empty then
				l_warnings.do_all (agent (a_item: ERROR)
					require
						a_item_attached: a_item /= Void
					do
						display_warning ({WARNING} #? a_item, output_window)
					end)
				output_window.put_new_line
			end
		end

	trace_errors (a_handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		do
			if a_handler.has_error then
				a_handler.error_list.do_all (agent display_error (?, output_window))
				output_window.put_new_line
			end
		end

	force_display is
			-- Make sure the user can see the messages we send.
		do
			output_window.display
		end

feature {NONE} -- Implementation

	display_warning (a_warning: WARNING; a_window: like output_window) is
			-- Display warning `a_warning' using output window `a_window'
		require
			a_warning_attached: a_warning /= Void
			a_window_attached: a_window /= Void
		do
			display_error (a_warning, a_window)
		end

	display_error (a_error: ERROR; a_window: like output_window) is
			-- Display error `a_error' using output window `a_window'
		require
			a_error_attached: a_error /= Void
			a_window_attached: a_window /= Void
		local
			l_se: SYNTAX_ERROR
			l_code: INTEGER
			l_file: PLAIN_TEXT_FILE
			l_parse_error: CONF_ERROR_PARSE
			l_line: STRING
			l_pos: INTEGER
		do
			l_se ?= a_error
			a_window.put_new_line

				-- Context
			if a_error.has_associated_file then
				a_window.put_string (relative_file_path (a_error.file_name))
				a_window.put_string ("(")
				a_window.put_string (a_error.column.out)
				a_window.put_string (", ")
				a_window.put_string (a_error.line.out)
				a_window.put_string (")")
			else
				a_window.put_string (application_name)
				l_parse_error ?= a_error
				if l_parse_error /= Void then
					a_window.put_string ("(")
					a_window.put_string (l_parse_error.column.out)
					a_window.put_string (", ")
					a_window.put_string (l_parse_error.row.out)
					a_window.put_string (")")
				end
			end

				-- Code
			a_window.put_string (" : ")
			a_window.put_string (a_error.error_string)
			a_window.put_string (" ")
			if l_se = Void then
				a_window.put_string (a_error.code.as_upper)
			else
				a_window.put_string ("SYNTAX")
			end
			l_code := a_error.subcode
			if l_code > 0 then
				a_window.put_string (l_code.out)
			end

				-- Description
			create l_file.make (short_help_file_name (a_error))
			if l_file.exists and not l_file.is_empty then
				a_window.put_string (": ")

					-- Read file to extract short description
				l_file.open_read
				l_file.read_line
				l_line := l_file.last_string
				if l_line /= Void and then not l_line.is_empty then
					l_pos := l_line.index_of (':', 1)
					if l_pos > 0 then
							-- Remove prefix
						l_line.keep_tail (l_line.count - l_pos)
						l_line.prune_all_leading (' ')
						l_line.prune_all_trailing (' ')
					end
					if not l_line.is_empty then
						l_line.put (l_line.item (1).as_upper, 1)
						a_window.put_string (l_line)
					end
				end
				l_file.close
			end

			a_window.put_new_line
			tracer.trace (a_window, a_error, {ERROR_TRACER}.context)
		end

	short_help_file_name (a_error: ERROR): STRING is
			-- Retrieve's short help file name from `a_error'
		local
			l_fn: FILE_NAME
		do
			create l_fn.make_from_string (eiffel_layout.error_path);
			l_fn.extend ("short");
			l_fn.set_file_name (a_error.help_file_name);
			create Result.make_from_string (l_fn)
			if a_error.subcode /= 0 then
				Result.append_integer (a_error.subcode)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	relative_file_path (a_path: STRING): STRING is
			-- Retrieve relative file path to project ECF.
		local
			l_project: E_PROJECT
			l_dir: STRING
			l_count: INTEGER
			l_pos: INTEGER
		do
			l_project := shared_project.eiffel_project
			l_dir := l_project.project_directory.path.out.as_lower
			l_count := l_dir.count
			if l_count < a_path.count + 1 then
				l_pos := a_path.as_lower.substring_index (l_dir, 1)
				if l_pos = 1 then
					Result := a_path.substring (l_count + 2, a_path.count)
				end
			end
			if Result = Void then
				Result := a_path
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	shared_project: SHARED_EIFFEL_PROJECT is
			-- Access to shared Eiffel project
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	eiffel_layout: EIFFEL_ENV is
			-- Access to shared Eiffel project
		once
			Result := (create {EIFFEL_LAYOUT}).eiffel_layout
		ensure
			result_attached: Result /= Void
		end

invariant
	application_name_attached: application_name /= Void
	not_application_name_is_empty: not application_name.is_empty

indexing
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
end -- class {ECL_ERROR_DISPLAYER}
