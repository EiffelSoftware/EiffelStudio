indexing
	description: "[
					Group dependency view
					This class is reponsible for displaying client/supplier classes for a given target/group/folder/class.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_DEPENDENCY_VIEW

inherit
	EB_CLASS_BROWSER_GRID_VIEW [EB_CLASS_BROWSER_DEPENDENCY_ROW]
		undefine
			pixmap_from_group_path,
			pixmap_from_group
		redefine
			data,
			default_ensure_visible_action,
			recycle_agents,
			starting_element,
			expand_row_recursively
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

	SHARED_WORKBENCH

	EV_SHARED_APPLICATION

	EB_METRIC_INTERFACE_PROVIDER

	QL_SHARED_FEATURE_INVOKE_RELATION_TYPES

	QL_SHARED

	QL_UTILITY

create
	make

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
				l_tool_bar.extend (show_self_dependency)
				l_tool_bar.extend (show_tooltip_checkbox)
				control_tool_bar.set_padding (2)
				control_tool_bar.extend (l_tool_bar)
				control_tool_bar.disable_item_expand (l_tool_bar)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	starting_element: STONE
			-- Starting element as root of the tree displayed in current browser.
			-- This is used when a tree view is to be built. And starting element serves as the root of that tree.
			-- If `starting_element' is Void, don't build tree.

	starting_element_group: QL_GROUP
			-- Group in which `starting_element_group' locates

	post_row_bind_action_table: HASH_TABLE [PROCEDURE [ANY, TUPLE [EV_GRID_ROW]], INTEGER]
			-- Table of action to be performed after a row whose level index is specified by key of the table has been binded into `grid'.

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip display be vetoed?
		do
			Result := show_tooltip_checkbox.is_selected
		end

	has_grid_been_binded_for_current_data: BOOLEAN
			-- Has `grid' been binded for current `data'?
			-- i.e., for the same `data', `grid' can be binded for many times (each time per sorting),
			-- and this feature is used in maintaining expansion status of rows.

	is_displaying_suppliers: BOOLEAN
			-- Is view displaying suppliers for the moment?

	is_displaying_clients: BOOLEAN is
			-- Is view displaying clients for the moment?
		do
			Result := not is_displaying_suppliers
		ensure
			good_result: Result = not is_displaying_suppliers
		end

	is_starting_element_folder: BOOLEAN
			-- Is `starting_element' a folder?
			-- If `starting_element' is a folder, we do special things in filtering out self dependency.

