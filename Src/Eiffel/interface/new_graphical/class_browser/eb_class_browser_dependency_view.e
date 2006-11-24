indexing
	description: "Group dependency view"
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
		end

	has_grid_been_binded_for_current_data: BOOLEAN
			-- Has `grid' been binded for current `data'?

	should_level_be_shown (a_level_index: INTEGER; a_level: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]): BOOLEAN is
			-- Should `a_level' be shown in level indexed by `a_level_index'?
		require
			a_level_attached: a_level /= Void
		local
			l_group: QL_GROUP
			l_starting_element_group: QL_GROUP
		do
			inspect
				a_level_index
			when 1 then
				l_starting_element_group := starting_element_group
				if not show_self_dependency.is_selected and then l_starting_element_group /= Void then
					l_group ?= a_level.data.item
					check l_group /= Void end
					Result :=  not l_group.is_equal (l_starting_element_group)
				else
					Result := True
				end
			else
				Result := True
			end
		end

	is_displaying_suppliers: BOOLEAN
			-- Is view displaying suppliers for the moment?

	is_displaying_clients: BOOLEAN is
			-- Is view displaying clients for the moment?
		do
			Result := not is_displaying_suppliers
		ensure
			good_result: Result = not is_displaying_suppliers
		end

feature -- Setting

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
			is_displaying_suppliers := True
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
			is_displaying_suppliers := False
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

	collapse_button_pressed_action: PROCEDURE [ANY, TUPLE] is
			-- Action to be performed when `collapse_button' is pressed
		do
			Result := agent on_collapse_one_level
		end

	expand_button_pressed_action: PROCEDURE [ANY, TUPLE] is
			-- Action to be performed when `expand_button' is pressed
		do
			Result := agent on_expand_one_level
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
				if a_expanded and then not l_referencer_row.has_been_expanded and then l_referencer_row.is_referencer_class_row then
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
		do
			if not is_up_to_date then
				set_has_grid_been_binded_for_current_data (False)
				starting_element_group := domain_item_from_stone (starting_element).group
				if data /= Void then
					text.hide
					component_widget.show
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

	path_name_tester (a_row, b_row: EB_CLASS_BROWSER_DEPENDENCY_ROW; a_order: INTEGER): BOOLEAN is
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

	data: HASH_TABLE [HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS], QL_GROUP]
			-- Data to be displayed in current view
			-- The outer hash table is indexed by group, and its value is the inner table,
			-- inner table is indexed by "referenced class" and its value is a set of classes who references the referenced class.

	rows: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW] is
			-- Rows to be displayed
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
		do
			l_rows := rows
			l_rows.children.wipe_out
			l_data := data
			from
				l_data.start
			until
				l_data.after
			loop
					-- Setup group row.
				create l_group_row
				create l_dependency_row.make (l_data.key_for_iteration, l_group_row, Current)
				l_group_row.set_data (l_dependency_row)
				l_rows.children.force_last (l_group_row)

					-- Setup referenced class rows
				l_referenced_classes := l_data.item_for_iteration
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
						l_dependency_row.set_is_referencer_class (True)
						l_referencer_class_row.set_data (l_dependency_row)
						l_referenced_class_row.children.force_last (l_referencer_class_row)
						l_referencer_class_set.forth
					end
					l_referenced_classes.forth
				end
				l_data.forth
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
					if should_level_be_shown (a_level_index, l_rows.item_for_iteration) then
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
			l_feature_domain: QL_FEATURE_DOMAIN
			l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_new_row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_feature_criterion: QL_FEATURE_CRITERION
			l_order_list: LINKED_LIST [INTEGER]
		do
				-- Get features.
			create l_feature_generator
			l_feature_generator.enable_fill_domain
			if is_displaying_clients then
				create {QL_FEATURE_CALLER_IS_CRI}l_feature_criterion.make (a_referenced_class.wrapped_domain, normal_callee, True)
			else
				create {QL_FEATURE_CALLERS_OF_CRI}l_feature_criterion.make (a_referenced_class.wrapped_domain, normal_caller, True)
			end
			l_feature_criterion := l_feature_criterion and feature_criterion_factory.criterion_with_name (query_language_names.ql_cri_is_visible, [])
			l_feature_generator.set_criterion (l_feature_criterion)
			l_feature_domain ?= a_referencer_class.wrapped_domain.new_domain (l_feature_generator)
				-- Bind feature in `rows'.
			l_feature_domain := l_feature_domain.distinct
			from
				l_feature_domain.start
			until
				l_feature_domain.after
			loop
				create l_new_row_node
				create l_dependency_row.make (l_feature_domain.item, l_new_row_node, Current)
				l_new_row_node.set_data (l_dependency_row)
				a_row_node.children.force_last (l_new_row_node)
				l_feature_domain.forth
			end
			create l_order_list.make
			l_order_list.extend (4)
			sort_level (a_row_node, 4, 4, comparator (l_order_list))
			first_non_void_grid_item (a_row_node.data.grid_row).set_tooltip (Void)
			bind_row_level (a_row_node.data.grid_row, a_row_node, 4, False)
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
			if l_dependency_row = Void or else not (l_dependency_row.is_referencer_class_row and then not l_dependency_row.has_been_expanded) then
				Precursor (a_row)
			end
		end

feature{NONE} -- Initialization

	build_grid is
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (4)
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
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_CLASS_BROWSER_DEPENDENCY_ROW]
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column_internal := 0
			set_sort_action (agent sort_agent)
			create l_sort_info.make (agent path_name_tester, ascending_order)
			l_sort_info.enable_auto_indicator
			set_sort_info (1, l_sort_info)
			create l_sort_info.make (agent path_name_tester, ascending_order)
			l_sort_info.enable_auto_indicator
			set_sort_info (2, l_sort_info)
			create l_sort_info.make (agent path_name_tester, ascending_order)
			l_sort_info.enable_auto_indicator
			set_sort_info (3, l_sort_info)

			create l_sort_info.make (agent path_name_tester, ascending_order)
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
