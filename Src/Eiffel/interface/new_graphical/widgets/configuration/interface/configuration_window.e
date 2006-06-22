indexing
	description: "[
		Project configuration window.
		 	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state,
			destroy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create, copy
		end

	DEFAULT_VALIDATOR
		undefine
			default_create, copy
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create, copy
		end

	CONF_CONSTANTS
		undefine
			default_create, copy
		end

	CONF_VALIDITY
		export
			{NONE} all
		undefine
			default_create, copy
		end

	OPTION_PROPERTIES
		export
			{NONE} all
		undefine
			default_create, copy
		redefine
			refresh
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			default_create, copy
		end

	EB_LAYOUT_CONSTANTS
		undefine
			default_create,
			copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE}-- Initialization

	make (a_system: like conf_system; a_factory: like conf_factory; a_debugs: like debug_clauses) is
			-- Create.
		require
			a_system_not_void: a_system /= Void
			a_factory_not_void: a_factory /= Void
			a_debugs_not_void: a_debugs /= Void
			application_target_set: a_system.application_target /= Void
		do
			conf_system := a_system
			conf_factory := a_factory
			debug_clauses := a_debugs
			default_create
			config_windows.force (Current, conf_system.file_name)
			create group_section_expanded_status.make (20)
		ensure
			system_set: conf_system = a_system
			factory_set: conf_factory = a_factory
			debug_clauses_set: debug_clauses = a_debugs
		end

	initialize is
			-- Initialize `Current'.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			cl: EV_CELL
			l_btn: EV_BUTTON
		do
				-- set default layout values
			set_padding_size (default_padding_size)

				-- window
			Precursor {EV_TITLED_WINDOW}
			set_title (configuration_title (conf_system.name))
			set_width (initial_window_width)
			set_height (initial_window_height)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_config_icon)
			enable_user_resize

			create hb
			extend (hb)

					-- section tree
			initialize_section_tree
			hb.extend (section_tree)
			hb.disable_item_expand (section_tree)

			create cl
			cl.set_minimum_width (margin_size)
			hb.extend (cl)
			hb.disable_item_expand (cl)
			create vb
			hb.extend (vb)
			create cl
			cl.set_minimum_height (margin_size)
			vb.extend (cl)
			vb.disable_item_expand (cl)

				-- configuration space
			create configuration_space
			vb.extend (configuration_space)

				-- property grid
			show_actions.extend (agent show_properties_system)

			create cl
			cl.set_minimum_height (margin_size)
			vb.extend (cl)
			vb.disable_item_expand (cl)
			create cl
			cl.set_minimum_width (margin_size)
			hb.extend (cl)
			hb.disable_item_expand (cl)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)

			hb.extend (create {EV_CELL})
			hb.set_padding (default_padding_size)

			create l_btn.make_with_text_and_action (ev_ok, agent on_ok)
			l_btn.set_minimum_width (default_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			create l_btn.make_with_text_and_action (ev_cancel, agent on_cancel)
			l_btn.set_minimum_width (default_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			close_request_actions.extend (agent on_cancel)

			append_margin (vb)
			show_actions.extend (agent section_tree.set_focus)
		end

feature -- Command

	destroy is
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			Precursor
			config_windows.remove (conf_system.file_name)
		end

feature {NONE} -- Agents

	refresh_current: PROCEDURE [ANY, TUPLE[]]
			-- What to call to refresh the current view.

	target_selection_changed is
			-- Currently edited target is changed.
		do
			if target_selection.text /= Void then
				current_target := conf_system.targets.item (target_selection.text)
				is_il_generation := current_target.setting_msil_generation
				if not is_refreshing then
					refresh_current.call ([])
				end
				if target_selection.count = 1 then
					target_selection.disable_sensitive
				end
			end
		ensure
			current_target_set: current_target /= Void
		end

	on_cancel is
			-- Quit without saving.
		do
			destroy
		end

	on_ok is
			-- Quit with saving
		do
			close_request_actions.call ([])
			conf_system.store
			destroy
		end

	edit_configuration (a_configuration: STRING) is
			-- Open a new dialog to edit the file `a_configuration'.
		require
			a_configuration_not_void: a_configuration /= Void
		local
			l_load: CONF_LOAD
			wd: EV_WARNING_DIALOG
			l_lib_conf: CONFIGURATION_WINDOW
		do
				-- see if we already have a window for this configuration and reuse it
			config_windows.search (a_configuration)
			if config_windows.found then
				l_lib_conf := config_windows.found_item
				l_lib_conf.set_focus
			else
				create l_load.make (conf_factory)
				l_load.retrieve_configuration (a_configuration)
				if l_load.is_error then
					create wd.make_with_text (l_load.last_error.out)
					wd.show_modal_to_window (Current)
				else
					l_load.last_system.targets.start
					l_load.last_system.set_application_target (l_load.last_system.targets.item_for_iteration)
					create l_lib_conf.make (l_load.last_system, conf_factory, create {DS_ARRAYED_LIST [STRING]}.make (0))
					l_lib_conf.show
					l_lib_conf.close_request_actions.extend (agent config_windows.remove (a_configuration))
				end
			end
		end

feature {NONE} -- Layout components

	target_selection: EV_COMBO_BOX

	section_tree: EV_TREE

	grid: ES_GRID

	configuration_space: EV_VERTICAL_BOX
			-- Space to put configuration.

	target_configuration_space: EV_VERTICAL_BOX
			-- Space to put configuration for `current_target'.

	edit_library_button: EV_BUTTON
			-- Button to edit the configuration file of a library.

feature {NONE} -- Section tree selection agents

	show_properties_system is
			-- Show configuration for system properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_system

			if target_configuration_space /= Void then
				target_configuration_space.destroy
				target_configuration_space := Void
			end

			initialize_properties_system
			configuration_space.wipe_out
			append_property_grid (configuration_space)
			append_small_margin (configuration_space)
			append_property_description (configuration_space)

			is_refreshing := False
		ensure
			target_configuration_space_void: target_configuration_space = Void
			not_refreshing: not is_refreshing
		end

	show_properties_target_general is
			-- Show configuration for general target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_general

			prepare_target_configuration_space
			initialize_properties_target_general
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_warning is
			-- Show configuration for warning target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_warning

			prepare_target_configuration_space
			initialize_properties_target_warning
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_debugs is
			-- Show configuration for debugs target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_debugs

			prepare_target_configuration_space
			initialize_properties_target_debugs
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_assertions is
			-- Show configuration for assertion target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_assertions

			prepare_target_configuration_space
			initialize_properties_target_assertions
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_externals is
			-- Show configuration for externals target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_button: EV_BUTTON
			cl: EV_CELL
			hb: EV_HORIZONTAL_BOX
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_externals

			if properties /= Void then
				properties.destroy
			end
			create properties

			prepare_target_configuration_space
			append_externals_tree (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			append_small_margin (target_configuration_space)
			create hb
			target_configuration_space.extend (hb)
			target_configuration_space.disable_item_expand (hb)

			create cl
			hb.extend (cl)
			hb.set_padding (default_padding_size)

			create l_button.make_with_text ("Add")
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width)
			l_button.select_actions.extend (agent new_external)

			create l_button.make_with_text ("Remove")
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width)
			l_button.select_actions.extend (agent remove_external)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_tasks is
			-- Show configuration for tasks target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_button: EV_BUTTON
			cl: EV_CELL
			hb: EV_HORIZONTAL_BOX
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_tasks

			if properties /= Void then
				properties.destroy
			end
			create properties

			prepare_target_configuration_space
			append_tasks_tree (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			append_small_margin (target_configuration_space)
			create hb
			target_configuration_space.extend (hb)
			target_configuration_space.disable_item_expand (hb)
			hb.set_padding (default_padding_size)

			create cl
			hb.extend (cl)

			create l_button.make_with_text ("Add")
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width)
			l_button.select_actions.extend (agent new_task)

			create l_button.make_with_text ("Remove")
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width)
			l_button.select_actions.extend (agent remove_task)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_groups is
			-- Show configuration for groups target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l_tb: EV_TOOL_BAR
			l_tb_btn: EV_TOOL_BAR_BUTTON
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_groups

			if properties /= Void then
				properties.destroy
			end
			create properties

			prepare_target_configuration_space
			create hb
			create vb
			hb.extend (vb)
			hb.disable_item_expand (vb)
			vb.set_minimum_width (group_tree_width)

			create l_tb
			vb.extend (l_tb)
			vb.disable_item_expand (l_tb)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.add_cluster_icon)
			l_tb_btn.set_tooltip (dialog_create_cluster_title)
			l_tb_btn.select_actions.extend (agent add_cluster)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.add_override_cluster_icon)
			l_tb_btn.set_tooltip (dialog_create_override_title)
			l_tb_btn.select_actions.extend (agent add_override)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.add_library_icon)
			l_tb_btn.set_tooltip (dialog_create_library_title)
			l_tb_btn.select_actions.extend (agent add_library)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.add_reference_icon)
			l_tb_btn.set_tooltip (dialog_create_assembly_title)
			l_tb_btn.select_actions.extend (agent add_assembly)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			l_tb_btn.set_tooltip (remove_group_text)
			l_tb_btn.select_actions.extend (agent remove_group)

			append_groups_tree (vb)
			append_small_margin (hb)
			target_configuration_space.extend (hb)
			create vb
			hb.extend (vb)
			create edit_library_button.make_with_text (library_edit_configuration)
			vb.extend (edit_library_button)
			vb.disable_item_expand (edit_library_button)
			edit_library_button.hide
			append_property_grid (vb)
			append_small_margin (vb)
			append_property_description (vb)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_variables is
			-- Show configuration for variables target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_vars, l_inh_vars: EQUALITY_HASH_TABLE [STRING, STRING]
			i: INTEGER
			l_item: TEXT_PROPERTY [STRING]
			l_btn: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb_grid: EV_VERTICAL_BOX
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_variables

			prepare_target_configuration_space
			create vb_grid
			vb_grid.set_border_width (1)
			vb_grid.set_background_color ((create {EV_STOCK_COLORS}).black)
			target_configuration_space.extend (vb_grid)
			create grid
			vb_grid.extend (grid)
			grid.set_column_count_to (2)
			grid.enable_border
			grid.enable_last_column_use_all_width
			grid.enable_single_row_selection
			grid.column (1).set_width (200)
			grid.column (2).set_width (200)
			grid.column (1).set_title ("Variable name")
			grid.column (2).set_title ("Value")
			if current_target.extends /= Void then
				l_inh_vars := current_target.extends.variables
			else
				create l_inh_vars.make (0)
			end
			from
				l_vars := current_target.variables
				l_vars.start
			until
				l_vars.after
			loop
				i := grid.row_count
				create l_item.make ("")
				l_item.set_value (l_vars.key_for_iteration)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent update_variable_key (l_vars.key_for_iteration, ?))
				grid.set_item (1, i + 1, l_item)
				create l_item.make ("")
				l_item.set_value (l_vars.item_for_iteration)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent update_variable_value (l_vars.key_for_iteration, ?))
				grid.set_item (2, i + 1, l_item)
				l_inh_vars.search (l_vars.key_for_iteration)
				if l_inh_vars.found then
					if l_inh_vars.found_item.is_equal (l_vars.item_for_iteration) then
						-- inherited
						grid.row (i + 1).set_background_color (inherit_color)
					else
						-- overriden
						grid.row (i + 1).set_background_color (override_color)
					end
				end
				l_vars.forth
			end

			create hb
			target_configuration_space.extend (hb)
			target_configuration_space.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action ("+", agent add_variable)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			create l_btn.make_with_text_and_action ("-", agent remove_variable)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	show_properties_target_mapping is
			-- Show configuration for mapping properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_vars, l_inh_vars: EQUALITY_HASH_TABLE [STRING, STRING]
			i: INTEGER
			l_item: TEXT_PROPERTY [STRING]
			l_btn: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb_grid: EV_VERTICAL_BOX
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_mapping

			prepare_target_configuration_space

			create vb_grid
			vb_grid.set_border_width (1)
			vb_grid.set_background_color ((create {EV_STOCK_COLORS}).black)
			target_configuration_space.extend (vb_grid)
			create grid
			vb_grid.extend (grid)
			grid.set_column_count_to (2)
			grid.enable_border
			grid.enable_last_column_use_all_width
			grid.enable_single_row_selection
			grid.column (1).set_width (200)
			grid.column (2).set_width (200)
			grid.column (1).set_title ("Old name")
			grid.column (2).set_title ("New Name")
			if current_target.extends /= Void then
				l_inh_vars := current_target.extends.mapping
			else
				create l_inh_vars.make (0)
			end
			from
				l_vars := current_target.mapping
				l_vars.start
			until
				l_vars.after
			loop
				i := grid.row_count
				create l_item.make ("")
				l_item.set_value (l_vars.key_for_iteration)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent update_mapping_key (l_vars.key_for_iteration, ?))
				grid.set_item (1, i + 1, l_item)
				create l_item.make ("")
				l_item.set_value (l_vars.item_for_iteration)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent update_mapping_value (l_vars.key_for_iteration, ?))
				grid.set_item (2, i + 1, l_item)
				l_inh_vars.search (l_vars.key_for_iteration)
				if l_inh_vars.found then
					if l_inh_vars.found_item.is_equal (l_vars.item_for_iteration) then
						-- inherited
						grid.row (i + 1).set_background_color (inherit_color)
					else
						-- overriden
						grid.row (i + 1).set_background_color (override_color)
					end
				end
				l_vars.forth
			end

			create hb
			target_configuration_space.extend (hb)
			target_configuration_space.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action ("+", agent add_mapping)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			create l_btn.make_with_text_and_action ("-", agent remove_mapping)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			is_refreshing := False
		end

	show_properties_target_advanced is
			-- Show configuration for advanced target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_advanced

			prepare_target_configuration_space
			initialize_properties_target_advanced
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	refresh_target (a_target: STRING_32) is
			-- Refresh target selection box and select `a_target'.
		require
			a_target_valid_8_string: a_target.is_valid_as_string_8
		do
			if target_configuration_space /= Void then
				target_configuration_space.destroy
				target_configuration_space := Void
			end
			current_target := conf_system.targets.item (a_target.to_string_8)
			is_il_generation := current_target.setting_msil_generation
			refresh
		end


