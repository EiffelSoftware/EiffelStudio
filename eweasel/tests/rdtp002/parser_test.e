indexing
	description	: "System's root class"

class
	PARSER_TEST

inherit
	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_ENCODING_CONVERTER

create
	make

feature

	make is
		local
			l_parser: EIFFEL_PARSER
			l_input_file: PLAIN_TEXT_FILE
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string ("$TEST")
			l_file_name.set_file_name ("test")
			create l_input_file.make_open_read (l_file_name)
			l_input_file.read_stream (l_input_file.count)
			l_input_file.close

			create l_parser.make_with_factory (create {AST_ROUNDTRIP_FACTORY})
			l_parser.parse_class_from_string (l_input_file.last_string, Void, Void)
			if l_parser.root_node /= Void and then l_parser.match_list /= Void then
				if compare_output (l_input_file.last_string, l_parser.match_list.out) then
					io.put_string ("OK%N")
				else
					io.put_string ("Failed%N")
				end
			end
		end

	compare_output (a_str_from_file, a_output: STRING): BOOLEAN
			-- Compare the content from `a_str_from_file' with `a_output'
			-- Convert `a_str_from_file' to UTF-8 before hand according to last parsing result.
		require
			a_str_from_file_not_void: a_str_from_file /= Void
			a_output_not_void: a_output /= Void
		local
			l_s: STRING
		do
			l_s := encoding_converter.utf8_string (a_str_from_file, Void)
			Result := l_s.is_equal (a_output)
		end

end
