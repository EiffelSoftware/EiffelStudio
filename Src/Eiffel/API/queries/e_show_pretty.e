note
	description: "Show the pretty form of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class E_SHOW_PRETTY

inherit
	SHARED_BATCH_NAMES
	KL_SHARED_STANDARD_FILES
	SHARED_ERROR_HANDLER
	EC_SHARED_PREFERENCES

create
	make_file,
	make_string

feature {NONE} -- Initialization

	make_file (input, output: READABLE_STRING_32)
			-- Prettify code from the file `input' and write it to the file `output'.
		require
			input_attached: attached input
			output_attached: attached output
		do
			error := False
				-- Parse the input file.
			parse_input_file (input)
				-- Print the output file.
			if not error then
				print_output_file (output)
			end
		end

	make_string (input: READABLE_STRING_32; output: STRING_32)
			-- Prettify code from the file `input' and write it to the string `output'.
		require
			input_attached: attached input
			output_attached: attached output
		do
			error := False
				-- Parse the input file
			parse_input_file (input)
				-- Print the output file
			if not error then
				generate_output (create {PRETTY_PRINTER_OUTPUT_STREAM}.make_string (output))
			end
		end

feature -- Access

	parser: EIFFEL_PARSER
			-- Source code parser.

	error: BOOLEAN
			-- Is error detected?

feature {NONE} -- Implementation

	parse_input_file (input: READABLE_STRING_32)
			-- Parses the input file `input'.
		local
			l_in_file: KL_BINARY_INPUT_FILE
			u: GOBO_FILE_UTILITIES
		do
				-- Open the input file
			l_in_file := u.make_binary_input_file (input)
			l_in_file.open_read

			if l_in_file.is_open_read then
					-- Parse the file
				create parser.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
				parser.set_syntax_version ({EIFFEL_SCANNER}.provisional_syntax)
				parser.parse (l_in_file)
				l_in_file.close

				error_handler.force_display
				error := parser.error_count > 0 or parser.root_node = Void or error_handler.has_error
			else
				error := True
			end
		ensure
			output_set: not error implies parser.root_node /= Void
		end

	print_output_file (output: READABLE_STRING_32)
			-- Pretty-print to the output file named `output'.
		require
			is_parsed: not error and parser /= Void and then parser.root_node /= Void
		local
			f: detachable PLAIN_TEXT_FILE
		do
			if not error then
				if output.is_empty then
					generate_output (create {PRETTY_PRINTER_OUTPUT_STREAM}.make_standard_output)
				else
					create f.make_with_name (output)
					f.open_write
					if f.is_open_write then
						if attached parser.detected_bom as bom then
								-- Write BOM at the beginning of the file.
							f.put_string (bom)
						end
						generate_output (create {PRETTY_PRINTER_OUTPUT_STREAM}.make_file (f, parser.detected_encoding))
						f.close
					else
						error := True
					end
				end
			end
		rescue
			error := True
			retry
		end

	generate_output (s: PRETTY_PRINTER_OUTPUT_STREAM)
			-- Generate output to stream `s'.
		require
			is_parsed: not error and parser /= Void and then parser.root_node /= Void
		local
			p: PRETTY_PRINTER
			pretty_printer_preferences: PRETTY_PRINTER_PREFERENCES
		do
			check
				root_node_attached: attached parser.root_node as r
				match_list_attached: attached parser.match_list as l
			then
				create p.make (s, r, l)
					-- TODO: Use preferences in the following priority order:
					-- • project-specific;
					-- • user-specific;
					-- • common.
				pretty_printer_preferences := preferences.pretty_printer_preferences
				p.set_loop_expression_style (pretty_printer_preferences.loop_expression_style)
				p.set_line_processing (pretty_printer_preferences.line_processing)
				p.set_is_unindented_comment_kept (pretty_printer_preferences.is_unindented_comment_kept)
				parser.root_node.process (p)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
