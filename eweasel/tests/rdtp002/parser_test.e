indexing
	description	: "System's root class"

class
	PARSER_TEST

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
			l_parser.parse_from_string (l_input_file.last_string)
			if l_parser.root_node /= Void and then l_parser.match_list /= Void then
				if l_input_file.last_string.is_equal (l_parser.match_list.out) then
					io.put_string ("OK%N")
				else
					io.put_string ("Failed%N")
				end
			end
		end

end 
