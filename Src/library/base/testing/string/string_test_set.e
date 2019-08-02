note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	STRING_TEST_SET

inherit
	EQA_TEST_SET


feature -- Eweasel compatible

	check_boolean (m: READABLE_STRING_GENERAL; cond: BOOLEAN)
		do
			assert_32 (m, cond)
		end

feature -- Test routines

	test_same_characters_on_immutable_string_8
		local
			s: IMMUTABLE_STRING_8
			o: IMMUTABLE_STRING_8
		do
			s := "12345"
			o := "234"
			check_boolean ("same_characters", s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", o.same_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_characters", not s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", not o.same_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_characters", not s.same_characters (o, 1, 2, 2))
		end

	test_same_characters_on_immutable_string_32
		local
			s: IMMUTABLE_STRING_32
			o: IMMUTABLE_STRING_32
		do
			s := "12345"
			o := "234"
			check_boolean ("same_characters", s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", o.same_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_characters", not s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", not o.same_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_characters", not s.same_characters (o, 1, 2, 2))
		end

	test_same_characters_on_string_8
		local
			s: STRING_8
			o: STRING_8
		do
			s := "12345"
			o := "234"
			check_boolean ("same_characters", s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", o.same_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_characters", not s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", not o.same_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_characters", not s.same_characters (o, 1, 2, 2))
		end

	test_same_characters_on_string_32
		local
			s: STRING_32
			o: STRING_32
		do
			s := "12345"
			o := "234"
			check_boolean ("same_characters", s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", o.same_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_characters", not s.same_characters (o, 1, 3, 2))
			check_boolean ("same_characters", not o.same_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_characters", not s.same_characters (o, 1, 2, 2))
		end

feature -- same_caseless_characters

	test_same_caseless_characters_on_immutable_string_8
		local
			s: IMMUTABLE_STRING_8
			o: IMMUTABLE_STRING_8
		do
			s := "12345"
			o := "234"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", o.same_caseless_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", not o.same_caseless_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 2, 2))
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 2, 3))
		end

	test_same_caseless_characters_on_immutable_string_32
		local
			s: IMMUTABLE_STRING_32
			o: IMMUTABLE_STRING_32
		do
			s := "12345"
			o := "234"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", o.same_caseless_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", not o.same_caseless_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 2, 2))
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 2, 3))
		end

	test_same_caseless_characters_on_string_8
		local
			s: STRING_8
			o: STRING_8
		do
			s := "12345"
			o := "234"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", o.same_caseless_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", not o.same_caseless_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 2, 2))
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 2, 3))
		end

	test_same_caseless_characters_on_string_32
		local
			s: STRING_32
			o: STRING_32
		do
			s := "12345"
			o := "234"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", o.same_caseless_characters (s, 2, 4, 1))
			o := "432"
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 3, 2))
			check_boolean ("same_caseless_characters", not o.same_caseless_characters (s, 2, 4, 1))

			s := "abcdef"
			o := "BCD"
			check_boolean ("same_caseless_characters", s.same_caseless_characters (o, 1, 2, 2))
			check_boolean ("same_caseless_characters", not s.same_caseless_characters (o, 1, 2, 3))
		end

feature -- autotests				


	test_same_substring
			-- New test routine
		local
			s8: READABLE_STRING_8
			s8g, s32g: READABLE_STRING_GENERAL
			s32: READABLE_STRING_32
			i,j: INTEGER
			n: INTEGER
		do
			s8 := "1234567890"
			n := s8.count
			s8g := s8
			s32 := s8.to_string_32
			s32g := s32

			i := 3
			j := 5
			check_same_substring_result_on_string_general (i,j, s8g)
			check_same_substring_result_on_string_general (i,j, s32g)
			check_same_substring_result_on_string_8 (i,j, s8)
			check_same_substring_result_on_string_32 (i,j, s32)

			i := 3
			j := n
			check_same_substring_result_on_string_general (i,j, s8g)
			check_same_substring_result_on_string_general (i,j, s32g)
			check_same_substring_result_on_string_8 (i,j, s8)
			check_same_substring_result_on_string_32 (i,j, s32)

			i := 1
			j := n
			check_same_substring_result_on_string_general (i,j, s8g)
			check_same_substring_result_on_string_general (i,j, s32g)
			check_same_substring_result_on_string_8 (i,j, s8)
			check_same_substring_result_on_string_32 (i,j, s32)

