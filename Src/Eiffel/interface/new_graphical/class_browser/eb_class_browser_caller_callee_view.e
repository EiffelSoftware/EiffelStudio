indexing
	description: "View to display caller/callee information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_CALLER_CALLEE_VIEW

inherit
	EB_CLASS_BROWSER_SORTABLE_TREE_VIEW [EB_CLASS_BROWSER_CALLER_CALLEE_ROW]
		rename
			make as view_make
		redefine
			data
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

	EB_SHARED_EDITOR_TOKEN_UTILITY

create
	make

feature{NONE} -- Initialization

	make (a_dev_window: like development_window; a_drop_actions: like drop_actions; a_sorting_order_preference: like sorting_order_preference; a_for_caller: BOOLEAN) is
			-- Initialize.
		require
			a_dev_window_attached: a_dev_window /= Void
			a_drop_actions_attached: a_drop_actions /= Void
			a_sorting_order_preference_attached: a_sorting_order_preference /= Void
		do
			sorting_order_preference := a_sorting_order_preference
			view_make (a_dev_window, a_drop_actions)
			set_sorting_status (sorted_columns_from_string (sorting_order_preference.value))
			is_for_caller := a_for_caller
		end

feature -- Access

	control_bar: EV_WIDGET is
			-- Widget of a control bar through which, certain control can be performed upon current view
		local
			l_tool_bar: EV_TOOL_BAR
		do
			if control_tool_bar = Void then
				create control_tool_bar
				create l_tool_bar
				l_tool_bar.extend (create{EV_TOOL_BAR_SEPARATOR})
				l_tool_bar.extend (show_tooltip_button)
				control_tool_bar.set_padding (2)
				control_tool_bar.extend (l_tool_bar)
				control_tool_bar.disable_item_expand (l_tool_bar)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	control_tool_bar: EV_HORIZONTAL_BOX
			-- Implementation of `control_bar'

	sorting_order_preference: STRING_PREFERENCE
			-- Preference to store sorting order

	version_count: INTEGER
			-- Number of versions for caller/callee

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN
			-- Should tooltip be displayed?
		do
			Result := show_tooltip_button.is_selected
		end

	is_for_caller: BOOLEAN
			-- Is Current view to display caller information?

	is_for_callee: BOOLEAN is
			-- Is Current view to display callee information?
		do
			Result := not is_for_caller
		ensure
			good_result: Result = not is_for_caller
		end

feature -- Setting

	set_version_count (a_version_count: INTEGER) is
			-- Set `version_count' with `a_version_count'.
		do
			version_count := a_version_count
		ensure
			version_count_set: version_count = a_version_count
		end

