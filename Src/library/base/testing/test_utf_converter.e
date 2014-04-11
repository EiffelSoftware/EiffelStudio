note
	description: "Testing of various conversion of the UTF_CONVERTER class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_UTF_CONVERTER

inherit
	EQA_TEST_SET

feature -- Testing

	test_invalid_utf_8
			-- Test whenever we have an escape character if roundtrip works properly or not.
		local
			l_str8: STRING_8
			l_str32: STRING_32
			l_expected: STRING_32
			u: UTF_CONVERTER
		do
			create l_str8.make (10)
			l_str8.append_character ('%/0x8F/')
			l_str8.append_character ('%/0x8F/')

			create l_expected.make (6)
			l_expected.append_character ({UTF_CONVERTER}.escape_character)
			l_expected.append ("8F")
			l_expected.append_character ({UTF_CONVERTER}.escape_character)
			l_expected.append ("8F")

			l_str32 := u.utf_8_string_8_to_escaped_string_32 (l_str8)

			assert ("test_invalid_utf_8", l_str32 ~ l_expected)
		end

	test_invalid_utf_16
			-- Test whenever we have an escape character if roundtrip works properly or not.
		local
			l_ptr: MANAGED_POINTER
			l_str32: STRING_32
			l_expected: STRING_32
			u: UTF_CONVERTER
		do
			create l_ptr.make (6)
			l_ptr.put_natural_16 (0xDC00, 0)
			l_ptr.put_natural_16 (0xDC00, 2)
			l_ptr.put_natural_16 (0x0, 4)

			create l_expected.make (6)
			l_expected.append_character ({UTF_CONVERTER}.escape_character)
			l_expected.append ("uDC00")
			l_expected.append_character ({UTF_CONVERTER}.escape_character)
			l_expected.append ("uDC00")

			l_str32 := u.utf_16_0_subpointer_to_escaped_string_32 (l_ptr, 0, 2, True)
			assert ("test_invalid_utf_16 - 1", l_str32 ~ l_expected)

				-- Slight variation, we replace the second 0xDC00 by 0xD800
			l_ptr.put_natural_16 (0xD800, 2)
			l_expected.put ('8', 10)

			l_str32 := u.utf_16_0_subpointer_to_escaped_string_32 (l_ptr, 0, 2, True)
			assert ("test_invalid_utf_16 - 2", l_str32 ~ l_expected)

				-- Mixed valid and invalid content
			create l_ptr.make (14)
			l_ptr.put_natural_16 (0xD800, 0)
			l_ptr.put_natural_16 (97, 2)
			l_ptr.put_natural_16 (0xDBFF, 4)
			l_ptr.put_natural_16 (98, 6)
			l_ptr.put_natural_16 (0xD800, 8)
			l_ptr.put_natural_16 (0xDC00, 10)
			l_ptr.put_natural_16 (0, 12)

			create l_expected.make (15)
			l_expected.append_character ({UTF_CONVERTER}.escape_character)
			l_expected.append ("uD800a")
			l_expected.append_character ({UTF_CONVERTER}.escape_character)
			l_expected.append ("uDBFFb")
			l_expected.append_character ('%/0x10000/')

			l_str32 := u.utf_16_0_subpointer_to_escaped_string_32 (l_ptr, 0, 6, True)
			assert ("test_invalid_utf_16", l_str32 ~ l_expected)
		end

	test_utf_16_with_escape_character
			-- Case where UTF-16 stream contains some escaped characters.
			-- It should not prevent any roundtrip between the UTF-32 representation
			-- and the UTF-16 one.
		local
			l_ptr: MANAGED_POINTER
			l_str32: STRING_32
			l_expected: STRING_32
			u: UTF_CONVERTER
			l_spec: SPECIAL [NATURAL_16]
		do
			create l_ptr.make (6)
			l_ptr.put_natural_16 (0xFFFD, 0)
			l_ptr.put_natural_16 (97, 2)
			l_ptr.put_natural_16 (0, 4)

			create l_expected.make (6)
			l_expected.append_character ({UTF_CONVERTER}.escape_character)
			l_expected.append ("a")

				-- Reading with or without escape should produce the same result.
			l_str32 := u.utf_16_0_subpointer_to_string_32 (l_ptr, 0, 2, True)
			assert ("test_utf_16_with_escape - 1", l_str32 ~ l_expected)
			l_str32 := u.utf_16_0_subpointer_to_escaped_string_32 (l_ptr, 0, 2, True)
			assert ("test_utf_16_with_escape - 2", l_str32 ~ l_expected)

				-- Converting the UTF-32 as with or without escaping should
				-- produce the same original UTF-16.
			l_spec := u.utf_32_string_to_utf_16 (l_str32)
			assert ("test_utf_16_with_escape - 3", l_spec.count = 2 and then l_spec.item (0) = 0xFFFD and then l_spec.item (1) = 97)
			u.escaped_utf_32_substring_into_utf_16_0_pointer (l_str32, 1, 2, l_ptr, 0, Void)
			assert ("test_utf_16_with_escape - 3", l_ptr.count = 6 and then l_ptr.read_natural_16 (0) = 0xFFFD and then l_ptr.read_natural_16 (2) = 97)
		end
note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
