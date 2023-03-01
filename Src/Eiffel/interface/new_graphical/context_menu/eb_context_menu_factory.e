note
	description: "Contextual menu factory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_MENU_FACTORY

inherit

	EV_SHARED_APPLICATION
	EB_RECYCLABLE
	EB_SHARED_MANAGERS
	EB_SHARED_MENU_EXTENDER
	EB_SHARED_PREFERENCES
	SHARED_BENCH_NAMES

create
	make

feature {NONE} -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW)
			-- Initialization
		require
			a_window_not_void: a_window /= Void
		do
			dev_window := a_window
		end

feature -- Status report

	menu_displayable (a_pebble: detachable ANY): BOOLEAN
			-- Should the menu be displayed?
		local
			l_shift_pressed: BOOLEAN
		do
			if attached {EIS_LINK_STONE} a_pebble as l_p then
				Result := True
			else
				l_shift_pressed := (create {EV_ENVIRONMENT}).application.shift_pressed
				if is_pnd_mode then
					Result := l_shift_pressed
				else
					Result := not l_shift_pressed
				end
			end
		end

feature -- Editor menu

	editor_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: detachable ANY; a_editor: EB_CLICKABLE_EDITOR)
			-- Setup editor menu.
		require
			a_menu_not_void: a_menu /= Void
			a_editor_not_void: a_editor /= Void
		local
			l_pebble: ANY
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
					if
						attached {CLASSC_STONE} a_editor.stone as l_classc_stone and then
						l_classc_stone.is_valid
					then
						create {CLASSC_STONE} l_pebble.make (l_classc_stone.e_class)
					elseif
						attached {CLASSI_STONE} a_editor.stone as l_classi_stone and then
						l_classi_stone.is_valid
					then
						create {CLASSI_STONE} l_pebble.make (l_classi_stone.class_i)
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
				setup_hyper_link_item (a_menu, a_pebble)
				extend_separator (a_menu)
				if a_pebble /= Void then
					if not (attached {STONE} a_pebble as l_stone and then l_stone.same_as (a_editor.stone)) then
							-- If the current stone is the same as the editor stone then we
							-- do not need a Retarget menu.
						extend_retarget_tool_menu (a_source, a_menu, a_pebble)
						extend_separator (a_menu)
					end
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

	class_tree_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu for class item in class tree
		require
			a_menu_not_void: a_menu /= Void
		local
			l_group: CONF_GROUP
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				if attached {STONE} a_pebble as l_stone then
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
					extend_separator (a_menu)
					extend_separator (a_menu)
					if attached {TARGET_STONE} l_stone as l_target_stone then
						extend_standard_compiler_item_menu (a_menu, l_stone)
					else
						if attached {CLUSTER_STONE} l_stone as l_cluster_stone then
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

	clusters_data_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu for clusters data stone.
		require
			a_menu_not_void: a_menu /= Void
		do
			if
				menu_displayable (a_pebble) and then
				attached {DATA_STONE} a_pebble as l_data_stone
			then
				build_name (a_pebble)
				setup_pick_item (a_menu, l_data_stone)
				extend_separator (a_menu)
				extend_add_subcluster_item (a_menu, Void, False)
				extend_separator (a_menu)
				extend_add_to_menu (a_menu, l_data_stone)
				extend_property_menu (a_menu, l_data_stone)
			end
		end

	libraries_data_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu for libraries data stone.
		require
			a_menu_not_void: a_menu /= Void
		do
			if
				menu_displayable (a_pebble) and then
				attached {DATA_STONE} a_pebble as l_data_stone
			then
				build_name (a_pebble)
				setup_pick_item (a_menu, l_data_stone)
				extend_separator (a_menu)
				extend_add_library (a_menu)
				extend_separator (a_menu)
				extend_add_to_menu (a_menu, l_data_stone)
				extend_property_menu (a_menu, l_data_stone)
			end
		end

	assemblies_data_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Context menu for assemblies data stone.
		require
			a_menu_not_void: a_menu /= Void
		do
			if
				menu_displayable (a_pebble) and then
				attached {DATA_STONE} a_pebble as l_data_stone
			then
				build_name (a_pebble)
				setup_pick_item (a_menu, l_data_stone)
				extend_separator (a_menu)
				extend_add_assembly (a_menu)
				extend_separator (a_menu)
				extend_add_to_menu (a_menu, l_data_stone)
				extend_property_menu (a_menu, l_data_stone)
			end
		end

feature -- Diagram tool

	diagram_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
			-- Setup editor menu.
		require
			a_menu_not_void: a_menu /= Void
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
					if not attached {FEATURE_STONE} a_pebble then
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

	uncompiled_feature_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_name: READABLE_STRING_GENERAL)
			-- Uncompiled feature item menu
		require
			a_name_not_void: a_name /= Void
			a_menu_not_void: a_menu /= Void
		do
		end

	feature_clause_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_clause: FEATURE_CLAUSE_AS)
			-- Feature clause item menu
		require
			a_clause_not_void: a_clause /= Void
			a_menu_not_void: a_menu /= Void
		do
		end

feature -- Favorites menus

	favorites_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_item: EB_FAVORITES_TREE_ITEM)
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

	metric_domain_selector_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_selector: EB_METRIC_DOMAIN_SELECTOR)
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

	metric_metric_selector_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_selector: EB_METRIC_SELECTOR)
			-- Metrics domain selector context menu
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				if attached {QL_METRIC_UNIT} a_pebble as l_unit then
					extend_metric_selector_move_up_and_down (a_menu, a_selector, l_unit)
				elseif attached {EB_METRIC} a_pebble as l_metric then
					extend_metric_clone_metric (a_menu, l_metric)
						-- Only basic metric can be used as a template for quick metrics
					if attached {EB_METRIC_BASIC} a_pebble as l_basic_metric then
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
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				if attached {CALL_STACK_STONE} a_pebble as l_call_stack_stone then
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
					extend_separator (a_menu)
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					extend_separator (a_menu)
					extend_sync_in_context_tool (a_menu, a_pebble)
					extend_expanded_object_view (a_menu, a_pebble)
					extend_property_menu (a_menu, a_pebble)
				end
			end
		end

