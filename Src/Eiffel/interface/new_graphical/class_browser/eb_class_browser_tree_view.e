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
	EB_CLASS_BROWSER_GRID_VIEW [EB_CLASS_BROWSER_TREE_ROW]
		redefine
			data,
			default_ensure_visible_action,
			recycle_agents,
			starting_element
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

	SHARED_WORKBENCH

	EV_SHARED_APPLICATION

	QL_UTILITY

create
	make_with_flag

feature{NONE} -- Initialization

	make_with_flag (a_dev_window: like development_window; a_drop_actions: like drop_actions; a_tree_view_enabled: BOOLEAN) is
			-- Initialize.
		require
			a_dev_window_attached: a_dev_window /= Void
			a_drop_actions_attached: a_drop_actions /= Void
		do
			make (a_dev_window, a_drop_actions)
			is_tree_view_enabled := a_tree_view_enabled
			if is_flat_view_enabled then
				setup_sorting_for_location
			end
		ensure
			is_tree_view_enabled_set: is_tree_view_enabled = a_tree_view_enabled
		end

feature -- Status report

	is_tree_view_enabled: BOOLEAN
		-- Is Tree view enabled for displaying ancestor/descendant hierarchy?

	is_flat_view_enabled: BOOLEAN is
			-- Is flat view enabled for displaying supplier/client referenced?
		do
			Result := not is_tree_view_enabled
		end

