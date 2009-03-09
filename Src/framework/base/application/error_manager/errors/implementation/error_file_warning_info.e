note
	description: "A file-based warning to report and warning at a specific line number."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERROR_FILE_WARNING_INFO

inherit
	ERROR_WARNING_INFO
		rename
			make as make_warning
		end

feature {NONE} -- Initialization

	make_with_context (a_file_name: like file_name; a_line_number: like line_number; a_context: like context)
			-- Initializes a file warning with a file name and line number
			--
			-- `a_file_name': The path to the file where the warning is present.
			-- `a_line_number': The line number where the warning is present.
			-- `a_context': Any optional contextual information.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_line_number_non_negative: a_line_number >= 0
			not_a_context_is_empty: a_context /= Void implies not a_context.is_empty
		do
			file_name := a_file_name
			line_number := a_line_number
			make_warning (a_context)
		ensure
			file_name_set: file_name ~ a_file_name
			line_number_set: line_number = a_line_number
			context_set: context = a_context
		end

feature -- Access

	file_name: STRING
			-- Warning absolute file name

	line_number: INTEGER
			-- Warning file line number

invariant
	file_name_attached: description /= Void
	not_file_name_is_empty: not file_name.is_empty
	line_number_positive: line_number >= 0

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class {ERROR_FILE_WARNING_INFO}
