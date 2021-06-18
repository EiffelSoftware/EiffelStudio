note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ADJUST_STRING

inherit

	EQA_TEST_SET

feature -- Test routines adjust string_8

	test_postcondition
		local
			l_string_8: STRING_8
			l_old_string_8: STRING_8
		do
			l_string_8 := "      string adjust nothing   "
			l_old_string_8 := l_string_8.twin
			l_string_8.adjust
			check
				only_spaces_removed_before: ∀ c: (l_old_string_8).substring (1, (l_old_string_8).substring_index (l_string_8, 1) - 1) ¦ c.is_space
				only_spaces_removed_after: ∀ c: (l_old_string_8).substring ((l_old_string_8).substring_index (l_string_8, 1) + l_string_8.count, l_old_string_8.count) ¦ c.is_space
			end
			assert ("Expected True", not l_string_8.same_string (l_old_string_8))
			assert ("Expected True", l_string_8.same_string ("string adjust nothing"))
		end

	test_adjust_nothing_8
		local
			l_string_8: STRING_8
			l_old_string_8: STRING_8
		do
			l_string_8 := "string adjust nothing"
			l_old_string_8 := l_string_8.twin
			l_old_string_8.adjust
			assert ("Expected True", l_string_8.same_string (l_old_string_8))
		end

	test_adjust_one_left_one_right_8
		local
			l_string_8: STRING_8
			l_old_string_8: STRING_8
		do
			l_string_8 := " string adjust nothing "
			l_old_string_8 := l_string_8.twin
			l_string_8.adjust
			assert ("Expected True", not l_string_8.same_string (l_old_string_8))
			assert ("Expected True", l_string_8.same_string ("string adjust nothing"))
		end

	test_adjust_left_and_right_8
		local
			l_string_8: STRING_8
			l_old_string_8: STRING_8
		do
			l_string_8 := "      string adjust nothing   "
			l_old_string_8 := l_string_8.twin
			l_string_8.adjust
			assert ("Expected True", not l_string_8.same_string (l_old_string_8))
			assert ("Expected True", l_string_8.same_string ("string adjust nothing"))
		end

feature -- Test routines adjust string_32

	test_adjust_nothing_32
		local
			l_string_32: STRING_32
			l_old_string_32: STRING_32
		do
			l_string_32 := "string adjust nothing"
			l_old_string_32 := l_string_32.twin
			l_old_string_32.adjust
			assert ("Expected True", l_string_32.same_string (l_old_string_32))
		end

	test_adjust_one_left_one_right_32
		local
			l_string_32: STRING_32
			l_old_string_32: STRING_32
		do
			l_string_32 := " string adjust nothing "
			l_old_string_32 := l_string_32.twin
			l_string_32.adjust
			assert ("Expected True", not l_string_32.same_string (l_old_string_32))
			assert ("Expected True", l_string_32.same_string ("string adjust nothing"))
		end

	test_adjust_left_and_right_32
		local
			l_string_32: STRING_32
			l_old_string_32: STRING_32
		do
			l_string_32 := "      string adjust nothing   "
			l_old_string_32 := l_string_32.twin
			l_string_32.adjust
			assert ("Expected True", not l_string_32.same_string (l_old_string_32))
			assert ("Expected True", l_string_32.same_string ("string adjust nothing"))
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
