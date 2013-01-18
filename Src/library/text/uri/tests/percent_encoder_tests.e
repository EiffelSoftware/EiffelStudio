note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PERCENT_ENCODER_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_encoding
			-- New test routine
		local
			uri: URI
			s: READABLE_STRING_GENERAL
			r32, s32: STRING_32
			r8, s8: STRING_8
			utf: UTF_CONVERTER
		do
			create uri.make_from_string ("a:b")
			s32 := {STRING_32} "foo=海&bar=海"
			s8  := utf.utf_32_string_to_utf_8_string_8 (s32)

			s := s32
			create r8.make_empty
			create r32.make_empty
			uri.append_www_form_urlencoded_string_to (s, r8)
			uri.append_www_form_urlencoded_string_to (s, r32)

			assert ("same string", r8.same_string_general (r32))

			s := r8
			create r8.make_empty
			create r32.make_empty
			uri.append_decoded_www_form_urlencoded_string_to (s, r8)
			uri.append_decoded_www_form_urlencoded_string_to (s, r32)

			assert ("s32 roundtrip", r32.same_string (s32))
			assert ("s8 roundtrip with UTF-8", r8.same_string (s8))

		end


end