feature -- Grind binding

	update_view is
			-- Update current view according to change in `model'.
		local
			l_msg: STRING_32
		do
			if not is_up_to_date then
				if data /= Void then
					text.hide
					component_widget.show
					fill_rows
					disable_auto_sort_order_change
					enable_force_multi_column_sorting
					sort (0, 0, 1, 0, 0, 0, 0, 0, last_sorted_column)
					disable_force_multi_column_sorting
					enable_auto_sort_order_change
				else
					component_widget.hide
					text.show
					l_msg := Warning_messages.w_Formatter_failed.twin
					if trace /= Void then
						l_msg.append ("%N")
						l_msg.append (trace)
					end
					text.set_text (l_msg)
				end
				is_up_to_date := True
			end
		end

	fill_rows is
			-- Fill rows with `data'.
		local
			l_data: like data
			l_feature: QL_FEATURE
			l_related_feature: QL_FEATURE
			l_table: HASH_TABLE [HASH_TABLE [LINKED_LIST [QL_FEATURE], CLASS_C], QL_FEATURE]
			l_inner_tbl: HASH_TABLE [LINKED_LIST [QL_FEATURE], CLASS_C]
			l_class_c: CLASS_C
			l_feature_list: LINKED_LIST [QL_FEATURE]
			l_rows: like rows
			l_related_feature_rows: EB_TREE_NODE [like row_type]
			l_feature_rows: EB_TREE_NODE [like row_type]
			l_class_rows: EB_TREE_NODE [like row_type]
			l_version_count: INTEGER
		do
			l_data := data
			check l_data /= Void end
			create l_table.make (20)
			from
				l_data.start
			until
				l_data.after
			loop
				l_feature := l_data.item
				l_related_feature ?= l_feature.data
				check l_related_feature /= Void end
				if l_table.has (l_related_feature) then
					l_inner_tbl := l_table.item (l_related_feature)
				else
					l_version_count := l_version_count + 1
					create l_inner_tbl.make (20)
					l_table.put (l_inner_tbl, l_related_feature)
				end
				l_class_c := l_feature.class_c
				if l_inner_tbl.has (l_class_c) then
					l_feature_list := l_inner_tbl.item (l_class_c)
				else
					create l_feature_list.make
					l_inner_tbl.put (l_feature_list, l_class_c)
				end
				l_feature_list.extend (l_feature)
				l_data.forth
			end
			set_version_count (l_version_count)

			l_rows := rows
			l_rows.children.wipe_out

			from
				l_table.start
			until
				l_table.after
			loop
				l_related_feature_rows := new_node (l_table.key_for_iteration, Void, {like row_type}.compact_feature_row)
				l_rows.children.force_last (l_related_feature_rows)

				l_inner_tbl := l_table.item_for_iteration
				from
					l_inner_tbl.start
				until
					l_inner_tbl.after
				loop
					l_class_rows := new_node (l_inner_tbl.item_for_iteration.first, Void, {like row_type}.class_row)
					l_related_feature_rows.children.force_last (l_class_rows)
					l_feature_list := l_inner_tbl.item_for_iteration
					from
						l_feature_list.start
					until
						l_feature_list.after
					loop
						l_feature_rows := new_node (l_feature_list.item, l_table.key_for_iteration, {like row_type}.feature_name_row)
						l_class_rows.children.force_last (l_feature_rows)
						l_feature_list.forth
					end
					l_inner_tbl.forth
				end
				l_table.forth
			end
		end

	bind_grid is
			-- Bind `data' into `grid'.
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [EB_TREE_NODE [like row_type]]
			l_grid_row: EV_GRID_ROW
		do
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
			l_cursor := rows.children.new_cursor
			if version_count > 1 then
				grid.insert_new_row (1)
				l_grid_row := grid.row (1)
				l_grid_row.set_item (1, first_row_item)
			end
			from
				l_cursor.start
			until
				l_cursor.after
			loop
				bind_level (1, l_cursor.item, l_grid_row, True)
				l_cursor.forth
			end
			if version_count > 1 then
				if l_grid_row.is_expandable and then not l_grid_row.is_expanded then
					l_grid_row.expand
				end
			elseif version_count = 1 then
				grid.row (1).expand
			end
			if not has_grid_been_binded then
				auto_resize_grid
				set_has_grid_been_binded (True)
			end

		end

	bind_level (a_level_index: INTEGER; a_node: EB_TREE_NODE [like row_type]; a_grid_row: EV_GRID_ROW; a_recursive: BOOLEAN) is
			-- Bind data in `a_node' whose level index is `a_level_index' in `a_grid_row'.
			-- If `a_recursive' is True, bind `children' of `a_node recursively.
			-- If `a_grid_row' is Void, insert as base row in `grid'.
		require
			a_node_attached: a_node /= Void
		local
			l_grid: like grid
			l_grid_row: EV_GRID_ROW
			l_cursor: DS_ARRAYED_LIST_CURSOR [EB_TREE_NODE [like row_type]]
			l_children_count: INTEGER
		do
			l_grid := grid
			if a_grid_row = Void then
				l_grid.insert_new_row (l_grid.row_count + 1)
				l_grid_row := l_grid.row (l_grid.row_count)
			else
				a_grid_row.insert_subrow (a_grid_row.subrow_count + 1)
				l_grid_row := a_grid_row.subrow (a_grid_row.subrow_count)
			end

			a_node.data.bind_row (l_grid_row, level_starting_column_index.i_th (a_level_index))
				-- Bind subrows.
			l_children_count := a_node.children.count
			if a_recursive and then l_children_count > 0 then
				l_cursor := a_node.children.new_cursor
--				l_grid_row.insert_subrows (l_children_count, 1)
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					bind_level (a_level_index + 1, l_cursor.item, l_grid_row, a_recursive)
					l_cursor.forth
				end
			end
			if l_grid_row.is_expandable and then not l_grid_row.is_expanded then
				l_grid_row.expand
			end
		end

