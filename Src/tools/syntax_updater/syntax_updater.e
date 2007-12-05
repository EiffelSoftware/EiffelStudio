indexing
	description	: "System's root class"

class
	SYNTAX_UPDATER

inherit
	ARGUMENTS

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
					fast_parser.parse_from_string (string_buffer)
					if fast_parser.error_handler.has_error then
							-- We ignore syntax errors since we want to test roundtrip parsing
							-- on valid Eiffel classes.
							parser.error_handler.wipe_out
							io.error.put_string ("Syntax error in file: " + file_name)
							io.error.put_new_line
					elseif fast_factory.has_obsolete_constructs then
							-- Slow parsing to rewrite the class using the new constructs.
						parser.parse_from_string (string_buffer)
						check no_error: not parser.error_handler.has_error end

						visitor.setup (parser.root_node, parser.match_list, True, True)
							-- Free some memory from the parser that we don't need.
						parser.reset
						parser.reset_nodes
							-- Perform the visiting
						visitor.process_ast_node (visitor.parsed_class)
						if visitor.is_updated then
							create outfile.make (file_name)
							outfile.open_write
							if outfile.is_open_write then
								outfile.put_string (visitor.text)
								outfile.close
							else
								io.error.put_string ("Could not write to: " + file_name)
								io.error.put_new_line
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

end
