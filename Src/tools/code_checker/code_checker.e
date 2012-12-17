note
	description	: "System's root class"

class
	CODE_CHECKER

inherit
	ARGUMENTS_32

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
			execute
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

	process_file (fn: PATH)
		local
			ast: like ast_from_file
			f: RAW_FILE
			l_name: STRING_32
		do
			create f.make_with_path (fn)
			if
				f.exists and then
				f.is_readable and then
				fn.has_extension ("e")
			then
				ast := ast_from_file (fn)
			end
		end

feature {NONE} -- Implementation

	ast_from_file (fn: PATH): AST_EIFFEL
		require
			fn_not_void: fn /= Void
		local
			cl_as: CLASS_AS
			s: STRING
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			f.open_read
			from
				create s.make (f.count)
			until
				f.exhausted
			loop
				f.read_stream (1024)
				s.append_string_general (f.last_string)
			end
			f.close

			initialize
				-- Slow parsing to rewrite the class using the new constructs.
			parser.set_has_syntax_warning (False)
--			parser.set_is_note_keyword (True)
--			parser.set_is_attribute_keyword (True)
			parser.parse_class_from_string (s, Void, Void)
			if parser.error_count = 0 then
				visitor.set_match_list (parser.match_list)
				cl_as := parser.root_node
					-- Free some memory from the parser that we don't need.
				parser.reset
				parser.reset_nodes
					-- Perform the visiting
				cl_as.process (visitor)
				if visitor.print_occurrences > 0 then
					print ("%"" + fn.name + "%" : class " + visitor.text (cl_as.class_name) + ": " + visitor.print_occurrences.out + "%N%N")
				end
				-- Free our memory.
				visitor.reset

				parser.wipe_out
			else
				print ("ERROR %"" + fn.name + "%"")
				if attached parser.error_message as m and then not m.is_empty then
					print (": " + m)
				end
				print ("%N%N")
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
			l_path: IMMUTABLE_STRING_32
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
						process_directory (d)
					else
						process_file (create {PATH}.make_from_string (l_path))
					end
					i := i + 1
				end
				i := 1
			end
		end

	process_directory (a_dir: DIRECTORY)
		require
			a_dir_exists: a_dir.exists
		local
			l_file: RAW_FILE
			l_dir_path, l_path: PATH
		do
			l_dir_path := a_dir.path
			across a_dir.entries as l_name loop
				if not l_name.item.is_current_symbol and not l_name.item.is_parent_symbol then
					l_path := l_dir_path.extended_path (l_name.item)
					create l_file.make_with_path (l_path)
					if l_file.exists then
						if l_file.is_directory then
							if not l_path.name.same_string_general (".svn") and not l_path.name.same_string_general ("EIFGENs") then
								process_directory (create {DIRECTORY}.make_with_path (l_path))
							end
						else
							process_file (l_path)
						end
					end
				end
			end
		end

end
