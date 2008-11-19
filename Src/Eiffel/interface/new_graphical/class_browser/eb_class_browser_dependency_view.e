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
	EB_CLASS_BROWSER_SORTABLE_TREE_VIEW [EB_CLASS_BROWSER_DEPENDENCY_ROW]
--		undefine
--			pixmap_from_group_path,
--			pixmap_from_group
		redefine
			make,
			data,
			default_ensure_visible_action,
			recycle_agents,
			starting_element,
			expand_row_recursively
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

	EV_SHARED_APPLICATION

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	QL_SHARED_FEATURE_INVOKE_RELATION_TYPES

	QL_SHARED

	QL_UTILITY

	EB_DOMAIN_ITEM_UTILITY

create
	make

feature{NONE} -- Initialization

	make (a_dev_window: like development_window; a_drop_actions: like drop_actions) is
			-- Initialize.
		do
			Precursor (a_dev_window, a_drop_actions)
		end

feature -- Access

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Widget of a control bar through which, certain control can be performed upon current view
		local
			l_tool_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			if control_tool_bar = Void then
				create control_tool_bar.make (10)
				l_tool_bar := control_tool_bar

				l_tool_bar.extend (create{SD_TOOL_BAR_SEPARATOR}.make)

				l_tool_bar.extend (show_self_dependency_button)
				l_tool_bar.extend (categorize_folder_button)
				l_tool_bar.extend (recursive_button)

				l_tool_bar.extend (create{SD_TOOL_BAR_SEPARATOR}.make)

				l_tool_bar.extend (normal_referenced_button)
				l_tool_bar.extend (syntactical_button)
				l_tool_bar.extend (inheritance_button)

				l_tool_bar.extend (create{SD_TOOL_BAR_SEPARATOR}.make)

				l_tool_bar.extend (show_tooltip_button)
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

	syntactical_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to indicate if syntactical supplier/clients are displayed
		do
			if syntactical_button_internal = Void then
				create syntactical_button_internal.make (preferences.class_browser_data.syntactical_class_preference)
				syntactical_button_internal.set_pixmap (pixmaps.icon_pixmaps.class_overriden_normal_icon)
				syntactical_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.class_overriden_normal_icon_buffer)
				syntactical_button_internal.set_tooltip (interface_names.h_show_syntactical_classes)
				syntactical_button_internal.select_actions.extend (agent on_retrieve_data)
			end
			Result := syntactical_button_internal
		ensure
			result_attached: Result /= Void
		end

	inheritance_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to indicate if inheritance are displayed
		do
			if inheritance_button_internal = Void then
				create inheritance_button_internal.make (preferences.class_browser_data.inheritance_class_preference)
				inheritance_button_internal.set_pixmap (pixmaps.icon_pixmaps.diagram_inheritance_link_icon)
				inheritance_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.diagram_inheritance_link_icon_buffer)
				inheritance_button_internal.set_tooltip (interface_names.h_show_ancestor_classes)
				inheritance_button_internal.select_actions.extend (agent on_retrieve_data)
			end
			Result := inheritance_button_internal
		ensure
			result_attached: Result /= Void
		end

	normal_referenced_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to indicate if normal referenced supplier/clients are displayed
		do
			if normal_referenced_button_internal = Void then
				create normal_referenced_button_internal.make (preferences.class_browser_data.normal_referenced_class_preference)
				normal_referenced_button_internal.set_pixmap (pixmaps.icon_pixmaps.diagram_supplier_link_icon)
				normal_referenced_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.diagram_supplier_link_icon_buffer)
				normal_referenced_button_internal.set_tooltip (interface_names.h_show_normal_referenced_classes)
				normal_referenced_button_internal.select_actions.extend (agent on_retrieve_data)
			end
			Result := normal_referenced_button_internal
		ensure
			result_attached: Result /= Void
		end

	recursive_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to indicate if class search is recursive for folder
		do
			if recursive_button_internal = Void then
				create recursive_button_internal.make (preferences.class_browser_data.folder_search_recursive_preference)
				recursive_button_internal.set_pixmap (pixmaps.icon_pixmaps.debugger_object_expand_icon)
				recursive_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.debugger_object_expand_icon_buffer)
				recursive_button_internal.set_tooltip (interface_names.h_search_for_class_recursively)
				recursive_button_internal.select_actions.extend (agent on_retrieve_data)
			end
			Result := recursive_button_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip display be vetoed?
		do
			Result := show_tooltip_button.is_selected
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
			grid.column (1).header_item.set_text (interface_names.l_supplier_group)
			grid.column (2).header_item.set_text (interface_names.l_supplier_class)
			grid.column (3).header_item.set_text (referenced_class_column_name (interface_names.l_client_class, a_name_of_starting_element))
			grid.column (4).header_item.set_text (interface_names.l_feature_in_client_class)
			grid.column (5).header_item.set_text (interface_names.l_callees_from_supplier_class)
			set_is_displaying_suppliers (True)
			inheritance_button.set_tooltip (interface_names.h_show_ancestor_classes)
		ensure
			is_displaying_suppliers: is_displaying_suppliers
		end

	prepare_for_client_view (a_name_of_starting_element: STRING) is
			-- Prepare for display client dependency.
			-- `a_name_of_starting_element' is the name displayed in referenced class column.
		do
			grid.column (1).header_item.set_text (interface_names.l_client_group)
			grid.column (2).header_item.set_text (interface_names.l_client_class)
			grid.column (3).header_item.set_text (referenced_class_column_name (interface_names.l_supplier_class, a_name_of_starting_element))
			grid.column (4).header_item.set_text (interface_names.l_feature_in_supplier_class)
			grid.column (5).header_item.set_text (interface_names.l_callers_from_client_class)
			set_is_displaying_suppliers (False)
			inheritance_button.set_tooltip (interface_names.h_show_descendant_classes)
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

feature{NONE} -- Actions

	on_categorized_folder_changed is
			-- Action to be performed when selection status of `categorized_folder_button' changes
		do
			create_index_info
			if data /= Void then
				fill_rows
				disable_auto_sort_order_change
				enable_force_multi_column_sorting
				sort (0, 0, 1, 0, 0, 0, 0, 0, 1)
				disable_force_multi_column_sorting
				enable_auto_sort_order_change
				bind_grid
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
				if a_expanded and then l_referencer_row.is_lazy_expandable and then not l_referencer_row.has_been_expanded then
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

	on_retrieve_data is
			-- Action to be performed to retrieve data
		do
			is_up_to_date := False
			if data /= Void then
				retrieve_data_actions.call (Void)
			end
		end

	on_show_self_dependency_changed is
			-- Action to be performed when selection status of `show_self_dependency_button' changes
		do
			if data /= Void then
				bind_grid
			end
		end

feature -- Notification

	provide_result is
			-- Provide result displayed in Current view.
		local
			l_cluster_stone: CLUSTER_STONE
			l_item_from_stone: like domain_item_from_stone
		do
			set_has_grid_been_binded_for_current_data (False)
			l_item_from_stone := domain_item_from_stone (starting_element)
			if l_item_from_stone /= Void and then l_item_from_stone.is_valid then
				starting_element_group := domain_item_from_stone (starting_element).group
			end
			l_cluster_stone ?= starting_element
			is_starting_element_folder := l_cluster_stone /= Void and then (l_cluster_stone.path /= Void and then not l_cluster_stone.path.is_empty)

			retrieve_classes_in_starting_element
			data_hierarchy := Void
			fill_rows
			if last_sorted_column_internal = 0 then
				last_sorted_column_internal := 1
			end
			disable_auto_sort_order_change
			enable_force_multi_column_sorting
			sort (0, 0, 1, 0, 0, 0, 0, 0, last_sorted_column)
			disable_force_multi_column_sorting
			enable_auto_sort_order_change
			set_has_grid_been_binded_for_current_data (True)
			try_auto_resize_grid (<<[150, 300, 1], [150, 300, 2], [150, 200, 3], [100, 200, 4], [100, 200, 5]>>, False)
		end

feature -- Sorting

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
			if a_row.row_type = {EB_CLASS_BROWSER_DEPENDENCY_ROW}.folder_row_type then
				check b_row.row_type = {EB_CLASS_BROWSER_DEPENDENCY_ROW}.folder_row_type end
				if a_order = topology_order then
					Result := name_tester (a_row, b_row, ascending_order)
				else
					Result := name_tester (a_row, b_row, a_order)
				end
			else
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

feature -- Constants

	group_column: INTEGER is 1
	folder_column: INTEGER is 1
	referenced_class_column: INTEGER is 2
	referencer_class_column: INTEGER is 3
	feature_column: INTEGER is 4
	feature_list_column: INTEGER is 5
	position_column: INTEGER is 6
			-- Column names

feature{NONE} -- Grid binding

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
			l_grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_domain_item: EB_DOMAIN_ITEM
		do
			create l_grid_item
			l_domain_item := domain_item_from_stone (starting_element)
			if l_domain_item /= Void then
					-- Sometimes domain item can be void after an incomplete compilation.
				token_writer.new_line
				l_grid_item.set_text_with_tokens (token_name_from_domain_item (l_domain_item))
				l_grid_item.set_pixmap (pixmap_from_domain_item (l_domain_item))
				l_grid_item.set_image (l_grid_item.text)
				l_grid_item.set_stone (starting_element)
			end
			grid.insert_new_row (1)
			grid.row (1).set_item (1, l_grid_item)
		ensure
			first_row_binded: grid.row_count = 1
		end

	level_row_type: ARRAYED_LIST [INTEGER]
			-- List of row type indexed by level

	column_level_table: HASH_TABLE [INTEGER, INTEGER]
			-- Level-column mapping
			-- Key of this table is columns in `grid', it can be `group_column', `folder_column', `referenced_class_column',
			-- `referencer_class_column', `feature_column'.
			-- Value of that key is the level-index for that column

	create_index_info is
			-- Create `level_starting_column_index' and `level_row_type'
		local
			b: BOOLEAN
		do
			b := categorize_folder_button.is_selected
			if b then
					-- If classes are categorized in their physical folder, we have 5 levels: group - folder - referencer class - referenced class - feature
				level_starting_column_index.wipe_out
				level_starting_column_index.extend (1)
				level_starting_column_index.extend (1)
				level_starting_column_index.extend (2)
				level_starting_column_index.extend (3)
				level_starting_column_index.extend (4)
				create level_row_type.make (5)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.group_row_type)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.folder_row_type)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.referenced_class_row_type)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.referencer_class_row_type)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.feature_row_type)
				create column_level_table.make (5)
				column_level_table.put (1, group_column)
				column_level_table.put (2, folder_column)
				column_level_table.put (3, referenced_class_column)
				column_level_table.put (4, referencer_class_column)
				column_level_table.put (5, feature_column)
				levels_column_table.wipe_out
				levels_column_table.put ((<<1, 2>>).linear_representation, 1)
				levels_column_table.put ((<<3>>).linear_representation, 2)
				levels_column_table.put ((<<4>>).linear_representation, 3)
				levels_column_table.put ((<<5>>).linear_representation, 4)
				create post_row_bind_action_table.make (1)
				post_row_bind_action_table.force (agent ensure_row_expandable, 4)
			else
					-- If classes are not categorized in their physical folder, we have 4 levels: group - referencer class - referenced class - feature
				level_starting_column_index.wipe_out
				level_starting_column_index.extend (1)
				level_starting_column_index.extend (2)
				level_starting_column_index.extend (3)
				level_starting_column_index.extend (4)
				create level_row_type.make (4)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.group_row_type)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.referenced_class_row_type)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.referencer_class_row_type)
				level_row_type.extend ({EB_CLASS_BROWSER_DEPENDENCY_ROW}.feature_row_type)
				create column_level_table.make (4)
				column_level_table.put (1, group_column)
				column_level_table.put (2, referenced_class_column)
				column_level_table.put (3, referencer_class_column)
				column_level_table.put (4, feature_column)
				levels_column_table.wipe_out
				levels_column_table.put ((<<1>>).linear_representation, 1)
				levels_column_table.put ((<<2>>).linear_representation, 2)
				levels_column_table.put ((<<3>>).linear_representation, 3)
				levels_column_table.put ((<<4>>).linear_representation, 4)
				create post_row_bind_action_table.make (1)
				post_row_bind_action_table.force (agent ensure_row_expandable, 3)
			end
		end

	should_level_be_expanded (a_level_index: INTEGER): BOOLEAN is
			-- Should level indexed by `a_level_index' be expanded by default?
		local
			l_expansion_table: HASH_TABLE [FUNCTION [ANY, TUPLE, BOOLEAN], INTEGER]
		do
			create l_expansion_table.make (4)
			l_expansion_table.put (agent: BOOLEAN do Result := True end, 1)

			if categorize_folder_button.is_selected then
				l_expansion_table.put (agent (preferences.class_browser_data).should_categorized_folder_level_be_expanded, 2)
				l_expansion_table.put (agent (preferences.class_browser_data).should_referenced_class_be_expanded, 3)
				l_expansion_table.put (agent (preferences.class_browser_data).should_referencer_class_be_expanded, 4)
			else
				l_expansion_table.put (agent (preferences.class_browser_data).should_referenced_class_be_expanded, 2)
				l_expansion_table.put (agent (preferences.class_browser_data).should_referencer_class_be_expanded, 3)
				l_expansion_table.put (agent: BOOLEAN do Result := False end, 4)
			end
			if l_expansion_table.has (a_level_index) then
				Result := l_expansion_table.item (a_level_index).item (Void)
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
			l_row, l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
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
						a_base_row.insert_subrow (a_base_row.subrow_count + 1)
						l_grid_row := a_base_row.subrow (a_base_row.subrow_count)
						l_starting_column := level_starting_column_index.i_th (a_level_index)
							-- Bind subrows.
						if a_recursive and then not l_rows.item_for_iteration.children.is_empty then
							bind_row_level (l_grid_row, l_rows.item_for_iteration, a_level_index + 1, a_recursive)
						end
							-- Bind row.
						l_row := l_rows.item_for_iteration.data
						l_row.set_row_count (l_grid_row.subrow_count)
						l_row.bind_row (l_grid_row, l_starting_column)

							-- Expand rows.
						if l_grid_has_been_binded_for_current_data then
							l_dependency_row ?= a_level.data
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
			l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_new_row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_order_list: LINKED_LIST [INTEGER]
			l_feature_table: like called_features
			l_features: DS_HASH_SET [QL_FEATURE]
			l_grid_row: EV_GRID_ROW
			l_sorter: DS_QUICK_SORTER [QL_FEATURE]
			l_level_index: INTEGER
		do
				-- Get features.
			create l_feature_generator
			l_feature_generator.enable_fill_domain
			create l_features.make (100)
			l_features.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [QL_FEATURE]}.make (agent is_feature_equal))
			if is_displaying_clients then
				l_feature_table := reversed_called_features (called_features (a_referencer_class, a_referenced_class))
			else
				l_feature_table := called_features (a_referenced_class, a_referencer_class)
			end
			create l_sorter.make (create {AGENT_BASED_EQUALITY_TESTER [QL_FEATURE]}.make (agent (a_feature, b_feature: QL_FEATURE): BOOLEAN do Result := a_feature.name < b_feature.name end))
			l_level_index := column_level_table.item (feature_column)
			if not l_feature_table.is_empty then
					-- If classes are related by feature invocation, we insert rows for these invocations.
				from
					l_feature_table.start
				until
					l_feature_table.after
				loop
					create l_new_row_node
					create l_dependency_row.make (l_feature_table.key_for_iteration, l_new_row_node, {EB_CLASS_BROWSER_DEPENDENCY_ROW}.feature_row_type , Current)
					l_sorter.sort (l_feature_table.item_for_iteration)
					l_dependency_row.set_feature_list (l_feature_table.item_for_iteration)
					l_new_row_node.set_data (l_dependency_row)
					a_row_node.children.force_last (l_new_row_node)
					l_feature_table.forth
				end
					-- Sort features.
				create l_order_list.make
				l_order_list.extend (feature_column)
				sort_level (a_row_node, l_level_index, l_level_index, comparator (l_order_list), feature_column)
			else
					-- If classes are related either by inheritance relationship or only syntactical references
				a_row_node.data.grid_item.set_component_spacing (8)
				a_row_node.data.grid_item.enable_adhesive_component
				if is_class_inheritance_related (a_referenced_class, a_referencer_class) then
					if is_displaying_suppliers then
						add_trailer (a_referenced_class, pixmaps.icon_pixmaps.class_descendents_icon, interface_names.l_descendant_of, a_row_node.data.grid_item)
					else
						add_trailer (a_referenced_class, pixmaps.icon_pixmaps.class_ancestors_icon, interface_names.l_ancestor_of, a_row_node.data.grid_item)
					end
				else
					if is_displaying_suppliers then
						add_trailer (a_referenced_class, pixmaps.icon_pixmaps.class_clients_icon, interface_names.l_syntactical_client_of, a_row_node.data.grid_item)
					else
						add_trailer (a_referenced_class, pixmaps.icon_pixmaps.class_supliers_icon, interface_names.l_syntactical_supplier_of, a_row_node.data.grid_item)
					end
				end
				if a_row_node.data.grid_row.subrow_count > 0 then
					grid.remove_row (a_row_node.data.grid_row.subrow (1).index)
				end
			end

				-- Bind retrieved rows in grid.
			l_grid_row := a_row_node.data.grid_row
			bind_row_level (l_grid_row, a_row_node, l_level_index, False)
			a_row_node.data.set_row_count (l_grid_row.subrow_count - 1)
			a_row_node.data.refresh_row

				-- Highlight selected rows (if any)
			if l_grid_row.is_selected then
				highlight_row (l_grid_row)
			else
				dehighlight_row (l_grid_row)
			end

				-- Auto resize grid columns.
			try_auto_resize_grid (<<[100, 200, feature_list_column], [100, 500, position_column]>>, False)
		end

	add_trailer (a_class: QL_CLASS; a_pixmap: EV_PIXMAP; a_text: STRING; a_grid_item: EB_GRID_EDITOR_TOKEN_ITEM)is
			-- Add trailer into `a_grid_item' to display information of `a_class'.	
			-- The trailer will display pixmap given by `a_pixmap' with tooltip saying `a_text' + name of `a_class'.
		require
			a_class_attached: a_class /= Void
			a_pixmap_attached: a_pixmap /= Void
			a_text_attached: a_text /= Void
			a_grid_item_attached: a_grid_item /= Void
		local
			l_tooltip: EB_EDITOR_TOKEN_TOOLTIP
			l_trailer: ES_GRID_PIXMAP_COMPONENT
		do
			create l_trailer.make (a_pixmap)
			create l_tooltip.make (l_trailer.pointer_enter_actions , l_trailer.pointer_leave_actions, Void, agent a_grid_item.is_destroyed)
			l_tooltip.enable_pointer_on_tooltip
			plain_text_style.set_source_text (a_text)
			complete_generic_class_style.set_ql_class (a_class)
			l_tooltip.set_tooltip_text ((plain_text_style + complete_generic_class_style).text)
			l_tooltip.veto_tooltip_display_functions.extend (agent should_tooltip_be_displayed)
			initialize_editor_token_tooltip (l_tooltip)
			l_trailer.set_general_tooltip (l_tooltip)
			a_grid_item.insert_component (l_trailer, 1)
		end

	mark_display is
			-- Mark rows to be displayed or not to be displayed according to status of `show_self_dependency_button'.
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
			l_folders: DS_LIST [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
			l_cursor: DS_LIST_CURSOR [EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]]
			l_folder_count: INTEGER
		do
			l_rows := rows
			l_groups := l_rows.children
			l_show_self := show_self_dependency_button.is_selected
			l_starting_element_group := starting_element_group
			if l_show_self or l_starting_element_group = Void then
					-- If self dependency is shown, we just mark every thing to be displayed.
				if categorize_folder_button.is_selected then
					mark_display_in_rows (l_groups, 3, True)
				else
					mark_display_in_rows (l_groups, 2, True)
				end
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
						if categorize_folder_button.is_selected then
							mark_display_in_rows (l_groups.item_for_iteration.children, 3, True)
						else
							mark_display_in_rows (l_groups.item_for_iteration.children, 2, True)
						end
					else
						l_classes_from_starting_element := classes_in_starting_element
						if categorize_folder_button.is_selected then
							l_folders := l_groups.item_for_iteration.children
							l_cursor := l_folders.new_cursor
							l_folder_count := 0
							from
								l_cursor.start
							until
								l_cursor.after
							loop
								l_classes := l_cursor.item.children
								l_new_class_count := 0
								from
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
								l_cursor.item.data.set_should_current_row_be_displayed (l_new_class_count > 0)
								if l_new_class_count > 0 then
									l_folder_count := l_folder_count + 1
								end
								l_cursor.forth
							end
							l_groups.item_for_iteration.data.set_should_current_row_be_displayed (l_folder_count > 0)
						else
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

feature{NONE} -- Implementation

	data: TUPLE [dependency_data: HASH_TABLE [HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS], QL_GROUP]; class_list_in_starting_element: QL_CLASS_DOMAIN]
			-- Data to be displayed in current view
			-- for `dependency_data, the outer hash table is indexed by group, and its value is the inner table,
			-- inner table is indexed by "referenced class" and its value is a set of classes who references the referenced class.
			-- And `class_list_in_starting_element' is a list of classes which contained in `starting_element'.
			-- For example, if `starting_element' is a group, then `class_list_in_starting_element' is all classes in that group.

	data_hierarchy: EB_TREE_NODE [QL_ITEM]
			-- Tree hierarchy representation of `data'

	-- Comments for rows:
	-- rows: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW] is
			-- Rows to be displayed
			-- It is a tree hierarchy.
			-- If `categorize_folder_button' is not selected:
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
			--			  |
			--		      +- foo		make_from_string, count, as_lower
			-- This graph means group "demo" depends on "base" library, in detail, class MY_CLASS1 in "demo" uses STRING_8 in "base",
			-- and in more detail, feature "foo" from MY_CLASS1 uses feature "make_from_string", "count" and "as_lower" from class STRING_8.
			-- Here, "base" is dependency group, "STRING_8" is referenced class, "MY_CLASS1" is referencer class and "foo" is features in referencer class.
			--
			-- If `categorize_folder_button' is selected:
			-- The first level (level index is 1) are dependency groups,
			-- the second level (level index is 2) are folders,
			-- the thrid level (level index is 3) referenced classes in each dependency group,
			-- the forth level (level index is 4) are referencer classes to each referenced class,
			-- the fifth level (level index is 5) are features in referencer classes,			
			-- For example, if we are displaying suppliers of group "demo":
			-- demo
			--	|
			--  +- base
			--	   |
			--     +- kernel
			--         |
			--	       +- STRING_8
			--		       |
			--		       +- MY_CLASS1
			--				   |
			--		           +- foo		make_from_string, count, as_lower			

	control_tool_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Implementation of `control_bar'

	show_self_dependency_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to turn on/off item path display
			-- For examples, if we are displaying suppliers for a given group "demo",
			-- actually we are displaying supplier classes of every class in that group,
			-- and always classes in group "demo" will use other classes in group "demo",
			-- but sometimes we don't want to show those classes in group "demo" as supplier classes.
			-- In this case, we can choose not to show self dependency.
		do
			if show_self_dependency_button_internal = Void then
				create show_self_dependency_button_internal.make (preferences.class_browser_data.show_self_dependency_preference)
				show_self_dependency_button_internal.set_pixmap (pixmaps.icon_pixmaps.metric_unit_group_icon)
				show_self_dependency_button_internal.set_tooltip (interface_names.h_show_dependency_on_self)
				show_self_dependency_button_internal.select_actions.extend (agent on_show_self_dependency_changed)
			end
			Result := show_self_dependency_button_internal
		ensure
			result_attached: Result /= Void
		end

	show_self_dependency_button_internal: like show_self_dependency_button
			-- Implementation of `show_self_dependency_button'

	categorize_folder_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON is
			-- Toggle button to decide if classes in a given group should be displayed in physical folders where they locates.
			-- For example, if this button is not selected, the following will be displayed:
			-- + base
			--    |
			--	  +- ARRAY
			--
			-- And if this button is selected, the following will be displayed:
			-- + base
			--    |
			--	  + base.kernel
			--		 |
			--		 +- ARRAY
		do
			if categorize_folder_button_internal = Void then
				create categorize_folder_button_internal.make (preferences.class_browser_data.categorized_folder_preference)
				categorize_folder_button_internal.set_pixmap (pixmaps.icon_pixmaps.diagram_fill_cluster_icon)
				categorize_folder_button_internal.set_pixel_buffer (pixmaps.icon_pixmaps.diagram_fill_cluster_icon_buffer)
				categorize_folder_button_internal.set_tooltip (interface_names.h_categorize_folder)
				categorize_folder_button_internal.select_actions.extend (agent on_categorized_folder_changed)
			end
			Result := categorize_folder_button_internal
		ensure
			result_attached: Result /= Void
		end

	categorize_folder_button_internal: like categorize_folder_button
			-- Implementation of `categorize_folder_button'

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

	fill_row_level (a_data: EB_TREE_NODE [QL_ITEM]; a_row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]; a_starting_level_index: INTEGER; a_fill_children: BOOLEAN) is
			-- Fill items from children of `a_data' into subrows of `a_row_node' staring from level index `a_starting_level_index'.
			-- If `a_fill_children' is True, fill children of `a_data' recursively.
		require
			a_data_attached: a_data /= Void
			a_row_node_attached: a_row_node /= Void
		local
			l_cursor: DS_ARRAYED_LIST_CURSOR [EB_TREE_NODE [QL_ITEM]]
			l_dependency_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_row_type: INTEGER
			l_new_row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
		do
			if not a_data.children.is_empty then
				l_cursor := a_data.children.new_cursor
				l_row_type := level_row_type.i_th (a_starting_level_index)
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					create l_new_row_node
					create l_dependency_row.make (l_cursor.item.data, l_new_row_node, l_row_type, Current)
					l_new_row_node.set_data (l_dependency_row)
					a_row_node.children.force_last (l_new_row_node)
					if a_fill_children then
						fill_row_level (l_cursor.item, l_new_row_node, a_starting_level_index + 1, a_fill_children)
					end
					l_cursor.forth
				end
			end
		end

	set_data_hierarchy (a_data: like data) is
			-- Set `data_hierarchy' with `a_data'. Do not categorize folder.
		local
			l_data_hierarchy: like data_hierarchy
			l_data: like data
			l_referenced_classes: HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS]
			l_referencer_class_set: DS_HASH_SET [QL_CLASS]
			l_dependency_data: HASH_TABLE [HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS], QL_GROUP]
			l_group_level: EB_TREE_NODE [QL_ITEM]
			l_referenced_class_level: EB_TREE_NODE [QL_ITEM]
			l_referencer_class_level: EB_TREE_NODE [QL_ITEM]
		do
			create data_hierarchy
			l_data_hierarchy := data_hierarchy
			l_data := data
			from
				l_dependency_data := data.dependency_data
				l_dependency_data.start
			until
				l_dependency_data.after
			loop
					-- Setup group row.						
				create l_group_level
				l_group_level.set_data (l_dependency_data.key_for_iteration)
				l_data_hierarchy.children.force_last (l_group_level)

					-- Setup referenced class rows
				l_referenced_classes := l_dependency_data.item_for_iteration
				from
					l_referenced_classes.start
				until
					l_referenced_classes.after
				loop
					create l_referenced_class_level
					l_referenced_class_level.set_data (l_referenced_classes.key_for_iteration)
					l_group_level.children.force_last (l_referenced_class_level)
						-- Setup referencer class rows
					l_referencer_class_set := l_referenced_classes.item_for_iteration
					from
						l_referencer_class_set.start
					until
						l_referencer_class_set.after
					loop
						create l_referencer_class_level
						l_referencer_class_level.set_data (l_referencer_class_set.item_for_iteration)
						l_referenced_class_level.children.force_last (l_referencer_class_level)
						l_referencer_class_set.forth
					end
					l_referenced_classes.forth
				end
				l_dependency_data.forth
			end
		ensure
			data_hierarchy_attached: data_hierarchy /= Void
		end

	set_data_hierarchy_with_folder_categorized (a_data: like data) is
			-- Set `data_hierarchy' with `a_data'. Categorize folder.
		require
			a_data_attached: a_data /= Void
		local
			l_data_hierarchy: like data_hierarchy
			l_referencer_class_row: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			l_referenced_classes: HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS]
			l_referencer_class_set: DS_HASH_SET [QL_CLASS]
			l_dependency_data: HASH_TABLE [HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS], QL_GROUP]

			l_group_level: EB_TREE_NODE [QL_ITEM]
			l_referenced_class_level: EB_TREE_NODE [QL_ITEM]
			l_referencer_class_level: EB_TREE_NODE [QL_ITEM]
			l_folder_level: EB_TREE_NODE [QL_ITEM]
			l_class_table: HASH_TABLE [LINKED_LIST [QL_CLASS], STRING]
			l_class_list: LINKED_LIST [QL_CLASS]
			l_path: STRING
			l_path_item: QL_ITEM
			l_class: CONF_CLASS
		do
			create data_hierarchy
			l_data_hierarchy := data_hierarchy
			from
				l_dependency_data := data.dependency_data
				l_dependency_data.start
			until
				l_dependency_data.after
			loop
					-- Setup group row.						
				create l_group_level
				l_group_level.set_data (l_dependency_data.key_for_iteration)
				l_data_hierarchy.children.force_last (l_group_level)

					-- Setup referenced class rows
				l_referenced_classes := l_dependency_data.item_for_iteration
					-- Categorize classes by folders
				create l_class_table.make (64)
				from
					l_referenced_classes.start
				until
					l_referenced_classes.after
				loop
					l_class := l_referenced_classes.key_for_iteration.class_i.config_class
					l_path_item := conf_group_as_parent (l_class.group, True)
					l_path := l_path_item.path + l_class.path
					l_class_list := l_class_table.item (l_path)
					if l_class_list = Void then
						create l_class_list.make
						l_class_table.put (l_class_list, l_path)
					end
					l_class_list.extend (l_referenced_classes.key_for_iteration)
					l_referenced_classes.forth
				end

				from
					l_class_table.start
				until
					l_class_table.after
				loop
					create l_folder_level
					l_class_list := l_class_table.item_for_iteration
					l_folder_level.set_data (l_class_list.first)
					l_group_level.children.force_last (l_folder_level)
					from
						l_class_list.start
					until
						l_class_list.after
					loop
						create l_referenced_class_level
						l_referenced_class_level.set_data (l_class_list.item)
						l_folder_level.children.force_last (l_referenced_class_level)
							-- Setup referencer class rows
						l_referencer_class_set := l_referenced_classes.item (l_class_list.item)
						from
							l_referencer_class_set.start
						until
							l_referencer_class_set.after
						loop
							create l_referencer_class_row
							create l_referencer_class_level
							l_referencer_class_level.set_data (l_referencer_class_set.item_for_iteration)
							l_referenced_class_level.children.force_last (l_referencer_class_level)
							l_referencer_class_set.forth
						end
						l_class_list.forth
					end
					l_class_table.forth
				end
				l_dependency_data.forth
			end
		end

	fill_rows  is
			-- Fill rows with `data'.
		do
			rows.children.wipe_out
			if categorize_folder_button.is_selected then
				set_data_hierarchy_with_folder_categorized (data)
			else
				set_data_hierarchy (data)
			end
			fill_row_level (data_hierarchy, rows, 1, True)
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
			classes_in_starting_element.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [QL_CLASS]}.make (agent is_class_equal))
			l_class_domain.do_all (agent classes_in_starting_element.force_last)
		ensure
			classes_in_starting_element_attached: classes_in_starting_element /= Void
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
			l_list: DS_LIST [QL_FEATURE]
			l_list2: DS_LIST [QL_FEATURE]
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
					if Result.has_key (l_list.item_for_iteration) then
						l_list2 := Result.item (l_list.item_for_iteration)
					else
						create {DS_ARRAYED_LIST [QL_FEATURE]}l_list2.make (10)
						Result.put (l_list2, l_list.item_for_iteration)
					end
					l_list2.force_last (a_called_features.key_for_iteration)
					l_list.forth
				end
				a_called_features.forth
			end
		end

	called_features (a_supplier_class: QL_CLASS; a_client_class: QL_CLASS): HASH_TABLE [DS_LIST [QL_FEATURE], QL_FEATURE] is
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
			l_list: DS_LIST [QL_FEATURE]
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
											create {DS_ARRAYED_LIST [QL_FEATURE]} l_list.make (10)
											Result.put (l_list, l_client_feature)
										end
										l_list.force_last (l_supplier_feature)
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

	recycle_agents is
			-- Recycle agents
		do
			if categorize_folder_button_internal /= Void then
				categorize_folder_button.recycle
			end
			if show_self_dependency_button_internal /= Void then
				show_self_dependency_button.recycle
			end
			if inheritance_button_internal /= Void then
				inheritance_button.recycle
			end
			if normal_referenced_button_internal /= Void then
				normal_referenced_button.recycle
			end
			if syntactical_button_internal /= Void then
				syntactical_button.recycle
			end
			if recursive_button_internal /= Void then
				recursive_button.recycle
			end
			Precursor
		end

	referenced_class_column_name (a_relation_name: STRING_GENERAL; a_name_of_starting_element: STRING_GENERAL): STRING_GENERAL is
			-- Name of referenced class column in dependency view.
			-- `a_relation_name' is "client" or "supplier", and `a_name_of_starting_element' is the name of the target/group/folder/class where
			-- the relation is investigated.
		require
			a_relation_name_attached: a_relation_name /= Void
			a_name_of_starting_element_attached: a_name_of_starting_element /= Void
		do
			Result := interface_names.l_one_from_two (a_relation_name, a_name_of_starting_element)
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

	syntactical_button_internal: like syntactical_button
			-- Implementation of `syntactical_button'

	inheritance_button_internal: like inheritance_button
			-- Implementation of `inheritance_button'

	is_class_inheritance_related (a_class, b_class: QL_CLASS): BOOLEAN is
			-- Are `a_class' and `b_class' related by inheritance relationship?
			-- i.e.,  `is_displaying_suppliers' is True, is `a_class' an ancestor of `b_class'?
			-- and if `is_displaying_clients' is True, is `a_class' a descendant of `b_class'?
		require
			a_class_attached: a_class /= Void
			b_class_attached: b_class /= Void
		local
			l_criterion: QL_CLASS_CRITERION
			l_generator: QL_CLASS_DOMAIN_GENERATOR
			l_class_domain: QL_CLASS_DOMAIN
		do
			if is_displaying_suppliers then
				create {QL_CLASS_ANCESTOR_RELATION_CRI} l_criterion.make (b_class.wrapped_domain, {QL_CLASS_ANCESTOR_RELATION_CRI}.ancestor_type)
			else
				create {QL_CLASS_DESCENDANT_RELATION_CRI} l_criterion.make (b_class.wrapped_domain, {QL_CLASS_DESCENDANT_RELATION_CRI}.descendant_type)
			end
			create l_generator.make (l_criterion, True)
			l_class_domain ?= system_target_domain.new_domain (l_generator)
			l_class_domain.compare_objects
			Result := l_class_domain.has (a_class)
		end

	normal_referenced_button_internal: like normal_referenced_button
			-- Implementation of `normal_referenced_button'

	recursive_button_internal: like recursive_button
			-- Implementation of `recursive_button'