feature -- Access

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Widget of a control bar through which, certain control can be performed upon current view
		do
			if control_tool_internal = Void then
				create control_tool_internal.make (4)
				control_tool_internal.extend (create{SD_TOOL_BAR_SEPARATOR}.make)
				control_tool_internal.extend (display_path_button)
				if is_flat_view_enabled then
					control_tool_internal.extend (normal_referenced_button)
					control_tool_internal.extend (syntactical_button)
				end
			end
			Result := control_tool_internal
		ensure then
			result_attached: Result /= Void
		end

	control_tool_bar: SD_TOOL_BAR is
			-- Tool bar contained in `control_bar'
		do
			if control_tool_bar_internal = Void then
				create control_tool_bar_internal.make
			end
			Result := control_tool_bar_internal
		ensure
			result_attached: Result /= Void
		end

	starting_element: QL_CLASS
			-- Starting element as root of the tree displayed in current browser.
			-- This is used when a tree view is to be built. And starting element serves as the root of that tree.
			-- If `starting_element' is Void, don't build tree.

	syntactical_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to indicate if syntactical supplier/clients are displayed
		do
			if syntactical_button_internal = Void then
				create syntactical_button_internal.make (preferences.class_browser_data.syntactical_class_preference)
				syntactical_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.class_overriden_normal_icon_buffer)
				syntactical_button_internal.set_tooltip (interface_names.h_show_syntactical_classes)
				syntactical_button_internal.select_actions.extend (agent on_refresh_for_flat_view)
			end
			Result := syntactical_button_internal
		ensure
			result_attached: Result /= Void
		end

	normal_referenced_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to indicate if normal referenced supplier/clients are displayed
		do
			if normal_referenced_button_internal = Void then
				create normal_referenced_button_internal.make (preferences.class_browser_data.normal_referenced_class_preference)
				normal_referenced_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.diagram_supplier_link_icon_buffer)
				normal_referenced_button_internal.set_tooltip (interface_names.h_show_normal_referenced_classes)
				normal_referenced_button_internal.select_actions.extend (agent on_refresh_for_flat_view)
			end
			Result := normal_referenced_button_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Actions

	on_grid_focus_in is
			-- Action to be performed when `grid' gets focus
		do
			if is_tree_node_highlight_enabled then
				highlight_tree_on_grid_focus_change
			end
		end

	on_grid_focus_out is
			-- Action to be performed when `grid' loses focus
		do
			if is_tree_node_highlight_enabled then
				highlight_tree_on_grid_focus_change
			end
		end

	on_pointer_double_click (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Action to be performed when mouse is double clicked in `grid'
		local
			l_grid_item: EV_GRID_ITEM
			l_row: EB_CLASS_BROWSER_TREE_ROW
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				l_grid_item := grid_item_at_position (grid, a_x, a_y)
				if l_grid_item /= Void then
					l_row ?= l_grid_item.row.data
					if l_row /= Void and then l_row.is_collapsed then
						l_row := first_occurrence (l_row)
						ensure_visible (l_row.class_grid_item, True)
					end
				end
			end
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when some key is pressed in `grid'
		require
			a_key_attached: a_key /= Void
		local
			l_processed: BOOLEAN
		do
			l_processed := on_predefined_key_pressed (a_key)
		end

	on_expand_all_level is
			-- Action to be performed to recursively expand all selected rows.
		do
			processed_rows.wipe_out
			do_all_in_rows (selected_rows, agent expand_row_recursively)
		end

	on_collapse_all_level is
			-- Action to be performed to recursively collapse all selected rows.
		do
			processed_rows.wipe_out
			do_all_in_rows (selected_rows, agent collapse_row_recursively)
		end

	on_expand_one_level is
			-- Action to be performed to expand all selected rows.
		local
			l_selected_rows: like selected_rows
			l_row: EV_GRID_ROW
			l_done: BOOLEAN
		do
			l_selected_rows := selected_rows
			if l_selected_rows.count = 1 then
				l_row := l_selected_rows.first
				if not l_row.is_expandable or else l_row.is_expanded then
					go_to_first_child (l_row)
					l_done := True
				end
			end
			if not l_done then
				processed_rows.wipe_out
				do_all_in_rows (selected_rows, agent expand_row)
			end
		end

	on_collapse_one_level is
			-- Action to be performed to collapse all selected rows.
		local
			l_selected_rows: like selected_rows
			l_row: EV_GRID_ROW
			l_done: BOOLEAN
		do
			l_selected_rows := selected_rows
			if l_selected_rows.count = 1 then
				l_row := l_selected_rows.first
				if not l_row.is_expandable or else not l_row.is_expanded then
					go_to_parent (l_row)
					l_done := True
				end
			end
			if not l_done then
				processed_rows.wipe_out
				do_all_in_rows (l_selected_rows, agent collapse_row_normal)
			end
		end

	on_collapse_one_level_partly is
			-- Action to be performed to collapse on level but leave the first level of child rows open.
		do
			processed_rows.wipe_out
			do_all_in_rows (selected_rows, agent collapse_row)
		end

	on_show_path_changed is
			-- Action to be performed when selection status of `display_path_button' changes
		do
			is_up_to_date := False
			if is_flat_view_enabled then
				setup_sorting_for_location
			end
			if data /= Void then
				bind_grid
			end
		ensure
			grid_sorting_setting_correct: is_sorting_setting_valid
		end

	on_refresh_for_flat_view is
			-- Refresh data for flat view.
		do
			is_up_to_date := False
			if data /= Void and then is_flat_view_enabled then
				retrieve_data_actions.call (Void)
			end
		end

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip display be vetoed?
		do
		end

feature -- Notification

	provide_result is
			-- Provide result displayed in Current view.
		do
			fill_rows
			if last_sorted_column_internal = 0 then
				last_sorted_column_internal := class_name_column_index
			end
			disable_auto_sort_order_change
			enable_force_multi_column_sorting
			sort (0, 0, 1, 0, 0, 0, 0, 0, last_sorted_column)
			disable_force_multi_column_sorting
			enable_auto_sort_order_change
		end

feature -- Sorting

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EB_CLASS_BROWSER_TREE_ROW]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		local
			l_sorter: DS_QUICK_SORTER [EB_CLASS_BROWSER_TREE_ROW]
		do
			create l_sorter.make (a_comparator)
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

	class_name_tester (row_a, row_b: EB_CLASS_BROWSER_TREE_ROW; a_order: INTEGER): BOOLEAN is
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
			if a_order = topology_order then
				Result := row_a.class_item.class_c.topological_id < row_b.class_item.class_c.topological_id
			else
				if l_class_a_name.is_equal (l_class_b_name) then
					Result := not row_a.is_collapsed and then row_b.is_collapsed
				else
					if a_order = ascending_order then
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

	path_name_tester (a_row, b_row: EB_CLASS_BROWSER_TREE_ROW; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order between `a_row' and `b_row' according to order `a_order'
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		do
			if a_order = ascending_order then
				Result := a_row.path_grid_item.image < b_row.path_grid_item.image
			else
				Result := a_row.path_grid_item.image > b_row.path_grid_item.image
			end
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

	default_ensure_visible_action (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN) is
			-- Ensure that `a_item' is visible.
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
			l_row.expand_parent_row_recursively (l_row.grid_row)
			grid.remove_selection
			l_grid_row.ensure_visible
			if a_selected then
				l_grid_row.enable_select
			end
		end

	fill_rows  is
			-- Fill rows with `data'.
		local
			l_data: like data
			l_row: EB_CLASS_BROWSER_TREE_ROW
			l_rows: like rows
			l_start_class: QL_CLASS
		do
			l_rows := rows
			l_rows.wipe_out
			l_data := data
			if is_flat_view_enabled then
				from
					l_data.start
				until
					l_data.after
				loop
					create l_row.make (Current, l_data.item, False)
					l_rows.force_last (l_row)
					l_data.forth
				end
			else
				class_table.wipe_out
				l_start_class := Void
				from
					l_data.start
				until
					l_data.after
				loop
					class_table.force (l_data.item, l_data.item.class_c.class_id)
					if l_start_class = Void and then l_data.item.is_equal (starting_element) then
						l_start_class := l_data.item
					end
					l_data.forth
				end
				processed_classes.wipe_out
				check l_start_class /= Void end
				create l_row.make (Current, l_start_class, False)
				l_rows.force_last (l_row)
				fill_row_tree (l_row, l_data)
			end
		end

	fill_row_tree (a_row: EB_CLASS_BROWSER_TREE_ROW; a_class_domain: like data) is
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
			l_class := class_table.item (a_row.class_item.class_c.class_id)
			l_list2 ?= l_class.data
			if l_list2 /= Void and then not l_list2.is_empty then
				l_processed_classes := processed_classes
				any_class_id := system.any_id
				create l_list.make (l_list2.count)
				l_list2.do_all (agent l_list.force_last)
				create l_agent_sorter.make (agent class_tester)
				create l_sorter.make (l_agent_sorter)
				l_sorter.sort (l_list)
				a_class_domain.compare_objects
				from
					l_list.start
				until
					l_list.after
				loop
					l_class := l_list.item_for_iteration
					if l_processed_classes.has (l_class) then
						l_list2 ?= l_class.data
						if l_list2 /= Void and then not l_list2.is_empty then
							create l_row.make (Current, l_class, True)
						else
							create l_row.make (Current, l_class, False)
						end
						a_row.add_child (l_row)
					else
						create l_row.make (Current, l_class, False)
						a_row.add_child (l_row)
						if l_class.class_c.class_id /= any_class_id then
							if l_processed_classes.count = l_processed_classes.capacity then
								l_processed_classes.resize (l_processed_classes.capacity + 50)
							end
							l_processed_classes.force_last (l_class)
							fill_row_tree (l_row, a_class_domain)
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
				processed_classes_internal.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [QL_CLASS]}.make(agent is_class_equal))
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
			l_is_path_displayed: BOOLEAN
		do
			l_bg_color := even_line_color
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
			grid.hide_tree_node_connectors
			grid.set_row_height (default_row_height)
			l_is_path_displayed := display_path_button.is_selected
			from
				l_rows := rows
				l_rows.start
			until
				l_rows.after
			loop
				l_row := rows.item_for_iteration
				l_row.bind_row (Void, grid, l_bg_color, 0, l_is_path_displayed)
				l_rows.forth
			end
			try_auto_resize_grid (<<[500, 800, 1]>>, False)
		end

	first_occurrence (a_row: EB_CLASS_BROWSER_TREE_ROW): EB_CLASS_BROWSER_TREE_ROW is
			-- Given `a_row' which represents a processed class (like "ARRAYED_LIST..."),
			-- return the first occurrence of the same class in `grid'.
		require
			a_row_attached: a_row /= Void
			a_row_is_collapsed: a_row.is_collapsed
		local
			l_row: EB_CLASS_BROWSER_TREE_ROW
		do
			l_row ?= grid.row (1).data
			check l_row /= Void end
			Result := first_occurrence_internal (l_row, a_row)
		ensure
			result_attached: Result /= Void
			good_result: not Result.is_collapsed
		end

	first_occurrence_internal (a_start_row, a_source_row: EB_CLASS_BROWSER_TREE_ROW): EB_CLASS_BROWSER_TREE_ROW is
			-- Find the first occurrence of class in `a_source_row' recursively starting from `a_start_row'.
		require
			a_start_row_attached: a_start_row /= Void
			a_source_row_attached: a_source_row /= Void
		local
			l_row_index: INTEGER
			l_row_count: INTEGER
			l_row: EB_CLASS_BROWSER_TREE_ROW
		do
			if a_start_row.class_item.conf_class = a_source_row.class_item.conf_class then
				Result := a_start_row
			else
				l_row_count := a_start_row.grid_row.subrow_count
				if l_row_count > 0 then
					from
						l_row_index := 1
					until
						l_row_index > l_row_count or Result /= Void
					loop
						l_row ?= a_start_row.grid_row.subrow (l_row_index).data
						if l_row /= Void then
							Result := first_occurrence_internal (l_row, a_source_row)
						end
						l_row_index := l_row_index + 1
					end
				end
			end
		end

	selected_rows: LIST [EV_GRID_ROW] is
			-- Selected rows in `grid'.
			-- If empty, put the first row in `grid' in result.
		do
			Result := grid.selected_rows
			if Result.is_empty and then grid.row_count > 0 then
				create {ARRAYED_LIST [EV_GRID_ROW]}Result.make (1)
				Result.extend (grid.row (1))
			end
		end

	class_table: HASH_TABLE [QL_CLASS, INTEGER] is
			-- Table for classes in `data'
			-- Key is class_id, value is that class
		do
			if class_table_internal = Void then
				create class_table_internal.make (100)
			end
			Result := class_table_internal
		ensure
			result_attached: Result /= Void
		end

	class_table_internal: like class_table
			-- Implementation of `class_table'		

	control_tool_internal: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Implementation of `control_bar'

	display_path_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to turn on/off item path display
		do
			if display_path_button_internal = Void then
				create display_path_button_internal.make (preferences.class_browser_data.show_item_path_preference)
				display_path_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.metric_unit_group_icon_buffer)
				display_path_button_internal.set_tooltip (interface_names.h_show_item_location)
				display_path_button_internal.select_actions.extend (agent on_show_path_changed)
			end
			Result := display_path_button_internal
		ensure
			result_attached: Result /= Void
		end

	syntactical_button_internal: like syntactical_button
			-- Implementation of `syntactical_button'

	display_path_button_internal: like display_path_button
			-- Implementation of `display_path_button'

	normal_referenced_button_internal: like normal_referenced_button
			-- Implementation of `normal_referenced_button'

	recycle_agents is
			-- Recycle agents
		do
			if display_path_button_internal /= Void then
				display_path_button.recycle
			end
			if syntactical_button_internal /= Void then
				syntactical_button.recycle
			end
			if normal_referenced_button_internal /= Void then
				normal_referenced_button.recycle
			end
			Precursor {EB_CLASS_BROWSER_GRID_VIEW}
		end

	is_sorting_setting_valid: BOOLEAN is
			-- Is setting for grid sorting valid?
			-- The criterion is: the class name column is sortable, and if the location column is displayed
			-- and then current view is in flat mode, the location column is sortable
		do
			Result := is_column_sortable (class_name_column_index)
			if Result then
				if is_flat_view_enabled and then display_path_button.is_selected then
					Result := is_column_sortable (location_column_index)
				else
					Result := not is_column_sortable (location_column_index)
				end
			end
		end

	setup_sorting_for_location is
			-- Set sorting information for location column.
		require
			is_flat_view_enabled: is_flat_view_enabled
		do
			if display_path_button.is_selected then
				if not is_column_sortable (location_column_index) then
					set_sort_info (location_column_index, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_CLASS_BROWSER_TREE_ROW]}.make (agent path_name_tester, ascending_order))
				end
			elseif is_column_sortable (location_column_index) then
				remove_sort_info (location_column_index)
			end
		ensure
			sorting_setting_correct: is_sorting_setting_valid
		end

