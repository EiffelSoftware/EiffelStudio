indexing
	description: "Project configuration window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	GROUP_PROPERTIES
		undefine
			default_create, copy
		redefine
			refresh
		end

	TARGET_PROPERTIES
		export
			{ANY} conf_system
		undefine
			default_create, copy
		redefine
			refresh,
			refresh_target
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

	EB_SHARED_PREFERENCES
		undefine
			copy,
			default_create
		end

	SHARED_CONFIG_WINDOWS
		undefine
			copy,
			default_create
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
			create group_expanded_header.make (4)
			window := Current
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
			l_btn: EV_BUTTON
		do
				-- set default layout values
			set_padding_size (default_padding_size)

				-- window
			Precursor {EV_TITLED_WINDOW}
			set_title (configuration_title (conf_system.name))
			set_size (preferences.dialog_data.project_settings_width, preferences.dialog_data.project_settings_height)
			set_position (preferences.dialog_data.project_settings_position_x, preferences.dialog_data.project_settings_position_y)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_config_icon)
			enable_user_resize

			create hb
			extend (hb)
			append_margin (hb)
			create vb
			hb.extend (vb)
			hb.disable_item_expand (vb)
			append_margin (vb)

					-- section tree
			initialize_section_tree
			vb.extend (section_tree)
			append_margin (vb)

			append_margin (hb)
			create vb
			hb.extend (vb)
			append_margin (vb)

				-- configuration space
			create configuration_space
			vb.extend (configuration_space)

				-- property grid
			show_properties_system

			append_margin (vb)
			append_margin (hb)

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

			append_margin (vb)

			key_press_actions.extend (agent on_key)
			close_request_actions.extend (agent on_cancel)
			show_actions.extend (agent section_tree.set_focus)
		end

