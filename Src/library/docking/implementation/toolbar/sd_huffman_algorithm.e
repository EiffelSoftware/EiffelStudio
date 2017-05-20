note
	description: "[
		Tool bar items grouping algorithm. Huffman alogrithm.
		This class has no relationship with SD_TOOL_BAR_GROUP_INFO.
		Only SD_TOOL_BAR_GROUP_DIVIDER use this class.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HUFFMAN_ALGORITHM

create
	make

feature {NONE} -- Creation

	make (a_max_group_count: INTEGER; a_items_width: like item_width)
			-- Create an object with `a_max_group_count' number of groups and `a_items_width' widths of items.
		require
			valid: a_max_group_count >= 0
			not_void: a_items_width /= Void
		do
			max_group_count := a_max_group_count
			group_count := 1
			item_width := a_items_width
			create all_best_grouping.make (max_group_count)
			calculate_all_best_grouping
		ensure
			set: max_group_count = a_max_group_count
			set: item_width = a_items_width
		end

feature -- Command

	set_group_count (a_group_count: INTEGER)
			-- Set `group_count'
		require
			valid: a_group_count > 0 and a_group_count <= max_group_count
		do
			group_count := a_group_count
		ensure
			set: a_group_count = group_count
		end

feature -- Query

	best_grouping: ARRAYED_LIST [ARRAYED_LIST [INTEGER_32]]
			-- Best grouping. Integer is the group index.
		do
			Result := best_grouping_when (group_count)
		ensure
			not_void: Result /= Void
			right_order: is_right_order (Result)
			right_count: is_right_count (Result)
		end

	best_grouping_when (a_group_count: INTEGER): ARRAYED_LIST [ARRAYED_LIST [INTEGER_32]]
			-- Best grouping when `a_group_count'
		require
			valid: a_group_count >= 1 and a_group_count <= max_group_count
		do
			check
				from_precondition: attached all_best_grouping.item (a_group_count) as r
			then
				Result := r
			end
		ensure
			not_void: Result /= Void
			valid: Result.count = a_group_count
			right_order: is_right_order (Result)
			right_count: is_right_count (Result)
		end

	is_right_order (a_grouping: like best_grouping): BOOLEAN
			-- If a_grouping integer which indicate index of `item_width' order right?
		require
			not_void: a_grouping /= Void
		local
			l_one_group: ARRAYED_LIST [INTEGER]
			l_check_index: INTEGER
		do
			Result := True
			l_check_index := a_grouping.first.first
			from
				a_grouping.start
			until
				a_grouping.after or not Result
			loop
				l_one_group := a_grouping.item
				from
					l_one_group.start
				until
					l_one_group.after or not Result
				loop
					if l_check_index /= l_one_group.item then
						Result := False
					end
					l_check_index := l_check_index + 1
					l_one_group.forth
				end
				a_grouping.forth
			end
		end

	is_right_count (a_group_info: like best_grouping): BOOLEAN
			-- If a_group_info count right?
		require
			not_void: a_group_info /= Void
			set: item_width /= Void
		local
			l_item_count: INTEGER
		do
			from
				a_group_info.start
			until
				a_group_info.after
			loop
				l_item_count := a_group_info.item.count + l_item_count
				a_group_info.forth
			end
			Result := l_item_count = item_width.count
		end

	item_width: ARRAYED_LIST [INTEGER]
			-- Groups to be calculated. Integer is each group width.

	group_count: INTEGER
			-- Group count is how many group excepted to divide.

	maximum_group_width (a_group_count: INTEGER): INTEGER
			-- Maximum width when divide group number to a_group_count.
		require
			valid: a_group_count > 0 and a_group_count <= max_group_count
		do
			Result := maximum_row_width (best_grouping_when (a_group_count))
		end

	maximum_group_width_index (a_group_count: INTEGER): INTEGER
			-- Maximum width group index when divide group number to a_group_count.
		require
			valid: a_group_count > 0 and a_group_count <= max_group_count
		do
			maximum_row_width (best_grouping_when (a_group_count)).do_nothing
			Result := internal_maximum_group_index
		ensure
			valid: Result >0 and Result <= max_group_count
		end

	max_group_count: INTEGER
			-- Maximum group count.

feature {NONE} -- Implementation functions

	calculate_all_best_grouping
			-- Calculate all best groupings, added the result to `all_best_grouping'.
		local
			l_group_count: INTEGER
			l_last_best_grouping: detachable like best_grouping
		do
			from
				all_best_grouping.wipe_out
				l_group_count := max_group_count

			until
				l_group_count < 1
			loop

				if l_group_count = max_group_count then
					l_last_best_grouping := start_condition
				else
					check
						attached l_last_best_grouping -- Implied by `next_best_grouping's result not void and `start_condition' not void
					then
						l_last_best_grouping := next_best_grouping (l_last_best_grouping)
					end
				end

				check count_right: l_last_best_grouping.count = l_group_count end
				all_best_grouping.extend (l_last_best_grouping, l_group_count)

				l_group_count := l_group_count - 1
			end
		end

	next_best_grouping (a_previous_info: like best_grouping): like best_grouping
			-- Next best grouping info of `a_previous_infos'.
		local
			l_group_index: INTEGER
			l_group: ARRAYED_LIST [INTEGER]
		do
			Result := a_previous_info.deep_twin
			l_group_index := minimum_two_group_index (a_previous_info)
			Result.go_i_th (l_group_index)

			-- Remove two minimum group items, add one which is combination of the two removed.
			l_group := Result.item
			l_group.append (Result.i_th (l_group_index + 1))

			Result.remove
			Result.replace (l_group)
		ensure
			not_same: Result /= a_previous_info
			group_count_right: Result.count = a_previous_info.count - 1
		end

	all_best_grouping: HASH_TABLE [like best_grouping, INTEGER]
			-- 2nd INTEGER parameter is group count.

	start_condition: like best_grouping
			-- Prepare start condition
		require
			set: item_width /= Void
		local
			l_item_count, l_max_count: INTEGER
			l_item: ARRAYED_LIST [INTEGER]
		do
			from
				l_item_count := 1
				l_max_count := item_width.count
				create Result.make (l_max_count)
			until
				l_item_count > l_max_count
			loop
				create l_item.make (1)
				l_item.extend (l_item_count)
				Result.extend (l_item)
				l_item_count := l_item_count + 1
			end
		ensure
			not_void: Result /= Void
			valid: attached item_width as l_item_width implies Result.count = l_item_width.count
		end

	minimum_two_group_index (a_condition: like best_grouping): INTEGER
			-- Which two items should be together. Result is first index, second item index is Result + 1.
			-- Huffman alogrithm, for example:
			-- After calculation:  	  11  2	  2	  2	  2   10
			-- Before calculation:	10	1	1	1	1	1	9
			-- Then Result is 2, bacause item 2 and item 3 should be together.
		require
			not_void: a_condition /= Void
			valid: a_condition.count > 1
		local
			l_minimum_two_width: INTEGER
			l_temp_two_width: INTEGER
		do
			from
				l_minimum_two_width := {INTEGER}.max_value
				a_condition.start
			until
				-- We stop at the 2nd last item
				a_condition.index >= a_condition.count
			loop
				l_temp_two_width := one_group_width (a_condition.item) + one_group_width (a_condition.i_th (a_condition.index + 1))
				if l_temp_two_width < l_minimum_two_width then
					l_minimum_two_width := l_temp_two_width
					Result := a_condition.index
				end
				a_condition.forth
			end
		ensure
			valid: 0 < Result and Result < a_condition.count
		end

	maximum_row_width (a_group: like best_grouping): INTEGER
			-- Maximum row width of a_group
		require
			not_void: a_group /= Void
		local
			l_one_group_width: INTEGER
		do
			from
				a_group.start
			until
				a_group.after
			loop
				l_one_group_width := one_group_width (a_group.item)

				if Result < l_one_group_width then
					Result := l_one_group_width
					internal_maximum_group_index := a_group.index
				end

				a_group.forth
			end
		ensure
			valid: Result > 0
		end

	internal_maximum_group_index: INTEGER
			-- Maximum width group index.

	one_group_width (a_group: ARRAYED_LIST [INTEGER]): INTEGER
			-- Width of `a_group'.
		require
			not_void: a_group /= Void
			at_leaat_one: a_group.count >= 1
			set: item_width /= Void
		local
			l_item_width: like item_width
		do
			from
				l_item_width := item_width
				a_group.start
			until
				a_group.after
			loop
				Result := l_item_width.i_th (a_group.item) + Result
				a_group.forth
			end
		ensure
			valid: Result > 0
		end

invariant
	valid: group_count >= 1 and group_count <= max_group_count
	attached_item_width: attached item_width

note
	library: "SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
