indexing
	description: "[
					When a SD_FLOATING_MENU_ZONE is resizing by user. SD_MENU_GROUP_DIVIDER will caculate best grouping.
					It will get total minmum size.
																														]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_GROUP_DIVIDER

create
	make_with_content

feature {NONE} -- Initlization

	make_with_content (a_content: SD_MENU_CONTENT) is
			-- Make with a_content.
		require
			not_void: a_content /= Void
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			create algorithm.make (a_content.group_count)
			content := a_content
			l_items := a_content.menu_items
			algorithm.set_items_with_width (init_group_width (l_items))
		ensure
			set: content = a_content
		end

	init_group_width (a_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]): ARRAYED_LIST [INTEGER] is
			-- Initlizatie a list with each item width in it.
		local
			l_separator: EV_TOOL_BAR_SEPARATOR
			l_temp_group: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
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

feature -- Command

	on_pointer_motion (a_group_count: INTEGER) is
			-- Handle pointer motion actions.
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
						print ("%N SD_MENU_GROUP_DIVIDER on_pointer_motion QQQQQQQQQQQQQQQQQQQQQQ l_row_left is: " + l_row_left.out)
					end
					compute_extra_groups (l_row_left)
				end
			end
		end

feature -- Query

	group_width (a_group: ARRAYED_LIST [EV_TOOL_BAR_ITEM]): INTEGER is
			-- Group total item width.
		require
			not_void: a_group /= Void
		do
			from
				a_group.start
			until
				a_group.after
			loop
				Result := Result + menu_item_width (a_group.item)
				a_group.forth
			end
		ensure
			valid: Result >= 0
		end

	group_item_width (a_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]): ARRAYED_LIST [INTEGER] is
			-- Initlizatie a list with each item width in it.
		local
			l_separator: EV_TOOL_BAR_SEPARATOR
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
					Result.extend (menu_item_width (a_items.item))
				else
					check must_not_contain_separator: False end
				end
				a_items.forth
			end
		ensure
			group_count_right: Result.count = a_items.count
		end

	menu_item_width (a_tool_bar_item: EV_TOOL_BAR_ITEM): INTEGER is
			-- Menu item width of a_tool_bar_item.
		require
			not_void: a_tool_bar_item /= Void
			parent_not_void: a_tool_bar_item.parent /= Void
			parent_count_one: a_tool_bar_item.parent.count = 1
		local
			l_tool_bar: EV_TOOL_BAR
		do
			l_tool_bar := a_tool_bar_item.parent
			Result := l_tool_bar.width
		ensure
			valid: Result >= 0
		end

	group_count: INTEGER is
			-- Group count.
		do
			check not_void: algorithm /= Void end
			Result := algorithm.group_count
		end

	best_grouping: SD_MENU_GROUP_INFO is
			-- Best grouping.
		do
			Result := internal_refined_grouping
			debug ("docking")
				print ("%NSD_MENU_GROUP_DIVIDER OY_OY_OY_OY best_grouping: Result.group_count = " + Result.group_count.out)
				print ("%N                      OY_OY_OY_OY best_grouping: Result.total_items_count = " + Result.total_items_count.out)
			end
		end

	maximum_group_width (a_group_idnex: INTEGER): INTEGER is
			-- Maimum group width.
		do
			Result := algorithm.maximum_group_width (a_group_idnex)
		end

	content: SD_MENU_CONTENT
			-- Menu content managed by Current.

	algorithm: SD_MENU_GROUP_ALGORITHM
			-- Algorithm for grouping.

feature {NONE} -- Implementation

	compute_extra_groups (a_extra_group_count: INTEGER) is
			-- Compute extra groups when all top groups are all in separated row.
		require
			valid: a_extra_group_count > 0
		local
			l_max_group_info: SD_MENU_GROUP_INFO
			l_temp_algorithm: SD_MENU_GROUP_ALGORITHM
			l_sub_grouping: SD_MENU_GROUP_INFO
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
				debug ("docking")
					print ("%NSD_MENU_GROUP_DIVIDER compute_extra_groups BaoBaoBaoBaoBaoBaoBaoBao maximum_width_group_index is: " + (internal_refined_grouping.maximum_width_group_index).out)
					print ("%N                                                                    group count is: " + ((content.group (internal_refined_grouping.maximum_width_group_index).count)).out)
				end
				l_temp_algorithm.set_items_with_width (group_item_width (content.group (internal_refined_grouping.maximum_width_group_index)))
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

	internal_refined_grouping: SD_MENU_GROUP_INFO
			-- Refined grouping info.

invariant

	not_void: algorithm /= Void

end
