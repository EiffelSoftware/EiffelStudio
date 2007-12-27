indexing
	description: "Contextual menu factory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_MENU_FACTORY

inherit

	EB_SHARED_MANAGERS

	EB_SHARED_PREFERENCES

	EV_SHARED_APPLICATION

	EB_RECYCLABLE

	SHARED_BENCH_NAMES

create
	make

feature -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialization
		require
			a_window_not_void: a_window /= Void
		do
			dev_window := a_window
		end

feature -- Status report

	menu_displayable (a_pebble: ANY): BOOLEAN
			-- Should the menu be displayed?
		local
			l_shift_pressed: BOOLEAN
		do
			l_shift_pressed := (create {EV_ENVIRONMENT}).application.shift_pressed
			if is_pnd_mode then
				Result := l_shift_pressed
			else
				Result := not l_shift_pressed
			end
		end

feature -- Editor menu

	editor_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_editor: EB_CLICKABLE_EDITOR) is
			-- Setup editor menu.
		require
			a_menu_not_void: a_menu /= Void
			a_editor_not_void: a_editor /= Void
		local
			l_pebble: ANY
			l_classi_stone: CLASSI_STONE
			l_classc_stone: CLASSC_STONE
			l_editor_is_current_editor: BOOLEAN
		do
			l_editor_is_current_editor := a_editor = dev_window.editors_manager.current_editor
			if a_pebble = Void then
					-- If no pebble is selected, and if we show a menu in a real editor, we select
					-- the stone associated with the editor for displaying the context menu.
				if l_editor_is_current_editor then
						-- Try to get `stone' from editor and transformed it into a CLASSI_STONE
						-- or CLASSC_STONE depending on the stone. We do this because the stone
						-- could represent a feature and we want the context menu to show what is
						-- applicable to the current class.
					l_classc_stone ?= a_editor.stone
					if l_classc_stone /= Void and then l_classc_stone.is_valid then
						create {CLASSC_STONE} l_pebble.make (l_classc_stone.e_class)
					else
						l_classi_stone ?= a_editor.stone
						if l_classi_stone /= Void and then l_classi_stone.is_valid then
							create {CLASSI_STONE} l_pebble.make (l_classi_stone.class_i)
						end
					end
				end
			else
				l_pebble := a_pebble
			end
				-- Note: we still use `a_pebble' to check whether or not we should display the
				-- context menu, since `l_pebble' might not be Void anymore with the above change.
			if menu_displayable (l_pebble) or a_pebble = Void then
				current_editor := a_editor
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				if a_pebble /= Void then
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
					extend_separator (a_menu)
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					extend_separator (a_menu)
				end
				extend_basic_editor_menus (a_menu, a_editor)
				extend_view_in_main_formatters_menus (a_menu)
				extend_property_menu (a_menu, a_pebble)
				current_editor := Void
			end
		end

feature -- Class Tree Menu

	class_tree_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu for class item in class tree
		require
			a_menu_not_void: a_menu /= Void
		local
			l_stone: STONE
			l_target_stone: TARGET_STONE
			l_cluster_stone: CLUSTER_STONE
			l_group: CONF_GROUP
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				l_stone ?= a_pebble
				if l_stone /= Void then
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
					extend_separator (a_menu)
					extend_separator (a_menu)
					l_target_stone ?= l_stone
					if l_target_stone /= Void then
						extend_add_to_menu (a_menu, l_stone)
					else
						l_cluster_stone ?= l_stone
						if l_cluster_stone /= Void then
							extend_separator (a_menu)
							l_group := l_cluster_stone.group
							if l_group.is_cluster then
								extend_add_new_class_item (a_menu, l_cluster_stone, l_group.is_readonly)
								extend_add_subcluster_item (a_menu, l_cluster_stone, l_group.is_readonly)
							elseif l_group.is_library then
								extend_add_library (a_menu)
							elseif l_group.is_assembly then
								extend_add_assembly (a_menu)
							end
							extend_separator (a_menu)
						end
						extend_standard_compiler_item_menu (a_menu, l_stone)
						extend_separator (a_menu)
						extend_delete_class_cluster_menu (a_menu, l_stone)
					end
					extend_property_menu (a_menu, l_stone)
				end
			end
		end

	clusters_data_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu for clusters data stone.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_data_stone: DATA_STONE
		do
			if menu_displayable (a_pebble) then
				l_data_stone ?= a_pebble
				if l_data_stone /= Void then
					build_name (a_pebble)
					setup_pick_item (a_menu, l_data_stone)
					extend_separator (a_menu)
					extend_add_subcluster_item (a_menu, Void, False)
					extend_separator (a_menu)
					extend_add_to_menu (a_menu, l_data_stone)
					extend_property_menu (a_menu, l_data_stone)
				end
			end
		end

	libraries_data_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu for libraries data stone.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_data_stone: DATA_STONE
		do
			if menu_displayable (a_pebble) then
				l_data_stone ?= a_pebble
				if l_data_stone /= Void then
					build_name (a_pebble)
					setup_pick_item (a_menu, l_data_stone)
					extend_separator (a_menu)
					extend_add_library (a_menu)
					extend_separator (a_menu)
					extend_add_to_menu (a_menu, l_data_stone)
					extend_property_menu (a_menu, l_data_stone)
				end
			end
		end

	assemblies_data_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Context menu for assemblies data stone.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_data_stone: DATA_STONE
		do
			if menu_displayable (a_pebble) then
				l_data_stone ?= a_pebble
				if l_data_stone /= Void then
					build_name (a_pebble)
					setup_pick_item (a_menu, l_data_stone)
					extend_separator (a_menu)
					extend_add_assembly (a_menu)
					extend_separator (a_menu)
					extend_add_to_menu (a_menu, l_data_stone)
					extend_property_menu (a_menu, l_data_stone)
				end
			end
		end

feature -- Diagram tool

	diagram_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Setup editor menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_feature_stone: FEATURE_STONE
		do
			if menu_displayable (a_pebble) then
				if a_pebble = Void then
					extend_basic_diagram_menu (a_menu)
				else
					build_name (a_pebble)
					setup_pick_item (a_menu, a_pebble)
					extend_separator (a_menu)
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					extend_separator (a_menu)
					l_feature_stone ?= a_pebble
					if l_feature_stone = Void then
						extend_diagram_add_menu (a_menu, names.b_add, a_pebble)
						extend_diagram_include_all_classes (a_menu, a_pebble)
						extend_force_right_angle (a_menu, a_pebble)
						extend_remove_anchor (a_menu, a_pebble)
						extend_remove_from_diagram (a_menu, a_pebble)
						extend_diagram_delete_menu (a_menu, a_pebble)
					end
					extend_property_menu (a_menu, a_pebble)
				end
			end
		end

feature -- Feature tree

	uncompiled_feature_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_name: STRING) is
			-- Uncompiled feature item menu
		require
			a_name_not_void: a_name /= Void
			a_menu_not_void: a_menu /= Void
		do
		end

	feature_clause_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_clause: FEATURE_CLAUSE_AS) is
			-- Feature clause item menu
		require
			a_clause_not_void: a_clause /= Void
			a_menu_not_void: a_menu /= Void
		do
		end

feature -- Favorites menus

	favorites_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_item: EB_FAVORITES_TREE_ITEM) is
			-- Favorites menu
		require
			a_menu_not_void: a_menu /= Void
			a_item_not_void: a_item /= Void
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_new_favorite_class (a_menu)
				extend_add_favorite_folder (a_menu)
				extend_move_to_folder (a_menu, a_pebble)
				extend_remove_from_favorites (a_menu, a_pebble)
			end
		end

feature -- Metrics tool

	metric_domain_selector_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_selector: EB_METRIC_DOMAIN_SELECTOR) is
			-- Metrics domain selector context menu
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_metric_selector_remove (a_menu, a_pebble, a_selector)
				extend_property_menu (a_menu, a_pebble)
			end
		end

	metric_metric_selector_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_selector: EB_METRIC_SELECTOR) is
			-- Metrics domain selector context menu
		local
			l_unit: QL_METRIC_UNIT
			l_metric: EB_METRIC
			l_basic_metric: EB_METRIC_BASIC
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				l_unit ?= a_pebble
				l_metric ?= a_pebble
				l_basic_metric ?= a_pebble
				if l_unit /= Void then
					extend_metric_selector_move_up_and_down (a_menu, a_selector, l_unit)
				elseif l_metric /= Void then
					extend_metric_clone_metric (a_menu, l_metric)
						-- Only basic metric can be used as a template for quick metrics
					if l_basic_metric /= Void then
						extend_metric_quick_metric (a_menu, l_basic_metric)
					end
					extend_separator (a_menu)
					extend_new_metric (a_menu)
					extend_reload_metrics (a_menu)
					extend_metric_open_user_metric (a_menu)
					extend_import_metric_from_file (a_menu)
					extend_separator (a_menu)
					extend_metric_delete (a_menu, l_metric)
				end
			end
		end

feature -- Call stack menu

	call_stack_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Call stack menu.
		local
			l_call_stack_stone: CALL_STACK_STONE
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				l_call_stack_stone ?= a_pebble
				if l_call_stack_stone /= Void then
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					extend_separator (a_menu)
					extend_sync_in_context_tool (a_menu, a_pebble)
					extend_expanded_object_view (a_menu, a_pebble)
					extend_property_menu (a_menu, a_pebble)
				end
			end
		end

feature -- Object tool, Object Viewer and Watch tool menus

	object_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_objects_tool: ES_OBJECTS_TOOL_PANEL; a_grid: ES_OBJECTS_GRID) is
			-- Object tool menu
		local
			l_object_stone: OBJECT_STONE
			m: EV_MENU
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				l_object_stone ?= a_pebble
				if l_object_stone /= Void then
					extend_separator (a_menu)
					extend_expanded_object_view (a_menu, a_pebble)
					extend_property_menu (a_menu, a_pebble)
				end
				if a_objects_tool /= Void then
					m := a_objects_tool.tool_menu (False)
					if m /= Void then
						if l_object_stone /= Void then
							extend_separator (a_menu)
						end
						a_menu.extend (m)
					end
				end
				if a_grid /= Void then
					extend_objects_grid_menu (a_menu, a_grid)
				end
			end
		end

	watch_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_watch_tool: ES_WATCH_TOOL_PANEL; a_grid: ES_OBJECTS_GRID) is
			-- Watch tool menu
		local
			l_object_stone: OBJECT_STONE
			l_sep_added: BOOLEAN
			l_row: EV_GRID_ROW
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				l_object_stone ?= a_pebble
				if l_object_stone /= Void then
					extend_separator (a_menu)
					l_sep_added := True
					extend_expanded_object_view (a_menu, a_pebble)

					l_row ?= l_object_stone.ev_item
					if l_row /= Void then
						if not l_sep_added then
							extend_separator (a_menu)
							l_sep_added := True
						end
						a_menu.extend (new_menu_item (names.m_remove))
						a_menu.last.select_actions.extend (agent a_watch_tool.remove_expression_row (l_row))
					end
				end
				extend_property_menu (a_menu, a_pebble)
				if a_grid /= Void then
					extend_objects_grid_menu (a_menu, a_grid)
				end
			end
		end

	object_viewer_browser_view_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_grid: ES_OBJECTS_GRID) is
			-- Object viewer browser view menu.
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				if a_grid /= Void then
					extend_objects_grid_menu (a_menu, a_grid)
				end
			end
		end

	extend_objects_grid_menu (a_menu: EV_MENU; a_grid: ES_OBJECTS_GRID) is
			-- Objects grid specific menu
		require
			a_menu_not_void: a_menu /= Void
			a_grid_not_void: a_grid /= Void
		local
			l_cell: EV_GRID_ITEM
			l_label: EV_GRID_LABEL_ITEM
			l_sep_added: BOOLEAN
			s: STRING_GENERAL
			l_row: ES_OBJECTS_GRID_ROW
			l_line: ES_OBJECTS_GRID_LINE
		do
			l_cell := a_grid.last_picked_item
			if l_cell /= Void then
				l_row ?= l_cell.row
				if l_row /= Void then
					l_line := l_row.associated_line
					if l_line /= Void then
						s := l_line.text_data_for_clipboard
						if s /= Void and then not s.is_empty then
							if not l_sep_added then
								extend_separator (a_menu)
								l_sep_added := True
							end
							a_menu.extend (new_menu_item (names.m_Copy_row_to_clipboard))
							a_menu.last.select_actions.extend (agent copy_to_clipboard (s))
						end
					end
				end
				l_label ?= l_cell
				if l_label /= Void then
					s := l_label.text
					if not s.is_empty then
						if not l_sep_added then
							extend_separator (a_menu)
							l_sep_added := True
						end
						a_menu.extend (new_menu_item (names.m_Copy_cell_to_clipboard))
						a_menu.last.select_actions.extend (agent copy_to_clipboard (s))
					end
				end
			end
		end

	copy_to_clipboard (t: STRING_GENERAL) is
			-- Copy `t' to clipboard
		do
			if t /= Void then
				ev_application.clipboard.set_text (t)
			end
		end


