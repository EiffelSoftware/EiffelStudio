note
	description: "Feature browser to display information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_BROWSER_GRID_VIEW

inherit
	EB_CLASS_BROWSER_GRID_VIEW [EB_FEATURE_BROWSER_GRID_ROW]
		redefine
			data,
			recycle_agents,
			default_ensure_visible_action
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

create
	make

feature -- Status report

	is_branch_id_used: BOOLEAN
			-- Is branch id used?

	is_written_class_used: BOOLEAN
			-- Is written class used

	is_signature_displayed: BOOLEAN
			-- Is full feature signature displayed?
			-- If False, just display feature name.

	is_version_from_displayed: BOOLEAN
			-- Is message "version from" displayed?

	should_tooltip_be_displayed: BOOLEAN
			-- Should tooltip display be vetoed?
		do
			Result := show_tooltip_button.is_selected
		ensure then
			good_result: Result = show_tooltip_button.is_selected
		end

	is_last_sorted_column_valid (a_column_index: INTEGER): BOOLEAN
			-- Is last sorted column valid?
			-- Last sorted column may become invalid because columns in grid changes.
		do
			Result := a_column_index >= 1 and then a_column_index <= grid_column_count
		end

feature -- Setting

	set_is_written_class_used (b: BOOLEAN)
			-- Set `is_written_class_used' with `b'.
		do
			is_written_class_used := b
		ensure
			is_written_class_used_set: is_written_class_used = b
		end

	set_is_branch_id_used (b: BOOLEAN)
			-- Set `is_branch_id_used' with `b'.
		do
			is_branch_id_used := b
		ensure
			is_branch_id_used_set: is_branch_id_used = b
		end

	set_is_signature_displayed (b: BOOLEAN)
			-- Set `is_signature_displayed' with `b'.
		do
			is_signature_displayed := b
		ensure
			is_signature_displayed_set: is_signature_displayed = b
		end

	set_is_version_from_displayed (b: BOOLEAN)
			-- Set `is_version_from_displayed' with `b'.
		do
			is_version_from_displayed := b
		ensure
			is_version_from_displayed_set: is_version_from_displayed = b
		end

	set_feature_item (a_feature: like feature_item)
			-- Set `feature_item' with `a_feature'.
		require
			a_feature_attached: a_feature /= Void
		do
			feature_item := a_feature
		ensure
			feature_item_set: feature_item = a_feature
		end

	rebuild_interface
			-- Rebuild interface
		local
			l_written_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [EB_FEATURE_BROWSER_GRID_ROW]
		do
			if is_written_class_used then
				grid.column (3).header_item.set_text (interface_names.l_version_from)
				create l_written_class_sort_info.make (agent written_class_tester, ascending_order)
				l_written_class_sort_info.enable_auto_indicator
				set_sort_info (3, l_written_class_sort_info)
			else
				grid.column (3).header_item.set_text ("")
				remove_sort_info (3)
				grid.column (3).clear
			end
		end

