note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	testing:  "covers/{DIFF}"

class
	DIFF_TESTS

inherit
	EQA_TEST_SET

feature {NONE} -- Access

	frozen diff: !DIFF_TEXT
			--
		once
			create Result
		end

feature -- Test routines

	test_values_set
			-- Check values have been set.
		do
			diff.set_text (text, text_insert_1)
			assert ("Values set", diff.values_set)
		end

	test_patching
		local
			l_patch: STRING
		do
			diff.set_text (text, text_insert_1)
			assert ("Values set", diff.values_set)

			diff.compute_diff

			l_patch := diff.unified
			assert ("None empty patch", not l_patch.is_empty)
		end

feature {NONE} -- Query



feature {NONE} -- Constants

	text: !STRING =
		"Test line 1%
		%Test line 2%
		%Test line 3"

	text_insert_1: !STRING =
		"Test line 1%
		%Inserted line 1%
		%Test line 2%
		%Test line 3"

	text_insert_2: !STRING =
		"Test line 1%
		%Test line 2%
		%Inserted line 2%
		%Test line 3"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