feature -- Setting

	set_is_displaying_suppliers (b: BOOLEAN) is
			-- Set `is_displaying_suppliers' with `b'.
		do
			is_displaying_suppliers := b
		ensure
			is_displaying_suppliers_set: is_displaying_suppliers = b
		end

	prepare_for_supplier_view (a_name_of_starting_element: STRING) is
			-- Prepare for display supplier dependency.
			-- `a_name_of_starting_element' is the name displayed in referenced class column.
		require
			a_name_of_starting_element_attached: a_name_of_starting_element /= Void
		do
			grid.header.i_th (1).set_text (interface_names.l_supplier_group)
			grid.header.i_th (2).set_text (interface_names.l_supplier_class)
			grid.header.i_th (3).set_text (referenced_class_column_name (interface_names.l_client_class, a_name_of_starting_element))
			grid.header.i_th (4).set_text (interface_names.l_feature_in_client_class)
			grid.header.i_th (5).set_text (interface_names.l_callees_from_supplier_class)
			set_is_displaying_suppliers (True)
		ensure
			is_displaying_suppliers: is_displaying_suppliers
		end

	prepare_for_client_view (a_name_of_starting_element: STRING) is
			-- Prepare for display client dependency.
			-- `a_name_of_starting_element' is the name displayed in referenced class column.
		do
			grid.header.i_th (1).set_text (interface_names.l_client_group)
			grid.header.i_th (2).set_text (interface_names.l_client_class)
			grid.header.i_th (3).set_text (referenced_class_column_name (interface_names.l_supplier_class, a_name_of_starting_element))
			grid.header.i_th (4).set_text (interface_names.l_feature_in_supplier_class)
			grid.header.i_th (5).set_text (interface_names.l_callers_from_client_class)
			set_is_displaying_suppliers (False)
		ensure
			is_displaying_clients: is_displaying_clients
		end

	set_has_grid_been_binded_for_current_data (a_binded: BOOLEAN) is
			-- Set `has_grid_been_binded_for_current_data' with `a_binded'.
		do
			has_grid_been_binded_for_current_data := a_binded
		ensure
			has_grid_been_binded_for_current_data_set: has_grid_been_binded_for_current_data = a_binded
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

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when some key is pressed in `grid'
		require
			a_key_attached: a_key /= Void
		local
			l_processed: BOOLEAN
		do
			l_processed := on_predefined_key_pressed (a_key)
		end

	on_enter_pressed is
			-- Action to be performed when enter key is pressed
		do
			on_expand_all_level
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

	on_notify is
			-- Action to be performed when `update' is called.
		do
		end

	on_post_sort (a_sorting_status_snapshot: LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]]) is
			-- Action to be performed after a sorting
		do
			preferences.class_browser_data.dependency_view_sorting_order_preference.set_value (string_representation_of_sorted_columns)
		end

	on_show_self_dependency_changed is
			-- Action to be performed when selection status of `show_self_dependency' changes
		do
			if data /= Void then
				bind_grid
			end
			preferences.class_browser_data.show_self_dependency_preference.set_value (show_self_dependency.is_selected)
		end

	on_show_self_dependency_changed_from_outside is
			-- Action to be performed when selection status of `show_self_dependency' changes from outside
		local
			l_displayed: BOOLEAN
		do
			l_displayed := preferences.class_browser_data.is_self_dependency_shown
			if l_displayed /= show_self_dependency.is_selected then
				if l_displayed then
					show_self_dependency.enable_select
				else
					show_self_dependency.disable_select
				end
			end
		end

	on_row_expanded_or_collapsed (a_row: EV_GRID_ROW; a_expanded: BOOLEAN) is
			-- Action to be performed when `a_row' is expanded indicated by True value of `a_expanded' or
			-- is collapsed indicated by False value of `a_expanded'.
		require
			a_row_attached: a_row /= Void
		local
			l_referencer_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_referenced_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_referenced_class: QL_CLASS
			l_referencer_class: QL_CLASS
		do
			l_referencer_row ?= a_row.data
			if l_referencer_row /= Void then
				if a_expanded and then not l_referencer_row.has_been_expanded and then l_referencer_row.is_lazy_expandable then
					l_referencer_row.set_is_expanded (a_expanded)
					l_referencer_class ?= l_referencer_row.item
					check a_row.parent_row /= Void end
					l_referenced_row ?= a_row.parent_row.data
					check l_referenced_row /= Void end
					l_referenced_class ?= l_referenced_row.item
					check l_referenced_class /= Void and then l_referencer_class /= Void end
					bind_feature_rows (l_referencer_row.row_node, l_referenced_class, l_referencer_class)
				else
					l_referencer_row.set_is_expanded (a_expanded)
				end
			end
		end

feature -- Notification

	update_view is
			-- Update current view according to change in `model'.
		local
			l_msg: STRING
			l_resize_table: HASH_TABLE [TUPLE [min_width: INTEGER; max_width: INTEGER], INTEGER]
			l_cluster_stone: CLUSTER_STONE
		do
			if not is_up_to_date then
				set_has_grid_been_binded_for_current_data (False)
				starting_element_group := domain_item_from_stone (starting_element).group
				l_cluster_stone ?= starting_element
				is_starting_element_folder := l_cluster_stone /= Void and then (l_cluster_stone.path /= Void and then not l_cluster_stone.path.is_empty)
				if data /= Void then
					text.hide
					component_widget.show
					retrieve_classes_in_starting_element
					fill_rows
					if last_sorted_column_internal = 0 then
						last_sorted_column_internal := 1
					end
					disable_auto_sort_order_change
					enable_force_multi_column_sorting
					sort (0, 0, 1, 0, 0, 0, 0, 0, 1)
					disable_force_multi_column_sorting
					enable_auto_sort_order_change
					set_has_grid_been_binded_for_current_data (True)
					if not has_grid_been_binded then
						set_has_grid_been_binded (True)
						create l_resize_table.make (2)
						l_resize_table.force ([150, 300], 1)
						l_resize_table.force ([150, 300], 2)
						l_resize_table.force ([150, 200], 3)
						l_resize_table.force ([100, 200], 4)
						auto_resize_columns (grid, l_resize_table)
					end
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