feature -- Actions

	on_key_pressed (a_key: EV_KEY)
			-- Action to be performed when some key is pressed in `grid'
		require
			a_key_attached: a_key /= Void
		local
			l_processed: BOOLEAN
		do
			l_processed := on_predefined_key_pressed (a_key)
		end

	on_expand_all_level
			-- Action to be performed to recursively expand all selected rows.
		do
			do_all_in_items (grid.selected_items, agent expand_item)
		end

	on_collapse_all_level
			-- Action to be performed to recursively collapse all selected rows.
		do
			do_all_in_items (grid.selected_items, agent collapse_item)
		end

	on_expand_one_level
			-- Action to be performed to expand all selected rows.
		local
			l_selected_items: LIST [EV_GRID_ITEM]
			l_item: EV_GRID_ITEM
			l_done: BOOLEAN
		do
			l_selected_items := grid.selected_items
			if l_selected_items.count = 1 then
				l_item := l_selected_items.first
				if l_item.column.index = 1 then
					if not l_item.row.is_expandable or else l_item.row.is_expanded then
						go_to_first_child (l_item.row)
						l_done := True
					end
				end
			end
			if not l_done then
				do_all_in_items (grid.selected_items, agent expand_item)
			end
		end

	on_collapse_one_level
			-- Action to be performed to collapse all selected rows.
		local
			l_selected_items: LIST [EV_GRID_ITEM]
			l_item: EV_GRID_ITEM
			l_done: BOOLEAN
		do
			l_selected_items := grid.selected_items
			if l_selected_items.count = 1 then
				l_item := l_selected_items.first
				if l_item.column.index = 1 then
					if not l_item.row.is_expandable or else not l_item.row.is_expanded then
						if l_item.column.index = 1 then
							go_to_parent (l_item.row)
						end
						l_done := True
					end
				end
			end
			if not l_done then
				do_all_in_items (grid.selected_items, agent collapse_item)
			end
		end

feature -- Access

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Widget of a control bar through which, certain control can be performed upon current view
		do
			if control_tool_bar = Void then
				create control_tool_bar.make (2)
				control_tool_bar.extend (create{SD_TOOL_BAR_SEPARATOR}.make)
				control_tool_bar.extend (show_tooltip_button)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	feature_item: e_feature
			-- Feature whose information is to be displayed						

feature{NONE} -- Initialization

	bind_grid
			-- Bind `grid'.
		local
			l_rows: like rows
			l_bg_color: EV_COLOR
			l_branch_row: EV_GRID_ROW
			l_cur_branch_id: INTEGER
			l_grid: like grid
			l_bid: INTEGER_REF
			l_row: EB_FEATURE_BROWSER_GRID_ROW
		do
			l_grid := grid
			l_bg_color := preferences.class_browser_data.even_row_background_color
			l_rows := rows
			if l_grid.row_count > 0 then
				l_grid.remove_rows (1, l_grid.row_count)
			end
			l_grid.set_row_height (default_row_height)
			l_grid.enable_tree
			l_grid.show_tree_node_connectors
			if not l_rows.is_empty then
				from
					l_rows.start
				until
					l_rows.after
				loop
					if is_branch_id_used then
						l_bid ?= l_rows.item_for_iteration.feature_item.data
						if l_bid /= Void then
							if l_bid.item /= l_cur_branch_id then
								l_branch_row := Void
								l_cur_branch_id := l_bid.item
							end
						end
						if l_branch_row = Void then
							l_grid.insert_new_row (l_grid.row_count + 1)
							l_branch_row := l_grid.row (l_grid.row_count)
							l_branch_row.set_item (1, branch_item (l_cur_branch_id))
						end
					end
					l_row := rows.item_for_iteration
					l_row.bind_row (l_branch_row, grid, l_bg_color, 0)
					if l_branch_row /= Void and then l_branch_row.is_expandable then
						l_branch_row.expand
					end
					l_rows.forth
				end
			end
		end

	build_grid
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (3)
			if is_written_class_used then
				grid.header.i_th (3).set_text (interface_names.l_version_from)
			else
				grid.header.i_th (3).set_text ("")
			end
			grid.enable_selection_on_single_button_click
			grid.header.i_th (1).set_text (interface_names.l_class_browser_classes)
			grid.header.i_th (2).set_text (interface_names.l_class_browser_features)
			grid.enable_tree
			grid.enable_multiple_item_selection
			grid.key_press_actions.extend (agent on_key_pressed)
			enable_ctrl_right_click_to_open_new_window
			enable_grid_item_pnd_support
		end

	build_sortable_and_searchable
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [EB_FEATURE_BROWSER_GRID_ROW]
			l_feature_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_FEATURE_BROWSER_GRID_ROW]
			l_written_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [EB_FEATURE_BROWSER_GRID_ROW]
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column_internal := 0
			set_sort_action (agent sort_agent)
			create l_class_sort_info.make (agent class_tester, topology_order)
			create l_feature_sort_info.make (agent feature_name_tester, ascending_order)
			if is_written_class_used then
				create l_written_class_sort_info.make (agent written_class_tester, ascending_order)
				l_written_class_sort_info.enable_auto_indicator
				set_sort_info (3, l_written_class_sort_info)
			end
			l_class_sort_info.enable_auto_indicator
			l_feature_sort_info.enable_auto_indicator
			set_sort_info (1, l_class_sort_info)
			set_sort_info (2, l_feature_sort_info)
				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
		end