--			i := 0
--			j := 5
--			check_same_substring_result_on_string_general (i,j, s8g)
--			check_same_substring_result_on_string_general (i,j, s32g)
--			check_same_substring_result_on_string_8 (i,j, s8)
--			check_same_substring_result_on_string_32 (i,j, s32)

--			i := 1
--			j := 50
--			check_same_substring_result_on_string_general (i,j, s8g)
--			check_same_substring_result_on_string_general (i,j, s32g)
--			check_same_substring_result_on_string_8 (i,j, s8)
--			check_same_substring_result_on_string_32 (i,j, s32)

--			i := 7
--			j := 3
--			check_same_substring_result_on_string_general (i,j, s8g)
--			check_same_substring_result_on_string_general (i,j, s32g)
--			check_same_substring_result_on_string_8 (i,j, s8)
--			check_same_substring_result_on_string_32 (i,j, s32)

			s8 := "A"
			n := s8.count
			s8g := s8
			s32 := s8.to_string_32
			s32g := s32

			i := 1
			j := n
			check_same_substring_result_on_string_general (i,j, s8g)
			check_same_substring_result_on_string_general (i,j, s32g)
			check_same_substring_result_on_string_8 (i,j, s8)
			check_same_substring_result_on_string_32 (i,j, s32)
		end

	test_same_caseless_substring
			-- New test routine
		local
			s8: READABLE_STRING_8
			s8g, s32g: READABLE_STRING_GENERAL
			s32: READABLE_STRING_32
			i,j: INTEGER
			n: INTEGER
		do
			s8 := "abcDEFghiJ"
			n := s8.count
			s8g := s8
			s32 := s8.to_string_32
			s32g := s32

			i := 3
			j := 5
			check_same_caseless_substring_result_on_string_general (i,j, s8g)
			check_same_caseless_substring_result_on_string_general (i,j, s32g)
			check_same_caseless_substring_result_on_string_8 (i,j, s8)
			check_same_caseless_substring_result_on_string_32 (i,j, s32)

			i := 3
			j := n
			check_same_caseless_substring_result_on_string_general (i,j, s8g)
			check_same_caseless_substring_result_on_string_general (i,j, s32g)
			check_same_caseless_substring_result_on_string_8 (i,j, s8)
			check_same_caseless_substring_result_on_string_32 (i,j, s32)

			i := 1
			j := n
			check_same_caseless_substring_result_on_string_general (i,j, s8g)
			check_same_caseless_substring_result_on_string_general (i,j, s32g)
			check_same_caseless_substring_result_on_string_8 (i,j, s8)
			check_same_caseless_substring_result_on_string_32 (i,j, s32)


		end

