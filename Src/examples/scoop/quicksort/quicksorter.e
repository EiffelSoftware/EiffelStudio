note
	description: "Quicksorter that sorts in parallel."
	author: "Marco Zietzling"
	reviewer: "Benjamin Morandi"
	date: "$Date$"
	revision: "$Revision$"

class
	QUICKSORTER

feature -- Basic operations

	sort (a_data: separate DATA; a_sorting_depth: NATURAL)
			-- Sort `a_data'.
		local
			l_left_quicksorter, l_right_quicksorter: detachable separate QUICKSORTER
			l_left_data: detachable separate DATA
			l_right_data: detachable separate DATA

			-- positions
			l_left_position: INTEGER
			l_right_position: INTEGER
			l_pivot_position: INTEGER

			-- elements
			l_pivot_element: INTEGER

		do
			-- Initialize.

			l_left_position := a_data.lower
			l_right_position := a_data.upper
			l_pivot_position := (l_left_position + l_right_position) // 2

			-- Partition.
			swap_data_items (a_data, l_left_position, l_pivot_position)
			l_pivot_position := l_left_position
			across ((l_left_position + 1) |..| l_right_position) as ic
			loop
				if a_data [ic.item] < a_data [l_left_position] then
					l_pivot_position := l_pivot_position + 1
					swap_data_items (a_data, ic.item, l_pivot_position)
				end
			end

			swap_data_items (a_data, l_left_position, l_pivot_position)
			l_pivot_element := a_data [l_pivot_position]

			-- Sort the data concurrently.
			-- Check if there is a left part with more than one item.
			if l_left_position < l_pivot_position - 1 then
				-- There is one.
				-- Sort the left part with another quicksorter.
				print ("Sorting the left side, " +l_left_position.out+ " to " +(l_pivot_position - 1).out+ " with ")
				if a_sorting_depth <= max_recursion_depth then
					print ("a separate quicksorter.%N")
					create l_left_quicksorter
					l_left_data := new_data_from_quicksorter (l_left_quicksorter, a_data, l_left_position, l_pivot_position - 1)
				else
					print ("the current quicksorter.%N")
					l_left_quicksorter := Current
					create {DATA} l_left_data.make_from_other_data (a_data, l_left_position, l_pivot_position - 1)
				end
					-- Retrieve data from processor of left sorter.

				recursive_sort (l_left_quicksorter, l_left_data, a_sorting_depth + 1)
			end

			-- Check if there is a right part with more than one item.
			if l_pivot_position + 1 < l_right_position then
				-- There is one.
				-- Sort the right part with another quicksorter.
				print ("Sorting the right side, " +(l_pivot_position + 1).out+ " to " +l_right_position.out+ " with ")
				if a_sorting_depth <= max_recursion_depth then
					print ("a separate quicksorter.%N")
					create l_right_quicksorter
					l_right_data := new_data_from_quicksorter (l_right_quicksorter, a_data, l_pivot_position + 1, l_right_position)
				else
					print ("the current quicksorter.%N")
					l_right_quicksorter := Current
					create {DATA} l_right_data.make_from_other_data (a_data, l_pivot_position + 1, l_right_position)
				end
					-- Retrieve data from processor of right sorter.

				recursive_sort (l_right_quicksorter, l_right_data, a_sorting_depth + 1)
			end

			-- Merge.

			-- Merge the left part.
			-- Check if there is a left part with more than one item.
			if l_left_quicksorter /= Void then
				-- There is one.
				-- Populate the result from the sub quicksorter.
				if l_left_data /= Void then
					import_data_items (l_left_data, a_data, l_left_position)
				else
					check has_left_data: False end
				end
			end

			-- Copy the pivot element to the result.
			a_data.put (l_pivot_element, l_pivot_position)

			-- Merge the right part.
			-- Check if there is a right part with more than one item.
			if l_right_quicksorter /= Void then
				-- There is one.
				-- Populate the result from the sub quicksorter.				
				if l_right_data /= Void then
					import_data_items (l_right_data, a_data, l_pivot_position + 1)
				else
					check has_right_data: False end
				end
			end
		end

	new_data_from_quicksorter (a_quicksorter: separate QUICKSORTER; a_data: separate DATA; a_left_position, a_right_position: INTEGER): separate DATA
			-- Retrieve a subsection of `a_data' from `a_left_position' to `a_right_position' on the processor of `a_quicksorter'.
		do
			if a_quicksorter = Current then
				create {DATA} Result.make_from_other_data (a_data, a_left_position, a_right_position)
			else
				Result := a_quicksorter.new_data_from_quicksorter (a_quicksorter, a_data, a_left_position, a_right_position)
			end
		end

feature {QUICKSORTER} -- Implementation

	max_recursion_depth: NATURAL = 4
		-- Maximum depth of recursion before using the same processor for sorting.

	recursive_sort (a_quicksorter: separate QUICKSORTER; a_data: separate DATA; a_sorting_depth: NATURAL)
			-- Sort `a_data' with `a_quicksorter'.
		do
			a_quicksorter.sort (a_data, a_sorting_depth)
		end

	swap_data_items (a_data: separate DATA; a_position_1: INTEGER; a_position_2: INTEGER)
			-- Swaps items at `position_1' and `position_2' in `a_data'.
		local
			l_swap_value, l_swap_value_2: INTEGER
		do
			if a_position_1 /= a_position_2 then
				l_swap_value := a_data [a_position_1]
				l_swap_value_2 := a_data [a_position_2]
				a_data.put (l_swap_value_2, a_position_1)
				a_data.put (l_swap_value, a_position_2)
			end
		end

	import_data_items (a_input_data: separate DATA; a_output_data: separate DATA; a_left_position: INTEGER)
			-- Copy the items in 'a_input_data' to 'a_output_data' starting at position 'a_left_position'.
		require
			a_output_data_is_big_enough: a_output_data.upper - a_left_position + 1 >= a_input_data.capacity
		local
			l_lower, l_upper: INTEGER
		do
			l_lower := a_input_data.lower
			l_upper := a_input_data.upper
			across (l_lower |..| l_upper) as ic loop
				a_output_data.put (a_input_data [ic.item], a_left_position + ic.item - l_lower)
			end
		end

end -- class QUICKSORTER