feature{NONE} -- Initialization

	build_grid is
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (6)
			grid.column (6).set_title (interface_names.t_reference_position)
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
			enable_grid_item_pnd_support
			set_select_all_action (agent do  end)
			enable_tree_node_highlight

			create_index_info
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
			grid.register_shortcut (
				create{ES_KEY_SHORTCUT}.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_left), True, False, False),
				agent on_collapse_one_level_partly
			)
		end

feature{NONE} -- Implementation/Stone

	item_to_put_in_editor: EV_GRID_ITEM is
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.			
		local
			l_rows: LIST [EV_GRID_ROW]
			l_grid_row: EV_GRID_ROW
			l_row: EB_CLASS_BROWSER_DEPENDENCY_ROW
			l_index: INTEGER
		do
			l_rows := grid.selected_rows
			if l_rows.count = 1 then
				l_grid_row := l_rows.first
				if
					is_subrow_recursively_expanded (
						l_grid_row,
						agent (a_grid_row: EV_GRID_ROW): BOOLEAN
							do
								Result := a_grid_row.is_expanded or else (a_grid_row.subrow_count = 1 and then a_grid_row.subrow (1).index_of_first_item = 0)
							end
					)
				then
					l_row ?= l_grid_row.data
					if l_row /= Void then
						if not l_row.is_stone_set then
							l_row.set_grid_item_stone
						end
						l_index := l_grid_row.index_of_first_item
						if l_index /= 0 then
							Result := l_grid_row.item (l_index)
						end
					else
						if l_grid_row.index = 1 then
							Result ?= l_grid_row.item (1)
						end
					end
				end
			end
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
