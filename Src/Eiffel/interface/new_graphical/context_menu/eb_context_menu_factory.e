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

	EB_RECYCLABLE

	SHARED_BENCH_NAMES

	EB_SHARED_MANAGERS

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

feature -- Editor menu

	editor_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_editor: EB_CLICKABLE_EDITOR) is
			-- Setup editor menu.
		require
			a_menu_not_void: a_menu /= Void
			a_editor_not_void: a_editor /= Void
		do
			if not is_pnd_mode then
				current_editor := a_editor
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				if a_pebble /= Void then
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					a_menu.extend (create {EV_MENU_SEPARATOR})
				end
				extend_basic_editor_menus (a_menu, a_editor.is_editable)
				extend_view_in_main_formatters_menus (a_menu)
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
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				l_stone ?= a_pebble
				if l_stone /= Void then
					l_target_stone ?= l_stone
					if l_target_stone /= Void then
						extend_add_to_menu (a_menu, l_stone)
					else
						l_cluster_stone ?= l_stone
						if l_cluster_stone /= Void then
							a_menu.extend (create {EV_MENU_SEPARATOR})
							l_group := l_cluster_stone.group
							if l_group.is_cluster then
								extend_add_new_class_item (a_menu, l_cluster_stone, l_group.is_readonly)
								extend_add_subcluster_item (a_menu, l_cluster_stone, l_group.is_readonly)
							elseif l_group.is_library then
								extend_add_library (a_menu)
							elseif l_group.is_assembly then
								extend_add_assembly (a_menu)
							end
							a_menu.extend (create {EV_MENU_SEPARATOR})
						end
						extend_standard_compiler_item_menu (a_menu, l_stone)
						a_menu.extend (create {EV_MENU_SEPARATOR})
						if l_cluster_stone = Void then
							extend_view_in_main_formatters_menus (a_menu)
							a_menu.extend (create {EV_MENU_SEPARATOR})
						end
						extend_delete_class_cluster_menu (a_menu, l_stone)
					end
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
			if not is_pnd_mode then
				l_data_stone ?= a_pebble
				if l_data_stone /= Void then
					build_name (a_pebble)
					setup_pick_item (a_menu, l_data_stone)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_add_subcluster_item (a_menu, Void, False)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_add_to_menu (a_menu, l_data_stone)
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
			if not is_pnd_mode then
				l_data_stone ?= a_pebble
				if l_data_stone /= Void then
					build_name (a_pebble)
					setup_pick_item (a_menu, l_data_stone)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_add_library (a_menu)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_add_to_menu (a_menu, l_data_stone)
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
			if not is_pnd_mode then
				l_data_stone ?= a_pebble
				if l_data_stone /= Void then
					build_name (a_pebble)
					setup_pick_item (a_menu, l_data_stone)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_add_assembly (a_menu)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_add_to_menu (a_menu, l_data_stone)
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
			if not is_pnd_mode then
				if a_pebble = Void then
					extend_basic_diagram_menu (a_menu)
				else
					build_name (a_pebble)
					setup_pick_item (a_menu, a_pebble)
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					l_feature_stone ?= a_pebble
					if l_feature_stone = Void then
						extend_diagram_add_menu (a_menu, names.b_add, a_pebble)
						extend_diagram_include_all_classes (a_menu, a_pebble)
						extend_force_right_angle (a_menu, a_pebble)
						extend_remove_anchor (a_menu, a_pebble)
						extend_remove_from_diagram (a_menu, a_pebble)
						extend_diagram_delete_menu (a_menu, a_pebble)
					end
				end
			end
		end

feature -- Feature tree

	uncompiled_feature_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_name: STRING) is
			-- Uncompiled feature item menu
		require
			a_name_not_void: a_name /= Void
			a_menu_not_void: a_menu /= Void
		local
			l_feature_tool: EB_FEATURES_TOOL
		do
			if not is_pnd_mode then
				l_feature_tool := dev_window.tools.features_tool
				a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_go_to))
				a_menu.last.select_actions.extend (agent l_feature_tool.go_to_feature_with_name (a_name))
			end
		end

	feature_clause_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_clause: FEATURE_CLAUSE_AS) is
			-- Feature clause item menu
		require
			a_clause_not_void: a_clause /= Void
			a_menu_not_void: a_menu /= Void
		local
			l_feature_tool: EB_FEATURES_TOOL
		do
			if not is_pnd_mode then
				l_feature_tool := dev_window.tools.features_tool
				a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_go_to))
				a_menu.last.select_actions.extend (agent l_feature_tool.go_to_clause (a_clause, False))
			end
		end

