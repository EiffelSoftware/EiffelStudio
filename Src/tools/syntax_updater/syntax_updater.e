indexing
	description	: "System's root class"

class
	SYNTAX_UPDATER

inherit
	ARGUMENTS

	KL_SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make is
		do
			create factory
			create parser.make_with_factory (factory)
				-- Enabling `il_parsing' only means accepting more, not accepting less
				-- which is important to allow for such a syntax converter
			parser.set_il_parser
			create visitor.make_with_default_context
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
			count: INTEGER
		do
			if equal (file_name.substring (file_name.count - 1, file_name.count), ".e") then
				create file.make (file_name)
				count := file.count
				file.open_read
				if file.is_open_read then
					file.read_string (count)
					parser.parse_from_string (file.last_string)
					file.close

					if parser.error_handler.has_error then
							-- We ignore syntax errors since we want to test roundtrip parsing
							-- on valid Eiffel classes.
						parser.error_handler.wipe_out
						io.error.put_string ("Syntax error in file: " + file_name)
						io.error.put_new_line
					else
						visitor.setup (parser.root_node, parser.match_list, True, True)
						visitor.reset
						visitor.process_ast_node (parser.root_node)
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
				else
					io.error.put_string ("Couldn't open: " + file_name)
					io.error.put_new_line
				end
			end
		end

feature {NONE}

	parser: EIFFEL_PARSER
	factory: AST_ROUNDTRIP_FACTORY
	visitor: SYNTAX_UPDATER_VISITOR
			-- Factories and visitors being used for parsing.

invariant
	parser_not_void: parser /= Void
	factory_not_void: factory /= Void
	visitor_not_void: visitor /= Void

end
