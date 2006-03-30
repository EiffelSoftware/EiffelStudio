indexing
	description: "[
					When a SD_FLOATING_TOOL_BAR_ZONE is resizing by user.
					SD_TOOL_BAR_GROUP_DIVIDER will calculate best grouping.
					It will get total minmum size.
																														]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_GROUP_DIVIDER

create
	make_with_content

feature {NONE} -- Initlization

	make_with_content (a_content: SD_TOOL_BAR_CONTENT) is
			-- Make with a_content.
		require
			not_void: a_content /= Void
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			create algorithm.make (a_content.group_count)
			content := a_content
			l_items := a_content.items
			algorithm.set_items_width (init_group_width (l_items))

			init_grouping_infos
		ensure
			set: content = a_content
		end

	init_group_width (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]): ARRAYED_LIST [INTEGER] is
			-- Initlizatie a list with each items width in it.
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
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
			Result.extend (group_width (l_temp_group))
		ensure
			group_count_right: Result.count = content.group_count
		end

	init_grouping_infos is
			-- Initlialize grouping infos.
		local
			l_count: INTEGER
			l_max_group_count: INTEGER
		do
			from
				l_count := 1
				l_max_group_count := content.item_count_except_separator
				create group_infos.make_default
			until
				l_count > l_max_group_count
			loop
				group_items (l_count)
				group_infos.force_last (internal_refined_grouping, l_count)

				l_count := l_count + 1
			end
		end

feature -- Query

	group_width (a_group: ARRAYED_LIST [SD_TOOL_BAR_ITEM]): INTEGER is
			-- Group total item width.
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

	group_item_width (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]): ARRAYED_LIST [INTEGER] is
			-- Initlizatie a list with each item width in it.
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
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

	tool_bar_item_width (a_tool_bar_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Tool bar item width of a_tool_bar_item.
		require
			not_void: a_tool_bar_item /= Void
		do
			Result := a_tool_bar_item.width
		ensure
			valid: Result >= 0
		end

	group_count: INTEGER is
			-- Group count.
		do
			check not_void: algorithm /= Void end
			Result := algorithm.group_count
		end

	best_grouping_by_width (a_width: INTEGER): SD_TOOL_BAR_GROUP_INFO is
			-- Best groupinp, Result is calculated by `a_width'.
		require
			valid: a_width > 0
		do
			from
				last_group_index := group_infos.count
				group_infos.finish
			until
				group_infos.before or Result /= Void
			loop
				if a_width < group_infos.item_for_iteration.maximum_width then
					Result := group_infos.item_for_iteration
				else
					last_group_index := last_group_index - 1
					group_infos.back
				end
			end
			if Result = Void then
				Result := group_infos.first
				last_group_index := 1
			end
		ensure
			not_void: Result /= Void
			valid: last_group_index >= 1 and last_group_index <= group_infos.count
		end

	last_group_index: INTEGER
			-- Last grouping info index.

	best_grouping (a_group_count: INTEGER): SD_TOOL_BAR_GROUP_INFO is
			-- Best grouping.
		require
			valid: a_group_count >= 1 and a_group_count <= content.item_count_except_separator
		do
			Result := group_infos.item (a_group_count)
		ensure
			not_void: Result /= Void
		end

	maximum_group_width (a_group_idnex: INTEGER): INTEGER is
			-- Maximum group width.
		do
			Result := algorithm.maximum_group_width (a_group_idnex)
		end

	max_row_count: INTEGER is
			-- Actual maximum row count.
		do
			Result := group_infos.last.row_total_count
		end

	content: SD_TOOL_BAR_CONTENT
			-- Tool bar content managed by Current.

	algorithm: SD_TOOL_BAR_GROUP_ALGORITHM
			-- Algorithm for grouping.

feature {NONE} -- Implementation

	group_items (a_group_count: INTEGER) is
			-- Group items.
		local
			l_row_left: INTEGER
		do
			if a_group_count >= 1 then
				if a_group_count > algorithm.max_group_count then
					algorithm.set_group_count (algorithm.max_group_count)
				else
					algorithm.set_group_count (a_group_count)
				end
				internal_refined_grouping := algorithm.best_grouping

				if a_group_count > content.group_count and a_group_count <= content.item_count_except_separator then
					l_row_left := a_group_count - content.group_count
					debug ("docking")
						print ("%N SD_tool_bar_GROUP_DIVIDER on_pointer_motion l_row_left is: " + l_row_left.out)
					end
					compute_extra_groups (l_row_left)
				end
			end
		end

	group_infos: DS_HASH_TABLE [SD_TOOL_BAR_GROUP_INFO, INTEGER]
			-- We record group infos here.

	compute_extra_groups (a_extra_group_count: INTEGER) is
			-- Compute extra groups when all top groups are all in separated row.
		require
			valid: a_extra_group_count > 0
		local
			l_max_group_info: SD_TOOL_BAR_GROUP_INFO
			l_temp_algorithm: SD_TOOL_BAR_GROUP_ALGORITHM
			l_sub_grouping: SD_TOOL_BAR_GROUP_INFO
			l_reduced: INTEGER
			l_stop: BOOLEAN
		do
			from
			until
				l_reduced >= a_extra_group_count or l_stop
			loop
				l_max_group_info := internal_refined_grouping.maximum_width_group
				l_max_group_info.start
				create l_temp_algorithm.make ((content.group (internal_refined_grouping.maximum_width_group_index).count))

				l_temp_algorithm.set_items_width (group_item_width (content.group (internal_refined_grouping.maximum_width_group_index)))
				if l_temp_algorithm.max_group_count = l_max_group_info.group_count then
					-- The maximum width row is already one iten per row.
					l_stop := True
				else
					l_temp_algorithm.set_group_count (l_max_group_info.group_count + 1)
					l_reduced := l_reduced + 1
					l_sub_grouping := l_temp_algorithm.best_grouping

					internal_refined_grouping.set_sub_group_info (l_sub_grouping, internal_refined_grouping.maximum_width_group_index)
				end
			end
		end

	internal_refined_grouping: SD_TOOL_BAR_GROUP_INFO
			-- Refined grouping info.

invariant

	not_void: algorithm /= Void

end