feature -- Notification

	provide_result
			-- Provide result displayed in Current view.
		do
			fill_rows
			if last_sorted_column_internal = 0 then
				last_sorted_column_internal := class_column
			end
			disable_auto_sort_order_change
			enable_force_multi_column_sorting
			if not sorted_columns.is_empty and then is_last_sorted_column_valid (sorted_columns.last) then
				sort (0, 0, 1, 0, 0, 0, 0, 0, sorted_columns.last)
			else
				sort (0, 0, 1, 0, 0, 0, 0, 0, class_column)
			end
			disable_force_multi_column_sorting
			enable_auto_sort_order_change
			try_auto_resize_grid (<<[150, 300, 1]>>, False)
			if not is_written_class_used then
				try_auto_resize_grid (<<[-1, 0, 2]>>, True)
			else
				try_auto_resize_grid (<<[300, 500, 2]>>, True)
			end
		end

	fill_rows
			-- Fill `rows' using `data'.
		local
			l_data: like data
			l_row: EB_FEATURE_BROWSER_GRID_ROW
			l_bid: INTEGER_REF
			l_feature: QL_FEATURE
			l_branch_id: INTEGER
			l_rows: like rows
			l_is_first: BOOLEAN
			l_last_bid: INTEGER
			l_is_single_branch_id: BOOLEAN
			l_written_class_used: BOOLEAN
		do
			l_rows := rows
			l_rows.wipe_out
			l_data := data
			from
				l_data.start
				l_is_first := True
				l_is_single_branch_id := True
				l_written_class_used := is_written_class_used
			until
				l_data.after
			loop
				l_feature := l_data.item
				l_bid ?= l_feature.data
				if l_bid /= Void then
					l_branch_id := l_bid.item
				else
					l_branch_id := 0
				end
				if l_is_first then
					l_is_first := False
				else
					if l_is_single_branch_id then
						l_is_single_branch_id := l_last_bid = l_branch_id
					end
				end
				l_last_bid := l_branch_id
				create l_row.make (l_data.item, l_branch_id, Current, l_written_class_used, is_signature_displayed)
				l_rows.force_last (l_row)
				l_data.forth
			end
			set_is_branch_id_used (not l_is_single_branch_id)
		end

