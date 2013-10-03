note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_SORTER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_quick_sort
			-- Test quick sort.
		note
			testing:  "sort"
		do
			test_sort_type (quick_type)
		end

	test_shell_sort
			-- Test shell sort.
		note
			testing:  "sort"
		do
			test_sort_type (shell_type)
		end

	test_bubble_sort
			-- Test bubble sort.
		note
			testing:  "sort"
		do
			test_sort_type (bubble_type)
		end

feature {NONE} -- Implementation

	test_sort_type (kind: INTEGER)
		require
			valid_kind: kind = bubble_type or kind = shell_type or kind = quick_type
		local
			l_list: like new_list
			l_array: ARRAY [STRING]
			l_sorter: like new_comparable_sorter
		do
			l_sorter := new_comparable_sorter (kind)
			if l_sorter /= Void then
				l_list := new_list (arrayed_list_type)
				if l_list /= Void then
					l_sorter.sort (l_list)
					assert ("list_sorted", l_sorter.sorted (l_list))
				else
					assert ("kind of list exists", False)
				end


				l_list := new_list (linked_list_type)
				if l_list /= Void then
					l_sorter.sort (l_list)
					assert ("list_sorted", l_sorter.sorted (l_list))
				else
					assert ("kind of list exists", False)
				end

				l_array := new_array
				l_sorter.sort (l_array)
				assert ("array_sorted", l_sorter.sorted (l_array))
			else
				assert ("valid sorter kind", False)
			end
		end

	new_list (kind: INTEGER): detachable LIST [STRING]
		require
			valid_kind: kind = arrayed_list_type or kind = linked_list_type
		do
			inspect
				kind
			when arrayed_list_type then
				create {ARRAYED_LIST [STRING]} Result.make (10)
			when linked_list_type then
				create {LINKED_LIST [STRING]} Result.make
			else

			end
			if Result /= Void then
				Result.extend ("titi")
				Result.extend ("tutu")
				Result.extend ("z")
				Result.extend ("a")
				Result.extend ("m")
				Result.extend ("d")
				Result.extend ("manu")
				Result.extend ("foo")
				Result.extend ("bafr")
			end
		end

	new_array: ARRAY [STRING]
		do
			create Result.make_filled ("", -3, 5)
			Result.put ("titi", -3)
			Result.put ("tutu", -2)
			Result.put ("z", -1)
			Result.put ("a", 0)
			Result.put ("m", 1)
			Result.put ("d", 2)
			Result.put ("manu", 3)
			Result.put ("foo", 4)
			Result.put ("bafr", 5)
		end

	new_comparable_sorter (kind: INTEGER): detachable SORTER [STRING]
		require
			valid_kind: kind = bubble_type or kind = shell_type or kind = quick_type
		do
			inspect kind
			when bubble_type then
				create {BUBBLE_SORTER [STRING]} Result.make (create {COMPARABLE_COMPARATOR [STRING]})
			when shell_type then
				create {SHELL_SORTER [STRING]} Result.make (create {COMPARABLE_COMPARATOR [STRING]})
			when quick_type then
				create {QUICK_SORTER [STRING]} Result.make (create {COMPARABLE_COMPARATOR [STRING]})
			else
			end
		end

	arrayed_list_type: INTEGER = 1
	linked_list_type: INTEGER = 2

	bubble_type: INTEGER = 1
	shell_type: INTEGER = 2
	quick_type: INTEGER = 3

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


