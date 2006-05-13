indexing
	description: "Tree view in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_TREE_VIEW

inherit

	EB_CLASS_BROWSER_GRID_VIEW
		redefine
			data
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

	SHARED_WORKBENCH

	EB_SHARED_PIXMAPS

create
	make

feature -- Access

	control_bar: EV_WIDGET is
			-- Widget of a control bar through which, certain control can be performed upon current view
		do
			if control_tool_bar = Void then
				create control_tool_bar
				control_tool_bar.extend (create {EV_TOOL_BAR_SEPARATOR})
				control_tool_bar.extend (expand_button)
				control_tool_bar.extend (collapse_button)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	control_tool_bar: EV_TOOL_BAR
			-- Tool bar of current view

	collapse_button: EV_TOOL_BAR_BUTTON is
			-- Button to collapse one level of tree
		do
			if collapse_button_internal = Void then
				create collapse_button_internal
				collapse_button_internal.set_pixmap (icon_collapse_all)
				collapse_button_internal.set_tooltip (interface_names.l_collapse_layer)
				collapse_button_internal.select_actions.extend (agent on_row_collapsed)
			end
			Result := collapse_button_internal
		ensure
			result_attached: Result /= Void
		end

	expand_button: EV_TOOL_BAR_BUTTON is
			-- Button to expand one level of tree
		do
			if expand_button_internal = Void then
				create expand_button_internal
				expand_button_internal.set_pixmap (icon_expand_all)
				expand_button_internal.set_tooltip (interface_names.l_expand_layer)
				expand_button_internal.select_actions.extend (agent on_row_expanded)
			end
			Result := expand_button_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Actions

	on_row_expanded is
			-- Action to be performed when a row is expanded
		local
			l_rows: LIST [EV_GRID_ROW]
		do
			l_rows := grid.selected_rows
			if l_rows.is_empty and then grid.row_count > 0 then
				l_rows.extend (grid.row (1))
			end
			if not l_rows.is_empty then
				l_rows.do_all (agent expand_row)
			end
		end

	on_row_collapsed is
			-- Action to be performed when a row is collapsed
		local
			l_rows: LIST [EV_GRID_ROW]
		do
			l_rows := grid.selected_rows
			if l_rows.is_empty and then grid.row_count > 0 then
				l_rows.extend (grid.row (1))
			end
			if not l_rows.is_empty then
				l_rows.do_all (agent collapse_row)
			end
		end

	on_color_or_font_changed is
			-- Action performed when color or font used to display editor tokens changes
		do
			if grid.is_displayed then
				fill_rows
				bind_grid
			else
				text.set_background_color (editor_preferences.normal_background_color)
				text.set_foreground_color (editor_preferences.normal_text_color)
				text.set_font (font)
				text.refresh_now
			end
		end

