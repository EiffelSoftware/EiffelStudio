note
	description	: "System's root class"

class
	CODE_CHECKER

inherit
	ARGUMENTS

	KL_SHARED_EXECUTION_ENVIRONMENT

create
	make,
	make_with_filename

feature {NONE} -- Initialization

	make
		do
			initialize
			execute
		end

	make_with_filename (fn: STRING)
		do
			initialize
			process_file (fn)
		end

	initialize
		do
			create factory
			has_syntax_warning := False
			is_note_keyword := True
			is_indexing_keyword := True
			is_attribute_keyword := True

			create parser.make_with_factory (factory)
				-- Enabling `il_parsing' only means accepting more, not accepting less
				-- which is important to allow for such a syntax converter
			parser.set_il_parser
			parser.set_syntax_version (parser.provisional_syntax)
--			parser.set_is_note_keyword (is_note_keyword)
--			parser.set_is_attribute_keyword (is_attribute_keyword)
--			parser.set_is_indexing_keyword (is_indexing_keyword)
			parser.set_has_syntax_warning (has_syntax_warning)

			create visitor.make
		end

feature -- Options

	is_note_keyword: BOOLEAN
	is_indexing_keyword: BOOLEAN
	is_attribute_keyword: BOOLEAN
	has_syntax_warning: BOOLEAN

feature -- Access

	parser: EIFFEL_PARSER
	factory: AST_ROUNDTRIP_FACTORY
	visitor: CODE_CHECKER_VISITOR
			-- Factories and visitors being used for parsing.

	process_file (fn: STRING)
		local
			ast: like ast_from_string
			f: RAW_FILE
		do
			create f.make (execution_environment.interpreted_string (fn))
			if
				f.exists and then
				f.is_readable and then
				attached f.name as l_filename and then l_filename.count > 2 and then
				l_filename.substring (l_filename.count - 1, l_filename.count).is_case_insensitive_equal (".e")
			then
				ast := ast_from_string (fn)
			end
		end

feature {NONE} -- Implementation

	ast_from_string (fn: STRING): AST_EIFFEL
		require
			fn_not_void: fn /= Void
		local
			cl_as: CLASS_AS
			s: STRING
			f: RAW_FILE
		do
			debug
				print ("Processing " + fn + "%N")
			end
			create f.make_open_read (fn)
			from
				create s.make (f.count)
			until
				f.exhausted
			loop
				f.read_stream (1024)
				s.append (f.last_string)
			end
			f.close


			initialize
				-- Slow parsing to rewrite the class using the new constructs.
			parser.set_has_syntax_warning (False)
--			parser.set_is_note_keyword (True)
--			parser.set_is_attribute_keyword (True)
			parser.parse_from_string (s, Void)
			if parser.error_count = 0 then
				visitor.set_match_list (parser.match_list)
				cl_as := parser.root_node
					-- Free some memory from the parser that we don't need.
				parser.reset
				parser.reset_nodes
					-- Perform the visiting
				cl_as.process (visitor)
				if visitor.print_occurrences > 0 then
					print ("%"" + fn + "%" : class " + visitor.text (cl_as.class_name) + ": " + visitor.print_occurrences.out + "%N%N")
				end
				-- Free our memory.
				visitor.reset

				parser.wipe_out
			else
				print ("ERROR %"" + fn + "%"")
				if attached parser.error_message as m and then not m.is_empty then
					print (": " + m)
				end
				print ("%N")
				parser.reset
				parser.reset_nodes
				parser.wipe_out
			end
		end

feature {NONE} -- File discovering and processing

	execute
			-- Process all files under directories specified on the command line arguments.
		local
			i: INTEGER
			l_path: STRING
			d: DIRECTORY
		do
			if argument_count < 1 then
				io.error.put_string ("Specify a eiffel class file.")
				io.error.put_new_line
			else
				from
					i := 1
				until
					i > argument_count
				loop
					l_path := argument (i)
					create d.make (l_path)
					if d.exists then
						process_directory (create {KL_DIRECTORY}.make (l_path))
					else
						process_file (l_path)
					end
					i := i + 1
				end
				i := 1
			end
		end

	process_directory (a_dir: KL_DIRECTORY)
		local
			dir_names, file_names: ARRAY [STRING]
		do
			if
				a_dir.exists
			then
				dir_names := a_dir.directory_names
				if dir_names /= Void then
					dir_names.do_all (agent (a_path: STRING; a_dir_name: STRING)
						local
							l_dir: KL_DIRECTORY
						do
							create l_dir.make (a_path + operating_environment.Directory_separator.out + a_dir_name)
							if
								l_dir.exists and then
								not a_dir_name.same_string ("EIFGENs") and then
								not a_dir_name.same_string (".svn")
							then
								process_directory (l_dir)
							end
						end (a_dir.name, ?))
				end

				a_dir.open_read
				file_names := a_dir.filenames
				if file_names /= Void then
					file_names.do_all (agent (a_path: STRING; a_dir_name: STRING)
						do
							process_file (a_path + operating_environment.Directory_separator.out + a_dir_name)
						end (a_dir.name, ?))
				end
			end
		end

end
