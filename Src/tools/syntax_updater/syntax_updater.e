note
	description	: "System's root class"

class
	SYNTAX_UPDATER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as argument_make,
			execute as argument_execute
		end

	SHARED_ERROR_HANDLER

	STRING_HANDLER

	KL_SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
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

				--
			argument_make (False, True)
			is_using_builtin_switches := False
			argument_execute (agent execute)
		end

feature {NONE} -- File discovering and processing

	execute
			-- Process all files under directories specified on the command line arguments.
		local
			dir: KL_DIRECTORY
			l_dir: STRING
			l_values: LIST [STRING]
			l_has_error: BOOLEAN
			l_processed_values: ARRAYED_LIST [STRING]
		do
				-- Ensure directories exist.
			from
				l_values := values
				create l_processed_values.make (l_values.count)
				l_values.start
			until
				l_values.after
			loop
				l_dir := execution_environment.interpreted_string (l_values.item)
				create dir.make (l_dir)
				if not dir.exists then
					if not l_dir.is_empty and then (l_dir.item (l_dir.count) = '/' or l_dir.item (l_dir.count) = '\') then
						l_dir.remove_tail (1)
						l_processed_values.extend (l_dir)
						create dir.make (l_dir)
						if not dir.exists then
							l_has_error := True
							io.error.put_string ("directory: " + l_dir + " is not accessible%N")
						end
					else
						l_has_error := True
						io.error.put_string ("directory: " + l_dir + " is not accessible%N")
					end
				else
					l_processed_values.extend (l_dir)
				end
				l_values.forth
			end

				-- All directories seem to exist, let's process them.
			if not l_has_error then
				from
					l_values := l_processed_values
					l_values.start
				until
					l_values.after
				loop
					create dir.make (l_values.item)
					if dir.exists then
						test_recursive (dir)
					else
						io.error.put_string ("Error trying to access directory: ")
						io.error.put_string (l_values.item)
						io.error.put_new_line
					end
					l_values.forth
				end
			end
		end

	test_recursive (a_dir: KL_DIRECTORY)
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

	update_eiffel_class (file_name: STRING)
		require
			file_name_not_void: file_name /= Void
		local
			file: KL_BINARY_INPUT_FILE
			outfile: KL_BINARY_OUTPUT_FILE
			count, nb: INTEGER
			l_text: STRING
			l_generate_output: BOOLEAN
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
						if attached {SYNTAX_ERROR} error_handler.error_list.last as l_syntax1 then
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
								if attached {SYNTAX_ERROR} error_handler.error_list.last as l_syntax2 then
									io.error.put_string (" (" + l_syntax2.line.out + ", " + l_syntax2.column.out + ")" + l_syntax2.error_message)
								end
								if has_option (force_switch) then
									l_generate_output := True
									io.error.put_string (" (converted)")
								else
									l_generate_output := False
								end
								io.error.put_new_line
								error_handler.wipe_out
							else
								l_generate_output := True
							end
							if l_generate_output then
								create outfile.make (file_name)
								outfile.open_write
								if outfile.is_open_write then
									outfile.put_string (l_text)
									outfile.close
									if has_option (verbose_switch) then
										io.put_string ("Converted: " + file_name)
										io.put_new_line
									end
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
			a_parser.set_syntax_version ({EIFFEL_PARSER}.obsolete_64_syntax)
			a_parser.parse_from_string (a_buffer, Void)
			if error_handler.has_error then
				error_handler.wipe_out
					-- There was an error, let's try to see if the code is using transitional syntax.
				a_parser.set_syntax_version ({EIFFEL_PARSER}.transitional_64_syntax)
				a_parser.parse_from_string (a_buffer, Void)
				if error_handler.has_error then
					error_handler.wipe_out
						-- Still an error, let's try to see if the code is strictly ECMA compliant.
					a_parser.set_syntax_version ({EIFFEL_PARSER}.ecma_syntax)
					a_parser.parse_from_string (a_buffer, Void)
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

feature {NONE} -- Arguments processing

	name: STRING = "Eiffel Syntax Updater"
	version: STRING = "v6.4"

	non_switched_argument_name: STRING = "Directory"
	non_switched_argument_description: STRING = "Directory to process"
	non_switched_argument_type: STRING = "Directory"
	verbose_switch: STRING = "v|verbose"
	verbose_switch_description: STRING = "Verbose output of processing"
	force_switch: STRING = "f|force"
	force_switch_description: STRING = "Force generation of syntactically incorrect classes"
			-- Our arguments

	switches: attached ARRAYED_LIST [attached ARGUMENT_SWITCH]
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, verbose_switch_description, True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, force_switch_description, True, False))
		end

invariant
	parser_not_void: parser /= Void
	fast_parser_not_void: parser /= Void
	factory_not_void: factory /= Void
	fast_factory_not_void: fast_factory /= Void
	visitor_not_void: visitor /= Void
	string_buffer_not_void: string_buffer /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
