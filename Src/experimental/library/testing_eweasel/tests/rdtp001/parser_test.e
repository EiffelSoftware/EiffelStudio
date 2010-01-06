indexing
	description	: "System's root class"

class
	PARSER_TEST

inherit
	ARGUMENTS

	KL_SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make is
		do
			test_roundtrip := False

			create {AST_NULL_FACTORY} factory
			execute

			create {AST_ROUNDTRIP_LIGHT_FACTORY} factory
			execute

			test_roundtrip_scanner := True
			create light_factory
			create {AST_ROUNDTRIP_SCANNER_FACTORY} factory
			execute
			test_roundtrip_scanner := False

			test_roundtrip := True
			create {AST_ROUNDTRIP_FACTORY} factory
			execute
		end

feature {NONE} -- Implementation

	generated_text (a_class: CLASS_AS; a_match_list: LEAF_AS_LIST): STRING is
			-- Is roundtrip generated code from `a_ast' in `a_class' and `a_match_list' the same as it is in `a_source'?
		require
			a_class_attached: a_class /= Void
			a_match_list_attached: a_match_list /= Void
		local
			l_visitor: AST_ROUNDTRIP_PRINTER_VISITOR
		do
			create l_visitor.make_with_default_context
			l_visitor.setup (a_class, a_match_list, True, True)
			l_visitor.process_ast_node (a_class)
			Result := l_visitor.text
		end

	test_parse (file_name: STRING) is
		local
			parser: STANDALONE_EIFFEL_PARSER
			scanner: EIFFEL_ROUNDTRIP_SCANNER
			file: KL_BINARY_INPUT_FILE
			fault: KL_BINARY_OUTPUT_FILE
			count: INTEGER
			output: STRING
			res: BOOLEAN
			file_system: KL_SHARED_FILE_SYSTEM
			fn: STRING
		do
			if equal (file_name.substring (file_name.count - 1, file_name.count), ".e") then
				if test_roundtrip_scanner then
					create scanner.make_with_factory (factory)
				end
				if test_roundtrip_scanner then
					create parser.make_with_factory (light_factory)
				else
					create parser.make_with_factory (factory)
				end
					-- Set for `IL' parsing since it accepts more classes.
				parser.set_il_parser
				create file.make (file_name)
				count := file.count
				file.open_read
				if file.is_open_read then
					file.read_string (count)
					parse_eiffel_class (scanner, parser, file.last_string)

					if parser.error_handler.has_error then
							-- We ignore syntax errors since we want to test roundtrip parsing
							-- on valid Eiffel classes.
						parser.error_handler.wipe_out
					elseif test_roundtrip or test_roundtrip_scanner then
						if test_roundtrip then
							output := generated_text (parser.root_node, parser.match_list)
							res := file.last_string.is_equal (output)
						else
							res := True
						end
						if res and test_roundtrip_scanner then
							output := generated_text (parser.root_node, scanner.match_list)
							res := file.last_string.is_equal (output)
						end
						if not res then
							create file_system
							fn := file_system.file_system.dirname (file_name)
							fn := file_name.substring (fn.count+2, file_name.count)

							create fault.make ("error_" + fn)
							fault.open_write
							fault.put_string (output)
							fault.close
							error_count := error_count + 1
						end
					end

					file.close
				else
					print ("couldn't open file: " + file_name)
					io.new_line
				end
			end
		end

	parse_eiffel_class (a_scanner: EIFFEL_ROUNDTRIP_SCANNER; a_parser: STANDALONE_EIFFEL_PARSER; a_buffer: STRING)
			-- Using a parser, parse our code using different parser mode, to ensure that we can
			-- indeed convert any kind of Eiffel classes.
		require
			a_parser_not_void: a_parser /= Void
			a_buffer_not_void: a_buffer /= Void
		do
				-- First we do it using the old conventions.
			if a_scanner /= Void then
				a_scanner.set_syntax_version ({EIFFEL_PARSER}.obsolete_64_syntax)
				a_scanner.scan_string (a_buffer)
			end
			a_parser.set_syntax_version ({EIFFEL_PARSER}.obsolete_64_syntax)
			a_parser.parse_from_string (a_buffer, Void)
			if a_parser.error_handler.has_error then
					-- There was an error, let's try to see if the code is using transitional syntax.
				if a_scanner /= Void then
					a_scanner.set_syntax_version ({EIFFEL_PARSER}.transitional_64_syntax)
					a_scanner.scan_string (a_buffer)
				end
				a_parser.set_syntax_version ({EIFFEL_PARSER}.transitional_64_syntax)
				a_parser.parse_from_string (a_buffer, Void)
				if a_parser.error_handler.has_error then
						-- Still an error, let's try to see if the code is already using `attribute'.
					if a_scanner /= Void then
						a_scanner.set_syntax_version ({EIFFEL_PARSER}.ecma_syntax)
						a_scanner.scan_string (a_buffer)
					end
					a_parser.set_syntax_version ({EIFFEL_PARSER}.ecma_syntax)
					a_parser.parse_from_string (a_buffer, Void)
				end
			end
		end

	test_conc (base_path, rem_path: STRING; recursive: BOOLEAN) is
		local
			full_path: STRING
		do
			full_path := base_path + operating_environment.Directory_separator.out + rem_path
			if recursive then
				test_recursive (full_path)
			else
				test_parse (full_path)
			end
		end

	test_recursive (path: STRING) is
		local
			dir: KL_DIRECTORY
			dir_names, file_names: ARRAY [STRING]
		do
			create dir.make (path)

			dir_names := dir.directory_names
			if dir_names /= Void then
				dir_names.do_all (agent test_conc(path, ?, True))
			end

			dir.open_read
			file_names := dir.filenames
			if file_names /= Void then
				file_names.do_all (agent test_conc(path, ?, False))
			end

		end

	execute is
		require
			argument_count > 0
		local
			i: INTEGER
			dir: KL_DIRECTORY
			l_dir: STRING
		do
			from
				i := 1
			until
				i > argument_count
			loop
				l_dir := Execution_environment.interpreted_string (argument (i))
				create dir.make (l_dir)
				if dir.exists then
					test_recursive (l_dir)
					i := i + 1
				else
					print ("directory: " + l_dir + " is not accessible%N")
					i := argument_count + 1
					error_count := error_count + 1
				end
			end
			print ("number of errors: " + error_count.out + "%N")
		end

feature {NONE}

	error_count: INTEGER

	test_roundtrip: BOOLEAN
			-- Are we testing the roundtrip?

	test_roundtrip_scanner: BOOLEAN

	factory: AST_FACTORY
			-- Factory being used for parsing.

	light_factory: AST_ROUNDTRIP_LIGHT_FACTORY

end -- class PARSER_TEST