feature {NONE} -- Implementation

	conf_factory: CONF_FACTORY
			-- Factory to create new configuration nodes.

	conf_system: CONF_SYSTEM
			-- Configuration system.

	current_target: CONF_TARGET
			-- Currently edited target.

	current_external: CONF_EXTERNAL
			-- Current selected external.

	current_task: CONF_ACTION
			-- Current selected task.

	current_group: CONF_GROUP
			-- Current selected group.

	config_windows: HASH_TABLE [CONFIGURATION_WINDOW, STRING] is
			-- Open configuration windows, indexed by the configuration file the represent.
		once
			create Result.make (5)
		end

	group_section_expanded_status: HASH_TABLE [HASH_TABLE [BOOLEAN, STRING], STRING]
			-- Expanded status of sections of groups, indexed by group name.

	is_refreshing: BOOLEAN
			-- Are we currently refreshing?

	refresh is
			-- Regenerate currently displayed data.
		do
			if refresh_current /= Void then
				Current.lock_update
				refresh_current.call ([])
				set_focus
				section_tree.set_focus
				Current.unlock_update
			end
		end

	initialize_section_tree is
			-- Initialize `section_tree'.
		require
			section_tree_void: section_tree = Void
		local
			l_item, l_subitem: EV_TREE_ITEM
		do
			create section_tree
			create l_item.make_with_text (section_system)
			section_tree.extend (l_item)
			l_item.enable_select
			l_item.select_actions.extend (agent show_properties_system)

			create l_item.make_with_text (section_target)
			section_tree.extend (l_item)
			l_item.select_actions.extend (agent show_properties_target_general)
			create l_subitem.make_with_text (section_assertions)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_assertions)
			create l_subitem.make_with_text (section_groups)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_groups)

			create l_subitem.make_with_text (section_advanced)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_advanced)
			l_item.expand
			l_item := l_subitem
			create l_subitem.make_with_text (section_warning)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_warning)
			create l_subitem.make_with_text (section_debug)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_debugs)
			create l_subitem.make_with_text (section_external)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_externals)
			create l_subitem.make_with_text (section_tasks)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_tasks)
			create l_subitem.make_with_text (section_variables)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_variables)
			create l_subitem.make_with_text (section_mapping)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_mapping)

			section_tree.set_minimum_width (section_tree_width)
		ensure
			section_tree_not_void: section_tree /= Void
		end

	prepare_target_configuration_space is
			-- Add space for target configuration and necessary elements for it.
		do
			if target_configuration_space = Void then
				configuration_space.wipe_out
				append_target_selection (configuration_space)
				append_small_margin (configuration_space)
				create target_configuration_space
				configuration_space.extend (target_configuration_space)
			else
				target_configuration_space.wipe_out
			end
		ensure
			target_configuration_space: target_configuration_space /= Void
		end

	append_target_selection (a_container: EV_BOX) is
			-- Append layout for target selection.
		require
			a_container: a_container /= Void
		local
			cl: EV_CELL
			hb: EV_HORIZONTAL_BOX
			l_targets: ARRAYED_LIST [CONF_TARGET]
			l_item: EV_LIST_ITEM
			l_selected: BOOLEAN
		do
			if target_selection /= Void then
				target_selection.destroy
			end

			create target_selection
			create hb
			a_container.extend (hb)
			a_container.disable_item_expand (hb)
			target_selection.set_minimum_width (target_selection_width)
			hb.extend (target_selection)
			hb.disable_item_expand (target_selection)

			target_selection.disable_edit
			from
				l_targets := conf_system.target_order
				l_targets.start
			until
				l_targets.after
			loop
				create l_item.make_with_text (l_targets.item.name)
				target_selection.extend (l_item)
				l_item.select_actions.extend (agent target_selection_changed)
				if current_target /= Void and then l_item.text.is_equal (current_target.name) then
					l_item.enable_select
					l_selected := True
				end
				l_targets.forth
			end
			if not l_selected and not target_selection.is_empty then
				target_selection.remove_selection
				target_selection.first.enable_select
			end

			if l_targets.count = 1 then
				target_selection.disable_sensitive
			end

			create cl
			hb.extend (cl)
		end

	append_property_grid (a_container: EV_BOX) is
			-- Append layout for property grid.
		require
			a_container: a_container /= Void
			properties: properties /= Void
		local
			l_frame: EV_FRAME
		do
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			l_frame.extend (properties)
			a_container.extend (l_frame)
		end

	append_property_description (a_container: EV_BOX) is
			-- Append layout for property description.
		require
			a_container: a_container /= Void
			properties: properties /= Void
		local
			vb: EV_VERTICAL_BOX
			cl: EV_CELL
			l_frame: EV_FRAME
			l_label: EV_LABEL
		do
				-- property description
			create l_label
			properties.set_description_field (l_label)
			l_label.align_text_left
			create vb
			vb.set_minimum_height (description_height)
			vb.extend (l_label)
			vb.disable_item_expand (l_label)
			create cl
			vb.extend (cl)
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			l_frame.extend (vb)
			a_container.extend (l_frame)
			a_container.disable_item_expand (l_frame)
		end

	append_externals_tree (a_container: EV_BOX) is
			-- Append tree with externals.
		require
			current_target: current_target /= Void
			a_container: a_container /= Void
		local
			l_tree: EV_TREE
			l_frame: EV_FRAME
		do
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			a_container.extend (l_frame)
			create l_tree
			l_frame.extend (l_tree)

			add_externals (current_target.internal_external_include, l_tree, external_include_tree)
			add_externals (current_target.internal_external_object, l_tree, external_object_tree)
			add_externals (current_target.internal_external_make, l_tree, external_make_tree)
			add_externals (current_target.internal_external_resource, l_tree, external_resource_tree)
		end

	append_tasks_tree (a_container: EV_BOX) is
			-- Append tree with tasks.
		require
			current_target: current_target /= Void
			a_container: a_container /= Void
		local
			l_tree: EV_TREE
			l_frame: EV_FRAME
		do
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			a_container.extend (l_frame)
			create l_tree
			l_frame.extend (l_tree)

			add_tasks (current_target.internal_pre_compile_action, l_tree, task_pre_tree)
			add_tasks (current_target.internal_post_compile_action, l_tree, task_post_tree)
		end

	append_groups_tree (a_container: EV_BOX) is
			-- Append tree with groups.
		require
			a_container: a_container /= Void
		local
			l_tree: EV_TREE
			l_frame: EV_FRAME
			l_ht: HASH_TABLE [CONF_GROUP, STRING]
		do
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			a_container.extend (l_frame)
			create l_tree
			l_frame.extend (l_tree)

			add_groups (current_target.internal_clusters, l_tree, group_cluster_tree, pixmaps.icon_pixmaps.top_level_folder_clusters_icon)
			add_groups (current_target.internal_overrides, l_tree, group_override_tree, pixmaps.icon_pixmaps.top_level_folder_overrides_icon)
			add_groups (current_target.internal_libraries, l_tree, group_library_tree, pixmaps.icon_pixmaps.top_level_folder_library_icon)
			add_groups (current_target.internal_assemblies, l_tree, group_assembly_tree, pixmaps.icon_pixmaps.top_level_folder_references_icon)
			if current_target.internal_precompile /= Void then
				create l_ht.make (1)
				l_ht.force (current_target.precompile, current_target.precompile.name)
				add_groups (l_ht, l_tree,group_precompile_tree, pixmaps.icon_pixmaps.top_level_folder_library_icon)
			end

			l_tree.key_press_actions.extend (agent on_group_tree_key)
		end

	initialize_properties_system is
			-- Initialize `properties' for system settings.
		local
			l_string_prop: TEXT_PROPERTY [STRING]
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_choice_prop: CHOICE_PROPERTY [STRING_32]
			l_targ_ord: ARRAYED_LIST [CONF_TARGET]
			l_targets, l_targets_none: ARRAYED_LIST [STRING_32]
			l_osl_prop: LIST_PROPERTY
			l_target_dialog: TARGET_DIALOG
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

			l_targ_ord := conf_system.target_order
			create l_targets.make (l_targ_ord.count)
			from
				l_targ_ord.start
			until
				l_targ_ord.after
			loop
				l_targets.force (l_targ_ord.item.name)
				l_targ_ord.forth
			end

			l_targets_none := l_targets.twin
			l_targets_none.put_front ("")

			properties.add_section (section_general)

				-- name
			create l_string_prop.make (system_name_name)
			l_string_prop.set_description (system_name_description)
			l_string_prop.set_value (conf_system.name)
			l_string_prop.validate_value_actions.extend (agent is_not_void_or_empty ({STRING}?))
			l_string_prop.change_value_actions.extend (agent conf_system.set_name)
			properties.add_property (l_string_prop)

				-- description
			create l_mls_prop.make (system_description_name)
			l_mls_prop.enable_text_editing
			l_mls_prop.set_description (system_description_description)
			if conf_system.description /= Void then
				l_mls_prop.set_value (conf_system.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent conf_system.set_description))
			properties.add_property (l_mls_prop)

				-- library target
			create l_choice_prop.make_with_choices (system_library_target_name, l_targets_none)
			l_choice_prop.set_description (system_library_target_description)
			if conf_system.library_target /= Void then
				l_choice_prop.set_value (conf_system.library_target.name)
			end
			l_choice_prop.validate_value_actions.extend (agent check_library_target)
			l_choice_prop.change_value_actions.extend (agent simple_wrapper({STRING_32}?, agent conf_system.set_library_target_by_name))
			properties.add_property (l_choice_prop)

				-- uuid
			create l_string_prop.make (system_uuid_name)
			l_string_prop.set_description (system_uuid_description)
			l_string_prop.enable_readonly
			l_string_prop.set_value (conf_system.uuid.out)
			properties.add_property (l_string_prop)

				-- targets
			create l_target_dialog
			l_target_dialog.set_conf_system (conf_system)
			create l_osl_prop.make_with_dialog (system_targets_name, l_target_dialog)
			l_osl_prop.set_description (system_targets_description)
			l_osl_prop.set_value (l_targets)
			l_osl_prop.change_value_actions.extend (agent list_wrapper ({LIST [STRING_32]}?, agent conf_system.update_targets (?, conf_factory)))
			properties.add_property (l_osl_prop)

			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
		end

	initialize_properties_target_general is
			-- Initialize `properties' for general target settings.
		require
			current_target: current_target /= Void
		local
			l_string_prop: TEXT_PROPERTY [STRING_32]
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_choice_prop: CHOICE_PROPERTY [STRING_32]
			l_root_prop: DIALOG_PROPERTY [CONF_ROOT]
			l_version_prop: DIALOG_PROPERTY [CONF_VERSION]
			l_file_rule_prop: FILE_RULE_PROPERTY
			l_targ_ord: ARRAYED_LIST [CONF_TARGET]
			l_base_targets: ARRAYED_LIST [STRING_32]
			l_done: BOOLEAN
			l_root_dial: ROOT_DIALOG
			l_extends: BOOLEAN
			l_bool_prop: BOOLEAN_PROPERTY
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

				-- does `current_target' extend something?
			l_extends := current_target.extends /= Void

				-- general section
			properties.add_section (section_general)

				-- name
			create l_string_prop.make (target_name_name)
			l_string_prop.set_description (target_name_description)
			l_string_prop.set_value (current_target.name)
			l_string_prop.validate_value_actions.extend (agent check_target_name)
			l_string_prop.change_value_actions.extend   (agent simple_wrapper ({STRING_32}?, agent current_target.set_name))
			l_string_prop.change_value_actions.extend (agent refresh_target)
			properties.add_property (l_string_prop)

				-- description
			create l_mls_prop.make (target_description_name)
			l_mls_prop.set_description (target_description_description)
			l_mls_prop.enable_text_editing
			if current_target.description /= Void then
				l_mls_prop.set_value (current_target.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent current_target.set_description))
			properties.add_property (l_mls_prop)

				-- parent target
			l_targ_ord := conf_system.target_order
			create l_base_targets.make (l_targ_ord.count)
			from
				l_targ_ord.start
			until
				l_done or l_targ_ord.after
			loop
				l_done := l_targ_ord.item = current_target
				if not l_done then
					l_base_targets.force (l_targ_ord.item.name)
				end
				l_targ_ord.forth
			end
			if l_base_targets.count > 0 then
				l_base_targets.put_front ("")
				create l_choice_prop.make_with_choices (target_base_name, l_base_targets)
				l_choice_prop.set_description (target_base_description)
				if current_target.extends /= Void then
					l_choice_prop.set_value (current_target.extends.name)
				end
				l_choice_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent current_target.set_parent_by_name))
				properties.add_property (l_choice_prop)
			end

				-- compilation type
			create l_choice_prop.make_with_choices (target_compilation_type_name, <<target_compilation_type_standard, target_compilation_type_dotnet>>)
			l_choice_prop.set_description (target_company_description)
			l_choice_prop.disable_text_editing
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent update_inheritance_setting (s_msil_generation, l_choice_prop)))
			if current_target.setting_msil_generation then
				l_choice_prop.set_value (target_compilation_type_dotnet)
			else
				l_choice_prop.set_value (target_compilation_type_standard)
			end
			l_choice_prop.change_value_actions.put_front (agent set_compilation_mode)
			l_choice_prop.use_inherited_actions.extend (agent current_target.update_setting (s_msil_generation, Void))
			l_choice_prop.use_inherited_actions.extend (agent refresh)
			properties.add_property (l_choice_prop)

				-- output name
			create l_string_prop.make (target_executable_name)
			l_string_prop.set_description (target_executable_description)
			add_string_setting_actions (l_string_prop, s_executable_name, "")
			properties.add_property (l_string_prop)

				-- root
			create l_root_dial
			create l_root_prop.make_with_dialog (target_root_name, l_root_dial)
			l_root_prop.set_description (target_root_description)
			l_root_prop.set_refresh_action (agent current_target.root)
			l_root_prop.refresh
			l_root_prop.change_value_actions.extend (agent current_target.set_root)
			l_root_prop.change_value_actions.extend (agent update_inheritance_root (?, l_root_prop))
			l_root_prop.use_inherited_actions.extend (agent current_target.set_root (Void))
			l_root_prop.use_inherited_actions.extend (agent update_inheritance_root (Void, l_root_prop))
			update_inheritance_root (Void, l_root_prop)
			properties.add_property (l_root_prop)

				-- version
			create l_version_prop.make_with_dialog (target_version_name, create {VERSION_DIALOG})
			l_version_prop.set_description (target_version_description)
			l_version_prop.set_refresh_action (agent current_target.version)
			l_version_prop.refresh
			l_version_prop.change_value_actions.extend (agent current_target.set_version)
			l_version_prop.change_value_actions.extend (agent update_inheritance_version (?, l_version_prop))
			l_version_prop.use_inherited_actions.extend (agent current_target.set_version (Void))
			l_version_prop.use_inherited_actions.extend (agent update_inheritance_version (Void, l_version_prop))
			update_inheritance_version (Void, l_version_prop)
			properties.add_property (l_version_prop)

				-- file rules
			create l_file_rule_prop.make (target_file_rule_name)
			l_file_rule_prop.set_description (target_file_rule_description)
			l_file_rule_prop.set_refresh_action (agent current_target.file_rule)
			l_file_rule_prop.refresh
			l_file_rule_prop.change_value_actions.extend (agent current_target.set_file_rules)
			l_file_rule_prop.change_value_actions.extend (agent update_inheritance_file_rule (?, l_file_rule_prop))
			l_file_rule_prop.use_inherited_actions.extend (agent current_target.set_file_rules (create {ARRAYED_LIST [CONF_FILE_RULE]}.make (0)))
			l_file_rule_prop.use_inherited_actions.extend (agent update_inheritance_file_rule (Void, l_file_rule_prop))
			update_inheritance_file_rule (Void, l_file_rule_prop)
			properties.add_property (l_file_rule_prop)

			properties.current_section.expand

			add_misc_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)

			create l_bool_prop.make_with_value (target_line_generation_name, current_target.setting_line_generation)
			l_bool_prop.set_description (target_line_generation_description)
			add_boolean_setting_actions (l_bool_prop, s_line_generation, False)
			properties.add_property (l_bool_prop)
		ensure
			properties_not_void: properties /= Void
		end

	initialize_properties_target_assertions is
			-- Initialize `properties' for target assertion settings.
		require
			current_target_not_void: current_target /= Void
		local
			l_extends: BOOLEAN
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

				-- does `current_target' extend something?
			l_extends := current_target.extends /= Void

			add_assertion_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)
			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
		end

	initialize_properties_target_warning is
			-- Initialize `properties' for target warning settings.
		require
			current_target_not_void: current_target /= Void
		local
			l_extends: BOOLEAN
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

				-- does `current_target' extend something?
			l_extends := current_target.extends /= Void

			add_warning_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)
			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
		end

	initialize_properties_target_debugs is
			-- Initialize `properties' for target debug settings.
		require
			current_target_not_void: current_target /= Void
		local
			l_extends: BOOLEAN
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

				-- does `current_target' extend something?
			l_extends := current_target.extends /= Void

			add_debug_option_properties (current_target.changeable_internal_options, current_target.options, l_extends)
			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
		end

	initialize_properties_target_externals (an_external: CONF_EXTERNAL) is
			-- Initialize `properties' for externals target settings.
		require
			properties_not_void: properties /= Void
			an_external_not_void: an_external /= Void
		local
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_dir_prop: DIRECTORY_PROPERTY
			l_file_prop: FILE_PROPERTY
			l_dial: DIALOG_PROPERTY [CONF_CONDITION_LIST]
			l_prop: TEXT_PROPERTY [STRING_32]
		do
			current_external := an_external
			properties.reset

			properties.add_section (section_general)

				-- type
			create l_prop.make ("Type")
			if an_external.is_include then
				l_prop.set_value (external_include)
			elseif an_external.is_object then
				l_prop.set_value (external_object)
			elseif an_external.is_make then
				l_prop.set_value (external_make)
			elseif an_external.is_resource then
				l_prop.set_value (external_resource)
			else
				check should_not_read: False end
			end
			l_prop.enable_readonly
			properties.add_property (l_prop)

				-- location
			if an_external.is_include then
				create l_dir_prop.make (external_location_name)
				l_dir_prop.set_description (external_location_description)
				l_dir_prop.enable_text_editing
				l_dir_prop.set_value (an_external.location)
				l_dir_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?,  agent an_external.set_location))
				properties.add_property (l_dir_prop)
			else
				create l_file_prop.make (external_location_name)
				l_file_prop.set_description (external_location_description)
				l_file_prop.enable_text_editing
				l_file_prop.set_value (an_external.location)
				l_file_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?,  agent an_external.set_location))
				properties.add_property (l_file_prop)
			end

				-- description
			create l_mls_prop.make (external_description_name)
			l_mls_prop.set_description (external_description_description)
			l_mls_prop.enable_text_editing
			if an_external.description /= Void then
				l_mls_prop.set_value (an_external.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent an_external.set_description))
			properties.add_property (l_mls_prop)

				-- condition
			create l_dial.make_with_dialog (external_condition_name, create {CONDITION_DIALOG})
			l_dial.set_description (external_condition_description)
			l_dial.set_value (an_external.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent an_external.set_conditions)
			properties.add_property (l_dial)

			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
			current_external_set: current_external = an_external
		end

	initialize_properties_target_tasks (a_task: CONF_ACTION; a_name: STRING) is
			-- Initialize `properties' for task target settings.
		require
			properties_not_void: properties /= Void
			a_task_not_void: a_task /= Void
			a_name_valid: a_name /= Void and then (a_name.is_equal (task_pre_tree) or a_name.is_equal (task_post_tree))
		local
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_dir_prop: DIRECTORY_LOCATION_PROPERTY
			l_dial: DIALOG_PROPERTY [CONF_CONDITION_LIST]
			l_prop: TEXT_PROPERTY [STRING_32]
			l_bool_prop: BOOLEAN_PROPERTY
		do
			current_task := a_task
			properties.reset

			properties.add_section (section_general)

				-- type
			create l_prop.make ("Type")
			if a_name.is_equal (task_pre_tree) then
				l_prop.set_value (task_pre)
			else
				l_prop.set_value (task_post)
			end
			l_prop.enable_readonly
			properties.add_property (l_prop)

				-- command
			create l_prop.make (task_command_name)
			l_prop.set_description (task_command_description)
			l_prop.set_value (a_task.command)
			l_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent a_task.set_command))
			properties.add_property (l_prop)

				-- description
			create l_mls_prop.make (task_description_name)
			l_mls_prop.set_description (task_description_description)
			l_mls_prop.enable_text_editing
			if a_task.description /= Void then
				l_mls_prop.set_value (a_task.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent a_task.set_description))
			properties.add_property (l_mls_prop)

				-- working directory
			create l_dir_prop.make (task_working_directory_name)
			l_dir_prop.set_target (current_target)
			l_dir_prop.set_description (task_working_directory_description)
			if a_task.working_directory /= Void then
				l_dir_prop.set_value (a_task.working_directory.original_path)
			end
			l_dir_prop.enable_text_editing
			l_dir_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent update_working_directory (a_task, ?)))
			properties.add_property (l_dir_prop)

				-- must succeed
			create l_bool_prop.make_with_value (task_succeed_name, a_task.must_succeed)
			l_bool_prop.set_description (task_succeed_description)
			l_bool_prop.change_value_actions.extend (agent a_task.set_must_succeed)
			properties.add_property (l_bool_prop)

				-- condition
			create l_dial.make_with_dialog (task_condition_name, create {CONDITION_DIALOG})
			l_dial.set_description (task_condition_description)
			l_dial.set_value (a_task.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent a_task.set_conditions)
			properties.add_property (l_dial)

			properties.current_section.expand
		ensure
			properties_not_void: properties /= Void
			current_task_set: current_task = a_task
		end

	initialize_properties_target_groups (a_group: CONF_GROUP) is
			-- Initialize `properties' for groups target settings.
		require
			properties_not_void: properties /= Void
			edit_library_button_not_void: edit_library_button /= Void
			a_group_not_void: a_group /= Void
		local
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_text_prop: TEXT_PROPERTY [STRING]
			l_dial: DIALOG_PROPERTY [CONF_CONDITION_LIST]
			l_bool_prop: BOOLEAN_PROPERTY
			l_dir_prop: DIRECTORY_LOCATION_PROPERTY
			l_file_prop: FILE_LOCATION_PROPERTY
			l_override: CONF_OVERRIDE
			l_cluster: CONF_CLUSTER
			l_assembly: CONF_ASSEMBLY
			l_library: CONF_LIBRARY
			l_file_rule_prop: FILE_RULE_PROPERTY
			l_list_prop: LIST_PROPERTY
			l_deps: DS_HASH_SET [CONF_GROUP]
			l_deps_list: ARRAYED_LIST [STRING_32]
			l_dep_dialog: DEPENDENCY_DIALOG
			l_over: ARRAYED_LIST [CONF_GROUP]
			l_over_list: ARRAYED_LIST [STRING_32]
			l_over_dialog: OVERRIDE_DIALOG
			l_rename_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [STRING, STRING]]
			l_mapping_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [STRING, STRING]]
			l_class_opt_prop: DIALOG_PROPERTY [HASH_TABLE [CONF_OPTION, STRING]]
			l_class_opt_dial: CLASS_OPTION_DIALOG
			l_vis_prop: DIALOG_PROPERTY [EQUALITY_HASH_TABLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]], STRING]]
			l_vis_dial: VISIBLE_DIALOG
			l_visible: CONF_VISIBLE
			l_expanded: HASH_TABLE [BOOLEAN, STRING]
		do
			current_group := a_group
			properties.reset

			edit_library_button.hide
			edit_library_button.select_actions.wipe_out

			properties.add_section (section_general)

				-- type
			create l_text_prop.make (group_type_name)
			l_text_prop.set_description (group_type_description)
			if a_group.is_override then
				l_text_prop.set_value (group_override)
				l_override ?= a_group
				l_cluster := l_override
				l_visible := l_cluster
			elseif a_group.is_cluster then
				l_text_prop.set_value (group_cluster)
				l_cluster ?= a_group
				l_visible := l_cluster
			elseif a_group.is_library then
				l_text_prop.set_value (group_library)
				l_library ?= a_group
				l_visible := l_library
				edit_library_button.show
				edit_library_button.disable_sensitive
				if not l_library.is_readonly then
					edit_library_button.enable_sensitive
					edit_library_button.select_actions.extend (agent edit_configuration (l_library.location.evaluated_path))
				end
			elseif a_group.is_assembly then
				l_text_prop.set_value (group_assembly)
				l_assembly ?= a_group
			else
				check should_not_reach: False end
			end
			l_text_prop.enable_readonly
			properties.add_property (l_text_prop)

				-- name
			create l_text_prop.make (group_name_name)
			l_text_prop.set_description (group_name_description)
			l_text_prop.set_value (a_group.name)
			l_text_prop.change_value_actions.extend (agent a_group.set_name)
			l_text_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING}?, agent refresh))
			properties.add_property (l_text_prop)

				-- description
			create l_mls_prop.make (group_description_name)
			l_mls_prop.set_description (group_description_description)
			l_mls_prop.enable_text_editing
			if a_group.description /= Void then
				l_mls_prop.set_value (a_group.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent a_group.set_description))
			properties.add_property (l_mls_prop)

				-- readonly
			create l_bool_prop.make_with_value (group_readonly_name, a_group.internal_read_only)
			l_bool_prop.set_description (group_readonly_description)
			l_bool_prop.change_value_actions.extend (agent a_group.set_readonly)
			properties.add_property (l_bool_prop)

				-- location
			if a_group.is_cluster then
				create l_dir_prop.make (group_location_name)
				l_dir_prop.set_target (current_target)
				l_dir_prop.set_description (group_location_description)
				l_dir_prop.set_value (a_group.location.original_path)
				l_dir_prop.change_value_actions.extend (agent update_group_location (a_group, ?))
				properties.add_property (l_dir_prop)
			else
				create l_file_prop.make (group_location_name)
				l_file_prop.set_target (current_target)
				l_file_prop.set_description (group_location_description)
				l_file_prop.set_value (a_group.location.original_path)
				l_file_prop.change_value_actions.extend (agent update_group_location (a_group, ?))
				properties.add_property (l_file_prop)
			end

				-- options
			if not a_group.is_assembly then
				add_misc_option_properties (a_group.changeable_internal_options, a_group.options, True)
				add_assertion_option_properties (a_group.changeable_internal_options, a_group.options, True)
				add_warning_option_properties (a_group.changeable_internal_options, a_group.options, True)
				add_debug_option_properties (a_group.changeable_internal_options, a_group.options, True)
			end

			properties.add_section (section_advanced)

				-- condition
			create l_dial.make_with_dialog (group_condition_name, create {CONDITION_DIALOG})
			l_dial.set_description (group_condition_description)
			l_dial.set_value (a_group.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent a_group.set_conditions)
			properties.add_property (l_dial)


				-- prefix
			create l_text_prop.make (group_prefix_name)
			l_text_prop.set_description (group_prefix_description)
			l_text_prop.set_value (a_group.name_prefix)
			l_text_prop.change_value_actions.extend (agent a_group.set_name_prefix)
			properties.add_property (l_text_prop)

				-- renaming
			create l_rename_prop.make_with_dialog (group_renaming_name, create {RENAMING_DIALOG})
			l_rename_prop.set_description (group_renaming_description)
			l_rename_prop.set_display_agent (agent output_renaming)
			if a_group.renaming /= Void then
				l_rename_prop.set_value (a_group.renaming)
			end
			l_rename_prop.change_value_actions.extend (agent a_group.set_renaming)
			properties.add_property (l_rename_prop)

				-- class options
			if not a_group.is_assembly then
				create l_class_opt_dial
				l_class_opt_dial.set_group_options (a_group.options)
				create l_class_opt_prop.make_with_dialog (group_class_option_name, l_class_opt_dial)
				l_class_opt_prop.set_description (group_class_option_description)
				l_class_opt_prop.set_display_agent (agent output_class_options)
				if a_group.class_options /= Void then
					l_class_opt_prop.set_value (a_group.class_options)
				end
				l_class_opt_prop.change_value_actions.extend (agent a_group.set_class_options)
				properties.add_property (l_class_opt_prop)
			end

			if l_override /= Void then
					-- overrides
				l_over := l_override.override
				if l_over /= Void then
					from
						create l_over_list.make (l_over.count)
						l_over.start
					until
						l_over.after
					loop
						l_over_list.force (l_over.item.name)
						l_over.forth
					end
				end
				create l_over_dialog
				l_over_dialog.set_conf_target (current_target)
				create l_list_prop.make_with_dialog (override_override_name, l_over_dialog)
				l_list_prop.set_description (override_override_description)
				l_list_prop.set_value (l_over_list)
				l_list_prop.change_value_actions.extend (agent update_overrides (l_override, ?))
				properties.add_property (l_list_prop)
			end

			if l_cluster /= Void then
					-- recursive
				create l_bool_prop.make_with_value (cluster_recursive_name, l_cluster.is_recursive)
				l_bool_prop.set_description (cluster_recursive_description)
				l_bool_prop.change_value_actions.extend (agent l_cluster.set_recursive)
				properties.add_property (l_bool_prop)

					-- file rules
				create l_file_rule_prop.make (cluster_file_rule_name)
				l_file_rule_prop.set_description (cluster_file_rule_description)
				l_file_rule_prop.set_refresh_action (agent l_cluster.file_rule)
				l_file_rule_prop.refresh
				l_file_rule_prop.change_value_actions.extend (agent l_cluster.set_file_rule)
				l_file_rule_prop.change_value_actions.extend (agent update_inheritance_file_rule_cluster (?, l_file_rule_prop))
				l_file_rule_prop.use_inherited_actions.extend (agent l_cluster.set_file_rule (create {ARRAYED_LIST [CONF_FILE_RULE]}.make (0)))
				l_file_rule_prop.use_inherited_actions.extend (agent update_inheritance_file_rule_cluster (Void, l_file_rule_prop))
				update_inheritance_file_rule (Void, l_file_rule_prop)
				properties.add_property (l_file_rule_prop)

					-- dependencies
				l_deps := l_cluster.dependencies
				if l_deps /= Void then
					from
						create l_deps_list.make (l_deps.count)
						l_deps.start
					until
						l_deps.after
					loop
						l_deps_list.force (l_deps.item_for_iteration.name)
						l_deps.forth
					end
				end
				create l_dep_dialog
				l_dep_dialog.set_conf_target (current_target)
				create l_list_prop.make_with_dialog (cluster_dependencies_name, l_dep_dialog)
				l_list_prop.set_description (cluster_dependencies_description)
				l_list_prop.set_value (l_deps_list)
				l_list_prop.change_value_actions.extend (agent update_dependencies (l_cluster, ?))
				properties.add_property (l_list_prop)

					-- mapping
				create l_mapping_prop.make_with_dialog (cluster_mapping_name, create {RENAMING_DIALOG})
				l_mapping_prop.set_description (cluster_mapping_description)
				l_mapping_prop.set_display_agent (agent output_renaming)
				if l_cluster.mapping /= Void then
					l_mapping_prop.set_value (l_cluster.mapping)
				end
				l_mapping_prop.change_value_actions.extend (agent l_cluster.set_mapping)
				properties.add_property (l_mapping_prop)
			elseif l_assembly /= Void then
					-- assembly culture
				create l_text_prop.make (assembly_name_name)
				l_text_prop.set_description (assembly_name_description)
				l_text_prop.set_value (l_assembly.assembly_name)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_name)
				properties.add_property (l_text_prop)

					-- assembly culture
				create l_text_prop.make (assembly_culture_name)
				l_text_prop.set_description (assembly_culture_description)
				l_text_prop.set_value (l_assembly.assembly_culture)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_culture)
				properties.add_property (l_text_prop)

					-- assembly version
				create l_text_prop.make (assembly_version_name)
				l_text_prop.set_description (assembly_version_description)
				l_text_prop.set_value (l_assembly.assembly_version)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_version)
				properties.add_property (l_text_prop)

					-- assembly public key token
				create l_text_prop.make (assembly_public_key_token_name)
				l_text_prop.set_description (assembly_public_key_token_description)
				l_text_prop.set_value (l_assembly.assembly_public_key_token)
				l_text_prop.change_value_actions.extend (agent l_assembly.set_assembly_public_key)
				properties.add_property (l_text_prop)
			end

			if l_visible /= Void then
					-- visible
				create l_vis_dial
				create l_vis_prop.make_with_dialog (cluster_visible_name, l_vis_dial)
				l_vis_prop.set_description (cluster_visible_description)
				l_vis_prop.set_display_agent (agent output_visible)
				l_vis_prop.set_value (l_visible.visible)
				l_vis_prop.change_value_actions.extend (agent l_visible.set_visible)
				properties.add_property (l_vis_prop)
			end

			if group_section_expanded_status.has (a_group.name) then
				l_expanded := group_section_expanded_status.found_item
			else
				create l_expanded.make (5)
				l_expanded.force (True, section_general)
				l_expanded.force (True, section_assertions)
				l_expanded.force (True, section_warning)
				l_expanded.force (True, section_debug)
				l_expanded.force (False, section_advanced)
				group_section_expanded_status.force (l_expanded, a_group.name)
			end
			properties.set_expanded_section_store (l_expanded)
		ensure
			properties_not_void: properties /= Void
			current_group_set: current_group = a_group
		end

	initialize_properties_target_advanced is
			-- Initialize `properties' for advanced target settings.
		require
			current_target: current_target /= Void
		local
			l_string_prop: TEXT_PROPERTY [STRING_32]
			l_choice_prop: CHOICE_PROPERTY [STRING_32]
			l_extends: BOOLEAN
			l_bool_prop: BOOLEAN_PROPERTY
			l_pf_choices: ARRAYED_LIST [STRING_32]
			l_dir_prop: DIRECTORY_PROPERTY
			l_file_prop: FILE_PROPERTY
			l_installed_runtimes: DS_LINEAR [STRING]
			l_il_env: IL_ENVIRONMENT
			l_il_choices: ARRAYED_LIST [STRING_32]
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

				-- does `current_target' extend something?
			l_extends := current_target.extends /= Void

			properties.add_section (section_advanced)

			create l_bool_prop.make_with_value (target_address_expression_name, current_target.setting_address_expression)
			l_bool_prop.set_description (target_address_expression_description)
			add_boolean_setting_actions (l_bool_prop, s_address_expression, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_check_vape_name, current_target.setting_check_vape)
			l_bool_prop.set_description (target_check_vape_description)
			add_boolean_setting_actions (l_bool_prop, s_check_vape, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_console_application_name, current_target.setting_console_application)
			l_bool_prop.set_description (target_console_application_description)
			add_boolean_setting_actions (l_bool_prop, s_console_application, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_dead_code_removal_name, current_target.setting_dead_code_removal)
			l_bool_prop.set_description (target_dead_code_removal_description)
			add_boolean_setting_actions (l_bool_prop, s_dead_code_removal, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_dynamic_runtime_name, current_target.setting_dynamic_runtime)
			l_bool_prop.set_description (target_dynamic_runtime_description)
			add_boolean_setting_actions (l_bool_prop, s_dynamic_runtime, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_exception_trace_name, current_target.setting_exception_trace)
			l_bool_prop.set_description (s_exception_trace)
			add_boolean_setting_actions (l_bool_prop, s_exception_trace, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_inlining_name, current_target.setting_inlining)
			l_bool_prop.set_description (target_inlining_description)
			add_boolean_setting_actions (l_bool_prop, s_inlining, False)
			properties.add_property (l_bool_prop)

			create l_string_prop.make (target_inlining_size_name)
			l_string_prop.set_description (target_inlining_size_description)
			add_string_setting_actions (l_string_prop, s_inlining_size, "")
			l_string_prop.validate_value_actions.extend (agent valid_inlining_size)
			properties.add_property (l_string_prop)

			create l_bool_prop.make_with_value (target_multithreaded_name, current_target.setting_multithreaded)
			l_bool_prop.set_description (target_multithreaded_description)
			add_boolean_setting_actions (l_bool_prop, s_multithreaded, False)
			properties.add_property (l_bool_prop)

			create l_bool_prop.make_with_value (target_old_verbatim_strings_name, current_target.setting_old_verbatim_strings)
			l_bool_prop.set_description (target_old_verbatim_strings_description)
			add_boolean_setting_actions (l_bool_prop, s_old_verbatim_strings, False)
			properties.add_property (l_bool_prop)

			create l_pf_choices.make (platform_names.count + 1)
			l_pf_choices.extend ("")
			from
				platform_names.start
			until
				platform_names.after
			loop
				l_pf_choices.extend (platform_names.item_for_iteration.as_lower)
				platform_names.forth
			end
			create l_choice_prop.make_with_choices (target_platform_name, l_pf_choices)
			l_choice_prop.set_description (target_platform_description)
			l_choice_prop.set_value (current_target.setting_platform)
			add_string_setting_actions (l_choice_prop, s_platform, "")
			properties.add_property (l_choice_prop)

			create l_string_prop.make (target_shared_library_definition_name)
			l_string_prop.set_description (target_shared_library_definition_description)
			add_string_setting_actions (l_string_prop, s_shared_library_definition, "")
			properties.add_property (l_string_prop)

			properties.current_section.expand

				-- .NET section
			if current_target.setting_msil_generation then
				properties.add_section (section_dotnet)

				create l_bool_prop.make_with_value (target_msil_use_optimized_precompile_name, current_target.setting_msil_use_optimized_precompile)
				l_bool_prop.set_description (target_msil_use_optimized_precompile_description)
				add_boolean_setting_actions (l_bool_prop, s_msil_use_optimized_precompile, False)
				properties.add_property (l_bool_prop)

				create l_bool_prop.make_with_value (target_use_cluster_name_as_namespace_name, current_target.setting_use_cluster_name_as_namespace)
				l_bool_prop.set_description (target_use_cluster_name_as_namespace_description)
				add_boolean_setting_actions (l_bool_prop, s_use_cluster_name_as_namespace, True)
				properties.add_property (l_bool_prop)

				create l_bool_prop.make_with_value (target_use_all_cluster_name_as_namespace_name, current_target.setting_use_all_cluster_name_as_namespace)
				l_bool_prop.set_description (target_use_all_cluster_name_as_namespace_description)
				add_boolean_setting_actions (l_bool_prop, s_use_all_cluster_name_as_namespace, True)
				properties.add_property (l_bool_prop)

				create l_bool_prop.make_with_value (target_dotnet_naming_convention_name, current_target.setting_dotnet_naming_convention)
				l_bool_prop.set_description (target_dotnet_naming_convention_description)
				add_boolean_setting_actions (l_bool_prop, s_dotnet_naming_convention, False)
				properties.add_property (l_bool_prop)

				create l_bool_prop.make_with_value (target_il_verifiable_name, current_target.setting_il_verifiable)
				l_bool_prop.set_description (target_il_verifiable_description)
				add_boolean_setting_actions (l_bool_prop, s_il_verifiable, True)
				properties.add_property (l_bool_prop)

				create l_bool_prop.make_with_value (target_cls_compliant_name, current_target.setting_cls_compliant)
				l_bool_prop.set_description (target_cls_compliant_description)
				add_boolean_setting_actions (l_bool_prop, s_cls_compliant, False)
				properties.add_property (l_bool_prop)

				create l_dir_prop.make (target_metadata_cache_path_name)
				l_dir_prop.set_description (target_metadata_cache_path_description)
				add_string_setting_actions (l_dir_prop, s_metadata_cache_path, "")
				properties.add_property (l_dir_prop)

				create l_string_prop.make (target_msil_classes_per_module_name)
				l_string_prop.set_description (target_msil_classes_per_module_description)
				add_string_setting_actions (l_string_prop, s_msil_classes_per_module, "")
				l_string_prop.validate_value_actions.extend (agent valid_classes_per_module)
				properties.add_property (l_string_prop)

				create l_il_env
				l_installed_runtimes := l_il_env.installed_runtimes
				create l_il_choices.make (l_installed_runtimes.count)
				from
					l_installed_runtimes.start
				until
					l_installed_runtimes.after
				loop
					l_il_choices.put_right (l_installed_runtimes.item_for_iteration)
					l_installed_runtimes.forth
				end
				create l_choice_prop.make_with_choices (target_msil_clr_version_name, l_il_choices)

				l_choice_prop.set_description (target_msil_clr_version_description)
				add_string_setting_actions (l_choice_prop, s_msil_clr_version, "")
				properties.add_property (l_choice_prop)

				create l_choice_prop.make_with_choices (target_msil_generation_type_name, <<"exe", "dll">>)
				l_choice_prop.set_description (target_msil_generation_type_description)
				add_string_setting_actions (l_choice_prop, s_msil_generation_type, "")
				properties.add_property (l_choice_prop)

				create l_file_prop.make (target_msil_key_file_name_name)
				l_file_prop.set_description (target_msil_key_file_name_description)
				add_string_setting_actions (l_file_prop, s_msil_key_file_name, "")
				properties.add_property (l_file_prop)

				properties.current_section.expand
			end

		ensure
			properties_not_void: properties /= Void
		end

	add_externals (a_externals: ARRAYED_LIST [CONF_EXTERNAL]; a_tree: EV_TREE; a_name: STRING) is
			-- Add `a_externals' to `a_tree' under a header with `a_name'.
		require
			a_tree: a_tree /= Void
		local
			l_head_item, l_item: EV_TREE_ITEM
			l_ext_item: CONF_EXTERNAL
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create l_head_item.make_with_text (a_name)
				a_tree.extend (l_head_item)
				from
					a_externals.start
				until
					a_externals.after
				loop
					l_ext_item := a_externals.item
					create l_item.make_with_text (l_ext_item.location)
					l_item.set_data (l_ext_item)
					l_item.select_actions.extend (agent initialize_properties_target_externals (l_ext_item))
					l_head_item.extend (l_item)
					if l_ext_item = current_external then
						l_item.enable_select
					end
					a_externals.forth
				end
				l_head_item.expand
			end
		end

	add_tasks (a_tasks: ARRAYED_LIST [CONF_ACTION]; a_tree: EV_TREE; a_name: STRING) is
			-- Add `a_tasks' to `a_tree' under a header with `a_name'.
		require
			a_tree: a_tree /= Void
		local
			l_head_item, l_item: EV_TREE_ITEM
			l_task: CONF_ACTION
		do
			if a_tasks /= Void and then not a_tasks.is_empty then
				create l_head_item.make_with_text (a_name)
				a_tree.extend (l_head_item)
				from
					a_tasks.start
				until
					a_tasks.after
				loop
					l_task := a_tasks.item
					create l_item.make_with_text (l_task.command)
					l_item.set_data (l_task)
					l_item.select_actions.extend (agent initialize_properties_target_tasks (l_task, a_name))
					l_head_item.extend (l_item)
					if l_task = current_task then
						l_item.enable_select
					end
					a_tasks.forth
				end
				l_head_item.expand
			end
		end

	add_groups (a_groups: HASH_TABLE [CONF_GROUP, STRING]; a_tree: EV_TREE; a_name: STRING; a_head_pix: EV_PIXMAP) is
			-- Add `a_groups' to `a_tree' under a header with `a_name'.
		require
			a_tree: a_tree /= Void
		local
			l_head_item, l_item: EV_TREE_ITEM
			l_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create l_head_item.make_with_text (a_name)
				l_head_item.set_pixmap (a_head_pix)
				a_tree.extend (l_head_item)
				from
					a_groups.start
				until
					a_groups.after
				loop
					l_group := a_groups.item_for_iteration
					l_cluster ?= l_group
					if l_cluster = Void or else l_cluster.parent = Void then
						create l_item.make_with_text (l_group.name)
						l_item.set_data (l_group)
						l_item.select_actions.extend (agent initialize_properties_target_groups (l_group))
						l_head_item.extend (l_item)
						if l_cluster /= Void then
							append_children (l_cluster.children, l_item)
						end
						if l_group = current_group then
							l_item.enable_select
						end
						l_item.set_pixmap (pixmap_from_group (l_group))
					end
					a_groups.forth
				end
			end
		end

	append_children (a_children: ARRAYED_LIST [CONF_CLUSTER]; a_parent: EV_TREE_ITEM) is
			-- Append `a_children' to `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
		local
			l_item: EV_TREE_ITEM
			l_cluster: CONF_CLUSTER
		do
			if a_children /= Void and then not a_children.is_empty then
				from
					a_children.start
				until
					a_children.after
				loop
					l_cluster := a_children.item
					create l_item.make_with_text (l_cluster.name)
					l_item.set_data (l_cluster)
					l_item.select_actions.extend (agent initialize_properties_target_groups (l_cluster))
					a_parent.extend (l_item)
					append_children (l_cluster.children, l_item)
					l_item.set_pixmap (pixmap_from_group (l_cluster))
					a_children.forth
				end
				a_parent.expand
			end
		end

