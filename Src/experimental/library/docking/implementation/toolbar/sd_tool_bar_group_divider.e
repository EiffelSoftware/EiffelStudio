note
	description: "[
					When a SD_FLOATING_TOOL_BAR_ZONE is resizing by user.
					SD_TOOL_BAR_GROUP_DIVIDER will calculate best grouping.
					It will get total minmum size.
																														]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_GROUP_DIVIDER

create
	make_with_content

feature {NONE} -- Initlization

	make_with_content (a_content: SD_TOOL_BAR_CONTENT)
			-- Make with a_content
		require
			not_void: a_content /= Void
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_group_count: INTEGER
		do
			l_group_count := a_content.groups_count (False)
			create algorithm.make (l_group_count)
			content := a_content
			l_items := a_content.items_visible

			algorithm.set_items_width (init_group_width (a_content.items_visible))
			init_grouping_infos
		ensure
			set: content = a_content
			set: algorithm.item_width /= Void
		end

	init_group_width (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]): ARRAYED_LIST [INTEGER]
			-- Initlizatie a list with each items width in it
		local
			l_separator: detachable SD_TOOL_BAR_SEPARATOR
			l_temp_group: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			create Result.make (1)
			from
				create l_temp_group.make (1)
				a_items.start
			until
				a_items.after
			loop
				l_separator := Void
				l_separator ?= a_items.item
				if l_separator = Void then
					l_temp_group.extend (a_items.item)
				else
					if l_temp_group.count > 0 then
						Result.extend (group_width (l_temp_group))
						create l_temp_group.make (1)
					end
				end
				a_items.forth
			end
			if l_temp_group.count > 0 then
				Result.extend (group_width (l_temp_group))
			end
		ensure
			group_count_right: Result.count = content.groups_count (False)
		end

	init_grouping_infos
			-- Initlialize grouping infos
		local
			l_count: INTEGER
			l_max_group_count: INTEGER
			l_refined_grouping: like internal_refined_grouping
		do
			create grouping_algorithm.make (10)
			from
				l_count := 1
				l_max_group_count := content.item_count_except_sep (False)
				create group_infos.make (1)
			until
				l_count > l_max_group_count
			loop
				group_items (l_count)
				l_refined_grouping := internal_refined_grouping
				check l_refined_grouping /= Void end -- Implied by postcondition of `group_items'
				check not_has: not group_infos.has_item (l_refined_grouping) end
				group_infos.put (l_refined_grouping, l_count)
				debug ("docking")
					print ("%N SD_TOOL_BAR_GROUP_DIVIDER init_grouping_infos: when group count is: " + l_count.out)
					print ("%N " + l_refined_grouping.out)
				end
				l_count := l_count + 1
			end
		end

feature -- Query

	group_width (a_group: ARRAYED_LIST [SD_TOOL_BAR_ITEM]): INTEGER
			-- Group total item width
		require
			not_void: a_group /= Void
		do
			from
				a_group.start
			until
				a_group.after
			loop
				Result := Result + tool_bar_item_width (a_group.item)
				a_group.forth
			end
		ensure
			valid: Result >= 0
		end

	group_item_width (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]): ARRAYED_LIST [INTEGER]
			-- Initlizatie a list with each item width in it
		local
			l_separator: detachable SD_TOOL_BAR_SEPARATOR
		do
			create Result.make (1)
			from
				a_items.start
			until
				a_items.after
			loop
				l_separator := Void
				l_separator ?= a_items.item
				if l_separator = Void then
					Result.extend (tool_bar_item_width (a_items.item))
				else
					check must_not_contain_separator: False end
				end
				a_items.forth
			end
		ensure
			group_count_right: Result.count = a_items.count
		end

	tool_bar_item_width (a_tool_bar_item: SD_TOOL_BAR_ITEM): INTEGER
			-- Tool bar item width of `a_tool_bar_item'
		require
			not_void: a_tool_bar_item /= Void
		do
			Result := a_tool_bar_item.width
		ensure
			valid: Result >= 0
		end

	group_count: INTEGER
			-- Group count
		do
			check not_void: algorithm /= Void end
			Result := algorithm.group_count
		end

	best_grouping_by_width_to_right (a_width: INTEGER): SD_TOOL_BAR_GROUP_INFO
			-- Best groupinp, Result is calculated by `a_width'
		require
			valid: a_width > 0
		local
			l_list : ARRAYED_LIST [SD_TOOL_BAR_GROUP_INFO]
			l_result: detachable like best_grouping_by_width_to_right
		do
			from
				last_group_index := group_infos.count
				l_list := group_infos.linear_representation
				l_list.finish
			until
				l_list.before or l_result /= Void
			loop
				if (not l_list.item.has_any_sub_info and a_width < l_list.item.maximum_width) or
					(l_list.item.has_any_sub_info and a_width < l_list.item.maximum_width_sub) then
					l_result := l_list.item
				else
					last_group_index := last_group_index - 1
					l_list.back
				end
			end
			if l_result = Void then
				l_result := l_list.first
				last_group_index := 1
			end
			Result := l_result
		ensure
			not_void: Result /= Void
			valid: last_group_index >= 1 and last_group_index <= group_infos.count
		end

	best_grouping_by_width_to_left (a_width: INTEGER): SD_TOOL_BAR_GROUP_INFO
			-- Best groupinp, Result is calculated by `a_width'
			-- When pointer is moving to left, use this feature
		require
			valid: a_width > 0
		local
			l_list : ARRAYED_LIST [SD_TOOL_BAR_GROUP_INFO]
			l_result: detachable like best_grouping_by_width_to_left
		do
			from
				last_group_index := 1
				l_list := group_infos.linear_representation
				l_list.start
			until
				l_list.after or l_result /= Void
			loop
				if (not l_list.item.has_any_sub_info and a_width > l_list.item.maximum_width) or
					(l_list.item.has_any_sub_info and a_width > l_list.item.maximum_width_sub) then
					l_result := l_list.item
				else
					last_group_index := last_group_index + 1
					l_list.forth
				end
			end
			if l_result = Void then
				l_result := l_list.last
				last_group_index := l_list.count
			end
			Result := l_result
		ensure
			not_void: Result /= Void
			valid: last_group_index >= 1 and last_group_index <= group_infos.count
		end

	last_group_index: INTEGER
			-- Last grouping info index

	best_grouping (a_group_count: INTEGER): SD_TOOL_BAR_GROUP_INFO
			-- Best grouping
		require
			valid: a_group_count >= 1 and a_group_count <= content.item_count_except_sep (False)
		local
			l_result: detachable like best_grouping
		do
			l_result := group_infos.item (a_group_count)
			check l_result /= Void end -- Implied by precondition `valid'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	max_row_count: INTEGER
			-- Actual maximum row count
		do
			Result := content.item_count_except_sep (False)
		end

	content: SD_TOOL_BAR_CONTENT
			-- Tool bar content managed by Current

	algorithm: SD_HUFFMAN_ALGORITHM
			-- Algorithm for grouping

feature {NONE} -- Implementation

	insert_arrayed_list_to_group_info_sub_level (a_list: ARRAYED_LIST [ARRAYED_LIST [INTEGER]]; a_sub_group_index: INTEGER; a_widths: ARRAYED_LIST [INTEGER])
			-- Insert `a_list' to `internal_refined_grouping'
		require
			not_void: internal_refined_grouping /= Void
			not_void: a_list /= Void
			valid: a_sub_group_index > 0 and a_sub_group_index <= content.groups_count (False)
			valid: list_and_width_equal (a_list, a_widths)
		local
			l_sub_group_info: SD_TOOL_BAR_GROUP_INFO
			l_refined_grouping: like internal_refined_grouping
		do
			l_refined_grouping := internal_refined_grouping
			check l_refined_grouping /= Void end -- Implied by precondition `set'
			l_refined_grouping.go_i_th (a_sub_group_index)

			-- `position_groups_imp' from SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT count base on total items in sub group
			l_sub_group_info := convert_arrayed_list_to_group_info (a_list, False, a_widths)

			l_refined_grouping.set_sub_group_info (l_sub_group_info, a_sub_group_index)
		end

	list_and_width_equal (a_list: ARRAYED_LIST [ARRAYED_LIST [INTEGER]]; a_items_width: ARRAYED_LIST [INTEGER]): BOOLEAN
			-- Is items count in `a_list' equal to `a_items_width''s count?
		require
			not_void: a_list /= Void
			not_void: a_items_width /= Void
		local
			l_count: INTEGER
		do
			from
				a_list.start
			until
				a_list.after
			loop
				l_count := l_count + a_list.item.count
				a_list.forth
			end
			Result := l_count = a_items_width.count
		end

	convert_arrayed_list_to_group_info (a_list: ARRAYED_LIST [ARRAYED_LIST [INTEGER]]; a_count_clear: BOOLEAN; a_items_width: ARRAYED_LIST [INTEGER]): SD_TOOL_BAR_GROUP_INFO
			-- Only covert first level
			-- Item is one group which has several items
		require
			not_void: a_list /= Void
			not_void: a_items_width /= Void
			valid: list_and_width_equal (a_list, a_items_width)
		local
			l_one_group: ARRAYED_LIST [INTEGER]
			l_group_width: INTEGER
			l_item: HASH_TABLE [INTEGER, INTEGER]
			l_item_count: INTEGER
		do
			from
				l_item_count := 1
				create Result.make
				a_list.start
			until
				a_list.after
			loop
				from
					l_one_group := a_list.item
					create l_item.make (10)
					l_group_width := 0
					if a_count_clear then
						l_item_count := 1
					end
					l_one_group.start
				until
					l_one_group.after
				loop
					l_item.extend (a_items_width.i_th (l_one_group.item), l_item_count)
					l_group_width := l_one_group.item + l_group_width

					l_item_count := l_item_count + 1
					l_one_group.forth
				end
				Result.extend (l_item, a_list.index /= 1)
				a_list.forth
			end
		ensure
			not_void: Result /= Void
		end

	group_items (a_group_count: INTEGER)
			-- Group items
		local
			l_row_left: INTEGER
			l_group: ARRAYED_LIST [ARRAYED_LIST [INTEGER]]
			l_item_width: detachable ARRAYED_LIST [INTEGER]
		do
			if a_group_count >= 1 then
				if a_group_count > algorithm.max_group_count then
					l_group := algorithm.best_grouping_when (algorithm.max_group_count)
					l_item_width := algorithm.item_width
					check l_item_width /= Void end-- Implied by `make_with_content's postcondition
					internal_refined_grouping := convert_arrayed_list_to_group_info (l_group, False, l_item_width)
				else
					l_group := algorithm.best_grouping_when (a_group_count)
					l_item_width := algorithm.item_width
					check l_item_width /= Void end-- Implied by `make_with_content's postcondition					
					internal_refined_grouping := convert_arrayed_list_to_group_info (l_group, False, l_item_width)
				end

				if a_group_count > content.groups_count (False) and a_group_count <= content.item_count_except_sep (False) then
					l_row_left := a_group_count - content.groups_count (False)
					debug ("docking")
						print ("%N SD_TOOL_BAR_GROUP_DIVIDER on_pointer_motion l_row_left is: " + l_row_left.out)
					end
					compute_extra_groups (l_row_left)
				end
			end
		ensure
			created: a_group_count > 1 implies internal_refined_grouping /= Void
		end

	grouping_algorithm_factory (a_max_width_group_index: INTEGER): SD_HUFFMAN_ALGORITHM
			-- Factory method of algorithm
		require
			valid: a_max_width_group_index > 0 and a_max_width_group_index <= content.groups_count (False)
		local
			l_sub_group_item_count: INTEGER
			l_result: detachable like grouping_algorithm_factory
		do
			if grouping_algorithm.has (a_max_width_group_index) then
				l_result := grouping_algorithm.item (a_max_width_group_index)
				check l_result /= Void end -- Implied by `has'
				Result := l_result
			else
				l_sub_group_item_count := content.group_items (a_max_width_group_index, False).count
				create Result.make (l_sub_group_item_count)
				Result.set_items_width (group_item_width (content.group_items (a_max_width_group_index, False)))
				grouping_algorithm.extend (Result, a_max_width_group_index)
			end
		ensure
			not_void: Result /= Void
			set: Result.item_width /= Void
		end

	compute_extra_groups (a_extra_group_count: INTEGER)
			-- Compute extra groups when all top groups are all in separated row
		require
			valid: a_extra_group_count > 0
			set: internal_refined_grouping /= Void
		local
			l_max_group_info: SD_TOOL_BAR_GROUP_INFO
			l_temp_algorithm: SD_HUFFMAN_ALGORITHM
			l_reduced: INTEGER
			l_stop: BOOLEAN
			l_max_info: TUPLE [max_group_index: INTEGER; max_row_item_count: INTEGER]
			l_item_width: detachable ARRAYED_LIST [INTEGER]
			l_refined_grouping: like internal_refined_grouping
		do
			from
				l_refined_grouping := internal_refined_grouping
				check l_refined_grouping /= Void end -- Implied by precondition `set'
			until
				l_reduced >= a_extra_group_count or l_stop
			loop
				l_max_group_info := l_refined_grouping.maximum_width_top_group
				l_max_group_info.start
				l_max_info := l_refined_grouping.maximum_width_group_index

				-- Is there only one item in max width row?
				if l_max_info.max_row_item_count <= 1 then
					l_stop := True
				end
				if not l_stop then
					l_temp_algorithm := grouping_algorithm_factory (l_max_info.max_group_index)

					if is_initialized_sub_group (l_max_group_info) and then l_temp_algorithm.max_group_count < l_max_group_info.group_count + 1 then
						-- The maximum width row is already one item per row
						l_stop := True
					else
						-- Should not pass a_extra
						l_reduced := l_reduced + 1
						-- Because if `l_max_group_info' is not sub group info, then group count will be 1 larger than actual
						if not is_initialized_sub_group (l_max_group_info) then
							-- Is not from a sub group info
							-- Or from sub group info which item count = 1
							if l_temp_algorithm.max_group_count < 2 then
								-- `l_temp_algorithm' is maximum width group which only have one item, so we stop here
								l_stop := True
							else
								l_item_width := l_temp_algorithm.item_width
								check l_item_width /= Void end -- Implied by `grouping_algorithm_factory's postcondition
								insert_arrayed_list_to_group_info_sub_level (l_temp_algorithm.best_grouping_when (2), l_max_info.max_group_index, l_item_width)
							end
						else
							-- Is from a sub group info
							l_max_group_info.start
							l_item_width := l_temp_algorithm.item_width
							check l_item_width /= Void end -- Implied by `grouping_algorithm_factory's postcondition							
							insert_arrayed_list_to_group_info_sub_level (l_temp_algorithm.best_grouping_when (l_max_group_info.group_count + 1), l_max_info.max_group_index, l_item_width)
						end
					end
				end
			end
		end

	is_initialized_sub_group (a_group_info: SD_TOOL_BAR_GROUP_INFO): BOOLEAN
			-- If `a_group_info' which is subgroup infornation initlialized?
		require
			not_void: a_group_info /= Void
		local
			l_snapshot: SD_TOOL_BAR_GROUP_INFO
		do
			l_snapshot := a_group_info.deep_twin
			l_snapshot.start
			Result := not (l_snapshot.count = 1 and l_snapshot.is_new_group = True)
		end

	group_infos: HASH_TABLE [SD_TOOL_BAR_GROUP_INFO, INTEGER]
			-- Group informations

	grouping_algorithm: HASH_TABLE [SD_HUFFMAN_ALGORITHM, INTEGER]
			-- We store algorithm here, so it'll not need recompute
			-- 2nd INTEGER is sub group index count

	internal_refined_grouping: detachable SD_TOOL_BAR_GROUP_INFO
			-- Refined grouping info

invariant

	not_void: algorithm /= Void

note
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