feature -- Object tool, Object Viewer and Watch tool menus

	object_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: detachable ANY; a_objects_tool: detachable ES_OBJECTS_TOOL_PANEL; a_grid: ES_OBJECTS_GRID)
			-- Object tool menu
		local
			m: EV_MENU
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_separator (a_menu)
				if a_pebble /= Void then
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
					extend_separator (a_menu)
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					if attached {OBJECT_STONE} a_pebble as l_object_stone then
						extend_separator (a_menu)
						extend_expanded_object_view (a_menu, a_pebble)
						extend_property_menu (a_menu, a_pebble)
					end
				end
				if a_objects_tool /= Void then
					m := a_objects_tool.tool_menu (False)
					if m /= Void then
						if attached {OBJECT_STONE} a_pebble as l_object_stone then
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

	watch_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: detachable ANY; a_watch_tool: ES_WATCH_TOOL_PANEL; a_grid: ES_OBJECTS_GRID)
			-- Watch tool menu
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				if a_pebble /= Void then
					extend_separator (a_menu)
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
					extend_separator (a_menu)
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					if attached {OBJECT_STONE} a_pebble as l_object_stone then
						extend_separator (a_menu)
						extend_expanded_object_view (a_menu, a_pebble)
						if attached {EV_GRID_ROW} l_object_stone.ev_item as l_row then
							a_menu.extend (new_menu_item (names.m_remove))
							a_menu.last.select_actions.extend (agent a_watch_tool.remove_expression_row (l_row))
						end
					end
				end
				extend_property_menu (a_menu, a_pebble)
				if a_grid /= Void then
					extend_objects_grid_menu (a_menu, a_grid)
				end
			end
		end

	object_viewer_browser_view_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_grid: ES_OBJECTS_GRID)
			-- Object viewer browser view menu.
		do
			if menu_displayable (a_pebble) then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				if a_pebble /= Void then
					extend_separator (a_menu)
					extend_retarget_tool_menu (a_source, a_menu, a_pebble)
				end
				extend_separator (a_menu)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				if a_grid /= Void then
					extend_objects_grid_menu (a_menu, a_grid)
				end
			end
		end

	extend_objects_grid_menu (a_menu: EV_MENU; a_grid: ES_OBJECTS_GRID)
			-- Objects grid specific menu
		require
			a_menu_not_void: a_menu /= Void
			a_grid_not_void: a_grid /= Void
		local
			l_cell: EV_GRID_ITEM
			l_sep_added: BOOLEAN
			s: STRING_GENERAL
			l_line: ES_OBJECTS_GRID_LINE
		do
			l_cell := a_grid.last_picked_item
			if l_cell /= Void then
				if attached {ES_OBJECTS_GRID_ROW} l_cell.row as l_row then
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
				if attached {EV_GRID_LABEL_ITEM} l_cell as l_label then
					s := l_label.text
					if not s.is_empty then
						if not l_sep_added then
							extend_separator (a_menu)
						end
						a_menu.extend (new_menu_item (names.m_Copy_cell_to_clipboard))
						a_menu.last.select_actions.extend (agent copy_to_clipboard (s))
					end
				end
			end
		end

	copy_to_clipboard (t: detachable STRING_GENERAL)
			-- Copy `t' to clipboard
		do
			if t /= Void then
				ev_application.clipboard.set_text (t)
			end
		end

feature -- EiffelStudio Error

	exeception_dialog_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_editor: SELECTABLE_TEXT_PANEL)
			-- Exception dialog menu
		local
			l_menu_item: EV_MENU_ITEM
		do
				-- Remove Pick
			a_menu.wipe_out

			--| Copy
			l_menu_item := new_menu_item (names.m_copy)
			a_menu.extend (l_menu_item)
			l_menu_item.select_actions.extend (agent a_editor.copy_selection)
			if a_editor.has_selection then
				l_menu_item.enable_sensitive
			else
				l_menu_item.disable_sensitive
			end

			--| Select all ...
			l_menu_item := new_menu_item (names.m_select_all)
			a_menu.extend (l_menu_item)
			l_menu_item.select_actions.extend (agent a_editor.select_all)
		end

feature -- Search scope menu

	search_scope_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY)
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

	standard_compiler_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: detachable ANY)
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

	extend_standard_compiler_item_menu (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend menu items for standard cluster/class/feature.
		do
			if attached {FEATURE_STONE} a_pebble as l_feature_stone then
				extend_basic_opening_menus (a_menu, l_feature_stone, True)
				extend_separator (a_menu)
				extend_feature_formatter_menus (a_menu, l_feature_stone)
				extend_feature_refactoring_menus (a_menu, l_feature_stone)
				if attached l_feature_stone.e_feature as l_feat then
					extend_debug_feature_menus (a_menu, l_feat)
				end
				extend_add_to_menu (a_menu, l_feature_stone)
				extend_feature_extension (l_feature_stone, a_menu)
			elseif attached {CLASSC_STONE} a_pebble as l_stonec then
				extend_basic_opening_menus (a_menu, l_stonec, True)
				extend_separator (a_menu)
				extend_class_formatter_menus (a_menu, l_stonec)
				extend_class_refactoring_menus (a_menu, l_stonec)
				extend_debug_class_menus (a_menu, l_stonec.e_class)
				extend_add_to_menu (a_menu, l_stonec)
				(create {ES_CODE_ANALYSIS_BENCH_HELPER}).build_context_menu_for_class_stone (a_menu, l_stonec)
				extend_class_extension (l_stonec, a_menu)
			elseif attached {CLASSI_STONE} a_pebble as l_stonei then
				extend_basic_opening_menus (a_menu, l_stonei, True)
				extend_separator (a_menu)
				extend_class_refactoring_menus (a_menu, l_stonei)
				extend_add_to_menu (a_menu, l_stonei)
			elseif attached {CLUSTER_STONE} a_pebble as l_cluster_stone then
				extend_basic_opening_menus (a_menu, l_cluster_stone, False)
				extend_add_to_menu (a_menu, l_cluster_stone)
				(create {ES_CODE_ANALYSIS_BENCH_HELPER}).build_context_menu_for_cluster_stone (a_menu, l_cluster_stone)
			elseif attached {TARGET_STONE} a_pebble as l_target_stone then
				extend_add_to_menu (a_menu, l_target_stone)
			end
				-- Add Info item
			extend_info_menu (a_menu, a_pebble)
		end

	extend_basic_diagram_menu (a_menu: EV_MENU)
			-- Extend menus for blank diagram area.
		require
			a_menu_not_void: a_menu /= Void
		do
		end

feature {NONE} -- Menu section, Granularity 1.

	extend_basic_opening_menus (a_menu: EV_MENU; a_stone: STONE; a_external_editor: BOOLEAN)
			-- Add items of basic opening operations.
			-- |Open in new Tab
			-- |Open in Editor
			-- |Open in external Editor
		require
			a_menu_not_void: a_menu /= Void
		local
			l_stone: STONE
			l_menu_item: like extend_show_tool_command
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

			if attached {CLASSI_STONE} a_stone as l_cs and then dev_window.commands.edit_contracts_command.is_stone_usable (l_cs) then
				l_menu_item := extend_show_tool_command (dev_window.commands.edit_contracts_command, l_cs)
				if l_cs.class_i.is_read_only then
					l_menu_item.disable_sensitive
				else
					l_menu_item.enable_sensitive
				end
				a_menu.extend (l_menu_item)
			end
		end

	extend_basic_editor_menus (a_menu: EV_MENU; a_editor: EB_CLICKABLE_EDITOR)
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
			l_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
			is_editable, l_has_selection: BOOLEAN
			l_menu_item: EV_MENU_ITEM
			l_unmanaged_editor: BOOLEAN
--			l_editor_is_current_editor: BOOLEAN
		do
				-- The commented code below is kept so that if one wants to add one of the commented item back to the
				-- context menu, we know in which order we should do it.
			is_editable := a_editor.is_editable
			l_has_selection := a_editor.has_selection
			l_unmanaged_editor := attached {EB_GRID_EDITOR} a_editor as lt_editor
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

			l_menu_item := dev_window.commands.editor_cut_cmd.new_menu_item_unmanaged
			a_menu.extend (l_menu_item)
			if l_unmanaged_editor then
				l_menu_item.select_actions.wipe_out
				l_menu_item.select_actions.extend (agent a_editor.cut_selection)
			end
			if is_editable and then l_has_selection then
				l_menu_item.enable_sensitive
			else
				l_menu_item.disable_sensitive
			end

			l_menu_item := dev_window.commands.editor_copy_cmd.new_menu_item_unmanaged
			a_menu.extend (l_menu_item)
			if l_unmanaged_editor then
				l_menu_item.select_actions.wipe_out
				l_menu_item.select_actions.extend (agent a_editor.copy_selection)
			end
			if l_has_selection then
				l_menu_item.enable_sensitive
			else
				l_menu_item.disable_sensitive
			end

			l_menu_item := dev_window.commands.editor_paste_cmd.new_menu_item_unmanaged
			a_menu.extend (l_menu_item)
			if l_unmanaged_editor then
				l_menu_item.select_actions.wipe_out
				l_menu_item.select_actions.extend (agent a_editor.paste)
			end
			if is_editable then
				l_menu_item.enable_sensitive
			else
				l_menu_item.disable_sensitive
			end

			if attached dev_window.commands.editor_insert_symbol_cmd as cmd then
				l_menu_item := cmd.new_menu_item_unmanaged
				a_menu.extend (l_menu_item)
				if l_unmanaged_editor then
					l_menu_item.select_actions.wipe_out
				end
				if is_editable then
					l_menu_item.enable_sensitive
				else
					l_menu_item.disable_sensitive
				end
			end

			extend_separator (a_menu)

			--| Send editor's selection to watch tool, if any and possible
			if
				attached dev_window.eb_debugger_manager as l_debugger and then
				l_debugger.raised
			then
				create l_menu.make_with_text (names.m_selection_to_watch_tool)
				a_menu.extend (l_menu)
				if
					l_has_selection and then
					attached l_debugger.watch_tool_list as l_list and then
					not l_list.is_empty
				then
					l_menu.enable_sensitive
					from
						l_list.start
					until
						l_list.after
					loop
						if l_list.item.is_tool_instantiated then
							if l_list.item.is_multiple_edition then
								l_menu.extend (new_menu_item (l_list.item.edition_title))
							else
								l_menu.extend (new_menu_item (l_list.item.title))
							end
							l_menu.last.select_actions.extend (agent (l_list.item).drop_text (a_editor.wide_string_selection))
						end
						l_list.forth
					end
				else
					l_menu.disable_sensitive
				end
				extend_separator (a_menu)
			end

			--| Select all ...
			l_menu_item := new_menu_item (names.m_select_all)
			a_menu.extend (l_menu_item)
			if l_unmanaged_editor then
				l_menu_item.select_actions.extend (agent a_editor.select_all)
			else
				l_menu_item.select_actions.extend (agent dev_window.select_all)
			end

--			extend_separator (a_menu)


				-- The following command are hard-coded and depend on positioning within `editor_commands' list.
			l_commands := dev_window.commands.editor_commands
			l_commands.go_i_th (5)

				-- Toggle Line Numbers