feature {NONE} -- Configuration setting

	add_cluster is
			-- Add a new cluster.
		local
			dial: CREATE_CLUSTER_DIALOG
		do
			create dial.make (current_target, conf_factory)
			dial.show_modal_to_window (Current)
			if dial.is_ok then
				refresh
			end
		end

	add_override is
			-- Add a new override cluster.
		local
			dial: CREATE_OVERRIDE_DIALOG
		do
			create dial.make (current_target, conf_factory)
			dial.show_modal_to_window (Current)
			if dial.is_ok then
				refresh
			end
		end

	add_library is
			-- Add a new library.
		require
			current_target_set: current_target /= Void
		local
			dial: CREATE_LIBRARY_DIALOG
		do
			create dial.make (current_target, conf_factory)
			dial.show_modal_to_window (Current)
			if dial.is_ok then
				refresh
			end
		end

	add_assembly is
			-- Add a new assembly.
		local
			dial: CREATE_ASSEMBLY_DIALOG
		do
			create dial.make (current_target, conf_factory)
			dial.show_modal_to_window (Current)
			if dial.is_ok then
				refresh
			end
		end

	on_group_tree_key (a_key: EV_KEY) is
			-- Button was pressed while we are in the group tree.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_delete then
				remove_group
			end
		end

	remove_group is
			-- Remove currently selected group.
		local
			cd: EV_CONFIRMATION_DIALOG
		do
			if current_group /= Void then
				create cd.make_with_text_and_actions ("Are you sure you want to remove "+current_group.name+"?", <<agent remove_group_conf (current_group)>>)
				cd.show_modal_to_window (Current)
			end
		end

	remove_group_conf (a_group: CONF_GROUP) is
			-- Remove `a_group' from the configuration.
		require
			a_group_not_void: a_group /= Void
			current_target_not_void: current_target /= Void
		local
			l_name: STRING
		do
			l_name := a_group.name
			if a_group.is_override then
				current_target.remove_override (l_name)
			elseif a_group.is_cluster then
				current_target.remove_cluster (l_name)
			elseif a_group.is_library then
				current_target.remove_library (l_name)
			elseif a_group.is_assembly then
				current_target.remove_assembly (l_name)
			else
				check should_not_reach: False end
			end
			refresh
		end

	set_compilation_mode (a_mode: STRING_32) is
			-- Set settings for `a_mode'.
		require
			current_target_not_void: current_target /= Void
			a_mode_ok: a_mode /= Void implies a_mode.is_equal (target_compilation_type_standard) or a_mode.is_equal (target_compilation_type_dotnet)
		do
			if a_mode = Void then
				current_target.update_setting (s_msil_generation, Void)
			elseif a_mode.is_equal (target_compilation_type_standard) then
				if current_target.internal_settings.has (s_msil_generation) then
					current_target.update_setting (s_msil_generation, "")
				else
					current_target.update_setting (s_msil_generation, "false")
				end
			else
				current_target.update_setting (s_msil_generation, "true")
			end
		end

	set_boolean_setting (a_name: STRING; a_default: BOOLEAN; a_value: BOOLEAN) is
			-- Set a boolean setting with `a_name' to `a_value'.
		require
			a_name_valid: valid_setting (a_name)
			current_target: current_target /= Void
		do
			if current_target.extends = Void and then a_value = a_default and current_target.internal_settings.has (a_name) then
				current_target.update_setting (a_name, "")
			else
				current_target.update_setting (a_name, a_value.out)
			end
		end

	set_string_setting (a_name: STRING; a_default: STRING; a_value: STRING) is
			-- Set a string setting with `a_name' to `a_value'.
		require
			a_name_valid: valid_setting (a_name)
			current_target: current_target /= Void
		do
			if current_target.extends = Void and then equal (a_value, a_default) and current_target.internal_settings.has (a_name) then
				current_target.update_setting (a_name, Void)
			else
				current_target.update_setting (a_name, a_value)
			end
		end

	new_external is
			-- Add a new external.
		local
			l_dia: NEW_EXTERNAL_DIALOG
			l_new_include: CONF_EXTERNAL_INCLUDE
			l_new_object: CONF_EXTERNAL_OBJECT
			l_new_make: CONF_EXTERNAL_MAKE
			l_new_resource: CONF_EXTERNAL_RESOURCE
		do
			create l_dia
			l_dia.show_modal_to_window (Current)
			if l_dia.is_ok then
				if l_dia.is_include then
					l_new_include := conf_factory.new_external_include ("new")
					current_target.add_external_include (l_new_include)
					current_external := l_new_include
				elseif l_dia.is_object then
					l_new_object := conf_factory.new_external_object ("new")
					current_target.add_external_object (l_new_object)
					current_external := l_new_object
				elseif l_dia.is_make then
					l_new_make := conf_factory.new_external_make ("new")
					current_target.add_external_make (l_new_make)
					current_external := l_new_make
				elseif l_dia.is_resource then
					l_new_resource := conf_factory.new_external_resource ("new")
					current_target.add_external_resource (l_new_resource)
					current_external := l_new_resource
				else
					check should_not_reach: False end
				end
				show_properties_target_externals
			end
		end

	remove_external is
			-- Remove an external.
		require
			current_target: current_target /= Void
		local
			l_include: CONF_EXTERNAL_INCLUDE
			l_object: CONF_EXTERNAL_OBJECT
			l_make: CONF_EXTERNAL_MAKE
			l_resource: CONF_EXTERNAL_RESOURCE
		do
			if current_external /= Void then
				if current_external.is_include then
					l_include ?= current_external
					check include: l_include /= Void end
					current_target.remove_external_include (l_include)
				elseif current_external.is_object then
					l_object ?= current_external
					check object: l_object /= Void end
					current_target.remove_external_object (l_object)
				elseif current_external.is_make then
					l_make ?= current_external
					check make: l_make /= Void end
					current_target.remove_external_make (l_make)
				elseif current_external.is_resource then
					l_resource ?= current_external
					check resoucre: l_resource /= Void end
					current_target.remove_external_resource (l_resource)
				end
				show_properties_target_externals
			end
		end

	new_task is
			-- Add a new task.
		local
			l_dia: NEW_TASK_DIALOG
		do
			create l_dia
			l_dia.show_modal_to_window (Current)
			if l_dia.is_ok then
				current_task := conf_factory.new_action ("new", False, Void)
				if l_dia.is_pre then
					current_target.add_pre_compile (current_task)
				elseif l_dia.is_post then
					current_target.add_post_compile (current_task)
				else
					check should_not_reach: False end
				end
				show_properties_target_tasks
			end
		end

	remove_task is
			-- Remove a task.
		require
			current_target: current_target /= Void
		do
			if current_task /= Void then
				if current_target.pre_compile_action.has (current_task) then
					current_target.remove_pre_action (current_task)
				elseif current_target.post_compile_action.has (current_task) then
					current_target.remove_post_action (current_task)
				else
					check should_not_reach: False end
				end
				show_properties_target_tasks
			end
		end

	add_variable is
			-- Add a new variable.
		require
			current_target: current_target /= Void
		do
			if not current_target.variables.has ("new") then
				current_target.add_variable ("new", "new_value")
				show_properties_target_variables
			end
		end

	remove_variable is
			-- Remove a variable.
		require
			current_target: current_target /= Void
			variables: grid /= Void
		local
			l_item: TEXT_PROPERTY [STRING]
		do
			if grid.selected_rows /= Void and then not grid.selected_rows.is_empty then
				l_item ?= grid.selected_rows.first.item (1)
				check
					valid_item: l_item /= Void
				end
				current_target.remove_variable (l_item.value)
				show_properties_target_variables
			end
		end

	update_variable_key (an_old_key: STRING; a_new_key: STRING) is
			-- Update key part of a variable.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			an_old_key_valid: current_target.variables.has (an_old_key)
		do
			if a_new_key /= Void and then not a_new_key.is_empty then
				current_target.variables.replace_key (a_new_key.as_lower, an_old_key)
			end
			show_properties_target_variables
		end

	update_variable_value (a_key: STRING; a_value: STRING) is
			-- Update value part of a variable.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			a_key_valid: current_target.variables.has (a_key)
		do
			if a_value /= Void and then not a_value.is_empty then
				current_target.update_variable (a_key, a_value)
			end
			show_properties_target_variables
		end

	add_mapping is
			-- Add a new mapping.
		require
			current_target: current_target /= Void
		do
			if not current_target.mapping.has ("new") then
				current_target.add_mapping ("new", "new_value")
				show_properties_target_mapping
			end
		end

	remove_mapping is
			-- Remove a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
		local
			l_item: TEXT_PROPERTY [STRING]
		do
			if grid.selected_rows /= Void and then not grid.selected_rows.is_empty then
				l_item ?= grid.selected_rows.first.item (1)
				check
					valid_item: l_item /= Void
				end
				current_target.remove_mapping (l_item.text)
				show_properties_target_mapping
			end
		end

	update_mapping_key (an_old_key: STRING; a_new_key: STRING) is
			-- Update key part of a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			an_old_key_valid: current_target.mapping.has (an_old_key)
		do
			if a_new_key /= Void and then not a_new_key.is_empty then
				current_target.mapping.replace_key (a_new_key.as_upper, an_old_key)
			end
			show_properties_target_mapping
		end

	update_mapping_value (a_key: STRING; a_value: STRING) is
			-- Update value part of a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			a_key_valid: current_target.mapping.has (a_key)
		do
			if a_value /= Void and then not a_value.is_empty then
				current_target.add_mapping (a_key, a_value.as_upper)
			end
			show_properties_target_mapping
		end

	update_working_directory (a_task: CONF_ACTION; a_value: STRING) is
			-- Update working directory of `a_task' to `a_value'.
		require
			a_task_not_void: a_task /= Void
			current_target_not_void: current_target /= Void
		do
			if a_value = Void or else a_value.is_empty then
				a_task.set_working_directory (Void)
			else
				a_task.set_working_directory (conf_factory.new_location_from_path (a_value, current_target))
			end
		end

	update_group_location (a_group: CONF_GROUP; a_location: STRING_32) is
			-- Update location of `a_group' to be `a_location'.
		require
			a_group: a_group /= Void
			current_target: current_target /= Void
		local
			l_location: CONF_LOCATION
		do
			if a_location /= Void and then not a_location.is_empty then
				if a_group.is_cluster then
					create {CONF_DIRECTORY_LOCATION}l_location.make (a_location, current_target)
				elseif a_group.is_assembly then
					create {CONF_FILE_LOCATION}l_location.make (a_location, current_target)
				elseif a_group.is_library then
					create {CONF_FILE_LOCATION}l_location.make (a_location, current_target)
				end
				a_group.set_location (l_location)
			end
		end

	update_dependencies (a_cluster: CONF_CLUSTER; a_dependencies: LIST [STRING_32]) is
			-- Update dependencies of `a_cluster'.
		require
			current_target_not_void: current_target /= Void
		local
			l_grps: HASH_TABLE [CONF_GROUP, STRING]
		do
			a_cluster.set_dependencies (Void)
			if a_dependencies /= Void and then not a_dependencies.is_empty then
				from
					l_grps := current_target.groups
					a_dependencies.start
				until
					a_dependencies.after
				loop
					a_cluster.add_dependency (l_grps.item (a_dependencies.item))
					a_dependencies.forth
				end
			end
		end

	update_overrides (an_override: CONF_OVERRIDE; an_overriding: LIST [STRING_32]) is
			-- Update groups we override of `a_cluster'.
		require
			current_target_not_void: current_target /= Void
		local
			l_grps: HASH_TABLE [CONF_GROUP, STRING]
		do
			an_override.set_override (Void)
			if an_overriding /= Void and then not an_overriding.is_empty then
				from
					l_grps := current_target.groups
					an_overriding.start
				until
					an_overriding.after
				loop
					an_override.add_override (l_grps.item (an_overriding.item))
					an_overriding.forth
				end
			end
		end

