indexing
	description	: "System's root class"

class
	PARSER_TEST

inherit
	ARGUMENTS

	KL_SHARED_EXECUTION_ENVIRONMENT

	ENCODING_CONVERTER
		rename
			make as make_encoding
		end

	SHARED_ENCODING_CONVERTER

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_encoding
			test_roundtrip := False

			create {AST_NULL_FACTORY} factory
			create parser.make_with_factory (factory)
			parser.set_il_parser
			execute

			create {AST_ROUNDTRIP_LIGHT_FACTORY} factory
			create parser.make_with_factory (factory)
			parser.set_il_parser
			execute

			test_roundtrip_scanner := True
			create {AST_ROUNDTRIP_SCANNER_FACTORY} factory
			create scanner.make_with_factory (factory)
			create light_factory
			create parser.make_with_factory (light_factory)
			parser.set_il_parser
			execute
			test_roundtrip_scanner := False

			test_roundtrip := True
			scanner := Void
			create {AST_ROUNDTRIP_FACTORY} factory
			create parser.make_with_factory (factory)
			parser.set_il_parser
			execute
		end

feature {NONE} -- Implementation

	test_parse (file_name: STRING) is
		local
			file: KL_BINARY_INPUT_FILE
			fault: RAW_FILE
			count: INTEGER
			output: STRING
			file_system: KL_SHARED_FILE_SYSTEM
			fn: STRING
			l_class2: CLASS_AS
		do
			if equal (file_name.substring (file_name.count - 1, file_name.count), ".e") then
					-- Set for `IL' parsing since it accepts more classes.
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
					elseif attached parser.root_node as l_class1 then
						parse_eiffel_class (scanner, parser, file.last_string)
						l_class2 := parser.root_node

						if not l_class1.is_equivalent (l_class2) then
							create fault.make_open_append ("errors")
							fault.put_string (file_name)
							fault.put_new_line
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
			a_parser.error_handler.wipe_out
				-- First we do it using the old conventions.
			if a_scanner /= Void then
				a_scanner.set_syntax_version ({EIFFEL_PARSER}.obsolete_64_syntax)
				a_scanner.scan_string (a_buffer)
			end
			a_parser.set_syntax_version ({EIFFEL_PARSER}.obsolete_64_syntax)
			a_parser.parse_class_from_string (a_buffer, Void, Void)
			if a_parser.error_handler.has_error then
				a_parser.error_handler.wipe_out
					-- There was an error, let's try to see if the code is using transitional syntax.
				if a_scanner /= Void then
					a_scanner.set_syntax_version ({EIFFEL_PARSER}.transitional_64_syntax)
					a_scanner.scan_string (a_buffer)
				end
				a_parser.set_syntax_version ({EIFFEL_PARSER}.transitional_64_syntax)
				a_parser.parse_class_from_string (a_buffer, Void, Void)
				if a_parser.error_handler.has_error then
					a_parser.error_handler.wipe_out
						-- Still an error, let's try to see if the code is already using `attribute'.
					if a_scanner /= Void then
						a_scanner.set_syntax_version ({EIFFEL_PARSER}.ecma_syntax)
						a_scanner.scan_string (a_buffer)
					end
					a_parser.set_syntax_version ({EIFFEL_PARSER}.ecma_syntax)
					a_parser.parse_class_from_string (a_buffer, Void, Void)
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

	parser: STANDALONE_EIFFEL_PARSER
	
	scanner: EIFFEL_ROUNDTRIP_SCANNER

end -- class PARSER_TEST