feature -- Notification

	update_view is
			-- Update current view according to change in `model'.
		do
			if not is_up_to_date then
				if data /= Void then
					text.hide
					component_widget.show
					fill_rows
					if last_sorted_column = 0 then
						last_sorted_column := 1
					end
					disable_auto_sort_order_change
					sort (0, 0, 0, 0, 0, 0, 0, 0, 1)
					enable_auto_sort_order_change
				else
					component_widget.hide
					text.show
					text.set_text (Warning_messages.w_Formatter_failed)
				end
				is_up_to_date := True
			end
		end

feature -- Sorting

	class_sorter (a_order: INTEGER) is
			-- Sorter for class name
		local
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EB_CLASS_BROWSER_TREE_ROW]
			l_sorter: DS_QUICK_SORTER [EB_CLASS_BROWSER_TREE_ROW]
		do
			create l_agent_sorter.make (agent class_name_tester)
			create l_sorter.make (l_agent_sorter)
			fill_rows
			sort_classes (rows, l_sorter)
			bind_grid
		end

	sort_classes (a_classes: DS_LIST [EB_CLASS_BROWSER_TREE_ROW]; a_sorter: DS_QUICK_SORTER [EB_CLASS_BROWSER_TREE_ROW]) is
			-- Sort `a_class' using `a_sorter'.
		require
			a_classes_attached: a_classes /= Void
			a_sorter_attached: a_sorter /= Void
		do
			a_sorter.sort (a_classes)
			from
				a_classes.start
			until
				a_classes.after
			loop
				if not a_classes.item_for_iteration.children.is_empty then
					sort_classes (a_classes.item_for_iteration.children, a_sorter)
				end
				a_classes.forth
			end
		end

	class_name_tester (row_a, row_b: EB_CLASS_BROWSER_TREE_ROW): BOOLEAN is
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
		do
			l_class_a_name := row_a.class_item.name
			l_class_b_name := row_b.class_item.name
			if current_class_sort_order = topology_order then
				Result := row_a.class_item.class_c.topological_id < row_b.class_item.class_c.topological_id
			else
				if l_class_a_name.is_equal (l_class_b_name) then
					Result := not row_a.is_collapsed and then row_b.is_collapsed
				else
					if current_class_sort_order = ascending_order then
						Result := l_class_a_name < l_class_b_name
					else
						Result := l_class_a_name > l_class_b_name
					end
				end
			end
		end

	class_tester (class_a, class_b: QL_CLASS): BOOLEAN is
			-- Compare `row_a' and `row_b' ascendingly.
		require
			class_a_valid: class_a /= Void
			class_b_valid: class_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
		do
			l_class_a_name := class_a.name
			l_class_b_name := class_b.name
			if current_class_sort_order = topology_order then
				Result := class_a.class_c.topological_id < class_b.class_c.topological_id
			elseif current_class_sort_order = ascending_order then
				Result := l_class_a_name < l_class_b_name
			else
				Result := l_class_a_name > l_class_b_name
			end
		end

	current_class_sort_order: INTEGER is
			-- Current sort order on class column
		do
			Result := column_sort_info.item (1).current_order
		end

feature{NONE} -- Implementation

	data: QL_CLASS_DOMAIN
			-- Data to be displayed in current view

	rows: DS_ARRAYED_LIST [EB_CLASS_BROWSER_TREE_ROW] is
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

	expand_button_internal: like expand_button
			-- Implementation of `expand_button'

	collapse_button_internal: like collapse_button
			-- Implementation of `collapse_button'

	ensure_visible (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN) is
			-- Ensure `a_item' is visible in viewable area of `grid'.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		local
			l_grid_item: EV_GRID_ITEM
			l_grid_row: EV_GRID_ROW
			l_row: EB_CLASS_BROWSER_TREE_ROW
		do
			l_grid_item := a_item.grid_item
			check l_grid_item /= Void end
			l_grid_row := l_grid_item.row
			check l_grid_row /= Void end
			l_row ?= l_grid_row.data
			check l_row /= Void end
			l_row.expand_row
			grid.remove_selection
			l_grid_row.ensure_visible
			l_grid_row.enable_select
		end

	fill_rows  is
			-- Fill rows with `data'.
		local
			l_data: like data
			l_row: EB_CLASS_BROWSER_TREE_ROW
			l_rows: like rows
		do
			l_rows := rows
			l_rows.wipe_out
			l_data := data
			if start_class = Void then
				from
					l_data.start
				until
					l_data.after
				loop
					create l_row.make (l_data.item, False)
					l_rows.force_last (l_row)
					l_data.forth
				end
			else
				processed_classes.wipe_out
				data.compare_objects
				data.start
				data.search (start_class)
				check not data.exhausted end
				create l_row.make (data.item, False)
				l_rows.force_last (l_row)
				fill_row_tree (l_row)
			end
		end

	fill_row_tree (a_row: EB_CLASS_BROWSER_TREE_ROW) is
			-- Fill row tree.
		require
			a_row_attached: a_row /= Void
		local
			l_list: DS_ARRAYED_LIST [QL_CLASS]
			l_row: EB_CLASS_BROWSER_TREE_ROW
			l_processed_classes: like processed_classes
			l_class: QL_CLASS
			any_class_id: INTEGER
			l_list2: ARRAYED_LIST [QL_CLASS]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [QL_CLASS]
			l_sorter: DS_QUICK_SORTER [QL_CLASS]
		do
			l_list2 ?= a_row.class_item.data
			if l_list2 /= Void and then not l_list2.is_empty then
				l_processed_classes := processed_classes
				any_class_id := system.any_id
				create l_list.make (l_list2.count)
				l_list2.do_all (agent l_list.force_last)
				create l_agent_sorter.make (agent class_tester)
				create l_sorter.make (l_agent_sorter)
				l_sorter.sort (l_list)
				from
					l_list.start
				until
					l_list.after
				loop
					l_class := l_list.item_for_iteration
					if l_processed_classes.has (l_class) then
						l_list2 ?= l_class.data
						if l_list2 /= Void and then not l_list2.is_empty then
							create l_row.make (l_class, True)
						else
							create l_row.make (l_class, False)
						end
						a_row.add_child (l_row)
					else
						create l_row.make (l_class, False)
						a_row.add_child (l_row)
						if l_class.class_c.class_id /= any_class_id then
							if l_processed_classes.count = l_processed_classes.capacity then
								l_processed_classes.resize (l_processed_classes.capacity + 50)
							end
							l_processed_classes.force_last (l_class)
							fill_row_tree (l_row)
						end
					end
					l_list.forth
				end
			end
		end

	processed_classes: DS_HASH_SET [QL_CLASS] is
			-- Processed classes
		do
			if processed_classes_internal = Void then
				create processed_classes_internal.make (100)
			end
			Result := processed_classes_internal
		ensure
			result_attached: Result /= Void
		end

	processed_classes_internal: like processed_classes
			-- Implementation of `processed_classes'

	bind_grid is
			-- Bind `rows' in `grid'.
		local
			l_row: EB_CLASS_BROWSER_TREE_ROW
			l_rows: like rows
			l_bg_color: EV_COLOR
		do
			l_bg_color := preferences.class_browser_data.even_row_background_color
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
			grid.hide_tree_node_connectors
			grid.set_row_height (line_height)
			from
				l_rows := rows
				l_rows.start
			until
				l_rows.after
			loop
				l_row := rows.item_for_iteration
				l_row.bind_row (Void, grid, l_bg_color, 0)
				l_rows.forth
			end
		end