feature {NONE} -- Implementation helper

	add_string_setting_actions (a_property: TYPED_PROPERTY [STRING_32]; a_name: STRING; a_default: STRING) is
			-- Add actions that deal with string settings.
		require
			a_property_not_void: a_property /= Void
			a_name_valid: valid_setting (a_name)
			current_target_not_void: current_target /= Void
		do
			a_property.set_refresh_action (agent get_setting (a_name))
			a_property.refresh
			a_property.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent set_string_setting (a_name, a_default, ?)))
			a_property.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent update_inheritance_setting (a_name, a_property)))
			a_property.use_inherited_actions.extend (agent current_target.update_setting (a_name, Void))
			a_property.use_inherited_actions.extend (agent update_inheritance_setting (a_name, a_property))
			update_inheritance_setting (a_name, a_property)
		end

	add_boolean_setting_actions (a_property: BOOLEAN_PROPERTY; a_name: STRING; a_default: BOOLEAN) is
			-- Add actions that deal with boolean settings.
		require
			a_property_not_void: a_property /= Void
			a_name_valid: valid_setting (a_name)
			current_target_not_void: current_target /= Void
		do
			a_property.set_refresh_action (agent current_target.setting_boolean (a_name))
			a_property.refresh
			a_property.change_value_actions.extend (agent set_boolean_setting (a_name, a_default, ?))
			a_property.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent update_inheritance_setting (a_name, a_property)))
			a_property.use_inherited_actions.extend (agent current_target.update_setting (a_name, Void))
			a_property.use_inherited_actions.extend (agent update_inheritance_setting (a_name, a_property))
			update_inheritance_setting (a_name, a_property)
		end