feature -- Search scope menu

	search_scope_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Search scope menu
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				extend_separator (a_menu)
				extend_search_scope_remove (a_menu, a_pebble)
				extend_property_menu (a_menu, a_pebble)
			end
		end

feature -- Standard menus

	standard_compiler_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Standard compiler item menu. (class/feature/cluster)
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				if a_pebble /= Void then
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
					extend_separator (a_menu)
				end
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				extend_property_menu (a_menu, a_pebble)
			end
		end

feature {NONE} -- Menu section, Granularity 2.

	extend_standard_compiler_item_menu (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend menu items for standard cluster/class/feature.
		local
			l_stonec: CLASSC_STONE
			l_stonei: CLASSI_STONE
			l_feature_stone: FEATURE_STONE
			l_cluster_stone: CLUSTER_STONE
			l_stone: STONE
		do
			l_feature_stone ?= a_pebble
			l_stonec ?= a_pebble
			l_stonei ?= a_pebble
			l_cluster_stone ?= a_pebble
			l_stone ?= a_pebble
			if l_feature_stone /= Void then
				extend_basic_opening_menus (a_menu, l_feature_stone, True)
				extend_separator (a_menu)
				extend_feature_formatter_menus (a_menu, l_feature_stone)
				extend_feature_refactoring_menus (a_menu, l_feature_stone)
				extend_debug_feature_menus (a_menu, l_feature_stone.e_feature)
				extend_add_to_menu (a_menu, l_stone)
			elseif l_stonec /= Void then
				extend_basic_opening_menus (a_menu, l_stonec, True)
				extend_separator (a_menu)
				extend_class_formatter_menus (a_menu, l_stonec)
				extend_class_refactoring_menus (a_menu, l_stonec)
				extend_debug_class_menus (a_menu, l_stonec.e_class)
				extend_add_to_menu (a_menu, l_stone)
			elseif l_stonei /= Void then
				extend_basic_opening_menus (a_menu, l_stonei, True)
				extend_separator (a_menu)
				extend_class_refactoring_menus (a_menu, l_stonei)
				extend_add_to_menu (a_menu, l_stone)
			elseif l_cluster_stone /= Void then
				extend_basic_opening_menus (a_menu, l_stone, False)
				extend_add_to_menu (a_menu, l_stone)
			end
		end

	extend_basic_diagram_menu (a_menu: EV_MENU) is
			-- Extend menus for blank diagram area.
		require
			a_menu_not_void: a_menu /= Void
		do

		end

feature {NONE} -- Menu section, Granularity 1.

	extend_basic_opening_menus (a_menu: EV_MENU; a_stone: STONE; a_external_editor: BOOLEAN) is
			-- Add items of basic opening operations.
			-- |Open in new Tab
			-- |Open in Editor
			-- |Open in external Editor
		require
			a_menu_not_void: a_menu /= Void
		local
			l_stone: STONE
		do
			l_stone := a_stone
			a_menu.extend (dev_window.commands.new_tab_cmd.new_menu_item_unmanaged)
			a_menu.last.set_text (names.m_context_menu_new_tab (last_type, last_name))
			a_menu.last.select_actions.wipe_out
			a_menu.last.select_actions.extend (agent (dev_window.commands.new_tab_cmd).execute_with_stone (l_stone))
			if current_editor /= Void and then l_stone.same_as (current_editor.stone) then
				a_menu.last.disable_sensitive
			end

			a_menu.extend (dev_window.new_development_window_cmd.new_menu_item_unmanaged)
			a_menu.last.set_text (names.m_context_menu_new_window (last_type, last_name))
			a_menu.last.select_actions.wipe_out
			a_menu.last.select_actions.extend (agent (dev_window.new_development_window_cmd).execute_with_stone (l_stone))
			if current_editor /= Void and then l_stone.same_as (current_editor.stone) then
				a_menu.last.disable_sensitive
			end

			if a_external_editor then
				a_menu.extend (dev_window.commands.shell_cmd.new_menu_item_unmanaged)
				a_menu.last.set_text (names.m_context_menu_external_editor (last_type, last_name))
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent (dev_window.commands.shell_cmd).execute_with_stone (l_stone))
			end
		end

	extend_basic_editor_menus (a_menu: EV_MENU; a_editor: EB_CLICKABLE_EDITOR) is
			-- Add items of basic editor operations.
			-- |Cut
			-- |Copy
			-- |Paste
			-- |----
			-- |Select All
			-- |Edit-->...
		require
			a_menu_not_void: a_menu /= Void
			a_editor_not_void: a_editor /= Void
		local
			l_menu: EV_MENU
			l_cmd: EB_STANDARD_CMD
			l_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
			is_editable: BOOLEAN
