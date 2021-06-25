note
	description: "[
			Eiffel tests that can be executed by testing tool.
		]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_SORTER_ON_STRINGS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_quick_sort
			-- Test quick sort.
		note
			testing: "sort"
		do
			test_sort_type (quick_type)
		end

	test_shell_sort
			-- Test shell sort.
		note
			testing: "sort"
		do
			test_sort_type (shell_type)
		end

	test_bubble_sort
			-- Test bubble sort.
		note
			testing: "sort"
		do
			test_sort_type (bubble_type)
		end

feature {NONE} -- Implementation

	test_sort_type (kind: INTEGER)
		require
			valid_kind: kind = bubble_type or kind = shell_type or kind = quick_type
		local
			l_list: like new_list
			l_array: ARRAY [READABLE_STRING_GENERAL]
			l_caseless_sorter: like new_caseless_comparable_sorter
			l_sorter: like new_comparable_sorter
		do
			l_sorter := new_comparable_sorter (kind)
			l_caseless_sorter := new_caseless_comparable_sorter (kind)
			if l_sorter /= Void and l_caseless_sorter /= Void then
				l_list := new_list (arrayed_list_type)
				if l_list /= Void then
					l_sorter.sort (l_list)
					assert ("list_sorted", l_sorter.sorted (l_list))
					assert ("is expected order", is_expected_order (l_list, expected_sorted_output))

					l_caseless_sorter.sort (l_list)
					assert ("list_sorted", l_caseless_sorter.sorted (l_list))
					assert ("is expected order", is_expected_order (l_list, expected_sorted_caseless_output))
				else
					assert ("kind of list exists", False)
				end

				l_list := new_list (linked_list_type)
				if l_list /= Void then
					l_sorter.sort (l_list)
					assert ("list_sorted", l_sorter.sorted (l_list))
					assert ("is expected order", is_expected_order (l_list, expected_sorted_output))

					l_caseless_sorter.sort (l_list)
					assert ("list_sorted", l_caseless_sorter.sorted (l_list))
					assert ("is expected order", is_expected_order (l_list, expected_sorted_caseless_output))
				else
					assert ("kind of list exists", False)
				end

				l_array := new_array
				l_sorter.sort (l_array)
				assert ("array_sorted", l_sorter.sorted (l_array))
				assert ("is expected order", is_expected_order (l_array, expected_sorted_output))

				l_caseless_sorter.sort (l_array)
				assert ("array_sorted", l_caseless_sorter.sorted (l_array))
				assert ("is expected order", is_expected_order (l_array, expected_sorted_caseless_output))
			else
				assert ("kind of sorter exists", False)
			end
		end

	is_expected_order (v: ITERABLE [READABLE_STRING_GENERAL]; a_expected: READABLE_STRING_32): BOOLEAN
		local
			s: STRING_32
		do
			create s.make (55)
			across
				v as c
			loop
				s.append_string_general (c)
				s.append_character ('%N')
			end
			Result := s.same_string (a_expected)
		end

	expected_sorted_output: STRING_32
		once
			create Result.make (55)
			Result.append ("CASE")
			Result.append_character ('%N')
			Result.append ("a")
			Result.append_character ('%N')
			Result.append ("bafr")
			Result.append_character ('%N')
			Result.append ("d")
			Result.append_character ('%N')
			Result.append ("foo")
			Result.append_character ('%N')
			Result.append ("m")
			Result.append_character ('%N')
			Result.append ("manu")
			Result.append_character ('%N')
			Result.append ("titi")
			Result.append_character ('%N')
			Result.append ("tutu")
			Result.append_character ('%N')
			Result.append ("z")
			Result.append_character ('%N')
		end

	expected_sorted_caseless_output: STRING_32
		once
			create Result.make (55)
			Result.append ("a")
			Result.append_character ('%N')
			Result.append ("bafr")
			Result.append_character ('%N')
			Result.append ("CASE")
			Result.append_character ('%N')
			Result.append ("d")
			Result.append_character ('%N')
			Result.append ("foo")
			Result.append_character ('%N')
			Result.append ("m")
			Result.append_character ('%N')
			Result.append ("manu")
			Result.append_character ('%N')
			Result.append ("titi")
			Result.append_character ('%N')
			Result.append ("tutu")
			Result.append_character ('%N')
			Result.append ("z")
			Result.append_character ('%N')
		end

	new_list (kind: INTEGER): detachable LIST [READABLE_STRING_GENERAL]
		require
			valid_kind: kind = arrayed_list_type or kind = linked_list_type
		do
			inspect
				kind
			when arrayed_list_type then
				create {ARRAYED_LIST [READABLE_STRING_GENERAL]} Result.make (11)
			when linked_list_type then
				create {LINKED_LIST [READABLE_STRING_GENERAL]} Result.make
			else

			end
			if Result /= Void then
				Result.extend ("titi")
				Result.extend ("tutu")
				Result.extend ("z")
				Result.extend ("a")
				Result.extend ({STRING_32} "m")
				Result.extend ("d")
				Result.extend ("manu")
				Result.extend ({STRING_32} "foo")
				Result.extend ("bafr")
				Result.extend ("CASE")
			end
		end

	new_array: ARRAY [READABLE_STRING_GENERAL]
		do
			create Result.make_filled ("", -3, 6)
			Result.put ("titi", -3)
			Result.put ("tutu", -2)
			Result.put ("z", -1)
			Result.put ("a", 0)
			Result.put ({STRING_32} "m", 1)
			Result.put ("d", 2)
			Result.put ("manu", 3)
			Result.put ({STRING_32} "foo", 4)
			Result.put ("bafr", 5)
			Result.put ("CASE", 6)
		end

	new_comparable_sorter (kind: INTEGER): detachable SORTER [READABLE_STRING_GENERAL]
		require
			valid_kind: kind = bubble_type or kind = shell_type or kind = quick_type
		do
			inspect kind
			when bubble_type then
				create {BUBBLE_SORTER [READABLE_STRING_GENERAL]} Result.make (create {STRING_COMPARATOR}.make)
			when shell_type then
				create {SHELL_SORTER [READABLE_STRING_GENERAL]} Result.make (create {STRING_COMPARATOR}.make)
			when quick_type then
				create {QUICK_SORTER [READABLE_STRING_GENERAL]} Result.make (create {STRING_COMPARATOR}.make)
			else

			end
		end

	new_caseless_comparable_sorter (kind: INTEGER): detachable SORTER [READABLE_STRING_GENERAL]
		require
			valid_kind: kind = bubble_type or kind = shell_type or kind = quick_type
		do
			inspect kind
			when bubble_type then
				create {BUBBLE_SORTER [READABLE_STRING_GENERAL]} Result.make (create {STRING_COMPARATOR}.make_caseless)
			when shell_type then
				create {SHELL_SORTER [READABLE_STRING_GENERAL]} Result.make (create {STRING_COMPARATOR}.make_caseless)
			when quick_type then
				create {QUICK_SORTER [READABLE_STRING_GENERAL]} Result.make (create {STRING_COMPARATOR}.make_caseless)
			else

			end
		end

	arrayed_list_type: INTEGER = 1
	linked_list_type: INTEGER = 2

	bubble_type: INTEGER = 1
	shell_type: INTEGER = 2
	quick_type: INTEGER = 3

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