--			if l_editor_is_current_editor then
--					-- We don't want this item shown for non editors
--				extend_standard_command_to_menu (l_commands.item, a_menu)
--				extend_separator (a_menu)
--			end
			l_commands.forth

				-- Find
--			extend_standard_command_to_menu (l_commands.item, a_menu)
			l_commands.forth

				-- Go To
--			extend_standard_command_to_menu (l_commands.item, a_menu)
			l_commands.forth

				-- Replace
--			extend_standard_command_to_menu (l_commands.item, a_menu)
			l_commands.forth
--			if not is_editable then
--				a_menu.last.disable_sensitive
--			end

--			create l_menu.make_with_text (names.m_find)
--			a_menu.extend (l_menu)


				-- Find Next
--			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Find Previous
--			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Find Next Selection
--			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Find Previous Selection
--			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth


--			extend_separator (a_menu)
			create l_menu.make_with_text (names.m_advanced)
			a_menu.extend (l_menu)
			if l_unmanaged_editor then
				l_menu.disable_sensitive
			else
				l_menu.enable_sensitive
			end

				-- Prettify Class
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Indent Selection
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Unindent Selection
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Set to Lowercase
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Set to Uppercase
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Comment
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Uncomment
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

			extend_separator (l_menu)

				-- Embed in "If"
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Embed in "Debug"
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

			extend_separator (l_menu)

				-- Complete Word
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

				-- Complete Class Name
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth

			extend_separator (l_menu)

				-- Show Formatting Marks
			extend_standard_command_to_menu (l_commands.item, l_menu)
			l_commands.forth
		end

	extend_standard_command_to_menu (a_command: EB_GRAPHICAL_COMMAND; a_menu: EV_MENU)
		do
			if attached {EB_STANDARD_CMD} a_command as cmd then
				a_menu.extend (cmd.new_menu_item_unmanaged)
			end
		end

	extend_view_in_main_formatters_menus (a_menu: EV_MENU)
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
				create l_internal
				if l_editor.changed or else attached {CLUSTER_STONE} l_editor.stone as l_cluster_stone or else l_internal.type_of (l_editor.stone) ~ {CLASSI_STONE} then
						-- Editor is being edited, disable the view menu since selecting one
						-- of the entry could discard the changes being made, if the editor is currently
						-- showing a cluster or uncompiled class then no view can be attained so it is also
						-- disabled.
					l_menu.disable_sensitive
				end
			end
		end

	extend_class_formatter_menus (a_menu: EV_MENU; a_class_stone: CLASSC_STONE)
			-- Extend class formatter menus.
		require
			a_menu_not_void: a_menu /= Void
			a_class_stone_not_void: a_class_stone /= Void
		local
			l_menu, l_c_menu: EV_MENU
