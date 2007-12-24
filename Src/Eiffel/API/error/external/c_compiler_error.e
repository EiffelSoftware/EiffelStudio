indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	C_COMPILER_ERROR

inherit
	COMPILER_ERROR
		redefine
			help_file_name, has_associated_file, print_single_line_error_message
		end

create
	make,
	make_with_file

feature {NONE} -- Initialization

	make (a_message: like message)
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		do
			message := a_message
		ensure
			message_set: message = a_message
		end

	make_with_file (a_message: like message; a_file_name: like file_name; a_line: like line; a_column: like column)
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			make (a_message)
			internal_file_name := a_file_name
			line := a_line
			column := a_column
		ensure
			message_set: message = a_message
			file_name_set: file_name = a_file_name
			line_set: line = a_line
			column_set: column = a_column
		end

feature -- Access

	code: STRING = "C Compiler Error"
			-- Code error

	help_file_name: STRING = "C_COMPILER_ERROR"
			-- Help file name

	message: STRING_GENERAL
			-- Message from C compiler

	file_name: STRING is
			-- Path to file involved in error.
			-- Could be Void if not a file specific error.
		do
			Result := internal_file_name
		end

feature -- Status report

	has_associated_file: BOOLEAN is
			-- Is current relative to a file?
		do
			Result := internal_file_name /= Void
		ensure then
			result_implies_internal_file_name_attached: Result implies internal_file_name /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build the error message
		do
		end

feature {NONE} -- Output

	print_single_line_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Displays single line help in `a_text_formatter'.
		do
			Precursor (a_text_formatter)
			a_text_formatter.add_space
			a_text_formatter.add (message)
		end

feature {NONE} -- Internal implementation cache

	internal_file_name: like file_name
			-- Mutable version of `file_name'

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