feature {NONE} -- Inheritance handling

	update_inheritance_setting (a_name: STRING; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' accordint to the setting `a_name'.
		require
			a_name_valid: valid_setting (a_name)
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if current_target.internal_settings.has (a_name) then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

	update_inheritance_root (a_dummy: CONF_ROOT; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' depending on if the root value is set in the current_target.
		require
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if current_target.internal_root /= Void then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

	update_inheritance_version (a_dummy: CONF_VERSION; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' depending on if the version value is set in the current_target.
		require
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if current_target.internal_version /= Void then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

	update_inheritance_file_rule (a_dummy: ARRAYED_LIST [CONF_FILE_RULE]; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' depending on if there are file rules in the `current_target'.
		require
			a_property_not_void: a_property /= Void
			current_target_not_void: current_target /= Void
		do
			if current_target.extends /= Void then
				if not current_target.internal_file_rule.is_empty then
					a_property.enable_overriden
				else
					a_property.enable_inherited
				end
			end
		end

	update_inheritance_file_rule_cluster (a_dummy: ARRAYED_LIST [CONF_FILE_RULE]; a_property: PROPERTY) is
			-- Enable inheritance/override on `a_property' depending on if there are file rules in the `current_group'.
		require
			a_property_not_void: a_property /= Void
			current_group_ok: current_group /= Void and then current_group.is_cluster
		local
			l_cluster: CONF_CLUSTER
		do
			l_cluster ?= current_group
			if not l_cluster.internal_file_rule.is_empty then
				a_property.enable_overriden
			else
				a_property.enable_inherited
			end
		end

feature {NONE} -- Validation and warning generation

	check_library_target (a_target: STRING_32): BOOLEAN is
			-- Is `a_target' a valid library target?
		require
			target_of_system: a_target /= Void and then not a_target.is_empty implies conf_system.targets.has (a_target)
		local
			l_target: CONF_TARGET
			wd: EV_WARNING_DIALOG
		do
			if a_target /= Void and then not a_target.is_empty then
				l_target := conf_system.targets.item (a_target)
				if not l_target.overrides.is_empty then
					create wd.make_with_text (library_target_override)
					wd.show_modal_to_window (Current)
				else
					Result := True
				end
			else
				Result := True
			end
		end

	check_target_name (a_name: STRING_32): BOOLEAN is
			-- Is `a_name' a valid name for a target?
		require
			current_target: current_target /= Void
			a_name_not_void: a_name /= Void
		local
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
			wd: EV_WARNING_DIALOG
		do
			l_targets := conf_system.targets
			l_targets.search (a_name)
			if l_targets.found and then l_targets.found_item /= current_target then
				create wd.make_with_text (target_name_duplicate)
				wd.show_modal_to_window (Current)
			else
				Result := True
			end
		end

	valid_classes_per_module (a_value: STRING_32): BOOLEAN is
			-- Is `a_value' a correct value for the classes per module setting?
		require
			current_target: current_target /= Void
		do
			if a_value /= Void and then not a_value.is_empty then
				Result := a_value.is_natural_16 and then a_value.to_natural_16 > 0
			else
				Result := True
			end
		end

	valid_inlining_size (a_value: STRING_32): BOOLEAN is
			-- Is `a_value' a correct value for the classes per module setting?
		require
			current_target: current_target /= Void
		do
			if a_value /= Void and then not a_value.is_empty then
				Result := a_value.is_natural_8 and then a_value.to_natural_8 <= 100
			else
				Result := True
			end
		end

feature {NONE} -- Output generation

	output_renaming (a_table: EQUALITY_HASH_TABLE [STRING, STRING]): STRING_32 is
			-- Generate a text representation of `a_table'.
		do
			if a_table /= Void and then not a_table.is_empty then
				from
					create Result.make (20)
					a_table.start
				until
					a_table.after
				loop
					Result.append (a_table.key_for_iteration+"=>"+a_table.item_for_iteration+";")
					a_table.forth
				end
				Result.remove_tail (1)
			else
				create Result.make_empty
			end
		end

	output_class_options (a_table: HASH_TABLE [CONF_OPTION, STRING]): STRING_32 is
			-- Generate a text representation of class options table `a_table'.
		do
			if a_table /= Void and then not a_table.is_empty then
				from
					create Result.make (20)
					a_table.start
				until
					a_table.after
				loop
					if not a_table.item_for_iteration.is_empty then
						Result.append (a_table.key_for_iteration+";")
					end
					a_table.forth
				end
				if not Result.is_empty then
					Result.remove_tail (1)
				end
			else
				create Result.make_empty
			end
		end

	output_visible (a_visible: EQUALITY_HASH_TABLE [TUPLE [class_renamed: STRING; features: EQUALITY_HASH_TABLE [STRING, STRING]], STRING]): STRING_32 is
			-- Generate a text representation for `a_visible'.
		do
			if a_visible /= Void and then not a_visible.is_empty then
				from
					create Result.make (20)
					a_visible.start
				until
					a_visible.after
				loop
					Result.append (a_visible.key_for_iteration+";")
					a_visible.forth
				end
				Result.remove_tail (1)
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Wrappers

	get_setting (a_name: STRING): STRING_32 is
			-- Get value of a setting as STRING_32.
		require
			current_target: current_target /= Void
			valid_name: valid_setting (a_name)
		local
			l_val: STRING
		do
			l_val := current_target.settings.item (a_name)
			if l_val /= Void then
				Result := l_val
			end
		end

	change_no_argument_wrapper (a_dummy: ANY; a_call: PROCEDURE [ANY, TUPLE[]]) is
			-- Wrapper that allows to plugin in an agent without arguments on a change call (e.g. to refresh inheritance information).
		require
			a_call_not_void: a_call /= Void
		do
			a_call.call ([])
		end

	simple_validate_wrapper (a_string: STRING_GENERAL; a_call: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]): BOOLEAN is
			-- Wrapper to allow to call agents that only accept STRING.
		require
			valid_8_string: a_string /= Void implies a_string.is_valid_as_string_8
			a_call_not_void: a_call /= Void
		do
			if a_string /= Void then
				Result := a_call.item ([a_string.to_string_8])
			else
				Result := a_call.item (Void)
			end
		end

	list_wrapper (a_list: LIST [STRING_GENERAL]; a_call: PROCEDURE [ANY, TUPLE [LIST [STRING]]]) is
			-- Wrapper to allow to call agents that only accept LIST [STRING].
		require
			valid_8_string: a_list.for_all (agent {STRING_GENERAL}.is_valid_as_string_8)
			a_call_not_void: a_call /= Void
		local
			l_lst: ARRAYED_LIST [STRING]
		do
			if a_list /= Void then
				create l_lst.make (a_list.count)
				from
					a_list.start
				until
					a_list.after
				loop
					l_lst.extend (a_list.item.to_string_8)
					a_list.forth
				end
			end
			a_call.call ([l_lst])
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is True
			-- Is `Current' in its default state?

feature {NONE} -- Constants

	initial_window_width: INTEGER is 600
	initial_window_height: INTEGER is 600
	section_tree_width: INTEGER is 140
	description_height: INTEGER is 50

	frame_border_size: INTEGER is 1
	target_selection_width: INTEGER is 200

	group_tree_width: INTEGER is 200

invariant
	configuration_space: is_initialized implies configuration_space /= Void
	config_factory: conf_factory /= Void
	conf_system: conf_system /= Void
	debug_clauses: debug_clauses /= Void
	group_section_expanded_status: group_section_expanded_status /= Void

end