feature -- Test routines

	test_is_whitespace_on_immutable_string_8
		local
			s: IMMUTABLE_STRING_8
		do
			s := ""
			check_boolean ("is_whitespace", s.is_whitespace)
			s := " "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := "       "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := " %T%R%N%T  %T"
			check_boolean ("is_whitespace", s.is_whitespace)

			s := "."
			check_boolean ("is not whitespace", not s.is_whitespace)
			s := " %T%R%N%T  %T."
			check_boolean ("is not whitespace", not s.is_whitespace)
			s := ".    %T"
			check_boolean ("is not whitespace", not s.is_whitespace)
		end

	test_is_whitespace_on_immutable_string_32_test
		local
			s: IMMUTABLE_STRING_32
		do
			s := {STRING_32} ""
			check_boolean ("is_whitespace", s.is_whitespace)
			s := {STRING_32} " "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := {STRING_32} "       "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := {STRING_32} " %T%R%N%T  %T"
			check_boolean ("is_whitespace", s.is_whitespace)

			s := {STRING_32} "."
			check_boolean ("is not whitespace", not s.is_whitespace)
			s := {STRING_32} " %T%R%N%T  %T."
			check_boolean ("is not whitespace", not s.is_whitespace)
			s := {STRING_32} ".    %T"
			check_boolean ("is not whitespace", not s.is_whitespace)
		end

	test_is_whitespace_on_string_8
		local
			s: STRING_8
		do
			s := ""
			check_boolean ("is_whitespace", s.is_whitespace)
			s := " "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := "       "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := " %T%R%N%T  %T"
			check_boolean ("is_whitespace", s.is_whitespace)


			s := "."
			check_boolean ("is not whitespace", not s.is_whitespace)
			s := " %T%R%N%T  %T."
			check_boolean ("is not whitespace", not s.is_whitespace)
			check_boolean ("substring is whitespace", s.is_substring_whitespace (1, s.count - 1))
			s := ".    %T"
			check_boolean ("is not whitespace", not s.is_whitespace)

			check_boolean ("substring is whitespace", s.is_substring_whitespace (2, s.count))
			check_boolean ("substring is whitespace", s.is_substring_whitespace (1, 0)) -- empty string is whitespace
			check_boolean ("substring is whitespace", s.is_substring_whitespace (2, 1)) -- empty string is whitespace
			check_boolean ("substring is whitespace", s.is_substring_whitespace (s.count + 1, s.count)) -- empty string is whitespace
		end

	test_is_whitespace_on_string_32
		local
			s: STRING_32
		do
			s := {STRING_32} ""
			check_boolean ("is_whitespace", s.is_whitespace)
			s := {STRING_32} " "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := {STRING_32} "       "
			check_boolean ("is_whitespace", s.is_whitespace)
			s := {STRING_32} " %T%R%N%T  %T"
			check_boolean ("is_whitespace", s.is_whitespace)

			s := {STRING_32} "."
			check_boolean ("is not whitespace", not s.is_whitespace)
			s := {STRING_32} " %T%R%N%T  %T."
			check_boolean ("is not whitespace", not s.is_whitespace)
			check_boolean ("substring is whitespace", s.is_substring_whitespace (1, s.count - 1))

			s := {STRING_32} ".    %T"
			check_boolean ("is not whitespace", not s.is_whitespace)

			check_boolean ("substring is whitespace", s.is_substring_whitespace (2, s.count))
			check_boolean ("substring is whitespace", s.is_substring_whitespace (1, 0)) -- empty string is whitespace
			check_boolean ("substring is whitespace", s.is_substring_whitespace (2, 1)) -- empty string is whitespace
			check_boolean ("substring is whitespace", s.is_substring_whitespace (s.count + 1, s.count)) -- empty string is whitespace

			create s.make_empty
			s.append_code (0x0009) -- HT, Horizontal Tab
			s.append_code (0x000A) -- LF, Line feed
			s.append_code (0x000B) -- VT, Vertical Tab
			s.append_code (0x000C) -- FF, Form feed
			s.append_code (0x000D) -- CR, Carriage return
			s.append_code (0x0020) -- SPACE
			s.append_code (0x0085) -- NEL, Next line
			s.append_code (0x00A0) -- NO-BREAK SPACE
			s.append_code (0x1680) -- OGHAM SPACE MARK
			s.append_code (0x2000) -- EN QUAD
			s.append_code (0x2001) -- EM QUAD
			s.append_code (0x2002) -- EN SPACE
			s.append_code (0x2003) -- EM SPACE
			s.append_code (0x2004) -- THREE-PER-EM SPACE
			s.append_code (0x2005) -- FOUR-PER-EM SPACE
			s.append_code (0x2006) -- SIX-PER-EM SPACE
			s.append_code (0x2007) -- FIGURE SPACE
			s.append_code (0x2008) -- PUNCTUATION SPACE
			s.append_code (0x2009) -- THIN SPACE
			s.append_code (0x200A) -- HAIR SPACE
			s.append_code (0x2028) -- LINE SEPARATOR
			s.append_code (0x2029) -- PARAGRAPH SEPARATOR
			s.append_code (0x202F) -- NARROW NO-BREAK SPACE
			s.append_code (0x205F) -- MEDIUM MATHEMATICAL SPACE
			s.append_code (0x3000) -- IDEOGRAPHIC SPACE
			check_boolean ("is unicode whitespace", s.is_whitespace)

			s.append_code (20320)
			s.append_code (22909)
			s.append_code (25827)
			check_boolean ("is not unicode whitespace", not s.is_whitespace)
		end