--			l_customized_tools: LIST [EB_CUSTOMIZED_TOOL]
--			l_customized_tool: EB_CUSTOMIZED_TOOL
		do
			create l_menu.make_with_text (names.m_show)
			a_menu.extend (l_menu)

			across
				dev_window.managed_class_formatters as ic
			loop
				if attached ic.item as l_class_formatter then
					l_menu.extend (new_menu_item (l_class_formatter.menu_name))
					l_menu.last.set_pixmap (l_class_formatter.pixel_buffer)
					l_menu.last.select_actions.extend (agent (dev_window.tools.class_tool).show)
					l_menu.last.select_actions.extend (agent l_class_formatter.execute_with_stone (a_class_stone))
				else
					extend_separator (l_menu)
				end
			end

				-- Extend customized formatters.
			create l_c_menu.make_with_text (names.f_customized_formatter)
			l_menu.extend (l_c_menu)

			extend_formatter (l_c_menu, dev_window.tools.class_tool.customized_formatters, dev_window.tools.class_tool, a_class_stone)
			extend_formatter (l_c_menu, dev_window.tools.dependency_tool.customized_formatters, dev_window.tools.dependency_tool, a_class_stone)
--			l_customized_tools := dev_window.tools.customized_tools
--			from
--				l_customized_tools.start
--			until
--				l_customized_tools.after
--			loop
--				l_customized_tool := l_customized_tools.item
--				extend_formatter (l_c_menu, l_customized_tool.formatters, l_customized_tool, a_class_stone)
--				l_customized_tools.forth
--			end
			if l_c_menu.is_empty then
				l_c_menu.disable_sensitive
			end

			extend_separator (l_menu)

			l_menu.extend (dev_window.commands.find_class_or_cluster_command.new_menu_item_unmanaged)
			l_menu.last.select_actions.wipe_out
			l_menu.last.select_actions.extend (agent (dev_window.commands.find_class_or_cluster_command).execute_with_stone (a_class_stone))

			l_menu.extend (dev_window.tools.diagram_tool.center_diagram_cmd.new_menu_item_unmanaged)
			l_menu.last.select_actions.wipe_out
			l_menu.last.select_actions.extend (agent (dev_window.tools.diagram_tool.center_diagram_cmd).execute_with_class_stone (a_class_stone))
		end

	extend_feature_formatter_menus (a_menu: EV_MENU; a_feature_stone: FEATURE_STONE)
			-- Extend class formatter menus.
		require
			a_menu_not_void: a_menu /= Void
			a_feature_stone_not_void: a_feature_stone /= Void
		local
			l_menu, l_c_menu: EV_MENU