feature -- Sorting

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EB_CLASS_BROWSER_DEPENDENCY_ROW]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty: not a_column_list.is_empty
		do
			a_column_list.do_all (agent sort_level (rows, ?, 1, a_comparator))
			bind_grid
		end

	sort_level (a_level: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]; a_level_index: INTEGER; a_current_level: INTEGER; a_comparator: AGENT_LIST_COMPARATOR [EB_CLASS_BROWSER_DEPENDENCY_ROW]) is
			-- Sort row level whose level index is specified by `a_level_index' starting from level `a_level' indexed by `a_level'.
			-- `a_comparator' is used to decide row orders.
		require
			a_level_attached: a_level /= Void
			a_comparator_attached: a_comparator /= Void
		local
			l_children: DS_LIST [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
			l_sorter: DS_QUICK_SORTER [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
			l_comparater: AGENT_LIST_COMPARATOR [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_agent: AGENT_BASED_EQUALITY_TESTER [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
		do
			if a_current_level < a_level_index then
				from
					l_children := a_level.children
					l_children.start
				until
					l_children.after
				loop
					sort_level (l_children.item_for_iteration, a_level_index, a_current_level + 1, a_comparator)
					l_children.forth
				end
			else
				l_comparater := a_comparator.new_agent_list_comparator (<<a_level_index>>)
				create l_agent.make (agent tree_node_tester (?, ?, l_comparater))
				create l_sorter.make (l_agent)
				l_sorter.sort (a_level.children)
			end
		end

	name_tester (a_row, b_row: EB_CLASS_BROWSER_DEPENDENCY_ROW; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order between `a_row' and `b_row' according to order `a_order'
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		do
			if a_order = ascending_order then
				Result := a_row.grid_item.image < b_row.grid_item.image
			else
				Result := a_row.grid_item.image > b_row.grid_item.image
			end
		end

	group_name_tester (a_row, b_row: EB_CLASS_BROWSER_DEPENDENCY_ROW; a_order: INTEGER): BOOLEAN is
			-- Tester to decide order between `a_row' an `b_row' as groups according to order `a_order'.
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		local
			l_a_group: QL_GROUP
			l_b_group: QL_GROUP
			l_a_index: INTEGER
			l_b_index: INTEGER
		do
			if a_order = topology_order then
				l_a_group ?= a_row.item
				l_b_group ?= b_row.item
				check
					l_a_group /= Void
					l_b_group /= Void
				end
				l_a_index := index_of_group (l_a_group)
				l_b_index := index_of_group (l_b_group)
				if l_a_index /= l_b_index then
					Result := l_a_index < l_b_index
				else
					Result := name_tester (a_row, b_row, ascending_order)
				end
			else
				Result := name_tester (a_row, b_row, a_order)
			end
		end

	index_of_group (a_group: QL_GROUP): INTEGER is
			-- Index for `a_group' used in sorting
			-- This is used when sort client/supplier group column to make sure that cluster is displayed before
			-- library which is before assembly.
		require
			a_group_attached: a_group /= Void
		do
			if a_group.is_cluster then
				Result := 1
			elseif a_group.is_library then
				Result := 2
			elseif a_group.is_assembly then
				Result := 3
			end
		end

	tree_node_tester (a_node, b_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]; a_comparator: AGENT_LIST_COMPARATOR [EB_CLASS_BROWSER_DEPENDENCY_ROW]): BOOLEAN is
			-- Tester to decide order of `a_node' and `b_node' according to comparator `a_comparator'.
		require
			a_node_attached: a_node /= Void
			b_node_attached: b_node /= Void
			a_comparator_attached: a_comparator /= Void
		do
			Result := a_comparator.less_than (a_node.data, b_node.data)
		end