feature -- Command

	destroy is
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			preferences.dialog_data.project_settings_width_preference.set_value (width)
			preferences.dialog_data.project_settings_height_preference.set_value (height)
			preferences.dialog_data.project_settings_position_x_preference.set_value (x_position)
			preferences.dialog_data.project_settings_position_y_preference.set_value (y_position)
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

	on_key (a_key: EV_KEY) is
			-- `a_key' was pressed.
		require
			a_key_not_void: a_key /= Void
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				on_cancel
			end
		end


	on_cancel is
			-- Quit without saving.
		do
			hide
		end

	on_ok is
			-- Quit with saving
		do
			conf_system.store
			conf_system.set_file_date
			hide
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
			if config_windows.found and then config_windows.found_item.is_displayed then
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

	edit_library_button: EV_TOOL_BAR_BUTTON
			-- Button to edit the configuration file of a library.

	remove_group_button: EV_TOOL_BAR_BUTTON
			-- Button to remove a group.

feature {NONE} -- Section tree selection agents

	show_properties_system is
			-- Show configuration for system properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_system
			lock_update

			if target_configuration_space /= Void then
				target_configuration_space.destroy
				target_configuration_space := Void
			end

			initialize_properties_system
			configuration_space.wipe_out
			append_property_grid (configuration_space)
			append_small_margin (configuration_space)
			append_property_description (configuration_space)
			properties.recompute_column_width

			unlock_update
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
			lock_update

			prepare_target_configuration_space
			initialize_properties_target_general
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)
			properties.recompute_column_width

			unlock_update
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
			lock_update

			prepare_target_configuration_space
			initialize_properties_target_warning
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)
			properties.recompute_column_width

			unlock_update
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
			lock_update

			prepare_target_configuration_space
			initialize_properties_target_debugs
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)
			properties.recompute_column_width

			unlock_update
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
			lock_update

			prepare_target_configuration_space
			initialize_properties_target_assertions
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)
			properties.recompute_column_width

			unlock_update
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
			lock_update

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

			create l_button.make_with_text (general_add)
			l_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width+10)
			l_button.select_actions.extend (agent new_external)

			create l_button.make_with_text (general_remove)
			l_button.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width+10)
			l_button.select_actions.extend (agent remove_external)

			properties.recompute_column_width

			unlock_update
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
			lock_update

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

			create l_button.make_with_text (general_add)
			l_button.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width+10)
			l_button.select_actions.extend (agent new_task)

			create l_button.make_with_text (general_remove)
			l_button.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			hb.extend (l_button)
			hb.disable_item_expand (l_button)
			l_button.set_minimum_width (default_button_width+10)
			l_button.select_actions.extend (agent remove_task)

			properties.recompute_column_width

			unlock_update
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
			hb, hb2: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l_tb: EV_TOOL_BAR
			l_tb_btn: EV_TOOL_BAR_BUTTON
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_groups
			lock_update

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

			create hb2
			vb.extend (hb2)
			vb.disable_item_expand (hb2)

			create l_tb
			hb2.extend (l_tb)
			hb2.disable_item_expand (l_tb)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.new_cluster_icon)
			l_tb_btn.set_tooltip (dialog_create_cluster_title)
			l_tb_btn.select_actions.extend (agent add_cluster)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.new_override_cluster_icon)
			l_tb_btn.set_tooltip (dialog_create_override_title)
			l_tb_btn.select_actions.extend (agent add_override)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.new_library_icon)
			l_tb_btn.set_tooltip (dialog_create_library_title)
			l_tb_btn.select_actions.extend (agent add_library)

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.new_precompiled_library_icon)
			l_tb_btn.set_tooltip (dialog_create_precompile_title)
			l_tb_btn.select_actions.extend (agent add_precompile)
			if current_target.precompile /= Void then
				l_tb_btn.disable_sensitive
			end

			create l_tb_btn
			l_tb.extend (l_tb_btn)
			l_tb_btn.set_pixmap (pixmaps.icon_pixmaps.new_reference_icon)
			l_tb_btn.set_tooltip (dialog_create_assembly_title)
			l_tb_btn.select_actions.extend (agent add_assembly)

			create remove_group_button
			l_tb.extend (remove_group_button)
			remove_group_button.set_pixmap (pixmaps.icon_pixmaps.general_delete_icon)
			remove_group_button.set_tooltip (remove_group_text)
			remove_group_button.select_actions.extend (agent remove_group)

				-- edit library tool bar
			hb2.extend (create {EV_CELL})
			create l_tb
			hb2.extend (l_tb)
			hb2.disable_item_expand (l_tb)

			create edit_library_button
			edit_library_button.disable_sensitive
			edit_library_button.set_pixmap (pixmaps.icon_pixmaps.project_settings_edit_library_icon)
			edit_library_button.set_tooltip (library_edit_configuration)
			l_tb.extend (edit_library_button)

			append_groups_tree (vb)
			append_small_margin (hb)
			target_configuration_space.extend (hb)
			create vb
			hb.extend (vb)
			append_property_grid (vb)
			append_small_margin (vb)
			append_property_description (vb)

			unlock_update
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
			l_item: STRING_PROPERTY [STRING]
			l_btn: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb_grid: EV_VERTICAL_BOX
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_variables
			lock_update

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
			grid.column (1).set_title (variables_name)
			grid.column (2).set_title (variables_value)
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
			hb.set_padding (default_padding_size)
			target_configuration_space.extend (hb)
			target_configuration_space.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (general_add, agent add_variable)
			l_btn.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			l_btn.set_minimum_width (default_button_width+10)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			create l_btn.make_with_text_and_action (general_remove, agent remove_variable)
			l_btn.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			l_btn.set_minimum_width (default_button_width+10)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			unlock_update
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
			l_item: STRING_PROPERTY [STRING]
			l_btn: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb_grid: EV_VERTICAL_BOX
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_mapping
			lock_update

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
			grid.column (1).set_title (mapping_old_name)
			grid.column (2).set_title (mapping_new_name)
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
			hb.set_padding (default_padding_size)
			target_configuration_space.extend (hb)
			target_configuration_space.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (general_add, agent add_mapping)
			l_btn.set_pixmap (pixmaps.icon_pixmaps.general_add_icon)
			l_btn.set_minimum_width (default_button_width+10)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			create l_btn.make_with_text_and_action (general_remove, agent remove_mapping)
			l_btn.set_pixmap (pixmaps.icon_pixmaps.general_remove_icon)
			l_btn.set_minimum_width (default_button_width+10)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			unlock_update
			is_refreshing := False
		end

	show_properties_target_advanced is
			-- Show configuration for advanced target properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_btn: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_advanced
			lock_update

			prepare_target_configuration_space
			initialize_properties_target_advanced
			append_property_grid (target_configuration_space)
			append_small_margin (target_configuration_space)
			append_property_description (target_configuration_space)

			append_small_margin (target_configuration_space)

			create hb
			target_configuration_space.extend (hb)
			target_configuration_space.disable_item_expand (hb)

			hb.extend (create {EV_CELL})

			create l_btn.make_with_text_and_action (target_edit_manually, agent open_text_editor)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			properties.recompute_column_width

			unlock_update
			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
		end

	refresh_target (a_target: STRING_32) is
			-- Refresh target selection box and select `a_target'.
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

	current_external: CONF_EXTERNAL
			-- Current selected external.

	current_task: CONF_ACTION
			-- Current selected task.

	current_group: CONF_GROUP
			-- Current selected group.

	group_section_expanded_status: HASH_TABLE [BOOLEAN, STRING] is
			-- Expanded status of sections of groups.
		once
			create Result.make (5)
			Result.force (True, section_general)
			Result.force (True, section_assertions)
			Result.force (False, section_warning)
			Result.force (False, section_debug)
			Result.force (False, section_advanced)
		end

	is_refreshing: BOOLEAN
			-- Are we currently refreshing?

	refresh is
			-- Regenerate currently displayed data.
		do
			if refresh_current /= Void then
				refresh_current.call ([])
				set_focus
				section_tree.set_focus
			end
		end

	open_text_editor is
			-- Open editor to edit the configuration file by hand.
		local
			l_cmd_exec: COMMAND_EXECUTOR
			l_cmd_string: STRING
		do
			l_cmd_string := preferences.misc_data.external_editor_command.twin
			if not l_cmd_string.is_empty then
				l_cmd_string.replace_substring_all ("$target", conf_system.file_name)
				l_cmd_string.replace_substring_all ("$line", "0")
				create l_cmd_exec
				l_cmd_exec.execute (l_cmd_string)
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
			l_item.set_pixmap (pixmaps.icon_pixmaps.project_settings_system_icon)

			create l_item.make_with_text (section_target)
			section_tree.extend (l_item)
			l_item.select_actions.extend (agent show_properties_target_general)
			l_item.set_pixmap (pixmaps.icon_pixmaps.folder_config_icon)
			create l_subitem.make_with_text (section_general)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_general)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_target_icon)
			create l_subitem.make_with_text (section_assertions)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_assertions)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_assertions_icon)
			create l_subitem.make_with_text (section_groups)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_groups)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_groups_icon)

			create l_subitem.make_with_text (section_advanced)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_advanced)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.folder_config_icon)
			l_item.expand
			l_item := l_subitem
			create l_subitem.make_with_text (section_general)
			l_item.extend (l_subitem)
			l_item.expand
			l_subitem.select_actions.extend (agent show_properties_target_advanced)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_advanced_icon)
			create l_subitem.make_with_text (section_warning)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_warning)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_warnings_icon)
			create l_subitem.make_with_text (section_debug)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_debugs)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_debug_icon)
			create l_subitem.make_with_text (section_external)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_externals)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_externals_icon)
			create l_subitem.make_with_text (section_tasks)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_tasks)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_tasks_icon)
			create l_subitem.make_with_text (section_variables)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_variables)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_variables_icon)
			create l_subitem.make_with_text (section_mapping)
			l_item.extend (l_subitem)
			l_subitem.select_actions.extend (agent show_properties_target_mapping)
			l_subitem.set_pixmap (pixmaps.icon_pixmaps.project_settings_type_mappings_icon)

			section_tree.set_minimum_width (section_tree_width)
		ensure
			section_tree_not_void: section_tree /= Void
		end

	prepare_target_configuration_space is
			-- Add space for target configuration and necessary elements for it.
		local
			l_refresh: BOOLEAN
		do
			l_refresh := is_refreshing
			is_refreshing := True
			if target_configuration_space = Void then
				configuration_space.wipe_out
				append_target_selection (configuration_space)
				append_small_margin (configuration_space)
				create target_configuration_space
				configuration_space.extend (target_configuration_space)
			else
				target_configuration_space.wipe_out
			end
			is_refreshing := l_refresh
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

			add_externals (current_target.internal_external_include, l_tree, external_include_tree, pixmaps.icon_pixmaps.project_settings_include_file_icon)
			add_externals (current_target.internal_external_object, l_tree, external_object_tree, pixmaps.icon_pixmaps.project_settings_object_file_icon)
			add_externals (current_target.internal_external_library, l_tree, external_library_tree, pixmaps.icon_pixmaps.project_settings_object_file_icon)
			add_externals (current_target.internal_external_make, l_tree, external_make_tree, pixmaps.icon_pixmaps.project_settings_make_file_icon)
			add_externals (current_target.internal_external_resource, l_tree, external_resource_tree, pixmaps.icon_pixmaps.project_settings_resource_file_icon)
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
				add_groups (l_ht, l_tree,group_precompile_tree, pixmaps.icon_pixmaps.top_level_folder_precompiles_icon)
			end

			l_tree.key_press_actions.extend (agent on_group_tree_key)
		end

	initialize_properties_system is
			-- Initialize `properties' for system settings.
		local
			l_string_prop: STRING_PROPERTY [STRING]
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_choice_prop: STRING_CHOICE_PROPERTY [STRING_32]
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
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

			add_general_properties
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
			l_prop: STRING_PROPERTY [STRING_32]
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
			elseif an_external.is_library then
				l_prop.set_value (external_library)
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
				l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent refresh))
				properties.add_property (l_dir_prop)
			else
				create l_file_prop.make (external_location_name)
				l_file_prop.set_description (external_location_description)
				l_file_prop.enable_text_editing
				l_file_prop.set_value (an_external.location)
				l_file_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?,  agent an_external.set_location))
				l_file_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent refresh))
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
			l_prop: STRING_PROPERTY [STRING_32]
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
			l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent refresh))
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
			remove_group_button_not_void: remove_group_button /= Void
			a_group_not_void: a_group /= Void
			current_target: current_target /= Void
		do
			current_group := a_group
			remove_group_button.enable_sensitive
			properties.reset

			edit_library_button.disable_sensitive
			edit_library_button.select_actions.wipe_out

			if a_group.is_library and not a_group.is_readonly then
				edit_library_button.enable_sensitive
				edit_library_button.select_actions.extend (agent edit_configuration (a_group.location.evaluated_path))
			end

			add_group_properties (a_group, current_target)

			properties.set_expanded_section_store (group_section_expanded_status)
		ensure
			properties_not_void: properties /= Void
			current_group_set: current_group = a_group
		end

	initialize_properties_target_advanced is
			-- Initialize `properties' for advanced target settings.
		require
			current_target: current_target /= Void
		do
			if properties /= Void then
				properties.destroy
			end
			create properties

			add_advanced_properties
		ensure
			properties_not_void: properties /= Void
		end

	add_externals (a_externals: ARRAYED_LIST [CONF_EXTERNAL]; a_tree: EV_TREE; a_name: STRING; a_pixmap: EV_PIXMAP) is
			-- Add `a_externals' to `a_tree' under a header with `a_name'.
		require
			a_tree: a_tree /= Void
			a_pixmap: a_pixmap /= Void
		local
			l_head_item, l_item: EV_TREE_ITEM
			l_ext_item: CONF_EXTERNAL
		do
			if a_externals /= Void and then not a_externals.is_empty then
				create l_head_item.make_with_text (a_name)
				l_head_item.set_pixmap (a_pixmap)
				a_tree.extend (l_head_item)
				from
					a_externals.start
				until
					a_externals.after
				loop
					l_ext_item := a_externals.item
					create l_item.make_with_text (l_ext_item.location)
					l_item.set_pixmap (a_pixmap)
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
				l_head_item.set_pixmap (pixmaps.icon_pixmaps.project_settings_task_icon)
				a_tree.extend (l_head_item)
				from
					a_tasks.start
				until
					a_tasks.after
				loop
					l_task := a_tasks.item
					create l_item.make_with_text (l_task.command)
					l_item.set_pixmap (pixmaps.icon_pixmaps.project_settings_task_icon)
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

	deselect_current_group is
			-- Select no group in the groups tree.
		require
			properties_not_void: properties /= Void
			edit_library_button_not_void: edit_library_button /= Void
		do
			properties.reset
			edit_library_button.disable_sensitive
			remove_group_button.disable_sensitive
			current_group := Void
		ensure
			current_group_void: current_group = Void
		end

	group_expanded_header: SEARCH_TABLE [STRING]
			-- Names of the group headers that are expanded.

	add_groups (a_groups: HASH_TABLE [CONF_GROUP, STRING]; a_tree: EV_TREE; a_name: STRING; a_head_pix: EV_PIXMAP) is
			-- Add `a_groups' to `a_tree' under a header with `a_name'.
		require
			a_tree: a_tree /= Void
			properties: properties /= Void
			edit_library_button: edit_library_button /= Void
		local
			l_head_item, l_item: EV_TREE_ITEM
			l_group: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_sort_list: DS_ARRAYED_LIST [CONF_GROUP]
		do
			if a_groups /= Void and then not a_groups.is_empty then
				create l_head_item.make_with_text (a_name)
				l_head_item.set_pixmap (a_head_pix)
				l_head_item.select_actions.extend (agent deselect_current_group)
				l_head_item.expand_actions.extend (agent group_expanded_header.force (a_name))
				l_head_item.collapse_actions.extend (agent group_expanded_header.remove (a_name))
				a_tree.extend (l_head_item)

					-- sort groups alphabetically
				create l_sort_list.make (a_groups.count)
				from
					a_groups.start
				until
					a_groups.after
				loop
					l_sort_list.force_last (a_groups.item_for_iteration)
					a_groups.forth
				end
				l_sort_list.sort (create {DS_QUICK_SORTER [CONF_GROUP]}.make (create {KL_COMPARABLE_COMPARATOR [CONF_GROUP]}.make))

				from
					l_sort_list.start
				until
					l_sort_list.after
				loop
					l_group := l_sort_list.item_for_iteration
					if current_group = Void then
						current_group := l_group
					end
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
					l_sort_list.forth
				end

				if group_expanded_header.has (a_name) then
					l_head_item.expand
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
			l_dial: CREATE_CLUSTER_DIALOG
			l_cluster: CONF_CLUSTER
		do
			create l_dial.make (current_target, conf_factory)
			if current_group /= Void and then current_group.is_cluster then
				l_cluster ?= current_group
				check
					cluster: l_cluster /= Void
				end
				l_dial.set_parent_cluster (l_cluster)
			end
			l_dial.show_modal_to_window (Current)
			if l_dial.is_ok then
				current_group := l_dial.last_cluster
				refresh
			end
		end

	add_override is
			-- Add a new override cluster.
		local
			l_dial: CREATE_OVERRIDE_DIALOG
			l_cluster: CONF_CLUSTER
		do
			create l_dial.make (current_target, conf_factory)
			if current_group /= Void and then current_group.is_cluster then
				l_cluster ?= current_group
				check
					cluster: l_cluster /= Void
				end
				l_dial.set_parent_cluster (l_cluster)
			end
			l_dial.show_modal_to_window (Current)
			if l_dial.is_ok then
				current_group := l_dial.last_cluster
				refresh
			end
		end

	add_library is
			-- Add a new library.
		require
			current_target_set: current_target /= Void
		local
			l_dial: CREATE_LIBRARY_DIALOG
		do
			create l_dial.make (current_target, conf_factory)
			l_dial.show_modal_to_window (Current)
			if l_dial.is_ok then
				current_group := l_dial.last_library
				refresh
			end
		end

	add_precompile is
			-- Add a new precompile.
		require
			current_target_set: current_target /= Void
		local
			l_dial: CREATE_PRECOMPILE_DIALOG
		do
			create l_dial.make (current_target, conf_factory)
			l_dial.show_modal_to_window (Current)
			if l_dial.is_ok then
				current_group := l_dial.last_library
				refresh
			end
		end

	add_assembly is
			-- Add a new assembly.
		local
			l_dial: CREATE_ASSEMBLY_DIALOG
		do
			create l_dial.make (current_target, conf_factory)
			l_dial.show_modal_to_window (Current)
			if l_dial.is_ok then
				current_group := l_dial.last_assembly
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
			l_cluster: CONF_CLUSTER
		do
			if a_group = current_group then
				current_group := Void
			end

			l_name := a_group.name
			if a_group.is_override then
				l_cluster := current_target.overrides.item (l_name)
				check
					cluster: l_cluster /= Void
				end
				if l_cluster.parent /= Void then
					l_cluster.parent.remove_child (l_cluster)
				end
				current_target.remove_override (l_name)
			elseif a_group.is_cluster then
				l_cluster := current_target.clusters.item (l_name)
				check
					cluster: l_cluster /= Void
				end
				if l_cluster.parent /= Void then
					l_cluster.parent.remove_child (l_cluster)
				end
				current_target.remove_cluster (l_name)
			elseif a_group.is_precompile then
				current_target.set_precompile (Void)
			elseif a_group.is_library then
				current_target.remove_library (l_name)
			elseif a_group.is_assembly then
				current_target.remove_assembly (l_name)
			else
				check should_not_reach: False end
			end
			refresh
		ensure
			current_group_different: a_group /= current_group
		end

	new_external is
			-- Add a new external.
		local
			l_dia: NEW_EXTERNAL_DIALOG
			l_new_include: CONF_EXTERNAL_INCLUDE
			l_new_object: CONF_EXTERNAL_OBJECT
			l_new_library: CONF_EXTERNAL_LIBRARY
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
				elseif l_dia.is_library then
					l_new_library := conf_factory.new_external_library ("new")
					current_target.add_external_library (l_new_library)
					current_external := l_new_library
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
			l_library: CONF_EXTERNAL_LIBRARY
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
				elseif current_external.is_library then
					l_library ?= current_external
					check library: l_library /= Void end
					current_target.remove_external_library (l_library)
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

feature {NONE} -- Wrappers

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

	initial_window_width: INTEGER is 670
	initial_window_height: INTEGER is 600
	section_tree_width: INTEGER is 165
	description_height: INTEGER is 50

	frame_border_size: INTEGER is 1
	target_selection_width: INTEGER is 200

	group_tree_width: INTEGER is 200

invariant
	configuration_space: is_initialized implies configuration_space /= Void
	debug_clauses: debug_clauses /= Void
	group_section_expanded_status: group_section_expanded_status /= Void
	group_expanded_header: group_expanded_header /= Void
	conf_system: conf_system /= Void

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