--			l_customized_tools: LIST [EB_CUSTOMIZED_TOOL]
--			l_customized_tool: EB_CUSTOMIZED_TOOL
		do
			create l_menu.make_with_text (names.m_show)
			a_menu.extend (l_menu)

			across
				dev_window.managed_feature_formatters as ic
			loop
				if attached ic.item as l_feature_formatter then
					l_menu.extend (new_menu_item (l_feature_formatter.menu_name))
					l_menu.last.set_pixmap (l_feature_formatter.pixel_buffer)
					l_menu.last.select_actions.extend (agent (dev_window.tools.features_relation_tool).show)
					l_menu.last.select_actions.extend (agent l_feature_formatter.execute_with_stone (a_feature_stone))
				else
					extend_separator (l_menu)
				end
			end

				-- Extend customized formatters.
			create l_c_menu.make_with_text (names.f_customized_formatter)
			l_menu.extend (l_c_menu)

			extend_formatter (l_c_menu, dev_window.tools.features_relation_tool.customized_formatters, dev_window.tools.features_relation_tool, a_feature_stone)
			extend_formatter (l_c_menu, dev_window.tools.dependency_tool.customized_formatters, dev_window.tools.dependency_tool, a_feature_stone)
--			l_customized_tools := dev_window.tools.customized_tools
--			from
--				l_customized_tools.start
--			until
--				l_customized_tools.after
--			loop
--				l_customized_tool := l_customized_tools.item
--				extend_formatter (l_c_menu, l_customized_tool.formatters, l_customized_tool, a_feature_stone)
--				l_customized_tools.forth
--			end
			if l_c_menu.is_empty then
				l_c_menu.disable_sensitive
			end
		end

	extend_formatter (a_menu: EV_MENU; a_formatters: LIST [EB_FORMATTER]; a_tool: EB_TOOL; a_stone: STONE)
			-- Extend formatter excution menu entries.
		require
			a_menu_not_void: a_menu /= Void
			a_formatter_not_void: a_formatters /= Void
			a_tool_not_void: a_tool /= Void
		do
			across
				a_formatters as ic
			loop
				a_menu.extend (new_menu_item (ic.item.name))
				a_menu.last.select_actions.extend (agent a_tool.show)
				a_menu.last.select_actions.extend (agent (ic.item).execute_with_stone (a_stone))
			end
		end

	extend_class_refactoring_menus (a_menu: EV_MENU; a_stone: CLASSI_STONE)
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

	extend_feature_refactoring_menus (a_menu: EV_MENU; a_stone: FEATURE_STONE)
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

	extend_feature_extension (f: FEATURE_STONE; m: EV_MENU)
			-- Extend menu `m` with entries for a feature `f`.
		do
			if
				attached context_menu_extension.service as s
			then
				s.extend_feature (f.e_feature, agent menu_extender.extend (?, ?, ?, ?, m))
			end
		end

	extend_class_extension (c: CLASSC_STONE; m: EV_MENU)
			-- Extend menu `m` with entries for a class `c`.
		do
			if
				attached context_menu_extension.service as s
			then
				s.extend_class (c.e_class, agent menu_extender.extend (?, ?, ?, ?, m))
			end
		end

	extend_debug_class_menus (a_menu: EV_MENU; a_class_c: CLASS_C)
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
					dev_window.debugger_manager.breakpoints_manager.enable_first_user_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (new_menu_item (names.m_enable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.breakpoints_manager.enable_user_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (new_menu_item (names.m_disable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.breakpoints_manager.disable_user_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (new_menu_item (names.m_clear_breakpoints))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.breakpoints_manager.remove_user_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)
		end

	extend_debug_feature_menus (a_menu: EV_MENU; a_efeature: E_FEATURE)
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
					dev_window.debugger_manager.breakpoints_manager.enable_first_user_breakpoint_of_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (new_menu_item (names.m_enable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.breakpoints_manager.enable_user_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (new_menu_item (names.m_disable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.breakpoints_manager.disable_user_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (new_menu_item (names.m_clear_breakpoints))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.breakpoints_manager.remove_user_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)
		end

	extend_add_to_menu (a_menu: EV_MENU; a_pebble: STONE)
			-- Extend Add to menu.
		require
			a_menu_not_void: a_menu /= Void
			a_pebble_not_void: a_pebble /= Void
		local
			l_menu, l_menu2: EV_MENU
			l_debugger: EB_DEBUGGER_MANAGER
			l_list: LINKED_SET [ES_WATCH_TOOL]
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
			l_debugger := dev_window.eb_debugger_manager
			if
				l_debugger.raised and then
				attached {CLASSC_STONE} a_pebble as l_class_stone
			then
				l_list := l_debugger.watch_tool_list
				if not l_list.is_empty then
					create l_menu2.make_with_text (names.m_watch_tool)
					l_menu.extend (l_menu2)
					from
						l_list.start
					until
						l_list.after
					loop
						if l_list.item.is_tool_instantiated then
							if l_list.item.is_multiple_edition then
								l_menu2.extend (new_menu_item (l_list.item.edition_title))
							else
								l_menu2.extend (new_menu_item (l_list.item.title))
							end
							l_menu2.last.select_actions.extend (agent (l_list.item).drop_stone (l_class_stone))
						end
						l_list.forth
					end
				end
			end
		end

	extend_info_menu (a_menu: EV_MENU; a_pebble: ANY)
			-- Info menu
		require
			a_menu_not_void: a_menu /= Void
		local
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			if attached last_name as l_last_name and then attached last_type as l_last_type then
				create l_menu.make_with_text (names.m_info)
				a_menu.extend (l_menu)

					-- Add Info
				create l_menu_item.make_with_text (names.m_add_info (l_last_type, l_last_name))
				l_menu_item.select_actions.extend (
					agent (a_p: ANY)
						local
							l_info_tool: like dev_window.tools.info_tool
						do
							l_info_tool := dev_window.tools.info_tool
							if l_info_tool.is_interface_usable then
								l_info_tool.add_information_to (a_p)
							end
						end (a_pebble)
				)
				l_menu.extend (l_menu_item)

					-- Copy URI
				create l_menu_item.make_with_text (names.m_copy_uri (l_last_type, l_last_name))
				l_menu_item.select_actions.extend (
					agent (a_stone: ANY)
						local
							l_generator: ES_INCOMING_URI_GENERATOR
						do
							create l_generator
							if attached l_generator.generate_uri_for_stone (a_stone) as l_uri then
								ev_application.clipboard.set_text (l_uri)
							end
						end (a_pebble)
				)
				l_menu.extend (l_menu_item)
			end
		end

	extend_delete_class_cluster_menu (a_menu: EV_MENU; a_pebble: STONE)
			-- Delete class/cluster menu
		require
			a_menu_not_void: a_menu /= Void
			a_pebble_not_void: a_pebble /= Void
		do
			if attached {CLASSI_STONE} a_pebble as l_classi_stone then
				a_menu.extend (dev_window.commands.delete_class_cluster_cmd.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent (dev_window.commands.delete_class_cluster_cmd).drop_class (l_classi_stone))
			elseif attached {CLUSTER_STONE} a_pebble as l_cluster_stone then
				a_menu.extend (dev_window.commands.delete_class_cluster_cmd.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent (dev_window.commands.delete_class_cluster_cmd).drop_cluster (l_cluster_stone))
			end
		end

	extend_add_new_class_item (a_menu: EV_MENU; a_cluster_stone: CLUSTER_STONE; a_disabled: BOOLEAN)
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

	extend_add_subcluster_item (a_menu: EV_MENU; a_cluster_stone: CLUSTER_STONE; a_disabled: BOOLEAN)
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

	extend_add_library (a_menu: EV_MENU)
			-- Extend Add library item to `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (dev_window.commands.new_library_cmd.new_menu_item_unmanaged)
		end

	extend_add_assembly (a_menu: EV_MENU)
			-- Extend Add assembly item to `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (dev_window.commands.new_assembly_cmd.new_menu_item_unmanaged)
		end

	extend_search_scope_remove (a_menu: EV_MENU; a_pebble: ANY)
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
		do
			if attached {STONE} a_pebble as l_stone then
					-- FIXME: Properties tool needs to be converted to ESF
				if attached {ES_PROPERTIES_TOOL} dev_window.shell_tools.tool ({ES_PROPERTIES_TOOL}) as l_tool then
					if l_tool.panel.dropable (l_stone) then
						create l_menu_item.make_with_text (l_tool.title)
						l_menu_item.select_actions.extend (agent l_tool.show (True))
						l_menu_item.select_actions.extend (agent (l_tool.panel).set_stone (l_stone))
						a_menu.extend (create {EV_MENU_SEPARATOR})
						a_menu.extend (l_menu_item)
					end
				else
					check l_tool_attached: False end
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

	extend_show_tool_command (a_cmd: ES_SHOW_TOOL_COMMAND; a_stone: STONE): EV_MENU_ITEM
			-- Extends a menu item to show a stonable tool.
		require
			a_cmd_is_attached: a_cmd /= Void
			a_cmd_is_interface_usable: a_cmd.is_interface_usable
			a_stone_is_usable: a_cmd.is_stone_usable (a_stone)
			a_stone_attached: a_stone /= Void
		local
			l_old_stone: STONE
		do
				-- Set the stone temporarly to retrieve the menu name, if it's based on the set stone.
			l_old_stone := a_cmd.stone
			a_cmd.set_stone (a_stone)
			Result := a_cmd.new_menu_item_unmanaged
			if not attached Result then
				create Result.make_with_text (a_cmd.menu_name)
			end
			a_cmd.set_stone (l_old_stone)

				-- Extend the menu.
			Result.select_actions.wipe_out
			Result.select_actions.extend (agent (a_ia_stone: STONE; a_ia_cmd: ES_SHOW_TOOL_COMMAND)
					-- Perform an action that sets a stone an executes the tool
				do
					check
						a_ia_stone_is_usable: a_ia_cmd.is_stone_usable (a_ia_stone)
					end
					a_ia_cmd.set_stone (a_ia_stone)
					a_ia_cmd.execute
				end (a_stone, a_cmd))
		end

feature {NONE} -- Diagram menu section, Granularity 1.

	extend_diagram_add_menu (a_menu: EV_MENU; a_name: STRING_GENERAL; a_pebble: ANY)
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
			if attached {CLASSI_STONE} a_pebble as st then
				l_classi_stone := st
			end
			if attached {CLASS_FIGURE_LIST_STONE} a_pebble as st then
				l_figures := st
			end
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

	extend_diagram_include_all_classes (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend Include all classes command.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_command: EB_FILL_CLUSTER_COMMAND
		do
			if attached {CLUSTER_STONE} a_pebble as l_cluster_stone then
				l_command := dev_window.tools.diagram_tool.fill_cluster_cmd
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_cluster_stone (l_cluster_stone))
			end
		end

	extend_force_right_angle (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend Force right angle command.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_command: EB_LINK_TOOL_COMMAND
		do
			if attached {LINK_STONE} a_pebble as l_link_stone then
				l_command := dev_window.tools.diagram_tool.link_tool_cmd
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_link_stone (l_link_stone))
			end
		end

	extend_remove_anchor (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend Remove Anchor menu item.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_command: EB_REMOVE_ANCHOR_COMMAND
		do
			l_command := dev_window.tools.diagram_tool.remove_anchor_cmd
			if attached {CLASSI_FIGURE_STONE} a_pebble as l_class_stone then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class (l_class_stone))
			elseif attached {CLUSTER_STONE} a_pebble as l_cluster_stone then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_cluster (l_cluster_stone))
			elseif attached {CLASS_FIGURE_LIST_STONE} a_pebble as l_class_figures then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class_list (l_class_figures))
			end
		end

	extend_diagram_delete_menu (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend diagram delete menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_command: EB_DELETE_DIAGRAM_ITEM_COMMAND
		do
			l_command := dev_window.tools.diagram_tool.delete_cmd
			if l_command.veto_pebble_function (a_pebble) then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				if attached {CLASSI_STONE} a_pebble as l_classi_stone then
					a_menu.last.select_actions.extend (agent l_command.drop_class (l_classi_stone))
				elseif attached {CLIENT_STONE} a_pebble as l_client then
					a_menu.last.select_actions.extend (agent l_command.execute_with_client_stone (l_client))
				elseif attached {INHERIT_STONE} a_pebble as l_inherit then
					a_menu.last.select_actions.extend (agent l_command.execute_with_inherit_stone (l_inherit))
				elseif attached {CLUSTER_STONE} a_pebble as l_cluster_stone then
					a_menu.last.select_actions.extend (agent l_command.drop_cluster (l_cluster_stone))
				end
			end
		end

	extend_remove_from_diagram (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend Remove Anchor menu item.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_command: EB_DELETE_FIGURE_COMMAND
		do
			l_command := dev_window.tools.diagram_tool.trash_cmd
			if attached {CLASSI_FIGURE_STONE} a_pebble as l_class_stone then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class_stone (l_class_stone))
			elseif attached {CLUSTER_FIGURE_STONE} a_pebble as l_cluster_stone then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_cluster_stone (l_cluster_stone))
			elseif attached {CLASS_FIGURE_LIST_STONE} a_pebble as l_class_figures then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_class_list (l_class_figures))
			elseif attached {INHERIT_STONE} a_pebble as l_inherit then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_inheritance_stone (l_inherit))
			elseif attached {CLIENT_STONE} a_pebble as l_client then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_client_stone (l_client))
			elseif attached {EG_EDGE} a_pebble as l_edge then
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.execute_with_link_midpoint (l_edge))
			end
		end

