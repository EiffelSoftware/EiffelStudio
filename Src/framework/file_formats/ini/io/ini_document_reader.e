note
	description: "Class to read and parse INI documents from a file or a text buffer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_DOCUMENT_READER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize document reader.
		do
			reset
		end

feature -- Access

	read_document: INI_DOCUMENT
			-- Document created as a result of a read operation

	errors: LIST [INI_SYNTAX_ERROR]
			-- List of errors generated from last read operation

	successful: BOOLEAN
			-- Was last read successful?

feature -- Basic Operations

	read_from_file (a_file: PLAIN_TEXT_FILE; a_ignore_errors: BOOLEAN)
			-- Parses file `a_file' and will set `read_document' on success.
			--
			-- When `a_ignore_errors', document errors are ignored but may lead to
			-- incorrect structure and/or missing properties. You may use `errors'
			-- to read any parsed errors.
		require
			a_file_attached: a_file /= Void
			a_file_opened_for_writing: a_file.is_open_read
			a_file_writable: a_file.readable
		local
			l_buffer: STRING
			l_line: STRING
			retried: BOOLEAN
		do
			if not retried then
				reset
				create l_buffer.make (a_file.count)
				from
				until
					a_file.end_of_file
				loop
					a_file.read_line
					l_line := a_file.last_string
					if l_line /= Void then
						l_buffer.append (l_line)
					end
					if not a_file.end_of_file then
						l_buffer.append_character ('%N')
					end
				end
				read_from_buffer (l_buffer, a_ignore_errors)
			end
		ensure
			read_document_set: successful implies read_document /= Void
		rescue
			retried := True
			retry
		end

	read_from_buffer (a_buffer: STRING; a_ignore_errors: BOOLEAN)
			-- Parsers buffer `a_buffer' and sets `read_document' on success.
			--
			-- When `a_ignore_errors', document errors are ignored but may lead to
			-- incorrect structure and/or missing properties. You may use `errors'
			-- to read any parsed errors.
		require
			a_buffer_attached: a_buffer /= Void
		local
			l_parser: like create_ini_parser
			l_visitor: like create_document_visitor
		do
			reset
			l_parser := create_ini_parser  (a_ignore_errors)
			parse_buffer (l_parser, a_buffer, a_ignore_errors)
			if successful then
				l_visitor := create_document_visitor
				l_parser.parsed_root_node.visit (l_visitor)
				read_document := l_visitor.document
			end
		ensure
			read_document_set: successful implies read_document /= Void
		end

feature {NONE} -- Basic Operations

	reset
			-- Reset reader for next read operation
		do
			create {ARRAYED_LIST [INI_SYNTAX_ERROR]}errors.make (0)
			read_document := Void
			successful := False
		ensure
			errors_is_empty: errors.is_empty
			read_document_unattached: read_document = Void
			not_successful: not successful
		end

	parse_buffer (a_parser: INI_PARSER; a_buffer: STRING; a_ignore_errors: BOOLEAN)
			-- Parses buffer `a_buffer' using `ini_parser'
		require
			a_parser_attached: a_parser /= Void
			a_buffer_attached: a_buffer /= Void
			errors_reset: errors.is_empty
			successful_reset: not successful
		local
			l_successful: like successful
		do
			a_parser.parse_source (a_buffer)
			l_successful := a_parser.successful
			if not l_successful then
				errors := a_parser.syntax_errors
				l_successful := a_ignore_errors
			end
			successful := l_successful
		ensure
			errors_set: not successful implies not errors.is_empty
		end

feature {NONE} -- Factory Functions

	create_ini_parser (a_ignore_errors: BOOLEAN): INI_PARSER
			-- Create a new INI parser and will instruct it to ignore
			-- all errors when `a_ignore_errors' is True.
		do
			create Result.make ({INTEGER}.max_value)
			Result.set_ignore_syntax_errors (a_ignore_errors)
		ensure
			result_attached: Result /= Void
			result_ignore_errors: Result.ignore_syntax_errors = a_ignore_errors
		end

	create_document_visitor: INI_DOCUMENT_BUILDER_NODE_VISITOR
			-- Creates a new visitor used to build `read_document'
		do
			create Result.make
		ensure
			result_attached: Result /= Void
		end

invariant
	errors_attached: errors /= Void

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

end -- class {INI_DOCUMENT_READER}