feature -- Favorites menus

	favorites_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_item: EB_FAVORITES_TREE_ITEM) is
			-- Favorites menu
		require
			a_menu_not_void: a_menu /= Void
			a_item_not_void: a_item /= Void
		do
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				a_menu.extend (create {EV_MENU_SEPARATOR})
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
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				a_menu.extend (create {EV_MENU_SEPARATOR})
				extend_metric_selector_remove (a_menu, a_pebble, a_selector)
			end
		end

	metric_metric_selector_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_selector: EB_METRIC_SELECTOR) is
			-- Metrics domain selector context menu
		local
			l_unit: QL_METRIC_UNIT
			l_basic: EB_METRIC_BASIC
		do
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				a_menu.extend (create {EV_MENU_SEPARATOR})
				l_unit ?= a_pebble
				l_basic ?= a_pebble
				if l_unit /= Void then
					extend_metric_selector_move_up_and_down (a_menu, a_selector, l_unit)
				elseif l_basic /= Void then
					extend_metric_clone_metric (a_menu, l_basic)
					extend_metric_quick_metric (a_menu, l_basic)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_new_metric (a_menu)
					extend_reload_metrics (a_menu)
					extend_metric_open_user_metric (a_menu)
					extend_import_metric_from_file (a_menu)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_metric_delete (a_menu, l_basic)
				end
			end
		end

feature -- Call stack menu

	call_stack_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_item: EB_FAVORITES_TREE_ITEM) is
			-- Call stack menu.
		local
			l_call_stack_stone: CALL_STACK_STONE
		do
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				l_call_stack_stone ?= a_pebble
				if l_call_stack_stone /= Void then
					extend_standard_compiler_item_menu (a_menu, a_pebble)
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_sync_in_context_tool (a_menu, a_pebble)
					extend_expanded_object_view (a_menu, a_pebble)
				end
			end
		end

feature -- Object and Watch tool menus

	object_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Object tool menu
		local
			l_object_stone: OBJECT_STONE
		do
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				l_object_stone ?= a_pebble
				if l_object_stone /= Void then
					a_menu.extend (create {EV_MENU_SEPARATOR})
					extend_expanded_object_view (a_menu, a_pebble)
				end
			end
		end

	watch_tool_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY; a_watch_tool: ES_WATCH_TOOL) is
			-- Watch tool menu
		local
			l_object_stone: OBJECT_STONE
			l_sep_added: BOOLEAN
		do
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				l_object_stone ?= a_pebble
				if l_object_stone /= Void then
					a_menu.extend (create {EV_MENU_SEPARATOR})
					l_sep_added := True
					extend_expanded_object_view (a_menu, a_pebble)
				end
				if a_watch_tool.has_selected_item then
					if not l_sep_added then
						a_menu.extend (create {EV_MENU_SEPARATOR})
					end
					extend_delete_expression (a_menu, a_pebble, a_watch_tool)
				end
			end
		end

feature -- Search scope menu

	search_scope_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Search scope menu
		do
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
				a_menu.extend (create {EV_MENU_SEPARATOR})
				extend_search_scope_remove (a_menu, a_pebble)
			end
		end