--			l_editor_is_current_editor: BOOLEAN
		do
				-- The commented code below is kept so that if one wants to add one of the commented item back to the
				-- context menu, we know in which order we should do it.
			is_editable := a_editor.is_editable
--			l_editor_is_current_editor := a_editor = dev_window.editors_manager.current_editor
--			a_menu.extend (dev_window.commands.undo_cmd.new_menu_item_unmanaged)
--			if not is_editable then
--				a_menu.last.disable_sensitive
--			end

--			a_menu.extend (dev_window.commands.redo_cmd.new_menu_item_unmanaged)
--			if not is_editable then
--				a_menu.last.disable_sensitive
--			end
--			extend_separator (a_menu)

			a_menu.extend (dev_window.commands.editor_cut_cmd.new_menu_item_unmanaged)
			if not is_editable then
				a_menu.last.disable_sensitive
			end
			a_menu.extend (dev_window.commands.editor_copy_cmd.new_menu_item_unmanaged)
			a_menu.extend (dev_window.commands.editor_paste_cmd.new_menu_item_unmanaged)
			if not is_editable then
				a_menu.last.disable_sensitive
			end
			extend_separator (a_menu)
			a_menu.extend (new_menu_item (names.m_select_all))
			a_menu.last.select_actions.extend (agent dev_window.select_all)