feature {NONE} -- Implementation			

	check_same_substring_result_on_string_8 (start_index, end_index: INTEGER; s: READABLE_STRING_8)
		local
			t: like s
		do
			t := s.substring (start_index, end_index)
			assert (start_index.out + ":" + end_index.out + " -> %""+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (t) +"%"", t.same_characters (s, start_index, end_index, 1))
		end

	check_same_substring_result_on_string_32 (start_index, end_index: INTEGER; s: READABLE_STRING_32)
		local
			t: like s
		do
			t := s.substring (start_index, end_index)
			assert (start_index.out + ":" + end_index.out + " -> %""+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (t) +"%"", t.same_characters (s, start_index, end_index, 1))
		end

	check_same_substring_result_on_string_general (start_index, end_index: INTEGER; s: READABLE_STRING_GENERAL)
		local
			t: like s
		do
			t := s.substring (start_index, end_index)
			assert (start_index.out + ":" + end_index.out + " -> %""+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (t) +"%"", t.same_characters (s, start_index, end_index, 1))
		end


	check_same_caseless_substring_result_on_string_8 (start_index, end_index: INTEGER; s: READABLE_STRING_8)
		local
			t: like s
		do
			t := s.substring (start_index, end_index).as_upper
			assert (start_index.out + ":" + end_index.out + " -> %""+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (t) +"%"",  t.same_caseless_characters (s, start_index, end_index, 1))
		end

	check_same_caseless_substring_result_on_string_32 (start_index, end_index: INTEGER; s: READABLE_STRING_32)
		local
			t: like s
		do
			t := s.substring (start_index, end_index).as_upper
			assert (start_index.out + ":" + end_index.out + " -> %""+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (t) +"%"",  t.same_caseless_characters (s, start_index, end_index, 1))
		end

	check_same_caseless_substring_result_on_string_general (start_index, end_index: INTEGER; s: READABLE_STRING_GENERAL)
		local
			t: like s
		do
			t := s.substring (start_index, end_index).as_upper
			assert (start_index.out + ":" + end_index.out + " -> %""+ {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (t) +"%"",  t.same_caseless_characters (s, start_index, end_index, 1))
		end

feature -- string_8

	test_is_case_insensitive_equal
		local
			s: STRING_8
		do
			create s.make (10)
			s.append ("12345")
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal (s))
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("12345"))
			check_boolean ("is_case_insensitive_equal", not s.is_case_insensitive_equal ("123456"))
			check_boolean ("is_case_insensitive_equal", not s.is_case_insensitive_equal ("1234"))

			s := "abcdef"
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("ABCDEF"))

			s := "ABCDEF"
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("abcdef"))

			s := "ABCdef"
			check_boolean ("is_case_insensitive_equal", s.is_case_insensitive_equal ("abcDEF"))

			check_boolean ("is_case_insensitive_equal", not s.is_case_insensitive_equal (""))
		end


note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