feature -- Standard menus

	standard_compiler_item_menu (a_menu: EV_MENU; a_target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; a_source: EV_PICK_AND_DROPABLE; a_pebble: ANY) is
			-- Standard compiler item menu. (class/feature/cluster)
		do
			if not is_pnd_mode then
				build_name (a_pebble)
				setup_pick_item (a_menu, a_pebble)
				extend_standard_compiler_item_menu (a_menu, a_pebble)
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
				a_menu.extend (create {EV_MENU_SEPARATOR})
				extend_feature_formatter_menus (a_menu, l_feature_stone)
				extend_feature_refactoring_menus (a_menu, l_feature_stone)
				extend_debug_feature_menus (a_menu, l_feature_stone.e_feature)
				extend_add_to_menu (a_menu, l_stone)
			elseif l_stonec /= Void then
				extend_basic_opening_menus (a_menu, l_stonec, False)
				a_menu.extend (create {EV_MENU_SEPARATOR})
				extend_class_formatter_menus (a_menu, l_stonec)
				extend_class_refactoring_menus (a_menu, l_stonec)
				extend_debug_class_menus (a_menu, l_stonec.e_class)
				extend_add_to_menu (a_menu, l_stone)
			elseif l_stonei /= Void then
				extend_basic_opening_menus (a_menu, l_stonei, False)
				a_menu.extend (create {EV_MENU_SEPARATOR})
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
			a_menu.last.set_text (add_type_and_name (names.m_new_tab))
			a_menu.last.select_actions.wipe_out
			a_menu.last.select_actions.extend (agent (dev_window.commands.new_tab_cmd).execute_with_stone (l_stone))
			if current_editor /= Void and then l_stone.same_as (current_editor.stone) then
				a_menu.last.disable_sensitive
			end

			a_menu.extend (dev_window.new_development_window_cmd.new_menu_item_unmanaged)
			a_menu.last.set_text (add_type_and_name (names.m_new_window))
			a_menu.last.select_actions.wipe_out
			a_menu.last.select_actions.extend (agent (dev_window.new_development_window_cmd).execute_with_stone (l_stone))

			if a_external_editor then
				a_menu.extend (dev_window.commands.shell_cmd.new_menu_item_unmanaged)
				a_menu.last.set_text (add_type_and_name (names.m_external_editor))
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent (dev_window.commands.shell_cmd).execute_with_stone (l_stone))
			end
		end

	extend_basic_editor_menus (a_menu: EV_MENU; is_editable: BOOLEAN) is
			-- Add items of basic editor operations.
			-- |Cut
			-- |Copy
			-- |Paste
			-- |----
			-- |Select All
			-- |Edit-->...
		require
			a_menu_not_void: a_menu /= Void
		local
			l_menu: EV_MENU
			l_editor_cmd: EB_EDITOR_COMMAND
			l_commands: ARRAYED_LIST [EB_GRAPHICAL_COMMAND]
		do
			a_menu.extend (dev_window.commands.editor_cut_cmd.new_menu_item_unmanaged)
			if not is_editable then
				a_menu.last.disable_sensitive
			end
			a_menu.extend (dev_window.commands.editor_copy_cmd.new_menu_item_unmanaged)
			a_menu.extend (dev_window.commands.editor_paste_cmd.new_menu_item_unmanaged)
			if not is_editable then
				a_menu.last.disable_sensitive
			end

			a_menu.extend (create {EV_MENU_SEPARATOR})
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_select_all))
			a_menu.last.select_actions.extend (agent dev_window.select_all)


			create l_menu.make_with_text (names.m_edit)
			a_menu.extend (l_menu)
			if not is_editable then
				a_menu.last.disable_sensitive
			end
			from
				l_commands := dev_window.commands.editor_commands
				l_commands.start
				l_commands.forth
					-- 'Select All' is at the first position.
			until
				l_commands.after
			loop
				l_editor_cmd ?= l_commands.item
				if l_editor_cmd /= Void then
					if not l_editor_cmd.menu_name.is_equal (names.m_select_all) then
						l_menu.extend (l_editor_cmd.new_menu_item_unmanaged)
					end
				end
				l_commands.forth
			end
			a_menu.extend (create {EV_MENU_SEPARATOR})
		end

	extend_view_in_main_formatters_menus (a_menu: EV_MENU) is
			--| View -->	Basic view
			--|				Clickable view
			--|				Flat view
			--|				Interface view
			--|				Contract view
		require
			a_menu_not_void: a_menu /= Void
		local
			l_menu: EV_MENU
			l_form: EB_CLASS_INFO_FORMATTER
		do
			create l_menu.make_with_text (names.m_view)
			a_menu.extend (l_menu)
			from
				dev_window.managed_main_formatters.start
			until
				dev_window.managed_main_formatters.after
			loop
				l_form := dev_window.managed_main_formatters.item
				l_menu.extend (create {EV_MENU_ITEM}.make_with_text (l_form.new_menu_item.text))
				l_menu.last.select_actions.extend (agent l_form.execute)
				l_menu.last.select_actions.extend (agent l_form.invalidate)
				dev_window.managed_main_formatters.forth
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
					l_menu.extend (create {EV_MENU_ITEM}.make_with_text (l_class_formatter.menu_name))
					l_menu.last.select_actions.extend (agent (dev_window.tools.class_tool).show)
					l_menu.last.select_actions.extend (agent l_class_formatter.execute_with_stone (a_class_stone))
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

			l_menu.extend (create {EV_MENU_SEPARATOR})

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
					l_menu.extend (create {EV_MENU_ITEM}.make_with_text (l_feature_formatter.menu_name))
					l_menu.last.select_actions.extend (agent (dev_window.tools.features_relation_tool).show)
					l_menu.last.select_actions.extend (agent l_feature_formatter.execute_with_stone (a_feature_stone))
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
				a_menu.extend (create {EV_MENU_ITEM}.make_with_text (a_formatters.item.name))
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
--			l_menu.extend (create {EV_MENU_ITEM}.make_with_text ("Move"))
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
			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_add_first_breakpoints_in_class))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.enable_first_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_enable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.enable_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_disable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.disable_breakpoints_in_class (a_class)
					window_manager.synchronize_all_about_breakpoints
				end (a_class_c)
			)

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_clear_breakpoints))
			l_menu.last.select_actions.extend (
				agent (a_class: CLASS_C) do
					dev_window.debugger_manager.remove_breakpoints_in_class (a_class)
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
			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_add_first_breakpoints_in_feature))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.enable_first_breakpoint_of_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_enable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.enable_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_disable_stop_points))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.disable_breakpoints_in_feature (a_feature)
					window_manager.synchronize_all_about_breakpoints
				end (a_efeature)
			)

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_clear_breakpoints))
			l_menu.last.select_actions.extend (
				agent (a_feature: E_FEATURE) do
					dev_window.debugger_manager.remove_breakpoints_in_feature (a_feature)
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
			l_list: LINKED_SET [ES_WATCH_TOOL]
		do
			create l_menu.make_with_text (names.m_add_to)
			a_menu.extend (l_menu)

			l_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_search_scope))
			l_menu.last.select_actions.extend (agent (dev_window.tools.search_tool).on_drop_add (a_pebble))

			extend_diagram_add_menu (l_menu, names.m_diagram_with, a_pebble)

			create l_menu2.make_with_text (names.m_input_domain)
			l_menu.extend (l_menu2)
			l_menu2.extend (create {EV_MENU_ITEM}.make_with_text (metric_names.t_evaluation_tab))
			l_menu2.last.select_actions.extend (
				agent (a_stone: STONE) do
					dev_window.tools.metric_tool.metric_evaluation_panel.force_drop_stone (a_stone)
				end (a_pebble)
			)
			l_menu2.extend (create {EV_MENU_ITEM}.make_with_text (metric_names.t_archive_tab))
			l_menu2.last.select_actions.extend (
				agent (a_stone: STONE) do
					dev_window.tools.metric_tool.metric_archive_panel.force_drop_stone (a_stone)
				end (a_pebble)
			)
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
						l_menu2.extend (create {EV_MENU_ITEM}.make_with_text (l_list.item.title))
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
			l_search_tool: EB_MULTI_SEARCH_TOOL
		do
			l_search_tool := dev_window.tools.search_tool
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_remove))
			a_menu.last.select_actions.extend (agent l_search_tool.on_drop_remove (a_pebble))
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_remove_all))
			a_menu.last.select_actions.extend (agent l_search_tool.remove_all)
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
			l_diagram_tool: EB_DIAGRAM_TOOL
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
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.b_new_favorite_class))
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
				a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.b_move_to_folder))
				a_menu.last.select_actions.extend (agent favorite_manager.move_to_folder (l_item, Void))
			end
		end

	extend_add_favorite_folder (a_menu: EV_MENU) is
			-- Extend "Create Folder..." menu.
		require
			a_menu_not_void: a_menu /= Void
		do
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.b_create_folder))
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
				a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_remove_from_favorites))
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
				a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_synchronize_in_tools))
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
			l_command: EB_OBJECT_VIEWER_COMMAND
		do
			l_stone ?= a_pebble
			if l_stone /= Void then
				l_command := dev_window.eb_debugger_manager.object_viewer_cmd
				a_menu.extend (l_command.new_menu_item_unmanaged)
				a_menu.last.select_actions.wipe_out
				a_menu.last.select_actions.extend (agent l_command.on_stone_dropped (l_stone))
			end
		end

	extend_delete_expression (a_menu: EV_MENU; a_pebble: ANY; a_watch_tool: ES_WATCH_TOOL) is
			-- Extend delete expression menu.
		require
			a_menu_not_void: a_menu /= Void
			a_watch_tool_not_void: a_watch_tool /= Void
		do
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_delete))
			a_menu.last.select_actions.extend (agent a_watch_tool.remove_object_line (a_pebble))
			if not a_watch_tool.is_removable (a_pebble) then
				a_menu.last.disable_sensitive
			end
		end

