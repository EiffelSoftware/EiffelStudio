class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			test (create {AST_FACTORY})
			test (create {AST_ROUNDTRIP_LIGHT_FACTORY})
			test (create {AST_ROUNDTRIP_FACTORY})
		end

	test (a_factory: AST_FACTORY)
			-- Run application.
		local
			l_parser: EIFFEL_PARSER
			l_ast: AST_EIFFEL
		do
			create l_parser.make_with_factory (a_factory)
			l_parser.set_feature_parser
			l_parser.parse_from_utf8_string ("[
				feature
					 foo
						do
							bar ("abs", ["de", "fr"])
						end
				]", Void)
			l_ast := l_parser.feature_node
			check_ast (l_ast)

			l_parser.parse_from_utf8_string ("[
				feature
					 foo
						do
							bar ("abs", << "de", "fr" >>)
						end
				]", Void)
			l_ast := l_parser.feature_node
			check_ast (l_ast)
		end

	check_ast (a_ast: AST_EIFFEL)
		do
			if
				attached {FEATURE_AS} a_ast as l_feature and then
				attached l_feature.body as l_body and then
				attached {ROUTINE_AS} l_body.content as l_routine and then
				attached {DO_AS} l_routine.routine_body as l_do and then
				attached l_do.compound as l_list and then not l_list.is_empty and then
				attached {INSTR_CALL_AS} l_list.first as l_instruction and then
				attached {ACCESS_ID_AS} l_instruction.call as l_call and then
				attached l_call.parameters as l_params and then l_params.count = 2
			then
				if attached {STRING_AS} l_params.i_th (1) as l_string then
					io.put_string_32 (l_string.value_32)
					io.put_new_line
				end
				if attached {TUPLE_AS} l_params.i_th (2) as l_tuple then
					io.put_string ("TUPLE_AS")
					io.put_new_line
				end
				if attached {ARRAY_AS} l_params.i_th (2) as l_array then
					io.put_string ("ARRAY_AS")
					io.put_new_line
				end
			end
		end

end
