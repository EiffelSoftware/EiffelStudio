note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_JSON_PARSER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

	PEG_FACTORY


feature -- Access


	uri: STRING
			--
		attribute
			create Result.make_empty
		end


feature -- Processing

	parse (a_string: STRING; a_uri: STRING): detachable JSON_VALUE
			-- Parses the string and creates a JSON_VALUE
			--
			-- `a_string': The string to parse
			-- `a_uri': The identifier that describes where the string comes from. It will be shown in an error.
		require
			a_string_attached_and_not_empty: a_string /= Void and then not a_string.is_empty
		local
			l_res: PEG_PARSER_RESULT
			l_row_line: TUPLE [line, row: INTEGER]
		do
			uri := a_uri
			l_res := parser.parse_string (a_string)
			if l_res.success and l_res.error_messages.is_empty then
				if attached {JSON_VALUE} l_res.parse_result.first as l_json then
					Result := l_json
				end
			else
				if not l_res.success then
					l_row_line := l_res.left_to_parse.debug_information_with_index (l_res.left_to_parse.longest_match.count)
					error_manager.add_error (create {XERROR_JSON_ERROR}.make (
						"Syntax error in '" + uri + "' on line: " + l_row_line.line.out + " row: " + l_row_line.row.out)
						, False)
				end
				from
					l_res.error_messages.start
				until
					l_res.error_messages.after
				loop
					error_manager.add_error (create {XERROR_JSON_ERROR}.make ("Error in '" + uri + "'" + l_res.error_messages.item), False)
					l_res.error_messages.forth
				end
			end

		end

feature -- Status Report

feature {NONE} -- Internal

	parser: PEG_ABSTRACT_PEG
			-- Defines the grammar for the parser
		local
			e_c, e_cc, e, exp, frac, int,
			number, chars, string, value,
			elements, array, pair,
			members, object,
			true_kw, false_kw, null_kw: PEG_ABSTRACT_PEG
		once
			e_c := char ('e')
			e_cc := char ('E')
			true_kw := stringp ("true")
			true_kw.set_behaviour (agent build_true)
			false_kw := stringp ("false")
			false_kw.set_behaviour (agent build_false)
			null_kw := stringp ("null")
			null_kw.set_behaviour (agent build_null)

			e := (e_c | e_cc) + (plus | minus).optional
			e.fixate
			exp := e + digits
			exp.fixate
			exp.set_name ("exp")
			frac := dot + digits
			frac.fixate
			frac.set_name ("frac")
			int := minus.optional + digits
			int.fixate
			int.set_name ("int")
			number := ((int | (int + frac) | (int + exp) | (int + frac + exp))).consumer
			number.fixate
			number.set_name ("number")
			number.set_behaviour (agent build_number)
			chars := +(quote.negate + any)
			chars.fixate
			chars.set_name ("chars")
			string := (quote + chars.consumer + quote)
			string.fixate
			string.set_behaviour (agent build_string)
			string.set_name ("string")
			create {PEG_SEQUENCE} object.make
			create {PEG_SEQUENCE} array.make
			value := array | object | number | string | true_kw | false_kw | null_kw
			value.fixate
			value.set_name ("value")
			create {PEG_CHOICE} elements.make
			elements := elements | (value |+ comma |+ elements) | value
			elements.fixate
			elements.set_name ("elements")
			array := array + open_square |+ elements.optional |+ close_square
			array.fixate
			array.set_behaviour (agent build_array)
			array.set_name ("array")
			pair := string |+ colon |+ value
			pair.set_name ("name")
			pair.fixate
			pair.set_behaviour (agent build_pair)
			create {PEG_CHOICE} members.make
			members := members | (pair |+ comma |+ members) | pair
			members.fixate
			members.set_name ("members")
			object := object |+ open_curly |+ members.optional |+ close_curly
			object.set_name ("object")
			object.fixate
			object.set_behaviour (agent build_object)
			Result := object
		end

feature {NONE} -- Behaviour

	build_object (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		local
			l_res: JSON_OBJECT
		do
			Result := a_result
			create l_res.make
			from
				Result.parse_result.start
			until
				Result.parse_result.after
			loop
				if attached {JSON_STRING} Result.parse_result.item as l_key then
					Result.parse_result.forth
					if attached {JSON_VALUE} Result.parse_result.item as l_child then
						l_res.put (l_child, l_key)
					end
				end
				Result.parse_result.forth
			end
			Result.replace_result (l_res)
		end

	build_pair (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		do
			Result := a_result
		end

	build_true (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		do
			Result := a_result
			Result.replace_result (create {JSON_BOOLEAN}.make_boolean (True))
		end

	build_false (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		do
			Result := a_result
			Result.replace_result (create {JSON_BOOLEAN}.make_boolean (False))
		end

	build_null (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		do
			Result := a_result
			Result.replace_result (create {JSON_NULL})
		end

	build_string (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		do
			Result := a_result
			if attached {STRING} a_result.parse_result.first as l_string then
				Result.replace_result (create {JSON_STRING}.make_json (l_string))
			end
		end

	build_number (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		do
			Result := a_result
			if attached {STRING} a_result.parse_result.first as l_number then
				if l_number.is_integer then
					Result.replace_result (create {JSON_NUMBER}.make_integer (l_number.to_integer))
				elseif l_number.is_real then
					Result.replace_result (create {JSON_NUMBER}.make_real (l_number.to_real))
				else
					Result.put_error_message ("Invalid Number! Assumed 0.")
					Result.replace_result (create {JSON_NUMBER}.make_integer (0))
				end
			end
		end

	build_array (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
		local
			l_res: JSON_ARRAY
		do
			Result := a_result
			from
				Result.parse_result.start
				create l_res.make_array
			until
				Result.parse_result.after
			loop
				if attached {JSON_VALUE} Result.parse_result.item as l_item then
					l_res.add (l_item)
				end
				Result.parse_result.forth
			end
			Result.replace_result (l_res)
		end
end