feature {NONE} -- Metrics tool section, Granularity 1.

	extend_metric_delete (a_menu: EV_MENU; a_basic: EB_METRIC_BASIC) is
			-- Extend metric Delete.
		require
			a_menu_not_void: a_menu /= Void
			a_basic_not_void: a_basic /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_delete))
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
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_quick_metric))
			a_menu.last.set_pixmap (l_metric_panel.quick_metric_btn.pixmap)
			a_menu.last.select_actions.extend (agent (dev_window.tools.metric_tool.metric_notebook).select_item (l_metric_panel))
			a_menu.last.select_actions.extend (agent l_metric_panel.on_create_quick_metric (a_basic))
		end

	extend_metric_clone_metric (a_menu: EV_MENU; a_basic: EB_METRIC_BASIC) is
			-- Extend Open user defined metrics externally.
		require
			a_menu_not_void: a_menu /= Void
			a_basic_not_void: a_basic /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_clone_metric))
			a_menu.last.set_pixmap (l_metric_panel.send_current_to_new_btn.pixmap)
			a_menu.last.select_actions.extend (agent (dev_window.tools.metric_tool.metric_notebook).select_item (l_metric_panel))
			a_menu.last.select_actions.extend (agent l_metric_panel.clone_and_load_metric (a_basic))
		end

	extend_reload_metrics (a_menu: EV_MENU) is
			-- Extend Reload metrics
		require
			a_menu_not_void: a_menu /= Void
		local
			l_metric_panel: EB_NEW_METRIC_PANEL
		do
			l_metric_panel := dev_window.tools.metric_tool.new_metric_panel
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_reload_metrics))
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
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_import_metrics_from_file))
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
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_open_user_defined_metric))
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
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_move_up))
			a_menu.last.select_actions.extend (agent a_selector.move_unit (a_unit, True))
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_move_down))
			a_menu.last.select_actions.extend (agent a_selector.move_unit (a_unit, False))
		end

	extend_metric_selector_remove (a_menu: EV_MENU; a_pebble: ANY; a_selector: EB_METRIC_DOMAIN_SELECTOR) is
			-- Remove and Remove all menus in metric selector
		require
			a_menu_not_void: a_menu /= Void
			a_selector_not_void: a_selector /= Void
		do
			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_remove))
				-- |Ted: Questionable: Metric domain selector has two routine handling removing?
			a_menu.last.select_actions.extend (agent a_selector.on_item_dropped_on_remove_button (a_pebble))
			a_menu.last.select_actions.extend (agent a_selector.on_item_drop_on_remove_button (a_pebble))

			a_menu.extend (create {EV_MENU_ITEM}.make_with_text (names.m_remove_all))
			a_menu.last.select_actions.extend (agent a_selector.on_remove_all_scopes)
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
				l_text := add_type_and_name (names.m_pick)
				a_menu.first.set_text (l_text)
			end
		end

	add_type_and_name (a_str: STRING_32): STRING_32 is
			-- Make new string extended `last_type' and `last_name' to `a_str'.
		require
			a_str_not_void: a_str /= Void
		do
			Result := a_str.twin
			if last_type /= Void and then last_name /= Void then
				Result.append (" ")
				Result.append (last_type)
				Result.append (" '")
				Result.append (last_name)
				Result.append ("'")
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
