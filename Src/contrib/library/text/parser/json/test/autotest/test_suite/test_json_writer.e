class
	TEST_JSON_WRITER

inherit
	EQA_TEST_SET

	EXCEPTIONS
		undefine
			default_create
		end

feature -- Test

	test_parser_reuse
		local
			w: JSON_STREAM_WRITER
			js, s: STRING_8
		do
			js := "{%"num%": 123, %"text%": %"abc%", %"true%": True, %"null%": null, %"empty-obj%": { }, %"arr%": [ 123, %"abc%", True, null] }"

			create s.make (256)
			create {JSON_STREAM_TEXT_WRITER} w.make_with_text (s)
--			create {JSON_STREAM_FILE_WRITER} w.make_with_file (io.output)
			create {JSON_STREAM_TEXT_EXPANDED_WRITER} w.make_with_text (s)
--			create {JSON_STREAM_FILE_EXPANDED_WRITER} w.make_with_file (io.output)

			w.reset -- Just in case
			w.put_object_start
			w.put_property_name ("num")
			w.put_integer_64_value (123)

			w.put_property_name ("text")
			w.put_string_value ("abc")

			w.put_property_name ("true")
			w.put_boolean_value (True)

			w.put_property_name ("null")
			w.put_null_value

			w.put_property_name ("empty-obj")
			w.put_object_start
			w.put_object_end

			w.put_property_name ("arr")
			w.put_array_start
			w.put_integer_64_value (123)
			w.put_string_value ("abc")
			w.put_boolean_value (True)
			w.put_null_value
			w.put_array_end

			w.put_object_end

			print (s)

			assert ("valid json", is_valid (s))
			assert ("expected string", same_json (s, js))
		end

feature -- Comparison

	is_valid (j: STRING_8): BOOLEAN
		local
			jp: JSON_PARSER
		do
			create jp.make
			jp.parse_string (j)
			if jp.is_parsed and jp.is_valid then
				Result := True
			end
		end

	same_json (j1, j2: STRING_8): BOOLEAN
		local
			jp: JSON_PARSER
			jv1, jv2: detachable JSON_VALUE
		do
			create jp.make

			jp.parse_string (j1)
			if jp.is_parsed and jp.is_valid then
				jv1 := jp.parsed_json_value
			end
			jp.parse_string (j2)
			if jp.is_parsed and jp.is_valid then
				jv2 := jp.parsed_json_value
			end
			if jv1 = Void then
				Result := jv2 = Void
			elseif jv2 = Void then
				Result := False
			else
				Result := jv1.representation.is_equal (jv2.representation)
			end
		end

end