feature {NONE} -- Favorites menu section, Granularity 1.

	extend_new_favorite_class (a_menu: EV_MENU)
			-- Extend new favorite class menu.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (new_menu_item (names.b_new_favorite_class))
			a_menu.last.select_actions.extend (agent favorite_manager.new_favorite_class (Void))
		end

	extend_move_to_folder (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend move to folder menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_item: detachable EB_FAVORITES_ITEM
		do
			if attached {EB_FAVORITES_CLASS_STONE} a_pebble as l_class_stone then
				l_item := l_class_stone.origin
			elseif attached {EB_FAVORITES_FOLDER} a_pebble as l_folder then
				l_item := l_folder
			end
			if l_item /= Void then
				a_menu.extend (new_menu_item (names.b_move_to_folder))
				a_menu.last.select_actions.extend (agent favorite_manager.move_to_folder (l_item, Void))
			end
		end

	extend_add_favorite_folder (a_menu: EV_MENU)
			-- Extend "Create Folder..." menu.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (new_menu_item (names.b_create_folder))
			a_menu.last.select_actions.extend (agent favorite_manager.create_folder (Void))
		end

	extend_remove_from_favorites (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend remove from favorites menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_item: EB_FAVORITES_ITEM
		do
			if attached {EB_FAVORITES_CLASS_STONE} a_pebble as l_class_stone then
				l_item := l_class_stone.origin
			elseif attached {EB_FAVORITES_FOLDER} a_pebble as l_folder then
				l_item := l_folder
			elseif attached {EB_FAVORITES_FEATURE_STONE} a_pebble as l_feature then
				l_item := l_feature.origin
			end
			if l_item /= Void then
				a_menu.extend (new_menu_item (names.m_remove_from_favorites))
				a_menu.last.select_actions.extend (agent favorite_manager.remove (l_item))
			end
		end

feature {NONE} -- Debug tool menu section, Granularity 1.

	extend_sync_in_context_tool (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend Synchronize in Feature relation tool menu.
		require
			a_menu_not_void: a_menu /= Void
		do
			if attached {CALL_STACK_STONE} a_pebble as l_stone then
				a_menu.extend (new_menu_item (names.m_synchronize_in_tools))
				a_menu.last.select_actions.extend (agent (dev_window.tools).launch_stone (l_stone))
			end
		end

	extend_expanded_object_view (a_menu: EV_MENU; a_pebble: ANY)
			-- Extend Expanded object view menu.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_objviewer_command: EB_OBJECT_VIEWER_COMMAND
			l_objstore_command: ES_DBG_OBJECT_STORAGE_MANAGEMENT_COMMAND
		do
			if attached {OBJECT_STONE} a_pebble as l_stone then
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

	extend_metric_delete (a_menu: EV_MENU; a_basic: EB_METRIC)
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

	extend_metric_quick_metric (a_menu: EV_MENU; a_basic: EB_METRIC_BASIC)
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

	extend_metric_clone_metric (a_menu: EV_MENU; a_basic: EB_METRIC)
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

	extend_reload_metrics (a_menu: EV_MENU)
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

	extend_import_metric_from_file (a_menu: EV_MENU)
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

	extend_new_metric (a_menu: EV_MENU)
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

	extend_metric_open_user_metric (a_menu: EV_MENU)
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

	extend_metric_selector_move_up_and_down (a_menu: EV_MENU; a_selector: EB_METRIC_SELECTOR; a_unit: QL_METRIC_UNIT)
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

	extend_metric_selector_remove (a_menu: EV_MENU; a_pebble: ANY; a_selector: EB_METRIC_DOMAIN_SELECTOR)
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

	setup_pick_item (a_menu: EV_MENU; a_pebble: ANY)
			-- Replace name of the first menu item of `a_menu'
			-- with right language.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_text: STRING_32
			l_menu_entry: EV_MENU_ITEM
		do
			if a_menu.count > 0 then
				if last_type /= Void and then last_name /= Void then
					l_text := names.m_context_menu_pick (last_type, last_name)
				else
						-- Reset "Pick" text so that it is translatable.
					l_text := names.m_pick
				end
				a_menu.first.set_text (l_text)
				if preferences.misc_data.is_pnd_mode then
					create l_menu_entry.make_with_text (names.m_disable_pick_and_drop)
					l_menu_entry.select_actions.extend (agent (preferences.misc_data.pnd_preference).set_value (False))
				else
					create l_menu_entry.make_with_text (names.m_enable_pick_and_drop)
					l_menu_entry.select_actions.extend (agent (preferences.misc_data.pnd_preference).set_value (True))
				end
				a_menu.extend (l_menu_entry)
			end
		end

	setup_hyper_link_item (a_menu: EV_MENU; a_pebble: ANY)
			-- Replace name of the first menu item of `a_menu'
			-- with right language.
		require
			a_menu_not_void: a_menu /= Void
		local
			l_menu_item: EV_MENU_ITEM
			l_browser_context: ES_EIS_ENTRY_HELP_CONTEXT
		do
			if
				attached {EIS_LINK_STONE} a_pebble as l_pebble and then
				attached l_pebble.link as l_context
			then
				a_menu.go_i_th (1)
				if l_context.is_http_link then
						-- Choices to open the link
					create l_menu_item.make_with_text (names.m_open)
					l_context.set_is_shown_in_es (True)
					l_menu_item.select_actions.extend (agent show_help (l_context))
					a_menu.put_left (l_menu_item)
					a_menu.go_i_th (1)
					create l_menu_item.make_with_text (names.m_open_in_brower)
					create l_browser_context.make_from_other (l_context)
					l_browser_context.set_is_shown_in_es (False)
					l_menu_item.select_actions.extend (agent show_help (l_browser_context))
					a_menu.put_right (l_menu_item)
					a_menu.forth
				else
						-- Only show web in EiffelStudio
					create l_menu_item.make_with_text (names.m_open)
					l_context.set_is_shown_in_es (False)
					l_menu_item.select_actions.extend (agent show_help (l_context))
					a_menu.put_left (l_menu_item)
					a_menu.go_i_th (1)
				end
				a_menu.put_right (create {EV_MENU_SEPARATOR})
			end
		end

	build_name (a_pebble: ANY)
			-- Build name of `a_pebble'.
		local
			l_group: CONF_GROUP
		do
			if attached {FEATURE_STONE} a_pebble as l_feature_stone then
				last_name := l_feature_stone.feature_name
				last_type := names.l_feature
			else
				if attached {CLASSI_STONE} a_pebble as l_classi_stone then
					last_name := l_classi_stone.class_name
					last_type := names.t_context_menu_class
				else
					if attached {CLUSTER_STONE} a_pebble as l_cluster_stone then
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
					elseif attached {TARGET_STONE} a_pebble as l_target_stone then
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

	last_name: STRING_32

	last_type: STRING_32

	current_editor: EB_CLICKABLE_EDITOR

	favorite_manager: EB_FAVORITES_MANAGER
			-- Favorites manager
		do
			Result := dev_window.favorites_manager
		end

	extend_separator (a_menu: EV_MENU)
			-- Extend a separator into `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
				-- Add a separator, only if it is not the first entry in the menu
				-- and if the last inserted entry was not a separator.
			if
				not a_menu.is_empty and then
				not attached {EV_MENU_SEPARATOR} a_menu.last
			then
				a_menu.extend (create {EV_MENU_SEPARATOR})
			end
		end

	new_menu_item (a_name: detachable READABLE_STRING_GENERAL): EV_MENU_ITEM
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

	show_help (a_context: HELP_CONTEXT_I)
		local
			l_providers: SERVICE_CONSUMER [HELP_PROVIDERS_S]
		do
			create l_providers
			if attached l_providers.service as l_service then
				l_service.show_help (a_context)
			end
		end

feature {NONE} -- Status report

	is_pnd_mode: BOOLEAN
			-- Is pnd mode? Or contextual mode.
		do
			Result := preferences.misc_data.is_pnd_mode
		end

feature {NONE} -- Recycle

	internal_recycle
			--
		do
		end

feature {NONE} -- Access

	dev_window: EB_DEVELOPMENT_WINDOW
			-- Window.

feature {NONE} -- Context menu extension

	context_menu_extension: SERVICE_CONSUMER [CONTEXT_MENU_EXTENSION_S]
			-- A context menu extension service access.
		once
			create Result
		end

invariant
	dev_window_not_void: dev_window /= Void

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
