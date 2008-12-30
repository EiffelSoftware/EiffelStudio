indexing
	description	: "System's root class"

class
	SYNTAX_UPDATER

inherit
	ARGUMENTS

	SHARED_ERROR_HANDLER

	STRING_HANDLER

	KL_SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make is
		do

			create factory
			create parser.make_with_factory (factory)
			create fast_factory
			create fast_parser.make_with_factory (fast_factory)
				-- Enabling `il_parsing' only means accepting more, not accepting less
				-- which is important to allow for such a syntax converter
			parser.set_il_parser
			fast_parser.set_il_parser
			create visitor.make_with_default_context

			create string_buffer.make (102400)
			execute
		end

feature {NONE} -- File discovering and processing

	execute is
			-- Process all files under directories specified on the command line arguments.
		local
			i: INTEGER
			dir: KL_DIRECTORY
			l_dir: STRING
		do
			if argument_count < 1 then
				io.error.put_string ("Specify a directory for a recursive processing of all Eiffel files.")
				io.error.put_new_line
			else
				from
					i := 1
				until
					i > argument_count
				loop
					l_dir := Execution_environment.interpreted_string (argument (i))
					create dir.make (l_dir)
					if dir.exists then
						test_recursive (dir)
						i := i + 1
					else
						print ("directory: " + l_dir + " is not accessible%N")
						i := argument_count + 1
					end
				end
			end
		end

	test_recursive (a_dir: KL_DIRECTORY) is
			-- Process files and directories under `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_exists: a_dir.exists
		local
			dir_names, file_names: ARRAY [STRING]
		do
			dir_names := a_dir.directory_names
			if dir_names /= Void then
				dir_names.do_all (agent (a_path: STRING; a_dir_name: STRING)
					local
						l_dir: KL_DIRECTORY
					do
						create l_dir.make (a_path + operating_environment.Directory_separator.out + a_dir_name)
						if l_dir.exists then
							test_recursive (l_dir)
						end
					end (a_dir.name, ?))
			end

			a_dir.open_read
			file_names := a_dir.filenames
			if file_names /= Void then
				file_names.do_all (agent (a_path: STRING; a_dir_name: STRING)
					do
						update_eiffel_class (
							a_path + operating_environment.Directory_separator.out + a_dir_name)
					end (a_dir.name, ?))
			end
		end

feature {NONE} -- Implementation

	update_eiffel_class (file_name: STRING) is
		require
			file_name_not_void: file_name /= Void
		local
			file: KL_BINARY_INPUT_FILE
			outfile: KL_BINARY_OUTPUT_FILE
			count, nb: INTEGER
			l_text: STRING
		do
			if file_name.substring (file_name.count - 1, file_name.count).is_case_insensitive_equal (".e") then
				create file.make (file_name)
				count := file.count
				file.open_read
				if file.is_open_read then
					if string_buffer.count < count then
						string_buffer.resize (count)
					end
					string_buffer.set_count (count)
					nb := file.read_to_string (string_buffer, 1, count)
					string_buffer.set_count (nb)
					file.close
						-- Fast parsing using our `fast_factory' to detect old constructs.
					fast_factory.reset
					parse_eiffel_class (fast_parser, string_buffer)
					if error_handler.has_error then
							-- We ignore syntax errors since we want to test roundtrip parsing
							-- on valid Eiffel classes.
						io.error.put_string ("Syntax error in file: " + file_name)
						if {l_syntax1: SYNTAX_ERROR} error_handler.error_list.last then
							io.error.put_string (" (" + l_syntax1.line.out + ", " + l_syntax1.column.out + ")" + l_syntax1.error_message)
						end
						io.error.put_new_line
						error_handler.wipe_out
					elseif fast_factory.has_obsolete_constructs then
							-- Slow parsing to rewrite the class using the new constructs.
						parse_eiffel_class (parser, string_buffer)
						check no_error: not error_handler.has_error end

						visitor.setup (parser.root_node, parser.match_list, True, True)
							-- Free some memory from the parser that we don't need.
						parser.reset
						parser.reset_nodes
							-- Perform the visiting
						visitor.process_ast_node (visitor.parsed_class)
						if visitor.is_updated then
							l_text := visitor.text
							parse_eiffel_class (fast_parser, l_text)
							if error_handler.has_error then
									-- We ignore syntax errors since we want to test roundtrip parsing
									-- on valid Eiffel classes.
								io.error.put_string ("After conversion syntax error in file: " + file_name)
								if {l_syntax2: SYNTAX_ERROR} error_handler.error_list.last then
									io.error.put_string (" (" + l_syntax2.line.out + ", " + l_syntax2.column.out + ")" + l_syntax2.error_message)
								end
								io.error.put_new_line
								error_handler.wipe_out
							else
								create outfile.make (file_name)
								outfile.open_write
								if outfile.is_open_write then
									outfile.put_string (l_text)
									outfile.close
								else
									io.error.put_string ("Could not write to: " + file_name)
									io.error.put_new_line
								end
							end
						end
							-- Free our memory.
						visitor.reset
					end
				else
					io.error.put_string ("Couldn't open: " + file_name)
					io.error.put_new_line
				end
			end
		end

	parse_eiffel_class (a_parser: EIFFEL_PARSER; a_buffer: STRING)
			-- Using a parser, parse our code using different parser mode, to ensure that we can
			-- indeed convert any kind of Eiffel classes.
		require
			a_parser_not_void: a_parser /= Void
			a_buffer_not_void: a_buffer /= Void
		do
				-- First we do it using the old conventions.
			a_parser.set_is_indexing_keyword (True)
			a_parser.set_is_attribute_keyword (False)
			a_parser.set_is_note_keyword (False)
			a_parser.parse_from_string (a_buffer)
			if error_handler.has_error then
				error_handler.wipe_out
					-- There was an error, let's try to see if the code is already using `note'.
				a_parser.set_is_indexing_keyword (True)
				a_parser.set_is_note_keyword (True)
				a_parser.set_is_attribute_keyword (False)
				a_parser.parse_from_string (a_buffer)
				if error_handler.has_error then
					error_handler.wipe_out
						-- Still an error, let's try to see if the code is already using `attribute'.
					a_parser.set_is_indexing_keyword (True)
					a_parser.set_is_note_keyword (True)
					a_parser.set_is_attribute_keyword (True)
					a_parser.parse_from_string (a_buffer)
				end
			end
		end

feature {NONE}

	parser: EIFFEL_PARSER
	fast_parser: EIFFEL_PARSER
	factory: AST_ROUNDTRIP_FACTORY
	fast_factory: SYNTAX_UPDATER_FACTORY
	visitor: SYNTAX_UPDATER_VISITOR
			-- Factories and visitors being used for parsing.

	string_buffer: STRING
			-- Buffer for reading Eiffel classes.

invariant
	parser_not_void: parser /= Void
	fast_parser_not_void: parser /= Void
	factory_not_void: factory /= Void
	fast_factory_not_void: fast_factory /= Void
	visitor_not_void: visitor /= Void
	string_buffer_not_void: string_buffer /= Void

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
