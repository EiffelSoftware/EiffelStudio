class
	TEST_JSON_WRITER

inherit
	EQA_TEST_SET

	EXCEPTIONS
		undefine
			default_create
		end

feature -- Test

	test_json_text_writer
		local
			w: JSON_STREAM_WRITER
			js, s: STRING_8
		do
			js := "{%"num%": 123, %"text%": %"abc%", %"true%": True, %"null%": null, %"empty-obj%": { }, %"arr%": [ 123, %"abc%", True, null] }"

			create s.make (256)
			create {JSON_STREAM_TEXT_WRITER} w.make_with_text (s)
			process_writer (w)
			print (s)
			assert (w.generator + ": valid json", is_valid (s))
			assert (w.generator + ": expected string", {JSON_EQUALITY_TESTER}.same_json (s, js))
		end

	test_json_text_expanded_writer
		local
			w: JSON_STREAM_WRITER
			js, s: STRING_8
		do
			js := "{%"num%": 123, %"text%": %"abc%", %"true%": True, %"null%": null, %"empty-obj%": { }, %"arr%": [ 123, %"abc%", True, null] }"

			create s.make (256)
			create {JSON_STREAM_TEXT_EXPANDED_WRITER} w.make_with_text (s)
			process_writer (w)
			print (s)
			assert (w.generator + ": valid json", is_valid (s))
			assert (w.generator + ": expected string", {JSON_EQUALITY_TESTER}.same_json (s, js))
		end

	test_json_file_writer
		local
			w: JSON_STREAM_WRITER
		do
			create {JSON_STREAM_FILE_WRITER} w.make_with_file (io.output)
			process_writer (w)
		end

	test_json_file_expanded_writer
		local
			w: JSON_STREAM_WRITER
		do
			create {JSON_STREAM_FILE_EXPANDED_WRITER} w.make_with_file (io.output)
			process_writer (w)
		end

	process_writer (w: JSON_STREAM_WRITER)
		do
			w.reset -- Just in case
			w.enter_object
			w.put_property_name ("num")
			w.put_integer_64_value (123)

			w.put_property_name ("text")
			w.put_string_value ("abc")

			w.put_property_name ("true")
			w.put_boolean_value (True)

			w.put_property_name ("null")
			w.put_null_value

			w.put_property_name ("empty-obj")
			w.enter_object
			w.leave_object

			w.put_property_name ("arr")
			w.enter_array
			w.put_integer_64_value (123)
			w.put_string_value ("abc")
			w.put_boolean_value (True)
			w.put_null_value
			w.leave_array

			w.leave_object
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

end
