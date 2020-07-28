note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TOPOLOGICAL_SORTER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_topological_sorter_no_cycles_fifo
		local
			l_topo_sorter: TOPOLOGICAL_SORTER [STRING]
			sorted: LIST [STRING]
		do
			create l_topo_sorter.make
			l_topo_sorter.record_constraint ("Map", "Louvre")
			l_topo_sorter.record_constraint ("Map", "Orsay")
			l_topo_sorter.record_constraint ("Pass", "Louvre")
			l_topo_sorter.record_constraint ("Pass", "Orsay")
			l_topo_sorter.record_constraint ("Money", "Pass")

				-- Check has_element
			assert ("has element Louvre", l_topo_sorter.has_element ("Louvre"))
			assert ("not has element Rodin", not l_topo_sorter.has_element ("Rodin"))

			l_topo_sorter.process

			assert ("done", l_topo_sorter.done)
			assert ("no cycles", not l_topo_sorter.cycle_found)
			assert ("cycle_list empty", l_topo_sorter.cycle_list.is_empty)

		    sorted := l_topo_sorter.sorted_elements
          	sorted.compare_objects
          	assert ("Has possible topological sort", sorted.is_equal (topo_sort_1) or else sorted.is_equal (topo_sort_2) or else sorted.is_equal (topo_sort_3) or else sorted.is_equal (topo_sort_4) or else sorted.is_equal (topo_sort_5) or else sorted.is_equal (topo_sort_6))
		end


	test_topological_sorter_no_cycles_lifo
		local
			l_topo_sorter: TOPOLOGICAL_SORTER [STRING]
			sorted: LIST [STRING]
		do
			create l_topo_sorter.make
			l_topo_sorter.use_lifo_output
			l_topo_sorter.record_constraint ("Map", "Louvre")
			l_topo_sorter.record_constraint ("Map", "Orsay")
			l_topo_sorter.record_constraint ("Pass", "Louvre")
			l_topo_sorter.record_constraint ("Pass", "Orsay")
			l_topo_sorter.record_constraint ("Money", "Pass")

				-- Check has_element
			assert ("has element Louvre", l_topo_sorter.has_element ("Louvre"))
			assert ("not has element Rodin", not l_topo_sorter.has_element ("Rodin"))

			l_topo_sorter.process

			assert ("done", l_topo_sorter.done)
			assert ("no cycles", not l_topo_sorter.cycle_found)
			assert ("cycle_list empty", l_topo_sorter.cycle_list.is_empty)

		    sorted := l_topo_sorter.sorted_elements
          	sorted.compare_objects
          	assert ("Has possible topological sort", sorted.is_equal (topo_sort_1) or else sorted.is_equal (topo_sort_2) or else sorted.is_equal (topo_sort_3) or else sorted.is_equal (topo_sort_4) or else sorted.is_equal (topo_sort_5) or else sorted.is_equal (topo_sort_6))
		end


	test_topological_sorter_cycles
		local
			l_topo_sorter: TOPOLOGICAL_SORTER [STRING]
		do
			create l_topo_sorter.make
			l_topo_sorter.use_lifo_output
			l_topo_sorter.record_constraint ("Map", "Louvre")
			l_topo_sorter.record_constraint ("Map", "Orsay")
			l_topo_sorter.record_constraint ("Pass", "Louvre")
			l_topo_sorter.record_constraint ("Pass", "Orsay")
			l_topo_sorter.record_constraint ("Money", "Pass")

				-- Adding a cycle.
			l_topo_sorter.record_constraint ("Orsay", "Money")

				-- Check has_element
			assert ("has element Louvre", l_topo_sorter.has_element ("Louvre"))
			assert ("not has element Rodin", not l_topo_sorter.has_element ("Rodin"))

			l_topo_sorter.process

			assert ("done", l_topo_sorter.done)
			assert ("has cycles",l_topo_sorter.cycle_found)
			assert ("cycle_list has one cycle", l_topo_sorter.cycle_list.count = 4)
		end


	topo_sort_1: LIST [STRING]
		do
			create {LINKED_LIST[STRING]} Result.make_from_iterable (<<"Map", "Money", "Pass", "Louvre", "Orsay">>)
			Result.compare_objects
		end

	topo_sort_2: LIST [STRING]
		do
			create {LINKED_LIST[STRING]} Result.make_from_iterable (<<"Map", "Money", "Pass", "Orsay", "Louvre">>)
			Result.compare_objects
		end

	topo_sort_3: LIST [STRING]
		do
			create {LINKED_LIST[STRING]} Result.make_from_iterable (<<"Money", "Map", "Pass", "Louvre", "Orsay">>)
			Result.compare_objects
		end

	topo_sort_4: LIST [STRING]
		do
			create {LINKED_LIST[STRING]} Result.make_from_iterable (<<"Money", "Map", "Pass", "Orsay", "Louvre">>)
			Result.compare_objects
		end

	topo_sort_5: LIST [STRING]
		do
			create {LINKED_LIST[STRING]} Result.make_from_iterable (<<"Money", "Pass", "Map", "Louvre", "Orsay">>)
			Result.compare_objects
		end

	topo_sort_6: LIST [STRING]
		do
			create {LINKED_LIST[STRING]} Result.make_from_iterable (<<"Money", "Pass", "Map", "Orsay", "Louvre">>)
			Result.compare_objects
		end



note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


