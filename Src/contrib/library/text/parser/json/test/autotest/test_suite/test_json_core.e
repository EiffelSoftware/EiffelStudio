class
	TEST_JSON_CORE

inherit
	EQA_TEST_SET

	JSON_PARSER_ACCESS
		undefine
			default_create
		end

	EXCEPTIONS
		undefine
			default_create
		end

feature -- Factory

	new_parser (a_string: STRING_8): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

	new_empty_parser: JSON_PARSER
		do
			create Result.make
		end

feature -- Test

	test_parser_reuse
		local
			jrep: STRING
			parser: like new_parser
		do
			jrep := "{%"num%": 123, %"text%": %"abc%", %"true%": True, %"null%": null, %"empty-obj%": { }, %"arr%": [ 123, %"abc%", True, null] }"
			parser := new_parser (jrep)
			assert ("not parsed", not parser.is_parsed)
			assert ("no error", not parser.has_error)
			parser.parse_content
			assert ("parsed", parser.is_parsed)
			assert ("is valid", parser.is_valid)

				-- Reuse with same content
			parser.set_representation (jrep)
			assert ("not parsed", not parser.is_parsed)
			assert ("no error", not parser.has_error)
			parser.parse_content
			assert ("parsed", parser.is_parsed)
			assert ("is valid", parser.is_valid)

				-- Reuse with bad content
			parser.set_representation ("{ bad content }")
			assert ("not parsed", not parser.is_parsed)
			assert ("no error", not parser.has_error)
			parser.parse_content
			assert ("parsed", parser.is_parsed)
			assert ("is not valid", not parser.is_valid)

				-- Reuse with first jrep content
			parser.set_representation (jrep)
			assert ("not parsed", not parser.is_parsed)
			assert ("no error", not parser.has_error)
			parser.parse_content
			assert ("parsed", parser.is_parsed)
			assert ("is valid", parser.is_valid)
		end

	test_parse_string
		local
			jrep: STRING
			parser: like new_empty_parser
		do
			parser := new_empty_parser
			jrep := "{%"num%": 123, %"text%": %"abc%", %"true%": True, %"null%": null, %"empty-obj%": { }, %"arr%": [ 123, %"abc%", True, null] }"
			parser.parse_string (jrep)
			assert ("parsed", parser.is_parsed)
			assert ("is valid", parser.is_valid)

				-- Reuse with same content
			parser.parse_string (jrep)
			assert ("parsed", parser.is_parsed)
			assert ("is valid", parser.is_valid)

				-- Reuse with bad content
			parser.parse_string ("{ bad content }")
			assert ("parsed", parser.is_parsed)
			assert ("is not valid", not parser.is_valid)

				-- Reuse with first jrep content
			parser.parse_string (jrep)
			assert ("parsed", parser.is_parsed)
			assert ("is valid", parser.is_valid)
		end

	test_json_number_and_integer
		local
			i: INTEGER
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			i := 42
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_integer (i)
			assert ("jn.representation.same_string (%"42%")", jn.representation.same_string ("42"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (i) as l_jn then
				assert ("l_jn.representation.same_string (%"42%")", jn.representation.same_string ("42"))
			else
				assert ("json_value (i) is a JSON_NUMBER", False)
			end

				-- JSON representation-> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_8 since the value is 42
			jrep := "42"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {INTEGER_8} json_object (jn, Void) as l_i8 then
					assert ("l_i8 = 42", l_i8 = 42)
				else
					assert ("json_object (jn, Void) is a INTEGER_8", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_integer_8
		local
			i8: INTEGER_8
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			i8 := 42
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_integer (i8)
			assert ("jn.representation.same_string (%"42%")", jn.representation.same_string ("42"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (i8) as l_jn then
				assert ("l_jn.representation.same_string (%"42%")", jn.representation.same_string ("42"))
			else
				assert ("json_value (i8) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_8 since the value is 42
			jrep := "42"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {INTEGER_8} json_object (jn, Void) as l_i8 then
					assert ("l_i8 = 42", l_i8 = 42)
				else
					assert ("json_object (jn, Void) is a INTEGER_8", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_integer_16
		local
			i16: INTEGER_16
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			i16 := 300
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_integer (i16)
			assert ("jn.representation.same_string (%"300%")", jn.representation.same_string ("300"))
				-- Eiffel value -> JSON with factory
			if attached {JSON_NUMBER} json_value (i16) as l_jn then
				assert ("l_jn.representation.same_string (%"300%")", l_jn.representation.same_string ("300"))
			else
				assert ("json_value (i16) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_16 since the value is 300
			jrep := "300"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {INTEGER_16} json_object (jn, Void) as l_i16 then
					assert ("l_i16 = 300", l_i16 = 300)
				else
					assert ("json_object (jn, Void) is a INTEGER_16", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_integer_32
		local
			i32: INTEGER_32
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			i32 := 100000
				-- Eiffel value -> JSON representation -> JSON value
			create jn.make_integer (i32)
			assert ("jn.representation.same_string (%"100000%")", jn.representation.same_string ("100000"))
				-- Eiffel value -> JSON representation -> JSON value with factory
			if attached {JSON_NUMBER} json_value (i32) as l_jn then
				assert ("l_jn.representation.same_string (%"100000%")", l_jn.representation.same_string ("100000"))
			else
				assert ("json_value (i32) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_32 since the value is 100000
			jrep := "100000"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {INTEGER_32} json_object (jn, Void) as l_i32 then
					assert ("l_i32 = 100000", l_i32 = 100000)
				else
					assert ("json_object (jn, Void) is a INTEGER_32", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_integer_64
		local
			i64: INTEGER_64
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			i64 := 42949672960
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_integer (i64)
			assert ("jn.representation.same_string (%"42949672960%")", jn.representation.same_string ("42949672960"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (i64) as l_jn then
				assert ("l_jn.representation.same_string (%"42949672960%")", l_jn.representation.same_string ("42949672960"))
			else
				assert ("json_value (i64) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_32 since the value is 42949672960
			jrep := "42949672960"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {INTEGER_64} json_object (jn, Void) as l_i64 then
					assert ("l_i64 = 42949672960", l_i64 = 42949672960)
				else
					assert ("json_object (jn, Void) is a INTEGER_64", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_natural_8
		local
			n8: NATURAL_8
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			n8 := 200
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_natural (n8)
			assert ("jn.representation.same_string (%"200%")", jn.representation.same_string ("200"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (n8) as l_jn then
				assert ("l_jn.representation.same_string (%"200%")", l_jn.representation.same_string ("200"))
			else
				assert ("json_value (n8) is a JSON_NUMBER}", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_16 since the value is 200
			jrep := "200"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {NATURAL_8} json_object (jn, Void) as jn8 then
					assert ("jn8 = 200", jn8 = 200)
				else
					assert ("json_object (jn, Void) is an INTEGER_16", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_natural_16
		local
			n16: NATURAL_16
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			n16 := 32768
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_natural (n16)
			assert ("jn.representation.same_string (%"32768%")", jn.representation.same_string ("32768"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (n16) as l_jn then
				assert ("l_jn.representation.same_string (%"32768%")", l_jn.representation.same_string ("32768"))
			else
				assert ("json_value (n16) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_32 since the value is 32768
			jrep := "32768"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {NATURAL_16} json_object (jn, Void) as nat16 then
					assert ("nat16 = 32768", nat16 = 32768)
				else
					assert ("json_object (jn, Void) is a NATURAL_16", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_natural_32
		local
			n32: NATURAL_32
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			n32 := 2147483648
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_natural (n32)
			assert ("jn.representation.same_string (%"2147483648%")", jn.representation.same_string ("2147483648"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached json_value (n32) as l_jn then
				assert ("l_jn.representation.same_string (%"2147483648%")", l_jn.representation.same_string ("2147483648"))
			else
				assert ("json_value (n32) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_64 since the value is 2147483648
			jrep := "2147483648"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {NATURAL_32} json_object (jn, Void) as nat32 then
					assert ("nat32 = 2147483648", nat32 = 2147483648)
				else
					assert ("json_object (jn, Void) is a NATURAL_32", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_large_integers
		local
			jrep: STRING
			n64: NATURAL_64
			jn: JSON_NUMBER
			parser: like new_parser
		do
			n64 := 9223372036854775808
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_natural (n64)
			assert ("jn.representation.same_string (%"9223372036854775808%")", jn.representation.same_string ("9223372036854775808"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (n64) as l_jn then
				assert ("l_jn.representation.same_string (%"9223372036854775808%")", l_jn.representation.same_string ("9223372036854775808"))
			else
				assert ("json_value (n64) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- we know it is INTEGER_32 since the value is 42949672960
			jrep := "9223372036854775808" -- 1 higher than largest positive number that can be represented by INTEGER 64
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {NATURAL_64} json_object (jn, Void) as l_n64 then
					assert ("l_n64 = 9223372036854775808", l_n64 = 9223372036854775808)
				else
					assert ("json_object (jn, Void) is a NATURAL_64", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_eiffel_real
		local
			r: REAL
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			r := 3.14
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_real (r)
			assert ("jn.representation.same_string (%"3.1400001049041748%")", jn.representation.same_string ("3.1400001049041748"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (r) as l_jn then
				assert ("l_jn.representation.same_string (%"3.1400001049041748%")", l_jn.representation.same_string ("3.1400001049041748"))
			else
				assert ("json_value (r) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will always return a REAL_64 if the value
				-- of the JSON number is a floating point number
			jrep := "3.14"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {REAL_64} json_object (jn, Void) as r64 then
					assert ("3.14 <= r64 and r64 <= 3.141", 3.14 <= r64 and r64 <= 3.141)
				else
					assert ("json_object (jn, Void) is a REAL_64", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_eiffel_real_32
		local
			r32: REAL_32
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			r32 := 3.14
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_real (r32)
			assert ("jn.representation.same_string (%"3.1400001049041748%")", jn.representation.same_string ("3.1400001049041748"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (r32) as l_jn then
				assert ("l_jn.representation.same_string (%"3.1400001049041748%")", l_jn.representation.same_string ("3.1400001049041748"))
			else
				assert ("json_value (r32) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			jrep := "3.1400001049041748"
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {REAL_64} json_object (l_jn, Void) as r then
					assert ("r = 3.1400001049041748", r = 3.1400001049041748)
				else
					assert ("json_object (l_jn, Void) is a REAL_64", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_eiffel_real_64
		local
			r64: REAL_64
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
			r64 := 3.1415926535897931 + {REAL_32}.max_value
				-- Eiffel value -> JSON value -> JSON representation
			create jn.make_real (r64)
			assert ("jn.representation.same_string (%"" + r64.out + "%")", jn.representation.same_string (r64.out))

				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NUMBER} json_value (r64) as l_jn then
				assert ("l_jn.representation.same_string (%""+r64.out+"%")", l_jn.representation.same_string (r64.out))
			else
				assert ("json_value (r64) is a JSON_NUMBER", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			jrep := r64.out
			parser := new_parser (jrep)
			if attached {JSON_NUMBER} parser.next_parsed_json_value as l_jn then
				if attached {REAL_64} json_object (jn, Void) as r then
					assert ("r = " + r64.out, r = r64)
				else
					assert ("json_object (jn, Void) is a REAL_64", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_NUMBER", False)
			end
		end

	test_json_number_and_eiffel_real_nan
		local
			r64: REAL_64
			jn: JSON_NUMBER
		do
			r64 := {REAL_64}.nan
			create jn.make_real (r64)
			assert ("jn.representation.same_string (%"" + r64.out + "%")", jn.representation.same_string ({JSON_NULL}.representation))
			if attached {JSON_NUMBER} json_value (r64) as l_jn then
				assert ("l_jn.representation.same_string (%""+r64.out+"%")", l_jn.representation.same_string ({JSON_NULL}.representation))
			else
				assert ("json_value (r64) is a JSON_NUMBER", False)
			end

			r64 := {REAL_64}.negative_infinity
			create jn.make_real (r64)
			assert ("jn.representation.same_string (%"" + r64.out + "%")", jn.representation.same_string ({JSON_NULL}.representation))
			if attached {JSON_NUMBER} json_value (r64) as l_jn then
				assert ("l_jn.representation.same_string (%""+r64.out+"%")", l_jn.representation.same_string ({JSON_NULL}.representation))
			else
				assert ("json_value (r64) is a JSON_NUMBER", False)
			end

			r64 := {REAL_64}.positive_infinity
			create jn.make_real (r64)
			assert ("jn.representation.same_string (%"" + r64.out + "%")", jn.representation.same_string ({JSON_NULL}.representation))
			if attached {JSON_NUMBER} json_value (r64) as l_jn then
				assert ("l_jn.representation.same_string (%""+r64.out+"%")", l_jn.representation.same_string ({JSON_NULL}.representation))
			else
				assert ("json_value (r64) is a JSON_NUMBER", False)
			end
		end

	test_json_boolean
		local
			parser: like new_parser
			jb: JSON_BOOLEAN
			b: BOOLEAN
		do
				-- Eiffel value -> JSON value -> JSON representation
			b := True
			create jb.make (b)
			assert ("jb.representation.is_equal (%"true%")", jb.representation.is_equal ("true"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_BOOLEAN} json_value (b) as l_jb then
				assert ("l_jb.representation.same_string (%"true%")", l_jb.representation.same_string ("true"))
			else
				assert ("l_jb /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			parser := new_parser ("true")
			if attached {JSON_BOOLEAN} parser.next_parsed_json_value as l_jb then
				if attached {BOOLEAN} json_object (l_jb, Void) as l_b then
					assert ("l_b = True", l_b = True)
				else
					assert ("json_object (l_jb, Void) is BOOLEAN", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_BOOLEAN", False)
			end

				-- Eiffel value -> JSON value -> JSON representation
			b := False
			create jb.make (b)
			assert ("jb.representation.same_string (%"false%")", jb.representation.same_string ("false"))
				-- Eiffel value -> JSON value  -> JSON representation with factory
			if attached {JSON_BOOLEAN} json_value (b) as l_jb then
				assert ("l_jb.representation.same_string (%"false%")", l_jb.representation.same_string ("false"))
			else
				assert ("json_value (b) is a JSON_BOOLEAN", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			parser := new_parser ("false")
			if attached {JSON_BOOLEAN} parser.next_parsed_json_value as l_jb then
				if attached {BOOLEAN} json_object (l_jb, Void) as l_b then
					assert ("l_b = False", l_b = False)
				else
					assert ("json_object (l_jb, Void) is a BOOLEAN", False)
				end
			else
				assert ("parser.next_parsed_json_value is a JSON_BOOLEAN", False)
			end
		end

	test_json_null
		local
			jrep: STRING
			jn: JSON_NULL
			parser: like new_parser
		do
				-- Eiffel value -> JSON value -> JSON representation
			create jn
			jrep := "null"
			assert ("jn.representation.is_equal (%"%"null%"%")", jn.representation.is_equal (jrep))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_NULL} json_value (Void) as l_json_null then
				assert ("jn.representation.is_equal (%"null%")", l_json_null.representation.is_equal ("null"))
			else
				assert ("json_value (Void) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			parser := new_parser (jrep)
			if attached parser.next_parsed_json_value as l_json_null then
				assert ("a = Void", json_object (l_json_null, Void) = Void)
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_string_and_character
		local
			c: CHARACTER
			jrep: STRING
			js: JSON_STRING
			parser: like new_parser
		do
			c := 'a'
				-- Eiffel value -> JSON value -> JSON representation
			create js.make_from_string (c.out)
			assert ("js.representation.is_equal (%"%"a%"%")", js.representation.is_equal ("%"a%""))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_STRING} json_value (c) as l_json_str then
				assert ("js.representation.is_equal (%"%"a%"%")", l_json_str.representation.is_equal ("%"a%""))
			else
				assert ("json_value (c) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			jrep := "%"a%""
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as l_json_str then
				if attached {STRING_32} json_object (l_json_str, Void) as ucs then
					assert ("ucs.string.is_equal (%"a%")", ucs.string.is_equal ("a"))
				end
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_string_and_string
		local
			s: STRING
			js: detachable JSON_STRING
			jrep: STRING
			parser: like new_parser
		do
			s := "foobar"
			jrep := "%"foobar%""

				-- Eiffel value -> JSON value -> JSON representation
			create js.make_from_string (s)
			assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal (jrep))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_STRING} json_value (s) as l_js then
				assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal (jrep))
			else
				assert ("json_value (s) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as l_js then
				if attached {STRING_32} json_object (l_js, Void) as l_ucs then
					assert ("ucs.string.is_equal (%"foo/bar%")", l_ucs.string.is_equal (s))
				end
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_string_and_slashes
		local
			s: STRING
			js: detachable JSON_STRING
			jrep: STRING
			parser: like new_parser
		do
			s := "foo/bar"
			jrep := "%"foo/bar%""

				-- Eiffel value -> JSON value -> JSON representation
			create js.make_from_string (s)
			assert ("js.representation.is_equal (%"%"foo/bar%"%")", js.representation.is_equal (jrep))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_STRING} json_value (s) as l_js then
				assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal (jrep))
			else
				assert ("json_value (s) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as l_js then
				if attached {STRING_32} json_object (l_js, Void) as l_ucs then
					assert ("ucs.string.is_equal (%"foo/bar%")", l_ucs.string.is_equal (s))
				end
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end

				-- JSON representation with escaped slash -> JSON value -> Eiffel value
			jrep := "%"foo\/bar%""
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as l_js2 then
				if attached {STRING_32} json_object (l_js2, Void) as l_ucs2 then
					assert ("ucs.string.is_equal (%"foo/bar%")", l_ucs2.string.is_equal (s))
				end
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_string_and_escaped_slashes
		local
			s: STRING
			jrep: STRING
			parser: like new_parser
		do
			s := "foo/bar"

				-- JSON representation with escaped slash -> JSON value -> Eiffel value
			jrep := "%"foo\/bar%""
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as l_js2 then
				assert ("l_js2.unesc.is_equal (%"foo/bar%")", l_js2.unescaped_string_32.same_string_general (s))
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_string_and_uc_string
		local
			js: detachable JSON_STRING
			ucs: detachable STRING_32
			jrep, s: STRING
			parser: like new_parser
		do
			s := "foobar"
			jrep := "%"foobar%""
			create ucs.make_from_string (s)

				-- Eiffel value -> JSON value -> JSON representation
			create js.make_from_string_general (ucs)
			assert ("js.representation.is_equal (%"%"foobar%"%")", js.representation.is_equal (jrep))

				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_STRING} json_value (ucs) as l_js then
				assert ("js.representation.is_equal (%"%"foobar%"%")", l_js.representation.is_equal (jrep))
			else
				assert ("json_value (ucs) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as l_js then
				if attached {STRING_32} json_object (l_js, Void) as l_ucs then
					assert ("ucs.string.is_equal (%"foobar%")", l_ucs.string.is_equal (s))
				else
					assert ("json_object (js, Void) /= Void", False)
				end
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_string_8_and_unicode
		local
			js: detachable JSON_STRING
			jrep, s: STRING
		do
			s := "begin \u003e end"
			jrep := "begin > end"
			create js.make_from_escaped_json_string (s)
			assert ("js.unescaped_string_8.same_string (" + jrep + ")", js.unescaped_string_8.same_string (jrep))
			assert ("js.unescaped_string_32.same_string_general (" + jrep + ")", js.unescaped_string_32.same_string_general (jrep))

			s := "begin \u003e"
			jrep := "begin >"
			create js.make_from_escaped_json_string (s)
			assert ("js.unescaped_string_8.same_string (" + jrep + ")", js.unescaped_string_8.same_string (jrep))
			assert ("js.unescaped_string_32.same_string_general (" + jrep + ")", js.unescaped_string_32.same_string_general (jrep))

			s := "\u003e end"
			jrep := "> end"
			create js.make_from_escaped_json_string (s)
			assert ("js.unescaped_string_8.same_string (" + jrep + ")", js.unescaped_string_8.same_string (jrep))
			assert ("js.unescaped_string_32.same_string_general (" + jrep + ")", js.unescaped_string_32.same_string_general (jrep))

			s := "\u003e\u003e\u003e"
			jrep := ">>>"
			create js.make_from_escaped_json_string (s)
			assert ("js.unescaped_string_8.same_string (" + jrep + ")", js.unescaped_string_8.same_string (jrep))
			assert ("js.unescaped_string_32.same_string_general (" + jrep + ")", js.unescaped_string_32.same_string_general (jrep))

			s := "bad unicode \u003"
			jrep := "bad unicode \u003"
			create js.make_from_escaped_json_string (s)
			assert ("bad unicode js.unescaped_string_8.same_string (" + jrep + ")", js.unescaped_string_8.same_string (jrep))
			assert ("bad unicode js.unescaped_string_32.same_string_general (" + jrep + ")", js.unescaped_string_32.same_string_general (jrep))

			s := "test \u2639 :( "
			jrep := "test \u2639 :( "
			create js.make_from_escaped_json_string (s)
			assert ("non char8 unicode js.unescaped_string_8.same_string (" + jrep + ")", js.unescaped_string_8.same_string (jrep))
			assert ("non char8 unicode js.unescaped_string_32.same_string_general (...)", js.unescaped_string_32.same_string_general ({STRING_32} "test %/9785/ :( "))

		end

	test_json_string_and_special_characters
		local
			js: detachable JSON_STRING
			s: detachable STRING_8
			jrep: STRING
			parser: like new_parser
		do
			jrep := "%"foo\\bar%""
			create s.make_from_string ("foo\bar")
			create js.make_from_string (s)
			assert ("js.representation.same_string (%"%"foo\\bar%"%")", js.representation.same_string (jrep))

				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_STRING} json_value (s) as l_js then
				assert ("js.representation.is_equal (%"%"foobar%"%")", l_js.representation.same_string (jrep))
			else
				assert ("json_value (s) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as l_js then
				if attached {STRING_32} json_object (l_js, Void) as l_ucs then
					assert ("ucs.same_string (%"foo\bar%")", l_ucs.same_string ("foo\bar"))
				end
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
			jrep := "%"foo\\bar%""
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as jstring then
				assert ("unescaped string %"foo\\bar%" to %"foo\bar%"", jstring.unescaped_string_8.same_string ("foo\bar"))
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
			create js.make_from_string_32 ({STRING_32} "你好")
			assert ("escaping unicode string32 %"%%/20320/%%/22909/%" %"\u4F60\u597D%"", js.item.same_string ("\u4F60\u597D"))
			jrep := "%"\u4F60\u597D%"" --| Ni hao
			parser := new_parser (jrep)
			if attached {JSON_STRING} parser.next_parsed_json_value as jstring then
				assert ("same unicode string32 %"%%/20320/%%/22909/%"", jstring.unescaped_string_32.same_string ({STRING_32} "你好"))
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_string_and_special_characters_2
		local
			js: detachable JSON_STRING
			s,j: STRING
		do
			s := "foo\%Tbar"
			j := "foo\\\tbar"
			create js.make_from_string (s)
			assert ("string %"" + s + "%" to json %"" + j + "%"", js.item.same_string (j))
			create js.make_from_escaped_json_string (js.item)
			assert ("json %"" + j + "%" to string %"" + s + "%"", js.unescaped_string_8.same_string (s))

			j := "foo\%Tbar"
			create js.make_from_escaped_json_string (js.item)
			--| ERROR but accepted as "foo\\\t"
			assert ("json %"" + j + "%" to string %"" + s + "%"", js.unescaped_string_8.same_string (s))


			s := "foo%Tbar"
			j := "foo\tbar"
			create js.make_from_string (s)
			assert ("string %"" + s + "%" to json %"" + j + "%"", js.item.same_string (j))
			create js.make_from_escaped_json_string (js.item)
			assert ("json %"" + j + "%" to string %"" + s + "%"", js.unescaped_string_8.same_string (s))



			s := "tab=%T cr=%R newline=%N backslash=%H slash=/ end"
			j := "tab=\t cr=\r newline=\n backslash=\\ slash=/ end"
			create js.make_from_string (s)
			assert ("string %"" + s + "%" to json %"" + j + "%"", js.item.same_string (j))
			create js.make_from_escaped_json_string (js.item)
			assert ("json %"" + j + "%" to string %"" + s + "%"", js.unescaped_string_8.same_string (s))

			s := "<script>tab=%T cr=%R newline=%N backslash=%H slash=/ end</script>"
			j := "<script>tab=\t cr=\r newline=\n backslash=\\ slash=/ end<\/script>"
			create js.make_from_string (s)
			assert ("string %"" + s + "%" to json %"" + j + "%"", js.item.same_string (j))
			create js.make_from_escaped_json_string (js.item)
			assert ("json %"" + j + "%" to string %"" + s + "%"", js.unescaped_string_8.same_string (s))

			create js.make_from_escaped_json_string ("tab=\t")
			assert ("js.item.same_string (%"tab=\t%")", js.item.same_string ("tab=\t"))
			create js.make_from_escaped_json_string (js.item)
			assert ("js.item.same_string (%"tab=\t%")", js.item.same_string ("tab=\t"))


					-- <\/script>
			create js.make_from_escaped_json_string ("<script>tab=\t<\/script>")
			assert ("js.item.same_string (%"<script>tab=\t<\/script>%")", js.item.same_string ("<script>tab=\t<\/script>"))
			assert ("js.unescaped_string_8.same_string (%"<script>tab=%%T</script>%")", js.unescaped_string_8.same_string ("<script>tab=%T</script>"))

			create js.make_from_escaped_json_string (js.item)
			assert ("js.item.same_string (%"<script>tab=\t<\/script>%")", js.item.same_string ("<script>tab=\t<\/script>"))
			assert ("js.unescaped_string_8.same_string (%"<script>tab=%%T</script>%")", js.unescaped_string_8.same_string ("<script>tab=%T</script>"))

				-- </script>
			create js.make_from_escaped_json_string ("<script>tab=\t</script>")
			assert ("js.item.same_string (%"<script>tab=\t</script>%")", js.item.same_string ("<script>tab=\t</script>"))
			assert ("js.unescaped_string_8.same_string (%"<script>tab=%%T</script>%")", js.unescaped_string_8.same_string ("<script>tab=%T</script>"))

			create js.make_from_escaped_json_string (js.item)
			assert ("js.item.same_string (%"<script>tab=\t<\/script>%")", js.item.same_string ("<script>tab=\t</script>"))
			assert ("js.unescaped_string_8.same_string (%"<script>tab=%%T</script>%")", js.unescaped_string_8.same_string ("<script>tab=%T</script>"))

		end

	test_json_string_and_null_character
		local
			js: detachable JSON_STRING
			s,j: STRING
		do
			s := "foo%Ubar"
			j := "foo\u0000bar"
			create js.make_from_string (s)
			assert ("string %"" + s + "%" to json %"" + j + "%"", js.item.same_string (j))
			create js.make_from_escaped_json_string (js.item)
			assert ("json %"" + j + "%" to string %"" + s + "%"", js.unescaped_string_8.same_string (s))

			create js.make_from_escaped_json_string (s)
			assert ("json %"" + j + "%" to string %"" + s + "%"", js.unescaped_string_8.same_string (s))

		end

	test_json_array
		local
			ll: LINKED_LIST [INTEGER_8]
			ja: detachable JSON_ARRAY
			jn: JSON_NUMBER
			jrep: STRING
			parser: like new_parser
		do
				-- Eiffel value -> JSON value -> JSON representation
			create ll.make
			ll.extend (0)
			ll.extend (1)
			ll.extend (1)
			ll.extend (2)
			ll.extend (3)
			ll.extend (5)
				-- Note: Currently there is no simple way of creating a JSON_ARRAY
				-- from an LINKED_LIST.
			create ja.make (ll.count)
			from
				ll.start
			until
				ll.after
			loop
				create jn.make_integer (ll.item)
				ja.add (jn)
				ll.forth
			end
			assert ("ja /= Void", ja /= Void)
			assert ("ja.representation.is_equal (%"[0,1,1,2,3,5]%")", ja.representation.is_equal ("[0,1,1,2,3,5]"))
				-- Eiffel value -> JSON value -> JSON representation with factory
			if attached {JSON_ARRAY} json_value (ll) as l_ja then
				assert ("ja.representation.is_equal (%"[0,1,1,2,3,5]%")", l_ja.representation.is_equal ("[0,1,1,2,3,5]"))
			else
				assert ("json_value (ll) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value
				-- Note: The JSON_FACTORY will return the smallest INTEGER_* object
				-- that can represent the value of the JSON number, in this case
				-- it means we will get an LINKED_LIST [ANY] containing the INTEGER_8
				-- values 0, 1, 1, 2, 3, 5
			jrep := "[0,1,1,2,3,5]"
			parser := new_parser (jrep)
			if attached {JSON_ARRAY} parser.next_parsed_json_value as l_ja then
				if attached {LIST [detachable ANY]} json_object (ja, Void) as l_ll2 then
					assert ("same iterable (ll2, ll)", same_iterable (l_ll2, ll))
				else
					assert ("json_object (ja, Void) /= Void", False)
				end
			else
				assert ("parser.next_parsed_json_value /= Void", False)
			end
		end

	test_json_object
		local
			t: detachable STRING_TABLE [detachable ANY]
			i: INTEGER
			ucs_key, ucs: STRING_32
			a: ARRAY [INTEGER]
			jo: detachable JSON_OBJECT
			jn: JSON_NUMBER
			js_key, js: JSON_STRING
			ja: JSON_ARRAY
			jrep: STRING
			parser: like new_parser
		do
				-- Eiffel value -> JSON value -> JSON representation
				-- Note: Currently there is now way of creating a JSON_OBJECT from
				-- a HASH_TABLE, so we do it manually.
				-- t = {"name": "foobar", "size": 42, "contents", [0, 1, 1, 2, 3, 5]}
			create jo.make
			create js_key.make_from_string ("name")
			create js.make_from_string ("foobar")
			jo.put (js, js_key)
			create js_key.make_from_string ("size")
			create jn.make_integer (42)
			jo.put (jn, js_key)
			create js_key.make_from_string ("contents")
			create ja.make (6)
			create jn.make_integer (0)
			ja.add (jn)
			create jn.make_integer (1)
			ja.add (jn)
			create jn.make_integer (1)
			ja.add (jn)
			create jn.make_integer (2)
			ja.add (jn)
			create jn.make_integer (3)
			ja.add (jn)
			create jn.make_integer (5)
			ja.add (jn)
			jo.put (ja, js_key)
			assert ("jo /= Void", jo /= Void)
			assert ("jo.representation.is_equal (%"{%"name%":%"foobar%",%"size%":42,%"contents%":[0,1,1,2,3,5]}%")", jo.representation.is_equal ("{%"name%":%"foobar%",%"size%":42,%"contents%":[0,1,1,2,3,5]}"))

				-- Eiffel value -> JSON value -> JSON representation with factory
			create t.make (3)
			create ucs_key.make_from_string ("name")
			create ucs.make_from_string ("foobar")
			t.put (ucs, ucs_key)
			create ucs_key.make_from_string ("size")
			i := 42
			t.put (i, ucs_key)
			create ucs_key.make_from_string ("contents")
			a := <<0, 1, 1, 2, 3, 5>>
			t.put (a, ucs_key)
			if attached {JSON_OBJECT} json_value (t) as l_jo then
				assert ("jo.representation.is_equal (%"{%"name%":%"foobar%",%"size%":42,%"contents%":[0,1,1,2,3,5]}%")", l_jo.representation.is_equal ("{%"name%":%"foobar%",%"size%":42,%"contents%":[0,1,1,2,3,5]}"))
			else
				assert ("json_value (t) /= Void", False)
			end

				-- JSON representation -> JSON value -> Eiffel value -> JSON value -> JSON representation
			jrep := "{%"name%":%"foobar%",%"size%":42,%"contents%":[0,1,1,2,3,5]}"
			parser := new_parser (jrep)
			if attached {JSON_OBJECT} parser.next_parsed_json_value as l_jo then
				if attached {HASH_TABLE [detachable ANY, READABLE_STRING_GENERAL]} json_object (l_jo, Void) as l_t2 then
					if attached json_value (l_t2) as l_jo_2 then
						assert ("jrep.is_equal (jo.representation)", jrep.is_equal (l_jo_2.representation))
					else
						assert ("json_value (t2) /= Void", False)
					end
				else
					assert ("json_object (jo, Void) /= Void", False)
				end
			else
				assert ("parser.next_parsed_json_value /= Void", jo /= Void)
			end
		end

	test_json_chained_item
		local
			j: STRING
			parser: like new_parser
		do
				-- Eiffel value -> JSON value -> JSON representation
				-- Note: Currently there is now way of creating a JSON_OBJECT from
				-- a HASH_TABLE, so we do it manually.
				-- t = {"name": "foobar", "size": 42, "contents", [0, 1, 1, 2, 3, 5]}

			j := "[
						{
							"name": "John Smith",
							"address": {
								"zip": 10001,
								"city": "New York"
							},
							"notes": [
								{
									"title": "First note",
									"text": "1st"
								},
								{
									"title": "Second note",
									"text": "2nd"
								}									
							]
						}
			]"
			parser := new_parser (j)
			parser.parse_content
			assert ("parsing ok", parser.is_parsed and parser.is_valid)
			if attached parser.parsed_json_value as j_value then
				assert("name", (j_value / "name").same_string ("John Smith"))
				assert("zip is number", (j_value / "address" / "zip").is_number)
				assert("zip", (j_value / "address" / "zip").representation.same_string ("10001"))
				assert("notes / 2 / title", (j_value / "notes" / "2" / "title").same_caseless_string ("second note"))
				assert("notes / 2 / text", (j_value / "notes" / "2" / "text").same_string ("2nd"))
			end
		end

	test_json_object_hash_code
		local
			ht: HASH_TABLE [ANY, JSON_VALUE]
			jo: JSON_OBJECT
		do
			create ht.make (1)
			create jo.make
			ht.force ("", jo)
			assert ("ht.has_key (jo)", ht.has_key (jo))
		end

feature {NONE} -- Serialization

	json_value (obj: detachable ANY): detachable JSON_VALUE
		local
			conv: JSON_BASIC_SERIALIZATION
		do
			create conv.make
			Result := conv.to_json (obj)
		end

	json_object (j: detachable JSON_VALUE; a_base_class: detachable READABLE_STRING_GENERAL): detachable ANY
		local
			conv: JSON_BASIC_SERIALIZATION
		do
			create conv.make
			Result := conv.from_json (j)
		end

	same_iterable (i1, i2: ITERABLE [detachable ANY]): BOOLEAN
		local
			c1, c2: ITERATION_CURSOR [detachable ANY]
		do
			c1 := i1.new_cursor
			c2 := i2.new_cursor
			from
				Result := True
			until
				not Result and c1.after or c2.after
			loop
				Result := c1.item ~ c2.item
				c1.forth
				c2.forth
			end
			if not (c1.after and c2.after) then
				Result := False
			end
		end

end -- class TEST_JSON_CORE
