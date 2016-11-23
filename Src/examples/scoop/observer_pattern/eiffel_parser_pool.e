note
	description: "Summary description for {EIFFEL_PARSER_POOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_PARSER_POOL

create
	make

feature

	make (a_creation: like parser_creation)
		do
			parser_creation := a_creation
			create parsers.make (10)
		end

	parse (a_file: STRING; a_setup_action: PROCEDURE [separate EIFFEL_PARSER]; a_post_action: PROCEDURE)
		require
			a_file_not_void: a_file /= Void
		local
			l_parser: separate EIFFEL_PARSER
		do
			l_parser := next_parser
			a_setup_action.call ([l_parser])
			set_post_action (l_parser, a_post_action)
			parse_internal (l_parser, a_file)
		end

	next_parser: separate EIFFEL_PARSER
			-- Retrieve next parser.
		local
			l_index: INTEGER
		do
			if current_parser_index = max_parsers then
				current_parser_index := 0
			end

			l_index := current_parser_index + 1
			current_parser_index := l_index
			if l_index <= parsers.count then
				Result := parsers.i_th (l_index)
			else
				Result := parser_creation.item (Void)
				parsers.extend (Result)
			end
		ensure
			Result_not_void: Result /= Void
		end

	parse_internal (a_parser: separate EIFFEL_PARSER; a_file: separate STRING)
		do
			a_parser.parse (a_file)
		end

	current_parser_index: INTEGER

	parsers: ARRAYED_LIST [separate EIFFEL_PARSER]
		-- Managed parsers

feature {NONE} -- Implementation

	set_post_action (a_parser: separate EIFFEL_PARSER; a_post_action: PROCEDURE)
		do
			a_parser.set_post_parsing_action (a_post_action)
		end

	parser_creation: FUNCTION [separate EIFFEL_PARSER]

	max_parsers: INTEGER = 5

end
