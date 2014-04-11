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
