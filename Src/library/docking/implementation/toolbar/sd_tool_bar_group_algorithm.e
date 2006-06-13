indexing
	description: "Tool bar items grouping algorithm."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			calculate_all_best_grouping
		ensure
			set: item_width = a_items_width
		end

feature -- Query

	best_grouping: SD_TOOL_BAR_GROUP_INFO is
			-- Best grouping. Integer is the group index.
		do
			Result := best_grouping_when (group_count)
		ensure
			not_void: Result /= Void
			valid: Result.group_count = group_count
			right_order: is_right_order (Result)
			right_count: is_right_count (Result)
		end

	best_grouping_when (a_group_count: INTEGER): SD_TOOL_BAR_GROUP_INFO is
			--
		require
			valid: a_group_count >= 1 and a_group_count <= max_group_count
		do
			Result := all_best_grouping.item (a_group_count)
		ensure
			not_void: Result /= Void
			valid: Result.group_count = a_group_count
			right_order: is_right_order (Result)
			right_count: is_right_count (Result)
		end

	is_right_order (a_grouping: like one_possible_group): BOOLEAN is
			-- If a_grouping integer which indicate index of `item_width' order right?
		require
			not_void: a_grouping /= Void
		local
			l_one_group: DS_HASH_TABLE [INTEGER, INTEGER]
			l_check_index: INTEGER
		do
			Result := True
			a_grouping.i_th (1).start
			l_check_index := a_grouping.i_th (1).key_for_iteration
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
					if not (l_check_index = l_one_group.key_for_iteration) then
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
			Result := maximum_row_width (best_grouping_when (a_group_count))
		end

	maximum_group_width_index (a_group_count: INTEGER): INTEGER is
			-- Maximum width group index when divide group number to a_group_count.
		require
			valid: a_group_count > 0 and a_group_count <= max_group_count
		local
			l_fack: INTEGER
		do
			l_fack := maximum_row_width (best_grouping_when (a_group_count))
			Result := internal_maximum_group_index
		ensure
			valid: Result >0 and Result <= max_group_count
		end

	max_group_count: INTEGER
			-- Maximum group count.

feature {NONE} -- Implementation functions

	calculate_all_best_grouping is
			--
		local
			l_group_count: INTEGER
			l_last_best_grouping: SD_TOOL_BAR_GROUP_INFO
		do
			from
				create all_best_grouping.make (max_group_count)
				l_group_count := max_group_count

			until
				l_group_count < 1
			loop
-- FIXIT: we should do something like following.
--				if l_group_count < item_width.count then
--					-- Calculate one step before
--					calculate_one_step_before
--				end
				if l_group_count = max_group_count then
					l_last_best_grouping := start_condition
				else
					l_last_best_grouping := next_best_grouping (l_last_best_grouping)
				end

				check count_right: l_last_best_grouping.group_count = l_group_count end
				all_best_grouping.force_last (l_last_best_grouping, l_group_count)

				l_group_count := l_group_count - 1
			end
		end

	next_best_grouping (a_previous_info: SD_TOOL_BAR_GROUP_INFO): SD_TOOL_BAR_GROUP_INFO is
			-- Next best grouping info of `a_previous_infos'.
		local
			l_group_index: INTEGER
			l_group_item_index: INTEGER
		do
			Result := a_previous_info.deep_twin
			l_group_index := minimum_two_group_index (a_previous_info)
			l_group_item_index := Result.group_item_start_index (l_group_index)
			Result.go_i_th (l_group_item_index + Result.group_item_count (l_group_index))
			check is_new_group: Result.is_new_group end
			Result.replace (Result.item, False)
		ensure
			not_same: Result /= a_previous_info
			group_count_right: Result.group_count = a_previous_info.group_count - 1
		end

	all_best_grouping: DS_HASH_TABLE [SD_TOOL_BAR_GROUP_INFO, INTEGER]
			-- 2nd INTEGER parameter is group count.

	start_condition: SD_TOOL_BAR_GROUP_INFO is
			-- Prepare start condition
		local
			l_count: INTEGER
			l_temp: DS_HASH_TABLE [INTEGER, INTEGER]
			l_item_count: INTEGER
		do
			create Result.make
			from
				l_item_count := 1
				l_count := item_width.lower
			until
				l_count > item_width.upper
			loop
				create l_temp.make (1)
				l_temp.force_last (item_width.item (l_count), l_item_count)
				if l_item_count = 1 then
					Result.extend (l_temp, False)
				else
					Result.extend (l_temp, True)
				end
				l_count := l_count + 1
				l_item_count := l_item_count + 1
			end
		ensure
			not_void: Result /= Void
			valid: Result.count = item_width.count
		end

	minimum_two_group_index (a_condition: SD_TOOL_BAR_GROUP_INFO): INTEGER is
			-- Which two items should be together. Result is first index, second item index is Result + 1.
			-- For example:
			-- After calculation:  	  11  2	  2	  2	  2   10
			-- Before calculation:	10	1	1	1	1	1	9
			-- Then Result is 2, bacause item 2 and item 3 should be together.
		require
			not_void: a_condition /= Void
			valid: a_condition.group_count > 1
		local
			l_minimum_two_width: INTEGER
			l_temp_two_width: INTEGER
			l_group_count: INTEGER
		do
			from
				l_group_count := 1
				l_minimum_two_width := {INTEGER}.max_value
			until
				l_group_count >= a_condition.group_count
			loop
				l_temp_two_width := a_condition.group_width (l_group_count) + a_condition.group_width (l_group_count + 1)
				if l_temp_two_width < l_minimum_two_width then
					l_minimum_two_width := l_temp_two_width
					Result := l_group_count
				end
				l_group_count := l_group_count + 1
			end
		ensure
			valid: 0 < Result and Result < a_condition.group_count
		end

	maximum_row_width (a_group: like one_possible_group): INTEGER is
			-- Maximum row width of a_group
		require
			not_void: a_group /= Void
			valid: a_group.count = group_count
		local
			l_one_group: DS_HASH_TABLE [INTEGER, INTEGER]
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
			-- Maximum width group index.

	one_row_width (a_row: DS_HASH_TABLE [INTEGER, INTEGER]): INTEGER is
			-- Group width of a_row.
		require
			not_void: a_row /= Void
		do
			from
				a_row.start
			until
				a_row.after
			loop
				Result := a_row.value (a_row.key_for_iteration) + Result
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

invariant
	valid: group_count >= 1 and group_count <= max_group_count

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
