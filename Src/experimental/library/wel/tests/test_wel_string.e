note
	description: "Test the conversion from Eiffel strings to Windows UTF-16 strings."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_WEL_STRING

inherit
	WEL_TEST_SET

feature -- Tests

	test_new_line
		local
			str1, str2: STRING_32
			l_wstr: WEL_STRING
		do
			create str1.make (1)
			str1.append_character ('%N')
			create l_wstr.make (str1)

			assert ("Same string - 1", l_wstr.string.same_string (str1))

			create l_wstr.make_with_newline_conversion (str1)
			assert ("Same string - 2", l_wstr.string.same_string ({STRING_32} "%R%N"))
			assert ("Same string - 3", l_wstr.string_discarding_carriage_return.same_string ({STRING_32} "%N"))

				-- We are using Unicode characters that translate to 2 UTF-16 code unit which means
				-- that the WEL_STRING will have to reallocate its C memory properly.
			create str1.make (20)
			str1.append_character ('%/66304/')
			str1.append_character ('%/66304/')
			str1.append_character ('%/66304/')
			str1.append_character ('%/66304/')
			str1.append_character ('%/66304/')
			str1.append ("%N%N")
			create l_wstr.make_with_newline_conversion (str1)

			str2 := str1.twin
			str2.replace_substring_all ("%N", "%R%N")
			assert ("Same string - 4", l_wstr.string.same_string (str2))
			assert ("Same string - 5", l_wstr.string_discarding_carriage_return.same_string (str1))
		end

	test_occurrences
		local
			l_wstr: WEL_STRING
			l_str: STRING_32
		do
			l_str := "ABCDE_ABCDE_XYZ_ABCDE_"

			create l_wstr.make (l_str)

			assert ("Occurrences A", l_wstr.occurrences ('A') = 3)
			assert ("Occurrences B", l_wstr.occurrences ('B') = 3)
			assert ("Occurrences C", l_wstr.occurrences ('C') = 3)
			assert ("Occurrences D", l_wstr.occurrences ('D') = 3)
			assert ("Occurrences E", l_wstr.occurrences ('E') = 3)
			assert ("Occurrences _", l_wstr.occurrences ('_') = 4)
			assert ("Occurrences X", l_wstr.occurrences ('X') = 1)
			assert ("Occurrences Y", l_wstr.occurrences ('Y') = 1)
			assert ("Occurrences Z", l_wstr.occurrences ('Z') = 1)

				-- Let's search for Unicode characters that triggers
				-- a surrogate.
			l_str.prepend_character ('%/0x10DFF/')
			l_str.append_character ('%/0x10B04/')
			l_str.put ('%/0x10B84/', 6)

			create l_wstr.make (l_str)

			assert ("Occurrences A", l_wstr.occurrences ('A') = 3)
			assert ("Occurrences B", l_wstr.occurrences ('B') = 3)
			assert ("Occurrences C", l_wstr.occurrences ('C') = 3)
			assert ("Occurrences D", l_wstr.occurrences ('D') = 3)
			assert ("Occurrences E", l_wstr.occurrences ('E') = 2)
			assert ("Occurrences _", l_wstr.occurrences ('_') = 4)
			assert ("Occurrences X", l_wstr.occurrences ('X') = 1)
			assert ("Occurrences Y", l_wstr.occurrences ('Y') = 1)
			assert ("Occurrences Z", l_wstr.occurrences ('Z') = 1)
			assert ("Ocurrences 0x10DFF", l_wstr.occurrences ('%/0x10DFF/') = 1)
			assert ("Ocurrences 0x10B04", l_wstr.occurrences ('%/0x10B04/') = 1)
			assert ("Ocurrences 0x10B04", l_wstr.occurrences ('%/0x10B84/') = 1)
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