feature{NONE} -- Actions

	on_post_sort (a_sorting_status_snapshot: LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]]) is
			-- Action to be performed after a sorting
		do
			sorting_order_preference.set_value (string_representation_of_sorted_columns)
		end

feature{NONE} -- Implementation

	item_to_put_in_editor: EV_GRID_ITEM is
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.			
		do
		end

	data: QL_FEATURE_DOMAIN
			-- Data to be displayed in current view

	new_node (a_feature, a_related_feature: QL_FEATURE; a_row_type: INTEGER): EB_TREE_NODE [like row_type] is
			-- New caller/callee row of type `a_row_type' representing `a_feature' and `a_related_feature'
		require
			a_feature_attached: a_feature /= Void
		do
			create Result
			Result.set_data (create {like row_type}.make (Current, a_feature, a_related_feature, a_row_type, is_for_caller))
		ensure
			result_attached: Result /= Void
		end

	auto_resize_grid is
			-- Auto resize `grid'.
		local
			l_table: HASH_TABLE [TUPLE [INTEGER, INTEGER], INTEGER]
		do
			if grid.row_count > 0 then
				create l_table.make (1)
				l_table.put ([150, 800], 1)
				auto_resize_columns (grid, l_table)
			end
		end

feature{NONE} -- Implementation/Sorting

	row_order_tester (a_row, b_row: like row_type; a_order: INTEGER): BOOLEAN is
			-- Tester to decide the oder of `a_row' and `b_row' according sorting order `a_order'
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		local
			l_a_top_id, l_b_top_id: INTEGER
		do
			if a_order = topology_order then
				l_a_top_id := a_row.feature_item.class_c.topological_id
				l_b_top_id := b_row.feature_item.class_c.topological_id
				if l_a_top_id /= l_b_top_id then
					Result := l_a_top_id < l_b_top_id
				else
					Result := a_row.image < b_row.image
				end
			elseif a_order = ascending_order then
				Result := a_row.image < b_row.image
			elseif a_order = descending_order then
				Result := a_row.image >= b_row.image
			end
		end

	first_row_item: EV_GRID_ITEM is
			-- Grid item for first row
		local
			l_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_text: STRING
		do
			l_text := version_count.out
			l_text.append (" ")
			l_text.append (interface_names.le_versions)
			plain_text_style.set_source_text (l_text)
			create l_item
			l_item.set_text_with_tokens (plain_text_style.text)
			l_item.set_pixmap (pixmaps.icon_pixmaps.feature_group_icon)
			Result := l_item
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Initialization

	build_grid is
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (2)
			grid.enable_selection_on_single_button_click
			grid.enable_single_row_selection
			grid.enable_tree
			grid.set_row_height (default_row_height)
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end
			enable_ctrl_right_click_to_open_new_window
			grid.focus_in_actions.extend (agent on_grid_focus_in)
			grid.focus_out_actions.extend (agent on_grid_focus_out)
			grid.row_select_actions.extend (agent highlight_row)
			grid.row_deselect_actions.extend (agent dehighlight_row)
			grid.key_press_actions.extend (agent on_key_pressed)
			grid.hide_tree_node_connectors
			grid.enable_multiple_row_selection
			enable_tree_node_highlight
			enable_grid_item_pnd_support
			set_select_all_action (agent do  end)

			level_starting_column_index.wipe_out
			level_starting_column_index.extend (1)
			level_starting_column_index.extend (1)
			level_starting_column_index.extend (1)
			levels_column_table.put ((<<1, 2, 3>>).linear_representation, 1)
			grid.set_focused_selection_color (preferences.editor_data.selection_background_color)
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [like row_type]
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column_internal := 0
			create l_sort_info.make (agent row_order_tester, ascending_order)
			set_sort_action (agent sort_agent)
			l_sort_info.enable_auto_indicator
			set_sort_info (1, l_sort_info)

				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
			grid.register_shortcut (
				create{ES_KEY_SHORTCUT}.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_left), True, False, False),
				agent on_collapse_one_level_partly
			)
		end


invariant
	sorting_order_preference_attached: sorting_order_preference /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