feature{NONE} -- Initialization

	build_grid is
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (2)
			grid.enable_selection_on_single_button_click
			grid.header.i_th (class_name_column_index).set_text (interface_names.l_class_browser_classes)
			grid.header.i_th (location_column_index).set_text (interface_names.l_location)
			grid.enable_single_row_selection
			grid.enable_tree
			grid.set_row_height (default_row_height)
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end
			enable_ctrl_right_click_to_open_new_window
			grid.pointer_double_press_actions.extend (agent on_pointer_double_click)
			grid.focus_in_actions.extend (agent on_grid_focus_in)
			grid.focus_out_actions.extend (agent on_grid_focus_out)
			grid.row_select_actions.extend (agent highlight_row)
			grid.row_deselect_actions.extend (agent dehighlight_row)
			grid.key_press_actions.extend (agent on_key_pressed)
			grid.enable_multiple_row_selection
			enable_grid_item_pnd_support
			set_select_all_action (agent do  end)
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [EB_CLASS_BROWSER_TREE_ROW]
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column_internal := 0
			create l_class_sort_info.make (agent class_name_tester, ascending_order)
			set_sort_action (agent sort_agent)
			l_class_sort_info.enable_auto_indicator
			set_sort_info (class_name_column_index, l_class_sort_info)

				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
			grid.register_shortcut (
				create{ES_KEY_SHORTCUT}.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_left), True, False, False),
				agent on_collapse_one_level_partly
			)
		end

	control_tool_bar_internal: like control_tool_bar;
			-- Implementation of `control_tool_bar'

	class_name_column_index: INTEGER is 1
			-- Index of class name column

	location_column_index: INTEGER is 2;
			-- Index of location column

feature{NONE} -- Implementation/Stone

	item_to_put_in_editor: EV_GRID_ITEM is
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.
		do
			Result := item_to_put_in_editor_for_tree_row
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