feature{NONE} -- Implementation

	data: TUPLE [dependency_data: HASH_TABLE [HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS], QL_GROUP]; class_list_in_starting_element: QL_CLASS_DOMAIN]
			-- Data to be displayed in current view
			-- for `dependency_data, the outer hash table is indexed by group, and its value is the inner table,
			-- inner table is indexed by "referenced class" and its value is a set of classes who references the referenced class.
			-- And `class_list_in_starting_element' is a list of classes which contained in `starting_element'.
			-- For example, if `starting_element' is a group, then `class_list_in_starting_element' is all classes in that group.

	rows: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW] is
			-- Rows to be displayed
			-- It is a tree hierarchy.
			-- The first level (level index is 1) are dependency groups,
			-- the second level (level index is 2) are referenced classes in each dependency group,
			-- the third level (level index is 3) are referencer classes to each referenced class,
			-- the forth level (level index is 4) are features in referencer classes,			
			-- For example, if we are displaying suppliers of group "demo":
			-- demo
			--	|
			--  +- base
			--	   |
			--	   +- STRING_8
			--		  |
			--		  +- MY_CLASS1
			--		      +- foo		make_from_string, count, as_lower
			-- This graph means group "demo" depends on "base" library, in detail, class MY_CLASS1 in "demo" uses STRING_8 in "base",
			-- and in more detail, feature "foo" from MY_CLASS1 uses feature "make_from_string", "count" and "as_lower" from class STRING_8.
			-- Here, "base" is dependency group, "STRING_8" is referenced class, "MY_CLASS1" is referencer class and "foo" is features in referencer class.
		do
			if rows_internal = Void then
				create rows_internal
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
			l_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
		do
			l_grid_item := a_item.grid_item
			check l_grid_item /= Void end
			l_grid_row := l_grid_item.row
			check l_grid_row /= Void end
			l_row ?= l_grid_row.data
			if l_row /= Void then
				l_row.expand_parent_row_recursively (l_grid_row)
			end
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
			l_group_row: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_referenced_class_row: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_referencer_class_row: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_rows: like rows
			l_referenced_classes: HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS]
			l_referencer_class_set: DS_HASH_SET [QL_CLASS]
			l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_dependency_data: HASH_TABLE [HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS], QL_GROUP]
		do
			l_rows := rows
			l_rows.children.wipe_out
			l_data := data
			from
				l_dependency_data := data.dependency_data
				l_dependency_data.start
			until
				l_dependency_data.after
			loop
					-- Setup group row.
				create l_group_row
				create l_dependency_row.make (l_dependency_data.key_for_iteration, l_group_row, Current)
				l_group_row.set_data (l_dependency_row)
				l_rows.children.force_last (l_group_row)

					-- Setup referenced class rows
				l_referenced_classes := l_dependency_data.item_for_iteration
				from
					l_referenced_classes.start
				until
					l_referenced_classes.after
				loop
					create l_referenced_class_row
					create l_dependency_row.make (l_referenced_classes.key_for_iteration, l_referenced_class_row, Current)
					l_referenced_class_row.set_data (l_dependency_row)
					l_group_row.children.force_last (l_referenced_class_row)
						-- Setup referencer class rows
					l_referencer_class_set := l_referenced_classes.item_for_iteration
					from
						l_referencer_class_set.start
					until
						l_referencer_class_set.after
					loop
						create l_referencer_class_row
						create l_dependency_row.make (l_referencer_class_set.item_for_iteration, l_referencer_class_row, Current)
						l_dependency_row.set_is_lazy_expandable (True)
						l_referencer_class_row.set_data (l_dependency_row)
						l_referenced_class_row.children.force_last (l_referencer_class_row)
						l_referencer_class_set.forth
					end
					l_referenced_classes.forth
				end
				l_dependency_data.forth
			end
		end

	bind_grid is
			-- Bind `rows' in `grid'.
		do
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
			grid.set_row_height (default_row_height)
			bind_first_row
			mark_display
			bind_row_level (grid.row (1), rows, 1, True)
		end

	bind_first_row is
			-- Bind first row in `grid'.
		require
			grid_is_empty: grid.row_count = 0
		local
			l_grid_item: EB_GRID_COMPILER_ITEM
			l_first_row: EB_METRIC_DOMAIN_ITEM_ROW
		do
			create l_first_row.make (domain_item_from_stone (starting_element))
			create l_grid_item
			l_grid_item.set_text_with_tokens (l_first_row.token_name)
			l_grid_item.set_pixmap (l_first_row.pixmap)
			l_grid_item.set_image (l_grid_item.text)
			grid.insert_new_row (1)
			grid.row (1).set_item (1, l_grid_item)
		ensure
			first_row_binded: grid.row_count = 1
		end

	level_starting_column_index: ARRAYED_LIST [INTEGER] is
			-- Starting column index of levels
		once
			create Result.make (4)
			Result.extend (1)
			Result.extend (2)
			Result.extend (3)
			Result.extend (4)
		ensure
			result_attached: Result /= Void
		end

	should_level_be_expanded (a_level_index: INTEGER): BOOLEAN is
			-- Should level indexed by `a_level_index' be expanded by default?
		do
			inspect
				a_level_index
			when 1 then
				Result := True
			when 2 then
				Result := preferences.class_browser_data.should_referenced_class_be_expanded
			when 3 then
				Result := preferences.class_browser_data.should_referencer_class_be_expanded
			when 4 then
				Result := True
			else
			end
		end

	classes_in_starting_element: DS_HASH_SET [QL_CLASS]
			-- Classes in `starting_element'.

	retrieve_classes_in_starting_element is
			-- Retrieve classes in `starting_element' and store them in `classes_in_starting_element'.
		require
			data_attached: data /= Void
			class_from_starting_element_attached: data.class_list_in_starting_element /= Void
		local
			l_class_domain: QL_CLASS_DOMAIN
		do
			l_class_domain := data.class_list_in_starting_element
			create classes_in_starting_element.make (l_class_domain.count)
			classes_in_starting_element.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [QL_CLASS]}.make (agent class_equal))
			l_class_domain.do_all (agent classes_in_starting_element.force_last)
		ensure
			classes_in_starting_element_attached: classes_in_starting_element /= Void
		end

	class_equal (a_class: QL_CLASS; b_class: QL_CLASS): BOOLEAN is
			-- Is `a_class' same as `b_class'?
		require
			a_class_attached: a_class /= Void
			b_class_attached: b_class /= Void
		do
			Result := a_class.is_equal (b_class)
		end

	bind_row_level (a_base_row: EV_GRID_ROW; a_level: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]; a_level_index: INTEGER; a_recursive: BOOLEAN) is
			-- Bind rows.
		require
			a_base_row_attached: a_base_row /= Void
			a_level_attached: a_level /= Void
		local
			l_rows: DS_LIST [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
			l_grid_row: EV_GRID_ROW
			l_starting_column: INTEGER
			l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_grid_has_been_binded_for_current_data: BOOLEAN
			l_post_row_bind_action: PROCEDURE [ANY, TUPLE [EV_GRID_ROW]]
		do
			l_rows := a_level.children
			if not l_rows.is_empty then
				l_grid_has_been_binded_for_current_data := has_grid_been_binded_for_current_data
				l_post_row_bind_action := post_row_bind_action_table.item (a_level_index)
				from
					l_rows.start
				until
					l_rows.after
				loop
					if l_rows.item_for_iteration.data.should_current_row_be_displayed then
							-- Bind row.
						a_base_row.insert_subrow (a_base_row.subrow_count + 1)
						l_grid_row := a_base_row.subrow (a_base_row.subrow_count)
						l_starting_column := level_starting_column_index.i_th (a_level_index)
						l_rows.item_for_iteration.data.bind_row (l_grid_row, l_starting_column)
							-- Bind subrows.
						if a_recursive and then not l_rows.item_for_iteration.children.is_empty then
							bind_row_level (l_grid_row, l_rows.item_for_iteration, a_level_index + 1, a_recursive)
						end
							-- Expand rows.
						if l_grid_has_been_binded_for_current_data then
							l_dependency_row ?= a_base_row.data
							if l_dependency_row /= Void then
								if l_dependency_row.is_expanded then
									a_base_row.expand
								end
							else
								a_base_row.expand
							end
						elseif should_level_be_expanded (a_level_index) and then a_base_row.is_expandable then
							a_base_row.expand
						end

						if l_post_row_bind_action /= Void then
							l_post_row_bind_action.call ([l_grid_row])
						end
					end
					l_rows.forth
				end
			end
		end

	client_class_set (a_supplier_class: CLASS_C): DS_HASH_SET [CLASS_C] is
			-- Set of client classes of `a_supplier_class'
		require
			a_supplier_class_attached: a_supplier_class /= Void
		local
			l_list: LIST [CLASS_C]
		do
			l_list := a_supplier_class.clients
			if l_list /= Void then
				create Result.make (l_list.count)
				l_list.do_all (agent Result.force)
			else
				create Result.make (0)
			end
		ensure
			result_attached: Result /= Void
		end

	categorized_feature_table (a_class: QL_CLASS): HASH_TABLE [HASH_TABLE [QL_FEATURE, STRING], QL_CLASS] is
			-- For a class `a_class', return its categorized feature table.
			-- Value of the returned table is a table of features indexed by feature name.
			-- Key of that value is the written class where features in value is written.
			-- This is used to facility invariant computation. Because inherited invariant from a class are treated as
			-- a feature written in that class.
		require
			a_class_attached: a_class /= Void
		local
			l_feature_domain: QL_FEATURE_DOMAIN
			l_feature: QL_FEATURE
			l_invariant: QL_INVARIANT
			l_class: QL_CLASS
			l_feat_name_table: HASH_TABLE [QL_FEATURE, STRING]
		do
			create Result.make (10)
			from
				l_feature_domain ?= a_class.wrapped_domain.new_domain (create {QL_FEATURE_DOMAIN_GENERATOR}.make (Void, True))
				l_feature_domain.start
			until
				l_feature_domain.after
			loop
				l_feature := l_feature_domain.item
				if l_feature.is_invariant_feature then
					l_invariant ?= l_feature
					if l_invariant.written_class.class_id = l_invariant.class_c.class_id then
							-- For immediate invariant
						l_class ?= l_invariant.parent
					else
							-- For inherited invariant
						l_class := query_class_item_from_class_c (l_invariant.written_class)
					end
				else
					l_class ?= l_feature.parent
				end

				l_feat_name_table := Result.item (l_class)
				if l_feat_name_table = Void then
					create l_feat_name_table.make (30)
					Result.put (l_feat_name_table, l_class)
				end
				l_feat_name_table.put (l_feature, l_feature.name)
				l_feature_domain.forth
			end
		ensure
			result_attached: Result /= Void
		end

	reversed_called_features (a_called_features: like called_features): like called_features is
			-- Reversed repesentation of `called_features'.
			-- i.e., the keys are called feature and value is calling features of that key.
		require
			a_called_features_attached: a_called_features /= Void
		local
			l_list: LIST [QL_FEATURE]
			l_list2: LIST [QL_FEATURE]
		do
			create Result.make (20)
			from
				a_called_features.start
			until
				a_called_features.after
			loop
				l_list := a_called_features.item_for_iteration
				from
					l_list.start
				until
					l_list.after
				loop
					if Result.has_key (l_list.item) then
						l_list2 := Result.item (l_list.item)
					else
						create {LINKED_LIST [QL_FEATURE]}l_list2.make
						Result.put (l_list2, l_list.item)
					end
					l_list2.extend (a_called_features.key_for_iteration)
					l_list.forth
				end
				a_called_features.forth
			end
		end

	called_features (a_supplier_class: QL_CLASS; a_client_class: QL_CLASS): HASH_TABLE [LIST [QL_FEATURE], QL_FEATURE] is
			-- Called features from `a_client_class' to `a_supplier_class'.
			-- Key of Result is a feature from `a_client_class', value of that key is a list of features from `a_supplier_class' which are called by the key feature.
		require
			a_supplier_class_valid: a_supplier_class /= Void and then a_supplier_class.is_compiled
			a_client_class_valid: a_client_class /= Void and then a_client_class.is_compiled
		local
			l_supplier_features: QL_FEATURE_DOMAIN
			l_client_features: QL_FEATURE_DOMAIN
			l_client_feature: QL_FEATURE
			l_supplier_feature: QL_FEATURE
			l_feature_generator: QL_FEATURE_DOMAIN_GENERATOR
			l_caller_list: SORTED_LIST [STRING]
			l_invariant_name: STRING
			l_invariant_feature_name: STRING
			l_name_table: HASH_TABLE [HASH_TABLE [QL_FEATURE, STRING], QL_CLASS]
			l_feat_name_table: HASH_TABLE [QL_FEATURE, STRING]
			l_list: LIST [QL_FEATURE]
			l_clients_of_supplier_class: DS_HASH_SET [CLASS_C]
			l_class_c: CLASS_C
		do
			create Result.make (100)
			create l_feature_generator.make (Void, True)
			create l_name_table.make (10)
			l_invariant_name := "_invariant"
			l_invariant_feature_name := "invariant"
			l_clients_of_supplier_class := client_class_set (a_supplier_class.class_c)
			l_name_table := categorized_feature_table (a_client_class)
			l_client_features ?= a_client_class.wrapped_domain.new_domain (l_feature_generator)

			from
				l_supplier_features ?= a_supplier_class.wrapped_domain.new_domain (l_feature_generator)
				l_supplier_features.start
			until
				l_supplier_features.after
			loop
				l_supplier_feature := l_supplier_features.item
				if l_supplier_feature.is_real_feature then
					from
						l_name_table.start
					until
						l_name_table.after
					loop
						l_class_c := l_name_table.key_for_iteration.class_c
						if l_clients_of_supplier_class.has (l_class_c) then
							l_caller_list := l_supplier_feature.e_feature.callers (l_class_c, 0)
							if l_caller_list /= Void then
								l_feat_name_table := l_name_table.item_for_iteration
								from
									l_caller_list.start
								until
									l_caller_list.after
								loop
									if l_caller_list.item.is_equal (l_invariant_name) then
										l_client_feature := l_feat_name_table.item (l_invariant_feature_name)
									else
										l_client_feature := l_feat_name_table.item (l_caller_list.item)
									end
									if l_client_feature /= Void then
										l_list := Result.item (l_client_feature)
										if l_list = Void then
											create {LINKED_LIST [QL_FEATURE]} l_list.make
											Result.put (l_list, l_client_feature)
										end
										l_list.extend (l_supplier_feature)
									end

									l_caller_list.forth
								end
							end
						end
						l_name_table.forth
					end
				end
				l_supplier_features.forth
			end
		ensure
			result_attached: Result /= Void
		end

	bind_feature_rows (a_row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]; a_referenced_class: QL_CLASS; a_referencer_class: QL_CLASS) is
			-- Bind feature rows in subrows of `a_row_node'.
			-- `a_row_node' is a node in `rows'.
		require
			a_row_node_attached: a_row_node /= Void
			a_row_node_has_not_been_binded: a_row_node.children.is_empty
			a_referenced_class_attached: a_referenced_class /= Void
			a_referencer_class_attached: a_referencer_class /= Void
		local
			l_feature_generator: QL_FEATURE_DOMAIN_GENERATOR
			l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_new_row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_order_list: LINKED_LIST [INTEGER]
			l_feature_table: like called_features
			l_features: DS_HASH_SET [QL_FEATURE]
			l_grid_row: EV_GRID_ROW
		do
				-- Get features.
			create l_feature_generator
			l_feature_generator.enable_fill_domain
			create l_features.make (100)
			if is_displaying_clients then
				l_feature_table := reversed_called_features (called_features (a_referencer_class, a_referenced_class))
			else
				l_feature_table := called_features (a_referenced_class, a_referencer_class)
			end

			from
				l_feature_table.start
			until
				l_feature_table.after
			loop
				create l_new_row_node
				create l_dependency_row.make (l_feature_table.key_for_iteration, l_new_row_node, Current)
				l_dependency_row.set_feature_list (l_feature_table.item_for_iteration)
				l_new_row_node.set_data (l_dependency_row)
				a_row_node.children.force_last (l_new_row_node)
				l_feature_table.forth
			end
			create l_order_list.make
			l_order_list.extend (4)
			sort_level (a_row_node, 4, 4, comparator (l_order_list))
			l_grid_row := a_row_node.data.grid_row
			bind_row_level (l_grid_row, a_row_node, 4, False)
			if l_grid_row.is_selected then
				highlight_row (l_grid_row)
			else
				dehighlight_row (l_grid_row)
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

	control_tool_bar: EV_HORIZONTAL_BOX
			-- Implementation of `control_bar'

	show_self_dependency: EV_TOOL_BAR_TOGGLE_BUTTON
			-- Toggle button to turn on/off item path display
			-- For examples, if we are displaying suppliers for a given group "demo",
			-- actually we are displaying supplier classes of every class in that group,
			-- and always classes in group "demo" will use other classes in group "demo",
			-- but sometimes we don't want to show those classes in group "demo" as supplier classes.
			-- In this case, we can choose not to show self dependency.
		do
			if show_self_dependency_button_internal = Void then
				create show_self_dependency_button_internal
				show_self_dependency_button_internal.set_pixmap (pixmaps.icon_pixmaps.metric_unit_group_icon)
				show_self_dependency_button_internal.set_tooltip (interface_names.h_show_dependency_on_self)
				if preferences.class_browser_data.is_item_path_shown then
					show_self_dependency_button_internal.enable_select
				else
					show_self_dependency_button_internal.disable_select
				end
			end
			Result := show_self_dependency_button_internal
		ensure
			result_attached: Result /= Void
		end

	show_self_dependency_button_internal: like show_self_dependency
			-- Implementation of `show_self_dependency'

	on_show_self_dependency_changed_from_outside_agent: PROCEDURE [ANY, TUPLE]
			-- Agent for `on_show_self_dependency_changed_from_outside'

	recycle_agents is
			-- Recycle agents
		do
			Precursor {EB_CLASS_BROWSER_GRID_VIEW}
			if on_show_self_dependency_changed_from_outside_agent /= Void then
				preferences.class_browser_data.show_self_dependency_preference.change_actions.prune_all (on_show_self_dependency_changed_from_outside_agent)
			end
			if on_show_tooltip_changed_from_outside_agent /= Void then
				preferences.class_browser_data.show_tooltip_preference.change_actions.prune_all (on_show_tooltip_changed_from_outside_agent)
			end
		end

	referenced_class_column_name (a_relation_name: STRING_GENERAL; a_name_of_starting_element: STRING_GENERAL): STRING_GENERAL is
			-- Name of referenced class column in dependency view.
			-- `a_relation_name' is "client" or "supplier", and `a_name_of_starting_element' is the name of the target/group/folder/class where
			-- the relation is investigated.
		require
			a_relation_name_attached: a_relation_name /= Void
			a_name_of_starting_element_attached: a_name_of_starting_element /= Void
		local
			l_str: STRING
			l_upper_relation: STRING
		do
			create l_str.make_from_string ("$1 (from $2)")
			create l_upper_relation.make_from_string (a_relation_name.as_string_8)
			l_upper_relation.put (l_upper_relation.item (1).as_upper, 1)
			l_str.replace_substring_all ("$1", a_relation_name.as_string_8)
			l_str.replace_substring_all ("$2", a_name_of_starting_element.as_string_8)
			Result := l_str
		ensure
			result_attached: Result /= Void
		end

	ensure_row_expandable (a_row: EV_GRID_ROW) is
			-- Enable `a_row' is expandable.
		require
			a_row_attached: a_row /= Void
		do
			a_row.insert_subrow (a_row.subrow_count + 1)
		end

	expand_row_recursively (a_row: EV_GRID_ROW) is
			-- Expand `a_row' recursively.
		local
			l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
		do
			l_dependency_row ?= a_row.data
			if l_dependency_row = Void or else not (l_dependency_row.is_lazy_expandable and then not l_dependency_row.has_been_expanded) then
				Precursor (a_row)
			end
		end

	mark_display is
			-- Mark rows to be displayed or not to be displayed according to status of `show_self_dependency'.
		require
			rows_attached: rows /= Void
		local
			l_rows: like rows
			l_groups: DS_LIST [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
			l_show_self: BOOLEAN
			l_starting_element_group: QL_GROUP
			l_classes: DS_LIST [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
			l_classes_from_starting_element: like classes_in_starting_element
			l_group: QL_GROUP
			l_class: QL_CLASS
			l_new_class_count: INTEGER
			l_new_class: BOOLEAN
			l_is_group_equal: BOOLEAN
			l_used_in_library: CONF_GROUP
		do
			l_rows := rows
			l_groups := l_rows.children
			l_show_self := show_self_dependency.is_selected
			l_starting_element_group := starting_element_group
			if l_show_self or l_starting_element_group = Void then
					-- If self dependency is shown, we just mark every thing to be displayed.
				mark_display_in_rows (l_groups, 2, True)
			else
					-- If self dependency is not shown, we check every group.
				from
					l_groups.start
				until
					l_groups.after
				loop
					l_group ?= l_groups.item_for_iteration.data.item
					check l_group /= Void end
					l_is_group_equal := l_group.is_equal (l_starting_element_group)
					if not l_is_group_equal then
						if not l_starting_element_group.is_library then
							l_used_in_library := l_starting_element_group.group.target.system.lowest_used_in_library
							if l_used_in_library /= Void then
								l_is_group_equal := l_group.group = l_used_in_library
							end
						end
					end
					if not l_is_group_equal then
						l_groups.item_for_iteration.data.set_should_current_row_be_displayed (True)
						mark_display_in_rows (l_groups.item_for_iteration.children, 1, True)
					else
						l_classes_from_starting_element := classes_in_starting_element
						from
							l_classes := l_groups.item_for_iteration.children
							l_new_class_count := 0
							l_classes.start
						until
							l_classes.after
						loop
							l_class ?= l_classes.item_for_iteration.data.item
							l_new_class := not l_classes_from_starting_element.has (l_class)
							l_classes.item_for_iteration.data.set_should_current_row_be_displayed (l_new_class)
							if l_new_class then
								l_new_class_count := l_new_class_count + 1
							end
							l_classes.forth
						end
						l_groups.item_for_iteration.data.set_should_current_row_be_displayed (l_new_class_count > 0)
					end
					l_groups.forth
				end
			end
		end

	mark_display_in_rows (a_row_list: DS_LIST [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]; a_depth: INTEGER; a_display: BOOLEAN) is
			-- Mark `a_row_list' with display status specified in `a_display'.
			-- Mark subrows deep to `a_depth' of `a_row_list also'.
			-- For example, if `a_depth' is 1, mark `a_row_list' only, and if 2, mark the first level subrows of `a_row_list', and so on.
		require
			a_row_list_attached: a_row_list /= Void
			a_depth_valid: a_depth >= 1
		do
			if not a_row_list.is_empty then
				from
					a_row_list.start
				until
					a_row_list.after
				loop
					a_row_list.item_for_iteration.data.set_should_current_row_be_displayed (a_display)
					if a_depth > 1 then
						mark_display_in_rows (a_row_list.item_for_iteration.children, a_depth - 1, a_display)
					end
					a_row_list.forth
				end
			end
		end