feature -- Visiability

	default_ensure_visible_action (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN)
			-- Ensure that `a_item' is visible.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		local
			l_grid_row: EV_GRID_ROW
			l_grid_item: EV_GRID_ITEM
		do
			grid.remove_selection
			l_grid_item := a_item.grid_item
			l_grid_row := l_grid_item.row
			if attached {EB_FEATURE_BROWSER_GRID_ROW} l_grid_row.data as l_row then
				if attached l_row.parent as l_parent then
					if l_parent.is_expandable then
						l_parent.expand
					end
					l_grid_row.ensure_visible
				else
					if attached l_grid_item.parent then
						l_grid_item.ensure_visible
					end
				end
				l_grid_item.enable_select
			else
				l_grid_row.enable_select
			end
		end

feature{NONE} -- Sorting

	class_column: INTEGER = 1
			-- Column index for class

	feature_column: INTEGER = 2
			-- Column index for feature

	written_class_column: INTEGER = 3
			-- Column index for written class

	feature_name_tester (row_a, row_b: EB_FEATURE_BROWSER_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		do
			if row_a.branch_id /= row_b.branch_id then
				Result := row_a.branch_id < row_b.branch_id
			else
				if a_order = ascending_order then
					Result := row_a.feature_image < row_b.feature_image
				else
					Result := row_a.feature_image > row_b.feature_image
				end
			end
		end

	class_tester (row_a, row_b: EB_FEATURE_BROWSER_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
		do
			if row_a.branch_id /= row_b.branch_id then
				Result := row_a.branch_id < row_b.branch_id
			else
				l_class_a_name := row_a.feature_item.class_c.name
				l_class_b_name := row_b.feature_item.class_c.name
				if a_order = topology_order then
					Result := row_a.feature_item.class_c.topological_id < row_b.feature_item.class_c.topological_id
				else
					if a_order = ascending_order then
						Result := l_class_a_name < l_class_b_name
					else
						Result := l_class_a_name > l_class_b_name
					end
				end
			end
		end

	written_class_tester (row_a, row_b: EB_FEATURE_BROWSER_GRID_ROW; a_order: INTEGER): BOOLEAN
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
		do
			if row_a.branch_id /= row_b.branch_id then
				Result := row_a.branch_id < row_b.branch_id
			else
				l_class_a_name := row_a.feature_item.written_class.name
				l_class_b_name := row_b.feature_item.written_class.name
				if a_order = topology_order then
					Result := row_a.feature_item.written_class.topological_id < row_b.feature_item.written_class.topological_id
				else
					if a_order = ascending_order then
						Result := l_class_a_name < l_class_b_name
					else
						Result := l_class_a_name > l_class_b_name
					end
				end
			end
		end

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EB_FEATURE_BROWSER_GRID_ROW])
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		local
			l_sorter: DS_QUICK_SORTER [EB_FEATURE_BROWSER_GRID_ROW]
		do
			create l_sorter.make (a_comparator)
			l_sorter.sort (rows)
			bind_grid
		end

feature -- Recyclable

	recycle_agents
			-- Recyclable
		do
			Precursor {EB_CLASS_BROWSER_GRID_VIEW}
		end

feature{NONE} -- Implementation

	data: QL_FEATURE_DOMAIN
			-- Data to be displayed

	rows: DS_ARRAYED_LIST [EB_FEATURE_BROWSER_GRID_ROW]
			-- Rows to be displayed
		do
			if rows_internal = Void then
				create rows_internal.make (50)
			end
			Result := rows_internal
		ensure
			result_attached: Result /= Void
		end

	rows_internal: like rows
			-- Implementation of `rows'	

	control_tool_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Implementation of `control_bar'

	branch_item (a_branch_id: INTEGER): EB_GRID_EDITOR_TOKEN_ITEM
			-- A grid item to display branch id
		do
			create Result
			branch_item_style.set_source_text (interface_names.le_branch (a_branch_id))
			Result.set_text_with_tokens (branch_item_style.text)
			Result.set_pixmap (pixmaps.icon_pixmaps.feature_group_icon)
		ensure
			result_attached: Result /= Void
		end

	branch_item_style: EB_TEXT_EDITOR_TOKEN_STYLE
			-- Style to generate editor tokens for branch items
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	expand_item (a_item: EV_GRID_ITEM)
			-- Expand `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.parent /= Void
		do
			if a_item.column.index = 1 then
				if a_item.row.is_expandable then
					a_item.row.expand
				end
			end
		end

	collapse_item (a_item: EV_GRID_ITEM)
			-- Collapse `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.parent /= Void
		do
			if a_item.column.index = 1 then
				if a_item.row.is_expandable then
					a_item.row.collapse
				end
			end
		end

feature{NONE} -- Implementation/Stone

	item_to_put_in_editor: EV_GRID_ITEM
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.			
		do
			Result := item_to_put_in_editor_for_single_item_grid
		end

note
        copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
        source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
