note
	description: "Summary description for {DEGREE_5}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEGREE_5

feature

	start
		local
			l_pool: EIFFEL_PARSER_POOL
			l_file: STRING
			i: INTEGER
		do
			create l_pool.make (agent create_parser)
			from
				i := 1
			until
				i > 10
			loop
				l_file := "File " + i.out
				l_pool.parse (l_file, agent setup_parser, agent post_parsing (l_file))
				i := i + 1
			end

			wait_and_go_to_next_degree
		end

	create_parser: separate EIFFEL_PARSER
		do
			create Result
		end

	setup_parser (a_parser: separate EIFFEL_PARSER)
		do
			a_parser.do_nothing
		end

	post_parsing (a_file: STRING)
		do
			io.put_string (a_file)
			io.put_new_line
		end

	wait_and_go_to_next_degree
		do

		end

end
