indexing
	description: "Tool bar items grouping algorithm."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_GROUP_ALGORITHM

create
	make

feature {NONE} -- Initlization

	make (a_max_group_count: INTEGER) is
			-- Creation method
		require
			valid: a_max_group_count > 0
		do
			max_group_count := a_max_group_count
			group_count := 1
		ensure
			set: max_group_count = a_max_group_count
		end

feature -- Command

	set_group_count (a_group_count: INTEGER) is
			-- Set `group_count'
		require
			valid: a_group_count > 0 and a_group_count <= max_group_count
		do
			group_count := a_group_count
		ensure
			set: a_group_count = group_count
		end

	set_items_width (a_items_width: like item_width) is
			-- Set `item_width'.
		require
			not_void: a_items_width /= Void
		do
			item_width := a_items_width
		ensure
			set: item_width = a_items_width
		end

feature -- Query

	best_grouping: SD_TOOL_BAR_GROUP_INFO is
			-- Best grouping. Integer is the group index.
		do
			calculate_possible_groups
			Result := minmum_space_groups
			Result.set_items_width (item_width)
		ensure
			not_void: Result /= Void
			valid: Result.count = group_count
			right_order: is_right_order (Result)
			right_count: is_right_count (Result)
		end

	is_right_order (a_grouping: like one_possible_group): BOOLEAN is
			-- If a_grouping integer which indicate index of `item_width' order right?
		require
			not_void: a_grouping /= Void
		local
			l_one_group: ARRAYED_LIST [INTEGER]
			l_check_index: INTEGER
		do
			Result := True
			l_check_index := a_grouping.i_th (1).first
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
					if not (l_check_index = l_one_group.item) then
						Result := False
					end
					l_check_index := l_check_index + 1
					l_one_group.forth
				end
				a_grouping.forth
			end
		end

	is_right_count (a_group_info: like best_grouping): BOOLEAN is
			-- If a_group_info count right?
		require
			not_void: a_group_info /= Void
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

	item_width: ARRAY [INTEGER]
			-- Groups to be calculated. Integer is each group width.

	group_count: INTEGER
			-- Group count is how many group excepted to divide.

	maximum_group_width (a_group_count: INTEGER): INTEGER is
			-- Maximum width when divide group number to a_group_count.
		require
			valid: a_group_count > 0 and a_group_count <= max_group_count
		do
			group_count := a_group_count
			Result := maximum_row_width (best_grouping)
		end

	maximum_group_width_index (a_group_count: INTEGER): INTEGER is
			-- Maximum width group index when divide group number to a_group_count.
		require
			valid: a_group_count > 0 and a_group_count <= max_group_count
		local
			l_fack: INTEGER
		do
			group_count := a_group_count
			l_fack := maximum_row_width (best_grouping)
			Result := internal_maximum_group_index
		ensure
			valid: Result >0 and Result <= max_group_count
		end

	max_group_count: INTEGER
			-- Maximum group count.

feature {NONE} -- Implementation functions

	calculate_possible_groups is
			-- Calculate all possible item_with_width.
		local
			l_next_possible_group: like one_possible_group
		do
			create all_possible_groups.make (1)
			-- The start condition
			l_next_possible_group := prepare_start_condition (1, 1)
			check is_count_right: is_right_count (l_next_possible_group) end
			all_possible_groups.extend (l_next_possible_group)

			from
			until
				l_next_possible_group = Void
			loop
				l_next_possible_group := next_possible_group (l_next_possible_group.deep_twin)
				if l_next_possible_group /= Void then
					check is_count_right: is_right_count (l_next_possible_group) end
					all_possible_groups.extend (l_next_possible_group)
				end
			end

		end

	prepare_start_condition (a_group_start_index: INTEGER; a_item_start_index: INTEGER): like one_possible_group is
			-- Prepare start condition (from a_group_start_index to `group_count')
			-- 1 to (group_count - 1) all only have one index. The rest indexs all allocate at last group.
		require
			valid: a_group_start_index >= 1 and a_group_start_index <= group_count
			valid: a_item_start_index >= 1 and a_item_start_index <= item_width.count
		local
			l_one_group: ARRAYED_LIST [INTEGER]
			l_item_index: INTEGER
			l_group_count: INTEGER
		do
			from
				l_item_index := a_item_start_index
				create Result.make
				l_group_count := a_group_start_index
			until
				l_group_count > group_count
			loop
				create l_one_group.make (1)
				l_one_group.extend (l_item_index)
				if l_group_count = group_count then
					-- Last group, extend rest indexs.
					from
						l_item_index := l_item_index + 1
					until
						l_item_index > item_width.count
					loop
						l_one_group.extend (l_item_index)
						l_item_index := l_item_index + 1
					end
				else
					l_item_index := l_item_index + 1
				end
				Result.extend (l_one_group, True)

				l_group_count := l_group_count + 1
			end
		ensure
			not_void: Result /= Void
			count_right: Result.count = group_count - a_group_start_index + 1
		end

	next_possible_group (a_current_group: like one_possible_group): like one_possible_group is
			-- Next possible group, if no possible group, Result is Void.
			-- End codition is:
			-- All the item_with_width after current index only have one index.
		require
			not_void: a_current_group /= Void
		local
			l_temp_group: ARRAYED_LIST [INTEGER]
			l_group_before: ARRAYED_LIST [INTEGER]
			l_part_result: like one_possible_group
		do
			-- Find last group which have more than one index.
			from
				a_current_group.finish
				-- Loop in back order
			until
				a_current_group.before or Result /= Void
			loop
				l_temp_group := a_current_group.item
				check at_least_one: l_temp_group.count >= 1 end
				if l_temp_group.count > 1 and then a_current_group.index /= 1 then
					-- Move first index to the last position of group before.
					l_group_before := a_current_group.i_th (a_current_group.index - 1)
					l_group_before.extend (l_temp_group.first)

					-- Reset item_with_width from l_index to start condition.
					l_part_result := prepare_start_condition (a_current_group.index, l_temp_group.first + 1)
					-- Replace item with start condition order.
					replace_array_items (a_current_group, l_part_result, a_current_group.index)
					Result := a_current_group
				end
				a_current_group.back
			end
		end

	replace_array_items (a_be_replaced: like one_possible_group; a_array: like one_possible_group; a_start_index: INTEGER) is
			-- Replace a_be_replaced from a_start_index with a_array.
		require
			not_void: a_be_replaced /= Void
			not_void: a_array /= Void
			valid: a_be_replaced.count - a_start_index + 1 = a_array.count
		local
			l_count: INTEGER
		do
			from
				l_count := 1
				a_be_replaced.go_i_th (a_start_index)
			until
				a_be_replaced.after
			loop
				a_be_replaced.replace (a_array.i_th (l_count), True)
				a_be_replaced.forth
				l_count := l_count + 1
			end
		ensure

		end

	maximum_row_width (a_group: like one_possible_group): INTEGER is
			-- Maximum row width of a_group
		require
			not_void: a_group /= Void
			valid: a_group.count = group_count
		local
			l_one_group: ARRAYED_LIST [INTEGER]
			l_one_group_width: INTEGER
		do
			from
				a_group.start
			until
				a_group.after
			loop
				l_one_group_width := 0
				l_one_group := a_group.item
				l_one_group_width := l_one_group_width + one_row_width (l_one_group.twin)
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
			-- When use `maximum_row_width', store maximum group index here.

	minmum_space_groups: like one_possible_group is
			-- Compare groups, first one is minmum space occupied.
		require
			not_void: all_possible_groups /= Void
		local
			l_temp_result_index: INTEGER
			l_minmum_total_redundance_space: INTEGER
			l_total_redundance_space: INTEGER
			l_one_possible: like one_possible_group
		do
			from
				l_minmum_total_redundance_space := l_minmum_total_redundance_space.max_value
				all_possible_groups.start
			until
				all_possible_groups.after
 			loop
 				l_one_possible := all_possible_groups.item

				l_total_redundance_space := total_redundance_space (l_one_possible)
				if l_minmum_total_redundance_space > l_total_redundance_space then
					l_temp_result_index := all_possible_groups.index
					l_minmum_total_redundance_space := l_total_redundance_space
				end
				all_possible_groups.forth
			end

			Result := all_possible_groups.i_th (l_temp_result_index)
		ensure
			not_void: Result /= Void
		end

	total_redundance_space (a_group: like one_possible_group): INTEGER is
			-- Total redundance of one group
		require
			not_void: a_group /= Void
			valid: a_group.count = group_count
		local
			l_maximum_space: INTEGER
		do
			l_maximum_space := maximum_row_width (a_group)
			from
				a_group.start
			until
				a_group.after
			loop
				check maximum_space_right: l_maximum_space >= one_row_width (a_group.item) end
				Result := Result + (l_maximum_space - one_row_width (a_group.item))
				a_group.forth
			end
		ensure
			non_negative: Result >= 0
		end

	one_row_width (a_row: ARRAYED_LIST [INTEGER]): INTEGER is
			-- Group width of a_row.
		require
			not_void: a_row /= Void
		do
			from
				a_row.start
			until
				a_row.after
			loop
				Result := item_width.item (a_row.item) + Result
				a_row.forth
			end
		ensure
			valid: Result > 0
		end

feature {NONE} -- Implementation attributes

	one_possible_group: SD_TOOL_BAR_GROUP_INFO is
			-- Possible item_with_width. Integer is index of one group, the index is same index as `item_width'.
		require
			only_used_for_type_anchor: False
		do
		end

	all_possible_groups: ARRAYED_LIST [like one_possible_group]
			-- All possible item_with_width.

invariant
	valid: group_count >= 1 and group_count <= max_group_count

end
