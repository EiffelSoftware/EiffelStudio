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

	frozen diff: attached DIFF_TEXT
			-- Shared access to DIFF
		once
			create Result
		end

feature -- Test routines

	test_values_set
			-- Ensures the values are set when setting texts.
		do
			diff.set_text (text, text_merge)
			assert ("Values set", diff.values_set)
		end

	test_patch_generation_1
			-- Ensure a patch is generated correctly for insertion.
		note
			testing:  "covers/{DIFF_TEXT}.unified"
		local
			l_patch: STRING
		do
			diff.set_text (text, text_merge)
			assert ("Values set", diff.values_set)

			diff.compute_diff

			l_patch := diff.unified
			assert ("None empty patch", not l_patch.is_empty)
			assert ("Expected patch", l_patch.same_string_general (
				"@@ -2,0 +2 @@%N%
				%+Inserted line 1%N%
				%@@ -3,0 +4 @@%N%
				%+Inserted line 2%N"))
		end

	test_patch_generation_2
			-- Ensure a patch is generated correctly for removal.
		note
			testing:  "covers/{DIFF_TEXT}.unified"
		local
			l_patch: STRING
		do
			diff.set_text (text_merge, text)
			assert ("Values set", diff.values_set)

			diff.compute_diff

			l_patch := diff.unified
			assert ("None empty patch", not l_patch.is_empty)
			assert ("Expected patch", l_patch.same_string_general (
				"@@ -2 +2,0 @@%N%
				%-Inserted line 1%N%
				%@@ -4 +3,0 @@%N%
				%-Inserted line 2%N"))
		end

	test_patch_generation_3
			-- Ensure a patch is generated correctly for insertion and removal.
		note
			testing:  "covers/{DIFF_TEXT}.unified"
		local
			l_patch: STRING
		do
			diff.set_text (text, text_merge_dual)
			assert ("Values set", diff.values_set)

			diff.compute_diff

			l_patch := diff.unified
			assert ("None empty patch", not l_patch.is_empty)
				-- FIXME: This patch may not be correct in light of `test_merge_3' failing.
			assert ("Expected patch", l_patch.same_string_general (
				"@@ -1,2 +1,2 @@%N%
				%-Test line 1%N%
				%-Test line 2%N%
				%+Test line 1 changed%N%
				%+Inserted line 1%N%
				%@@ -4,0 +4,2 @@%N%
				%+Inserted line 2%N%
				%+Inserted line 3%N"))
		end

	test_merge_1
			-- Ensure a patch generated can be applied to produce the original source, for insertion.
		note
			testing:  "covers/{DIFF_TEXT}.unified"
			testing:  "covers/{DIFF_TEXT}.patch"
		local
			l_patch: STRING
			l_text: STRING
		do
			diff.set_text (text, text_merge)
			assert ("Values set", diff.values_set)
			diff.compute_diff
			l_patch := diff.unified
			assert ("None empty patch", not l_patch.is_empty)

			l_text := diff.patch (text, l_patch, False)
			assert ("Merge not empty", not l_text.is_empty)
			assert ("Expected merge", l_text.same_string_general (text_merge))
		end

	test_merge_2
			-- Ensure a patch generated can be applied to produce the original source, for removal.
		note
			testing:  "covers/{DIFF_TEXT}.unified"
			testing:  "covers/{DIFF_TEXT}.patch"
		local
			l_patch: STRING
			l_text: STRING
		do
				-- Create first patch
			diff.set_text (text_merge, text)
			assert ("Values set", diff.values_set)
			diff.compute_diff
			l_patch := diff.unified
			assert ("None empty patch", not l_patch.is_empty)

			l_text := diff.patch (text_merge, l_patch, False)
			assert ("Merge not empty", not l_text.is_empty)
			assert ("Expected merge", l_text.same_string_general (text))
		end

	test_merge_3
			-- Ensure a patch generated can be applied to produce the original source, for insertion, change and removal.
		note
			testing:  "covers/{DIFF_TEXT}.unified"
			testing:  "covers/{DIFF_TEXT}.patch"
		local
			l_patch: STRING
			l_text: STRING
		do
				-- Create first patch
			diff.set_text (text, text_merge_dual)
			assert ("Values set", diff.values_set)
			diff.compute_diff
			l_patch := diff.unified
			assert ("None empty patch", not l_patch.is_empty)

			l_text := diff.patch (text, l_patch, False)
			assert ("Merge not empty", not l_text.is_empty)
				-- FIXME: The following currently fails. See `text_path_generation_3' when working to adjust the patch.
			assert ("Expected merge", l_text.same_string_general (text_merge_dual))
		end

	test_compute_lcs_with_equal_src_and_dst
		note
			testing: "covers/{DIFF}.compute_lcs"
		local
			l_src, l_dst: ARRAY [STRING]
			l_diff: DIFF [STRING]
		do
			create l_src.make_filled (create {STRING}.make_empty, 0, 1)
			l_dst := l_src.deep_twin
			create l_diff
			l_diff.set (l_src, l_dst)
			l_diff.compute_diff
		end

feature {NONE} -- Constants

	text: attached STRING =
		"Test line 1%N%
		%Test line 2%N%
		%Test line 3"

	text_merge: attached STRING =
		"Test line 1%N%
		%Inserted line 1%N%
		%Test line 2%N%
		%Inserted line 2%N%
		%Test line 3"

	text_merge_dual: attached STRING =
		"Test line 1 changed%N%
		%Inserted line 1%N%
		%Test line 3%N%
		%Inserted line 2%N%
		%Inserted line 3"

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