feature{NONE} -- Initialization

	build_grid is
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (5)
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
			grid.enable_multiple_row_selection
			grid.set_tree_node_connector_color ((create {EV_STOCK_COLORS}).gray)
			grid.row_expand_actions.extend (agent on_row_expanded_or_collapsed (?, True))
			grid.row_collapse_actions.extend (agent on_row_expanded_or_collapsed (?, False))
			enable_editor_token_pnd
			set_select_all_action (agent do  end)
			enable_tree_node_highlight
			show_self_dependency.select_actions.extend (agent on_show_self_dependency_changed)
			on_show_self_dependency_changed_from_outside_agent := agent on_show_self_dependency_changed_from_outside
			preferences.class_browser_data.show_self_dependency_preference.change_actions.extend (on_show_self_dependency_changed_from_outside_agent)

			create post_row_bind_action_table.make (1)
			post_row_bind_action_table.force (agent ensure_row_expandable, 3)

			show_tooltip_checkbox.select_actions.extend (agent on_show_tooltip_changed)
			on_show_tooltip_changed_from_outside_agent := agent on_show_tooltip_changed_from_outside
			preferences.class_browser_data.show_tooltip_preference.change_actions.extend (on_show_tooltip_changed_from_outside_agent)
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_three_way_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [EB_CLASS_BROWSER_DEPENDENCY_ROW]
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column_internal := 0
			set_sort_action (agent sort_agent)
				-- Setup sorting info for the first column: the dependency group column.
			create l_three_way_sort_info.make (agent group_name_tester, ascending_order)
			l_three_way_sort_info.enable_auto_indicator
			set_sort_info (1, l_three_way_sort_info)

				-- Setup sorting info for the second column: the referenced class column.
			create l_sort_info.make (agent name_tester, ascending_order)
			l_sort_info.enable_auto_indicator
			set_sort_info (2, l_sort_info)

				-- Setup sorting info for the third column: the referencer class column.
			create l_sort_info.make (agent name_tester, ascending_order)
			l_sort_info.enable_auto_indicator
			set_sort_info (3, l_sort_info)

				-- Setup sorting info for the forth column: the feature column.
			create l_sort_info.make (agent name_tester, ascending_order)
			l_sort_info.enable_auto_indicator
			set_sort_info (4, l_sort_info)

				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
			grid.add_key_action (agent on_collapse_one_level_partly, collapse_one_level_partly_index)
			grid.add_key_shortcut (collapse_one_level_partly_index, create{ES_KEY_SHORTCUT}.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_left), True, False, False))
		end

	collapse_one_level_partly_index: INTEGER is 65530;
			-- Key shortcut index for collapse one level partly

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