feature{NONE} -- Initialization

	build_grid is
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (1)
			grid.enable_selection_on_single_button_click
			grid.header.i_th (1).set_text (interface_names.l_class_browser_classes)
			grid.enable_tree
			grid.set_row_height (line_height)
			grid.pick_ended_actions.force_extend (agent on_pick_ended)
			grid.set_item_pebble_function (agent on_pick)
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
			l_quick_search_bar: EB_GRID_QUICK_SEARCH_TOOL
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column := 0
			create l_class_sort_info.make (grid.column (1), agent class_sorter, ascending_order)
			l_class_sort_info.enable_auto_indicator
			set_sort_info (l_class_sort_info, 1)

				-- Prepare search facilities
			create l_quick_search_bar.make (development_window)
			l_quick_search_bar.attach_tool (Current)
			enable_search
		end

	expand_row (a_row: EV_GRID_ROW) is
			-- Expand `a_row' recursively.
		require
			a_row_attached: a_row /= Void
		local
			l_subrow_cnt: INTEGER
			l_subrow_index: INTEGER
		do
			if a_row.is_expandable then
				a_row.expand
				l_subrow_cnt := a_row.subrow_count
				if l_subrow_cnt > 0 then
					from
						l_subrow_index := 1
					until
						l_subrow_index > l_subrow_cnt
					loop
						expand_row (a_row.subrow (l_subrow_index))
						l_subrow_index := l_subrow_index + 1
					end
				end
			end
		end


	collapse_row (a_row: EV_GRID_ROW) is
			-- Collapse subrows of `a_row'.
			-- But don't collapse `a_row', and make sure direct subrows of `a_row' is visible.
		require
			a_row_attached: a_row /= Void
		local
			l_subrow_cnt: INTEGER
			l_subrow_index: INTEGER
		do
			l_subrow_cnt := a_row.subrow_count
			if l_subrow_cnt > 0 then
				from
					l_subrow_index := 1
				until
					l_subrow_index > l_subrow_cnt
				loop
					if a_row.subrow (l_subrow_index).is_expandable then
						a_row.subrow (l_subrow_index).collapse
					end
					l_subrow_index := l_subrow_index + 1
				end
			end
			if a_row.is_expandable then
				a_row.expand
			end
		end

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
