note
	description: "Show the pretty form of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class E_SHOW_PRETTY

inherit
	SHARED_BATCH_NAMES
	KL_SHARED_STANDARD_FILES
	SHARED_ERROR_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_in_filename, a_out_filename: STRING)
			-- Initialization
		require
			a_in_filename_not_void: a_in_filename /= Void
			a_out_filename_not_void: a_out_filename /= Void
		do
			in_filename := a_in_filename
			out_filename := a_out_filename
			error := False
		ensure
			a_in_filename_set: in_filename = a_in_filename
			a_out_filename_set: out_filename = a_out_filename
		end

feature -- Access

	in_filename: STRING
			-- Input filename

	out_filename: STRING
			-- Output filename

	parser: EIFFEL_PARSER
			-- Parser

	error: BOOLEAN
			-- Set to `True' if an error occured.

	prettified: STRING
			-- Returns the prettified class text.
		require
			no_error_happened: not error
			output_file_set: out_filename /= Void and then out_filename /= ""
		local
			l_out_file: PLAIN_TEXT_FILE
		do
			create l_out_file.make (out_filename)
			l_out_file.open_read
			if l_out_file.is_open_read then
				l_out_file.read_stream (l_out_file.count)
				Result := l_out_file.last_string
			else
				error := True
			end
		ensure
			error_reported: error = (Result = Void)
		end

feature -- Execution

	execute
			-- Execute the pretty-printing command.
		do
				-- Parse the input file
			parse_input_file

				-- Print the output file
			if not error then
				print_output_file
			end
		end

feature {NONE} -- Implementation

	parse_input_file
			-- Parses the input file.
		local
			l_in_file: KL_BINARY_INPUT_FILE
		do
				-- Open the input file
			create l_in_file.make (in_filename)
			l_in_file.open_read

			if l_in_file.is_open_read then
					-- Parse the file
				create parser.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
				parser.set_syntax_version ({EIFFEL_SCANNER}.provisional_syntax)
				parser.parse (l_in_file)
				l_in_file.close

				Error_handler.force_display
				error := parser.error_count > 0 or parser.root_node = Void or Error_handler.has_error
			else
				Error := True
			end
		ensure
			output_set: not error implies parser.root_node /= Void
		end

	print_output_file
			-- Pretty-prints the output file.
		require
			is_parsed: not error and parser /= Void and then parser.root_node /= Void
		local
			l_printer: PRETTY_PRINTER
			l_out_file: KL_TEXT_OUTPUT_FILE
		do
			if out_filename.same_string ("-") then
				create l_printer.make (std.output)
				l_printer.set_parsed_class (parser.root_node)
				l_printer.set_match_list (parser.match_list)
				parser.root_node.process (l_printer)
			else
				create l_out_file.make (out_filename)
				l_out_file.recursive_open_write

				if l_out_file.is_open_write then
					create l_printer.make (l_out_file)
					l_printer.set_parsed_class (parser.root_node)
					l_printer.set_match_list (parser.match_list)
					parser.root_node.process (l_printer)
					l_out_file.close
				else
					error := True
				end
			end
		end

invariant
	in_filename_not_void: in_filename /= Void
	out_filename_not_void: out_filename /= Void

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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

end -- class E_SHOW_PRETTY
