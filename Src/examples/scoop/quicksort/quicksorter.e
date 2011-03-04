note
	description: "Quicksorter that sorts in parallel."
	author: "Marco Zietzling"
	reviewer: "Benjamin Morandi"
	date: "$Date$"
	revision: "$Revision$"

class
	QUICKSORTER

feature -- Basic operations

	sort (a_data: separate DATA; a_result_data_items: separate ARRAY[INTEGER])
			-- Sort `a_data'.
		local
			l_left_quicksorter: separate QUICKSORTER
			l_right_quicksorter: separate QUICKSORTER
			l_left_data: detachable separate DATA
			l_right_data: detachable separate DATA

			-- positions
			l_left_position: INTEGER
			l_right_position: INTEGER
			l_pivot_position: INTEGER

			-- elements
			l_pivot_element: INTEGER

			-- indices
			i: INTEGER
		do
			-- Initialize.
			l_left_position := data_items_lower (a_data.items)
			l_right_position := data_items_upper (a_data.items)
			l_pivot_position := (l_left_position + l_right_position) // 2

			-- Partition.
			swap_data_items (a_data, l_left_position, l_pivot_position)
			l_pivot_position := l_left_position
			from
				i := l_left_position + 1
			until
				i > l_right_position
			loop
				if data_items_i_th (a_data.items, i) < data_items_i_th (a_data.items, l_left_position) then
					l_pivot_position := l_pivot_position + 1
					swap_data_items (a_data, i, l_pivot_position)
				end
				i := i + 1
			end
			swap_data_items (a_data, l_left_position, l_pivot_position)
			l_pivot_element := data_items_i_th (a_data.items, l_pivot_position)

			-- Sort the data concurrently.
			-- Check if there is a left part with more than one item.
			if l_left_position < l_pivot_position - 1 then
				-- There is one.
				-- Sort the left part with another quicksorter.
				create l_left_quicksorter
				create l_left_data.make_with_other_data (a_data, l_left_position, l_pivot_position - 1)
				recursive_sort (l_left_data, l_left_quicksorter)
			else
				-- There is none.
			end
			-- Check if there is a right part with more than one item.
			if l_pivot_position + 1 < l_right_position then
				-- There is one.
				-- Sort the right part with another quicksorter.
				create l_right_quicksorter
				create l_right_data.make_with_other_data (a_data, l_pivot_position + 1, l_right_position)
				recursive_sort (l_right_data, l_right_quicksorter)
			else
				-- There is none.
			end

			-- Merge.


			-- Merge the left part.
			-- Check if there is a left part with more than one item.
			if l_left_position < l_pivot_position - 1 then
				-- There is one.
				-- Populate the result from the sub quicksorter.
				check l_left_data /= Void end
				import_data_items (l_left_data, a_result_data_items, data_items_lower (a_data.items))
			elseif l_left_position = l_pivot_position - 1 then
				-- There is none.
				-- Copy one item directly.
				a_result_data_items.put (data_items_i_th (a_data.items, l_left_position), l_left_position)
			end

			-- Copy the pivot element to the result.
			a_result_data_items.put (l_pivot_element, l_pivot_position)

			-- Merge the right part.
			-- Check if there is a right part with more than one item.
			if l_pivot_position + 1 < l_right_position then
				-- There is one.
				-- Populate the result from the sub quicksorter.
				check l_right_data /= Void end
				import_data_items (l_right_data, a_result_data_items, l_pivot_position + 1)
			elseif l_pivot_position + 1 = l_right_position then
				-- There is none.
				-- Copy one item directly.
				a_result_data_items.put (data_items_i_th (a_data.items, l_right_position), l_right_position)
			end

			-- Set the sorted data items.
			a_data.make_with_other_items (a_result_data_items)
		end

feature {NONE} -- Implementation

	recursive_sort (a_data: separate DATA; a_quicksorter: separate QUICKSORTER)
			-- Sort `a_data' with `a_quicksorter'.
		local
			l_result_data_items: separate ARRAY [INTEGER_32]
		do
			-- Create the result data items.
			create l_result_data_items.make (data_items_lower (a_data.items), data_items_upper (a_data.items))
			a_quicksorter.sort (a_data, l_result_data_items)
		end

	swap_data_items (a_data: separate DATA; a_position_1: INTEGER; a_position_2: INTEGER)
			-- Swaps items at `position_1' and `position_2' in `a_data'.
		local
			l_swap_value: INTEGER
		do
			if a_position_1 /= a_position_2 then
				l_swap_value := data_items_i_th (a_data.items, a_position_1)
				data_items_put (a_data.items, data_items_i_th (a_data.items, a_position_2), a_position_1)
				data_items_put (a_data.items, l_swap_value, a_position_2)
			end
		end

	import_data_items (a_input_data: separate DATA; a_output_data: separate ARRAY[INTEGER]; a_left_position: INTEGER)
			-- Copy the items in 'a_input_data' to 'a_output_data' starting at position 'a_left_position'.
		require
			a_output_data_is_big_enough: a_output_data.upper - a_left_position + 1 >= data_items_capacity (a_input_data.items)
		local
			i: INTEGER
		do
			from
				i := data_items_lower (a_input_data.items)
			until
				i > data_items_upper (a_input_data.items)
			loop
				a_output_data.put (data_items_i_th (a_input_data.items, i), a_left_position + i - data_items_lower (a_input_data.items))
				i := i + 1
			end
		end

	data_items_capacity (a_data_items: separate ARRAY[INTEGER]): separate INTEGER
			--
		do
			Result := a_data_items.capacity
		end

	data_items_lower (a_data_items: separate ARRAY[INTEGER]): separate INTEGER
			--
		do
			Result := a_data_items.lower
		end

	data_items_upper (a_data_items: separate ARRAY[INTEGER]): separate INTEGER
			--
		do
			Result := a_data_items.upper
		end

	data_items_i_th (a_data_items: separate ARRAY[INTEGER]; a_i_th: separate INTEGER): separate INTEGER
			--
		do
			Result := a_data_items [a_i_th]
		end

	data_items_put (a_data_items: separate ARRAY[INTEGER]; a_i_th: separate INTEGER; a_value: separate INTEGER)
			--
		do
			a_data_items.put (a_value, a_i_th)
		end

end -- class QUICKSORTER
