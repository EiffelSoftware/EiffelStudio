note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STRING_ITERATOR

inherit
	EQA_TEST_SET

feature -- Test string iteration cursor

	test_string_general_cursor_32
		local
			l_string_32: STRING_32
			l_cursor: STRING_ITERATION_CURSOR
			l_new_string: STRING_32
		do
			l_string_32 := {STRING_32} "Testing string general cursor"
			create l_cursor.make (l_string_32)
			create l_new_string.make_empty
			⟳ c: l_cursor ¦ l_new_string.append_character (c) ⟲
			assert ("Same String", l_string_32.same_string (l_new_string))
		end

	test_substring_general_cursor_32
		local
			l_string_32: STRING_32
			l_cursor: STRING_ITERATION_CURSOR
			l_new_string: STRING_32
		do
			l_string_32 := {STRING_32} "Testing string general cursor"
			create l_cursor.make_from_substring (l_string_32, 9, 9 + 5)
			create l_new_string.make_empty
			⟳ c: l_cursor ¦ l_new_string.append_character (c) ⟲
			assert ("Same String", l_string_32.substring (9, 9 + 5).same_string (l_new_string))
		end

	test_string_general_cursor_8
		local
			l_string_8: STRING_8
			l_cursor: STRING_ITERATION_CURSOR
			l_new_string: STRING_8
		do
			l_string_8 := {STRING_8} "Testing string general cursor"
			create l_cursor.make (l_string_8)
			create l_new_string.make_empty
			⟳ c: l_cursor ¦ l_new_string.append_character (c.to_character_8) ⟲
			assert ("Same String", l_string_8.same_string (l_new_string))
		end

	test_substring_general_cursor_8
		local
			l_string: STRING_8
			l_cursor: STRING_ITERATION_CURSOR
			l_new_string: STRING_8
		do
			l_string := {STRING_8} "Testing string general cursor"
			create l_cursor.make_from_substring (l_string, 9, 9 + 5)
			create l_new_string.make_empty
			⟳ c: l_cursor ¦ l_new_string.append_character (c.to_character_8) ⟲
			assert ("Same String", l_string.substring (9, 9 + 5).same_string (l_new_string))
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