--			extend_separator (a_menu)


				-- The following command are hard-coded and depend on positioning within `editor_commands' list.
			l_commands := dev_window.commands.editor_commands
			l_commands.go_i_th (5)

				-- Toggle Line Numbers
--			if l_editor_is_current_editor then
--					-- We don't want this item shown for non editors
--				l_cmd ?= l_commands.item
--				a_menu.extend (l_cmd.new_menu_item_unmanaged)
--				extend_separator (a_menu)
--			end
			l_commands.forth

				-- Find
--			l_cmd ?= l_commands.item
--			a_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Go To
--			l_cmd ?= l_commands.item
--			a_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Replace
--			l_cmd ?= l_commands.item
--			a_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth
--			if not is_editable then
--				a_menu.last.disable_sensitive
--			end

--			create l_menu.make_with_text (names.m_find)
--			a_menu.extend (l_menu)


				-- Find Next
--			l_cmd ?= l_commands.item
--			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Find Previous
--			l_cmd ?= l_commands.item
--			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Find Next Selection
--			l_cmd ?= l_commands.item
--			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Find Previous Selection
--			l_cmd ?= l_commands.item
--			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth


--			extend_separator (a_menu)
			create l_menu.make_with_text (names.m_advanced)
			a_menu.extend (l_menu)

				-- Indent Selection
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Unindent Selection
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Set to Lowercase
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Set to Uppercase
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Comment
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Uncomment
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

			extend_separator (l_menu)

				-- Embed in "If"
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Embed in "Debug"
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

			extend_separator (l_menu)

				-- Complete Word
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

				-- Complete Class Name
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth

			extend_separator (l_menu)

				-- Show Formatting Marks
			l_cmd ?= l_commands.item
			l_menu.extend (l_cmd.new_menu_item_unmanaged)
			l_commands.forth
		end

	extend_view_in_main_formatters_menus (a_menu: EV_MENU) is
			--|----
			--| View -->	Basic view
			--|				Clickable view
			--|				Flat view
			--|				Interface view
			--|				Contract view
		require
			a_menu_not_void: a_menu /= Void
		local
			l_menu: EV_MENU
			l_item, l_selected_item: EV_RADIO_MENU_ITEM
			l_form: EB_CLASS_INFO_FORMATTER
			l_editor: EB_SMART_EDITOR
			l_cluster_stone: CLUSTER_STONE
			l_internal: INTERNAL
		do
			l_editor := dev_window.editors_manager.current_editor
			if l_editor /= Void and then l_editor = current_editor then
					-- Menu only appears when showing the context menu in a real editor (the one where
					-- classes are edited).
				extend_separator (a_menu)
				create l_menu.make_with_text (names.m_view)
				a_menu.extend (l_menu)
				from
					dev_window.managed_main_formatters.start
				until
					dev_window.managed_main_formatters.after
				loop
					l_form := dev_window.managed_main_formatters.item
					l_item := l_form.new_standalone_menu_item
					if l_form.selected and l_form.is_button_sensitive then
						l_selected_item := l_item
					end
					l_menu.extend (l_item)
					l_menu.last.select_actions.extend (agent l_form.execute)
					dev_window.managed_main_formatters.forth
				end
				if l_selected_item /= Void then
					l_selected_item.enable_select
				end
				l_cluster_stone ?= l_editor.stone
				create l_internal
				if l_editor.changed or else l_cluster_stone /= Void or else (l_internal.type_of (l_editor.stone)).is_equal ({CLASSI_STONE}) then
						-- Editor is being edited, disable the view menu since selecting one
						-- of the entry could discard the changes being made, if the editor is currently
						-- showing a cluster or uncompiled class then no view can be attained so it is also
						-- disabled.
					l_menu.disable_sensitive
				end
			end
		end

	extend_class_formatter_menus (a_menu: EV_MENU; a_class_stone: CLASSC_STONE) is
			-- Extend class formatter menus.
		require
			a_menu_not_void: a_menu /= Void
			a_class_stone_not_void: a_class_stone /= Void
		local
			l_menu, l_c_menu: EV_MENU
			l_class_formatter: EB_CLASS_INFO_FORMATTER
			l_customized_tools: LIST [EB_CUSTOMIZED_TOOL]
			l_customized_tool: EB_CUSTOMIZED_TOOL
		do
			create l_menu.make_with_text (names.m_show)
			a_menu.extend (l_menu)

			from
				dev_window.managed_class_formatters.start
			until
				dev_window.managed_class_formatters.after
			loop
				l_class_formatter ?= dev_window.managed_class_formatters.item
				if l_class_formatter /= Void then
					l_menu.extend (new_menu_item (l_class_formatter.menu_name))
					l_menu.last.set_pixmap (l_class_formatter.pixel_buffer)
					l_menu.last.select_actions.extend (agent (dev_window.tools.class_tool).show)
					l_menu.last.select_actions.extend (agent l_class_formatter.execute_with_stone (a_class_stone))
				else
					extend_separator (l_menu)
				end
				dev_window.managed_class_formatters.forth
			end

				-- Extend customized formatters.
			create l_c_menu.make_with_text (names.f_customize_formatter)
			l_menu.extend (l_c_menu)

			extend_formatter (l_c_menu, dev_window.tools.class_tool.customized_formatters, dev_window.tools.class_tool, a_class_stone)
			extend_formatter (l_c_menu, dev_window.tools.dependency_tool.customized_formatters, dev_window.tools.dependency_tool, a_class_stone)
			l_customized_tools := dev_window.tools.customized_tools
			from
				l_customized_tools.start
			until
				l_customized_tools.after
			loop
				l_customized_tool := l_customized_tools.item
				extend_formatter (l_c_menu, l_customized_tool.formatters, l_customized_tool, a_class_stone)
				l_customized_tools.forth
			end
			if l_c_menu.is_empty then
				l_c_menu.disable_sensitive
			end

			extend_separator (l_menu)

			l_menu.extend (dev_window.tools.cluster_tool.show_current_class_cluster_cmd.new_menu_item_unmanaged)
			l_menu.last.select_actions.wipe_out
			l_menu.last.select_actions.extend (agent (dev_window.tools.cluster_tool).show_class (a_class_stone))

			l_menu.extend (dev_window.tools.diagram_tool.center_diagram_cmd.new_menu_item_unmanaged)
			l_menu.last.select_actions.wipe_out
			l_menu.last.select_actions.extend (agent (dev_window.tools.diagram_tool.center_diagram_cmd).execute_with_class_stone (a_class_stone))
		end

	extend_feature_formatter_menus (a_menu: EV_MENU; a_feature_stone: FEATURE_STONE) is
			-- Extend class formatter menus.
		require
			a_menu_not_void: a_menu /= Void
			a_feature_stone_not_void: a_feature_stone /= Void
		local
			l_menu, l_c_menu: EV_MENU
			l_feature_formatter: EB_FEATURE_INFO_FORMATTER
			l_customized_tools: LIST [EB_CUSTOMIZED_TOOL]
			l_customized_tool: EB_CUSTOMIZED_TOOL
		do
			create l_menu.make_with_text (names.m_show)
			a_menu.extend (l_menu)

			from
				dev_window.managed_feature_formatters.start
			until
				dev_window.managed_feature_formatters.after
			loop
				l_feature_formatter ?= dev_window.managed_feature_formatters.item
				if l_feature_formatter /= Void then
					l_menu.extend (new_menu_item (l_feature_formatter.menu_name))
					l_menu.last.set_pixmap (l_feature_formatter.pixel_buffer)
					l_menu.last.select_actions.extend (agent (dev_window.tools.features_relation_tool).show)
					l_menu.last.select_actions.extend (agent l_feature_formatter.execute_with_stone (a_feature_stone))
				else
					extend_separator (l_menu)
				end
				dev_window.managed_feature_formatters.forth
			end

				-- Extend customized formatters.
			create l_c_menu.make_with_text (names.f_customize_formatter)
			l_menu.extend (l_c_menu)

			extend_formatter (l_c_menu, dev_window.tools.features_relation_tool.customized_formatters, dev_window.tools.features_relation_tool, a_feature_stone)
			extend_formatter (l_c_menu, dev_window.tools.dependency_tool.customized_formatters, dev_window.tools.dependency_tool, a_feature_stone)
			l_customized_tools := dev_window.tools.customized_tools
			from
				l_customized_tools.start
			until
				l_customized_tools.after
			loop
				l_customized_tool := l_customized_tools.item
				extend_formatter (l_c_menu, l_customized_tool.formatters, l_customized_tool, a_feature_stone)
				l_customized_tools.forth
			end
			if l_c_menu.is_empty then
				l_c_menu.disable_sensitive
			end
		end

	extend_formatter (a_menu: EV_MENU; a_formatters: LIST [EB_FORMATTER]; a_tool: EB_TOOL; a_stone: STONE) is
			-- Extend formatter excution menu entries.
		require
			a_menu_not_void: a_menu /= Void
			a_formatter_not_void: a_formatters /= Void
			a_tool_not_void: a_tool /= Void
		do
			from
				a_formatters.start
			until
				a_formatters.after
			loop
				a_menu.extend (new_menu_item (a_formatters.item.name))
				a_menu.last.select_actions.extend (agent a_tool.show)
				a_menu.last.select_actions.extend (agent (a_formatters.item).execute_with_stone (a_stone))
				a_formatters.forth
			end
		end

	extend_class_refactoring_menus (a_menu: EV_MENU; a_stone: CLASSI_STONE) is
			-- Extend class refactoring menus.
		require
			a_menu_not_void: a_menu /= Void
			a_stone_not_void: a_stone /= Void
		local
			l_menu: EV_MENU
		do
			create l_menu.make_with_text (names.m_refactoring)
			a_menu.extend (l_menu)
			l_menu.extend (dev_window.refactoring_manager.rename_command.new_menu_item_unmanaged)
			l_menu.last.select_actions.wipe_out
			l_menu.last.select_actions.extend (agent (dev_window.refactoring_manager.rename_command).drop_class (a_stone))
--			l_menu.extend (new_menu_item ("Move"))
			--| FIXME IEK There is no dialog for moving a class?
		end

	extend_feature_refactoring_menus (a_menu: EV_MENU; a_stone: FEATURE_STONE) is
			-- Extend feature refactoring menus.
		require
			a_menu_not_void: a_menu /= Void
			a_stone_not_void: a_stone /= Void
		local
			l_menu: EV_MENU
		do
			create l_menu.make_with_text (names.m_refactoring)
			a_menu.extend (l_menu)
			l_menu.extend (dev_window.refactoring_manager.rename_command.new_menu_item_unmanaged)
			l_menu.last.select_actions.wipe_out
			l_menu.last.select_actions.extend (agent (dev_window.refactoring_manager.rename_command).drop_feature (a_stone))

			l_menu.extend (dev_window.refactoring_manager.pull_command.new_menu_item_unmanaged)
			l_menu.last.select_actions.wipe_out
			l_menu.last.select_actions.extend (agent (dev_window.refactoring_manager.pull_command).drop_feature (a_stone))
		end

	extend_debug_class_menus (a_menu: EV_MENU; a_class_c: CLASS_C) is
			-- Extend debug menu for a class.
		require
			a_menu_not_void: a_menu /= Void
			a_class_c_not_void: a_class_c /= Void
		local
			l_menu: EV_MENU
		do
			create l_menu.make_with_text (names.m_debug)
			a_menu.extend (l_menu)
			l_menu.extend (new_menu_item (names.m_add_first_breakpoints_in_class))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.breakpoints_manager.enable_first_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (new_menu_item (names.m_enable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.breakpoints_manager.enable_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (new_menu_item (names.m_disable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.breakpoints_manager.disable_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (new_menu_item (names.m_clear_breakpoints))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.breakpoints_manager.remove_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)
		end

	extend_debug_feature_menus (a_menu: EV_MENU; a_efeature: E_FEATURE) is
			-- Extend debug menus for a feature.
		require
			a_menu_not_void: a_menu /= Void
			a_feature_not_void: a_efeature /= Void
		local
			l_menu: EV_MENU
		do
			create l_menu.make_with_text (names.m_debug)
			a_menu.extend (l_menu)
			l_menu.extend (new_menu_item (names.m_add_first_breakpoints_in_feature))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.breakpoints_manager.enable_first_breakpoint_of_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (new_menu_item (names.m_enable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.breakpoints_manager.enable_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (new_menu_item (names.m_disable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.breakpoints_manager.disable_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (new_menu_item (names.m_clear_breakpoints))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.breakpoints_manager.remove_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)
		end

	extend_add_to_menu (a_menu: EV_MENU; a_pebble: STONE) is
			-- Extend Add to menu.
		require
			a_menu_not_void: a_menu /= Void
			a_pebble_not_void: a_pebble /= Void
		local
			l_menu, l_menu2: EV_MENU
			l_class_stone: CLASSC_STONE
			l_debugger: EB_DEBUGGER_MANAGER
			l_list: LINKED_SET [ES_WATCH_TOOL_PANEL]
		do
			create l_menu.make_with_text (names.m_add_to)
			a_menu.extend (l_menu)

			if dev_window.tools.search_tool.veto_pebble_function (a_pebble) then
				l_menu.extend (new_menu_item (names.m_search_scope))
				l_menu.last.select_actions.extend (agent (dev_window.tools.search_tool).on_drop_add (a_pebble))
			end

			if favorite_manager.veto_pebble_function (a_pebble) then
				l_menu.extend (new_menu_item (names.m_favorites))
				l_menu.last.select_actions.extend (agent favorite_manager.add_stone (a_pebble))
			end

			if dev_window.tools.metric_tool.is_ready then
			   create l_menu2.make_with_text (names.m_input_domain)
			   l_menu.extend (l_menu2)
			   l_menu2.extend (new_menu_item (metric_names.t_evaluation_tab))
			   l_menu2.last.select_actions.extend (
			    agent (a_stone: STONE) do
			     dev_window.tools.metric_tool.metric_evaluation_panel.force_drop_stone (a_stone)
			    end (a_pebble)
			   )
			   l_menu2.extend (new_menu_item (metric_names.t_archive_tab))
			   l_menu2.last.select_actions.extend (
			    agent (a_stone: STONE) do
			     dev_window.tools.metric_tool.metric_archive_panel.force_drop_stone (a_stone)
			    end (a_pebble)
			   )
			end

				-- Added to Watch tool, if possible.
			l_class_stone ?= a_pebble
			if l_class_stone /= Void then
				l_debugger := dev_window.eb_debugger_manager
				l_list := l_debugger.watch_tool_list
				if l_debugger.raised and not l_list.is_empty then
					create l_menu2.make_with_text (names.m_watch_tool)
					l_menu.extend (l_menu2)
					from
						l_list.start
					until
						l_list.after
					loop
						l_menu2.extend (new_menu_item (l_list.item.title))
						l_menu2.last.select_actions.extend (agent (l_list.item).on_element_drop (l_class_stone))
						l_list.forth
					end
				end
			end
		end

	extend_delete_class_cluster_menu (a_menu: EV_MENU; a_pebble: STONE) is
			-- Delete class/cluster menu
		require
			a_menu_not_void: a_menu /= Void
			a_pebble_not_void: a_pebble /= Void
		local
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
		do
			l_classi_stone ?= a_pebble
			if l_classi_stone /= Void then
				a_menu.extend (dev_window.commands.delete_class_cluster_cmd.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent (dev_window.commands.delete_class_cluster_cmd).drop_class (l_classi_stone))
			else
				l_cluster_stone ?= a_pebble
				if l_cluster_stone /= Void then
					a_menu.extend (dev_window.commands.delete_class_cluster_cmd.new_menu_item_unmanaged)
					a_menu.last.select_actions.wipe_out
					a_menu.last.select_actions.extend (agent (dev_window.commands.delete_class_cluster_cmd).drop_cluster (l_cluster_stone))
				end
			end
		end

	extend_add_new_class_item (a_menu: EV_MENU; a_cluster_stone: CLUSTER_STONE; a_disabled: BOOLEAN) is
			-- Extend Add new class menu to `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
			a_cluster_stone_not_void: a_cluster_stone /= Void
		do
			a_menu.extend (dev_window.commands.new_class_cmd.new_menu_item_unmanaged)
			a_menu.last.select_actions.wipe_out
			a_menu.last.select_actions.extend (agent (dev_window.commands.new_class_cmd).execute_stone (a_cluster_stone))
			if a_disabled then
				a_menu.last.disable_sensitive
			end
		end

	extend_add_subcluster_item (a_menu: EV_MENU; a_cluster_stone: CLUSTER_STONE; a_disabled: BOOLEAN) is
			-- Extend Add subcluster item to `a_menu'.
			-- If `a_cluster_stone' is Void, we add simple new cluster command.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (dev_window.commands.new_cluster_cmd.new_menu_item_unmanaged)
			if a_cluster_stone /= Void then
				a_menu.last.set_text (names.m_add_subcluster)
			end
			if a_cluster_stone /= Void then
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent (dev_window.commands.new_cluster_cmd).execute_stone (a_cluster_stone))
			end
			if a_disabled then
				a_menu.last.disable_sensitive
			end
		end

	extend_add_library (a_menu: EV_MENU) is
			-- Extend Add library item to `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (dev_window.commands.new_library_cmd.new_menu_item_unmanaged)
		end

	extend_add_assembly (a_menu: EV_MENU) is
			-- Extend Add assembly item to `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (dev_window.commands.new_assembly_cmd.new_menu_item_unmanaged)
		end

	extend_search_scope_remove (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend search remove menu.
		local
			l_search_tool: ES_MULTI_SEARCH_TOOL_PANEL
		do
			l_search_tool := dev_window.tools.search_tool
			a_menu.extend (new_menu_item (names.m_remove))
			a_menu.last.select_actions.extend (agent l_search_tool.on_drop_remove (a_pebble))
			a_menu.extend (new_menu_item (names.m_remove_all))
			a_menu.last.select_actions.extend (agent l_search_tool.remove_all)
		end

	extend_property_menu (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend Properties menu item relating to `a_pebble'.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_menu_item: EV_MENU_ITEM
			l_properties_tool: ES_PROPERTIES_TOOL_PANEL
			l_stone: STONE
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				l_properties_tool := dev_window.tools.properties_tool
				if l_properties_tool.dropable (l_stone) then
					create l_menu_item.make_with_text (l_properties_tool.menu_name)
					l_menu_item.select_actions.extend (agent l_properties_tool.show)
					l_menu_item.select_actions.extend (agent l_properties_tool.set_stone (l_stone))
					a_menu.extend (create {EV_MENU_SEPARATOR})
					a_menu.extend (l_menu_item)
				end
			end
		end

	extend_retarget_tool_menu (a_source: EV_PICK_AND_DROPABLE; a_menu: EV_MENU; a_pebble: ANY)
		require
			a_source_not_void: a_source /= Void
			a_menu_not_void: a_menu /= Void
			a_pebble_not_void: a_pebble /= Void
		local
			l_text: STRING_32
		do
			if last_type /= Void and then last_name /= Void and then a_source.drop_actions.accepts_pebble (a_pebble) then
				extend_separator (a_menu)
				l_text := names.m_context_menu_retarget (last_type, last_name)
				a_menu.extend (create {EV_MENU_ITEM}.make_with_text (l_text))
				a_menu.last.select_actions.extend (agent (a_source.drop_actions).call ([a_pebble]))
			end
		end


feature {NONE} -- Diagram menu section, Granularity 1.

	extend_diagram_add_menu (a_menu: EV_MENU; a_name: STRING_GENERAL; a_pebble: ANY) is
			-- Extend Add commands in diagram.
		require
			a_menu_not_void: a_menu /= Void
			a_name_not_void: a_name /= Void
		local
			l_menu: EV_MENU
			l_classi_stone: CLASSI_STONE
			l_figures: CLASS_FIGURE_LIST_STONE
			l_diagram_tool: ES_DIAGRAM_TOOL_PANEL
		do
			l_classi_stone ?= a_pebble
			l_figures ?= a_pebble
			if l_classi_stone /= Void or l_figures /= Void then
				create l_menu.make_with_text (a_name)
				a_menu.extend (l_menu)
				l_diagram_tool := dev_window.tools.diagram_tool

				l_menu.extend (l_diagram_tool.toggle_selected_classes_ancestors_cmd.new_menu_item_unmanaged)
				l_menu.last.select_actions.wipe_out
				if l_classi_stone /= Void then
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_ancestors_cmd).execute_with_class_stone (l_classi_stone))
				else
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_ancestors_cmd).execute_with_class_list (l_figures))
				end

				l_menu.extend (l_diagram_tool.toggle_selected_classes_descendents_cmd.new_menu_item_unmanaged)
				l_menu.last.select_actions.wipe_out
				if l_classi_stone /= Void then
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_descendents_cmd).execute_with_class_stone (l_classi_stone))
				else
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_descendents_cmd).execute_with_class_list (l_figures))
				end

				l_menu.extend (l_diagram_tool.toggle_selected_classes_clients_cmd.new_menu_item_unmanaged)
				l_menu.last.select_actions.wipe_out
				if l_classi_stone /= Void then
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_clients_cmd).execute_with_class_stone (l_classi_stone))
				else
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_clients_cmd).execute_with_class_list (l_figures))
				end

				l_menu.extend (l_diagram_tool.toggle_selected_classes_suppliers_cmd.new_menu_item_unmanaged)
				l_menu.last.select_actions.wipe_out
				if l_classi_stone /= Void then
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_suppliers_cmd).execute_with_class_stone (l_classi_stone))
				else
					l_menu.last.select_actions.extend (agent (l_diagram_tool.toggle_selected_classes_suppliers_cmd).execute_with_class_list (l_figures))
				end
			end
		end

	extend_diagram_include_all_classes (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend Include all classes command.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_cluster_stone: CLUSTER_STONE
			l_command: EB_FILL_CLUSTER_COMMAND
		do
			l_cluster_stone ?= a_pebble
			if l_cluster_stone /= Void then
				l_command := dev_window.tools.diagram_tool.fill_cluster_cmd
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_cluster_stone (l_cluster_stone))
			end
		end

	extend_force_right_angle (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend Force right angle command.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_link_stone: LINK_STONE
			l_command: EB_LINK_TOOL_COMMAND
		do
			l_link_stone ?= a_pebble
			if l_link_stone /= Void then
				l_command := dev_window.tools.diagram_tool.link_tool_cmd
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_link_stone (l_link_stone))
			end
		end

	extend_remove_anchor (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend Remove Anchor menu item.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_class_stone: CLASSI_FIGURE_STONE
			l_cluster_stone: CLUSTER_STONE
			l_class_figures: CLASS_FIGURE_LIST_STONE
			l_command: EB_REMOVE_ANCHOR_COMMAND
		do
			l_command := dev_window.tools.diagram_tool.remove_anchor_cmd
			l_class_stone ?= a_pebble
			l_cluster_stone ?= a_pebble
			l_class_figures ?= a_pebble
			if l_class_stone /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class (l_class_stone))
			elseif l_cluster_stone /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_cluster (l_cluster_stone))
			elseif l_class_figures /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class_list (l_class_figures))
			end
		end

	extend_diagram_delete_menu (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend diagram delete menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_command: EB_DELETE_DIAGRAM_ITEM_COMMAND
			l_classi_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_client: CLIENT_STONE
			l_inherit: INHERIT_STONE
		do
			l_command := dev_window.tools.diagram_tool.delete_cmd
			if l_command.veto_pebble_function (a_pebble) then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				l_classi_stone ?= a_pebble
				if l_classi_stone /= Void then
					a_menu.last.select_actions.extend (agent l_command.drop_class (l_classi_stone))
				else
					l_client ?= a_pebble
					if l_client /= Void then
						a_menu.last.select_actions.extend (agent l_command.execute_with_client_stone (l_client))
					else
						l_inherit ?= a_pebble
						if l_inherit /= Void then
							a_menu.last.select_actions.extend (agent l_command.execute_with_inherit_stone (l_inherit))
						else
							l_cluster_stone ?= a_pebble
							if l_cluster_stone /= Void then
								a_menu.last.select_actions.extend (agent l_command.drop_cluster (l_cluster_stone))
							end
						end
					end
				end
			end
		end

	extend_remove_from_diagram (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend Remove Anchor menu item.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_class_stone: CLASSI_FIGURE_STONE
			l_cluster_stone: CLUSTER_FIGURE_STONE
			l_class_figures: CLASS_FIGURE_LIST_STONE
			l_edge: EG_EDGE
			l_inherit: INHERIT_STONE
			l_client: CLIENT_STONE
			l_command: EB_DELETE_FIGURE_COMMAND
		do
			l_command := dev_window.tools.diagram_tool.trash_cmd
			l_class_stone ?= a_pebble
			l_cluster_stone ?= a_pebble
			l_class_figures ?= a_pebble
			l_edge ?= a_pebble
			l_inherit ?= a_pebble
			l_client ?= a_pebble
			if l_class_stone /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class_stone (l_class_stone))
			elseif l_cluster_stone /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_cluster_stone (l_cluster_stone))
			elseif l_class_figures /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class_list (l_class_figures))
			elseif l_inherit /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_inheritance_stone (l_inherit))
			elseif l_client /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_client_stone (l_client))
			elseif l_edge /= Void then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_link_midpoint (l_edge))
			end
		end

feature {NONE} -- Favorites menu section, Granularity 1.

	extend_new_favorite_class (a_menu: EV_MENU) is
			-- Extend new favorite class menu.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (new_menu_item (names.b_new_favorite_class))
			a_menu.last.select_actions.extend (agent favorite_manager.new_favorite_class (Void))
		end

	extend_move_to_folder (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend move to folder menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_class_stone: EB_FAVORITES_CLASS_STONE
			l_folder: EB_FAVORITES_FOLDER
			l_item: EB_FAVORITES_ITEM
		do
			l_class_stone ?= a_pebble
			l_folder ?= a_pebble
			if l_class_stone /= Void then
				l_item := l_class_stone.origin
			elseif l_folder /= Void then
				l_item := l_folder
			end
			if l_item /= Void then
				a_menu.extend (new_menu_item (names.b_move_to_folder))
				a_menu.last.select_actions.extend (agent favorite_manager.move_to_folder (l_item, Void))
			end
		end

	extend_add_favorite_folder (a_menu: EV_MENU) is
			-- Extend "Create Folder..." menu.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (new_menu_item (names.b_create_folder))
			a_menu.last.select_actions.extend (agent favorite_manager.create_folder (Void))
		end

	extend_remove_from_favorites (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend remove from favorites menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_item: EB_FAVORITES_ITEM
			l_class_stone: EB_FAVORITES_CLASS_STONE
			l_folder: EB_FAVORITES_FOLDER
			l_feature: EB_FAVORITES_FEATURE_STONE
		do
			l_class_stone ?= a_pebble
			l_folder ?= a_pebble
			l_feature ?= a_pebble
			if l_class_stone /= Void then
				l_item := l_class_stone.origin
			elseif l_folder /= Void then
				l_item := l_folder
			elseif l_feature /= Void then
				l_item := l_feature.origin
			end
			if l_item /= Void then
				a_menu.extend (new_menu_item (names.m_remove_from_favorites))
				a_menu.last.select_actions.extend (agent favorite_manager.remove (l_item))
			end
		end

feature {NONE} -- Debug tool menu section, Granularity 1.

	extend_sync_in_context_tool (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend Synchronize in Feature relation tool menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_stone: CALL_STACK_STONE
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				a_menu.extend (new_menu_item (names.m_synchronize_in_tools))
				a_menu.last.select_actions.extend (agent (a_stone: STONE)
					do
						dev_window.tools.launch_stone (a_stone)
					end (l_stone))
			end
		end

	extend_expanded_object_view (a_menu: EV_MENU; a_pebble: ANY) is
			-- Extend Expanded object view menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_stone: OBJECT_STONE
			l_objviewer_command: EB_OBJECT_VIEWER_COMMAND
			l_objstore_command: ES_DBG_OBJECT_STORAGE_MANAGEMENT_COMMAND
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				l_objviewer_command := dev_window.eb_debugger_manager.object_viewer_cmd
				a_menu.extend (l_objviewer_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_objviewer_command.on_stone_dropped (l_stone))

				l_objstore_command := dev_window.eb_debugger_manager.object_storage_management_cmd
				if l_objstore_command /= Void then
					a_menu.extend (l_objstore_command.new_menu_item_unmanaged)
					a_menu.last.select_actions.wipe_out
					a_menu.last.select_actions.extend (agent l_objstore_command.on_stone_dropped (l_stone))
				end
			end
		end

feature {NONE} -- Metrics tool section, Granularity 1.

	extend_metric_delete (a_menu: EV_MENU; a_basic: EB_METRIC) is
			-- Extend metric Delete.
		require
			a_menu_not_void: a_menu /= Void
			a_basic_not_void: a_basic /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (new_menu_item (names.m_delete))
			a_menu.last.set_pixmap (l_metric_panel.remove_metric_btn.pixmap)
			a_menu.last.select_actions.extend (agent l_metric_panel.remove_metric_by_context_menu (a_basic))
			if a_basic.is_predefined then
				a_menu.last.disable_sensitive
			end
		end

	extend_metric_quick_metric (a_menu: EV_MENU; a_basic: EB_METRIC_BASIC) is
			-- Extend Quick metric.
		require
			a_menu_not_void: a_menu /= Void
			a_basic_not_void: a_basic /= Void
		local
			l_metric_panel: EB_METRIC_EVALUATION_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.metric_evaluation_panel
			a_menu.extend (new_menu_item (names.m_quick_metric))
			a_menu.last.set_pixmap (l_metric_panel.quick_metric_btn.pixmap)
			a_menu.last.select_actions.extend (agent (dev_window.tools.metric_tool.metric_notebook).select_item (l_metric_panel))
			a_menu.last.select_actions.extend (agent l_metric_panel.on_create_quick_metric (a_basic))
		end

	extend_metric_clone_metric (a_menu: EV_MENU; a_basic: EB_METRIC) is
			-- Extend Open user defined metrics externally.
		require
			a_menu_not_void: a_menu /= Void
			a_basic_not_void: a_basic /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (new_menu_item (names.m_clone_metric))
			a_menu.last.set_pixmap (l_metric_panel.send_current_to_new_btn.pixmap)
			a_menu.last.select_actions.extend (agent (dev_window.tools.metric_tool.metric_notebook).select_item (l_metric_panel))
			a_menu.last.select_actions.extend (agent l_metric_panel.clone_and_load_metric (a_basic.identical_new_instance))
		end

	extend_reload_metrics (a_menu: EV_MENU) is
			-- Extend Reload metrics
		require
			a_menu_not_void: a_menu /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (new_menu_item (names.m_reload_metrics))
			a_menu.last.set_pixmap (l_metric_panel.reload_btn.pixmap)
			a_menu.last.select_actions.extend (agent l_metric_panel.on_reload_metrics)
		end

	extend_import_metric_from_file (a_menu: EV_MENU) is
			-- Extend Import metrics from file.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (new_menu_item (names.m_import_metrics_from_file))
			a_menu.last.set_pixmap (l_metric_panel.import_btn.pixmap)
			a_menu.last.select_actions.extend (agent l_metric_panel.on_import_metrics)
		end

	extend_new_metric (a_menu: EV_MENU) is
			-- Extend New metric
		require
			a_menu_not_void: a_menu /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
			l_menu: EV_MENU
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			l_menu := l_metric_panel.new_metric_menu (True)
			l_menu.set_pixmap (l_metric_panel.new_metric_btn.pixmap)
			l_menu.set_text (names.m_new_metric)
			a_menu.extend (l_menu)
		end

	extend_metric_open_user_metric (a_menu: EV_MENU) is
			-- Extend Open user defined metrics externally.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (new_menu_item (names.m_open_user_defined_metric))
			a_menu.last.set_pixmap (l_metric_panel.open_metric_file_btn.pixmap)
			a_menu.last.select_actions.extend (agent l_metric_panel.on_open_user_defined_metric_file)
		end

	extend_metric_selector_move_up_and_down (a_menu: EV_MENU; a_selector: EB_METRIC_SELECTOR; a_unit: QL_METRIC_UNIT) is
			-- Extend Move up and Move down menus for metric selector
		require
			a_menu_not_void: a_menu /= Void
			a_selector_not_void: a_selector /= Void
			a_unit_not_void: a_unit /= Void
		do
			a_menu.extend (new_menu_item (names.m_move_up))
			a_menu.last.select_actions.extend (agent a_selector.move_unit (a_unit, True))
			a_menu.extend (new_menu_item (names.m_move_down))
			a_menu.last.select_actions.extend (agent a_selector.move_unit (a_unit, False))
		end

	extend_metric_selector_remove (a_menu: EV_MENU; a_pebble: ANY; a_selector: EB_METRIC_DOMAIN_SELECTOR) is
			-- Remove and Remove all menus in metric selector
		require
			a_menu_not_void: a_menu /= Void
			a_selector_not_void: a_selector /= Void
		do
			if a_pebble /= Void then
				a_menu.extend (new_menu_item (names.m_remove))
					-- |Ted: Questionable: Metric domain selector has two routine handling removing?
				a_menu.last.select_actions.extend (agent a_selector.on_item_dropped_on_remove_button (a_pebble))
				a_menu.last.select_actions.extend (agent a_selector.on_item_drop_on_remove_button (a_pebble))

				a_menu.extend (new_menu_item (names.m_remove_all))
				a_menu.last.select_actions.extend (agent a_selector.on_remove_all_scopes)
			end
		end

feature {NONE} -- Implementation

	setup_pick_item (a_menu: EV_MENU; a_pebble: ANY) is
			-- Replace name of the first menu item of `a_menu'
			-- with right language.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_text: STRING_32
		do
			if a_menu.count > 0 then
				if last_type /= Void and then last_name /= Void then
					l_text := names.m_context_menu_pick (last_type, last_name)
				else
						-- Reset "Pick" text so that it is translatable.
					l_text := names.m_pick
				end
				a_menu.first.set_text (l_text)
			end
		end

	build_name (a_pebble: ANY) is
			-- Build name of `a_pebble'.
		local
			l_classi_stone: CLASSI_STONE
			l_feature_stone: FEATURE_STONE
			l_cluster_stone: CLUSTER_STONE
			l_target_stone: TARGET_STONE
			l_group: CONF_GROUP
		do
			l_feature_stone ?= a_pebble
			if l_feature_stone /= Void then
				last_name := l_feature_stone.feature_name
				last_type := names.l_feature
			else
				l_classi_stone ?= a_pebble
				if l_classi_stone /= Void then
					last_name := l_classi_stone.class_name
					last_type := names.t_class
				else
					l_cluster_stone ?= a_pebble
					if l_cluster_stone /= Void then
						last_name := l_cluster_stone.group.name
						l_group := l_cluster_stone.group
						if l_group.is_cluster then
							last_type := names.l_cluster
						elseif l_group.is_library then
							last_type := names.m_library
						elseif l_group.is_assembly then
							last_type := names.m_assembly
						else
							last_type := Void
						end
					else
						l_target_stone ?= a_pebble
						if l_target_stone /= Void then
							last_name := l_target_stone.target.name
							last_type := names.l_target
						else
								-- Other stones
							last_name := Void
							last_type := Void
						end
					end
				end
			end
		end

	last_name: STRING_32

	last_type: STRING_32

	current_editor: EB_CLICKABLE_EDITOR

	favorite_manager: EB_FAVORITES_MANAGER is
			-- Favorites manager
		do
			Result := dev_window.favorites_manager
		end

	extend_separator (a_menu: EV_MENU) is
			-- Extend a separator into `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_sep: EV_MENU_SEPARATOR
		do
				-- Add a separator, only if it is not the first entry in the menu
				-- and if the last inserted entry was not a separator.
			if not a_menu.is_empty then
				l_sep ?= a_menu.last
				if l_sep = Void then
					a_menu.extend (create {EV_MENU_SEPARATOR})
				end
			end
		end

	new_menu_item (a_name: STRING_GENERAL): EV_MENU_ITEM is
			-- New menu item with `a_name'.
		do
			if a_name /= Void then
				create Result.make_with_text (a_name)
			else
				create Result
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Status report

	is_pnd_mode: BOOLEAN is
			-- Is pnd mode? Or contextual mode.
		do
			Result := preferences.misc_data.is_pnd_mode
		end

feature {NONE} -- Recycle

	internal_recycle is
			--
		do
		end

feature {NONE} -- Implementation

	dev_window: EB_DEVELOPMENT_WINDOW;
			-- Window

invariant
	dev_window_not_void: dev_window /= Void

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
