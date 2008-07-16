indexing
	description: "Project configuration window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION_WINDOW

inherit
	EV_DIALOG
		export
			{ANY} is_initialized
		redefine
			initialize, is_in_default_state,
			destroy
		end

	CONF_ACCESS
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
			handle_value_changes,
			refresh
		end

	TARGET_PROPERTIES
		export
			{ANY} conf_system
		undefine
			default_create, copy
		redefine
			handle_value_changes,
			refresh
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

	SHARED_CONFIG_WINDOWS
		undefine
			copy,
			default_create
		end

	CONF_GUI_INTERFACE_CONSTANTS
		export
			{CONFIGURATION_SECTION} conf_interface_names
		undefine
			copy,
			default_create
		end

	PROPERTY_HELPER
		undefine
			default_create,
			copy
		end

create
	make,
	make_for_target

feature {NONE}-- Initialization

	make_for_target (a_system: like conf_system; a_target: STRING; a_factory: like conf_factory; a_debugs: like debug_clauses; a_pixmaps: CONF_PIXMAPS; a_editor: like external_editor_command) is
			-- Create and select `a_target'.
		require
			a_target_ok: a_target /= Void and then not a_target.is_empty
			a_system_not_void: a_system /= Void
			a_factory_not_void: a_factory /= Void
			a_editor_not_void: a_editor /= Void
		do
			if a_debugs = Void then
				create debug_clauses.make (0)
			else
				debug_clauses := a_debugs
			end
			window := Current
			selected_target := a_target
			set_pixmaps (a_pixmaps)
			conf_system := a_system
			conf_factory := a_factory
			external_editor_command := a_editor
			default_create
			config_windows.force (Current, conf_system.file_name)
			set_split_position (220)
		ensure
			system_set: conf_system = a_system
			factory_set: conf_factory = a_factory
			debug_clauses_set: a_debugs /= Void implies debug_clauses = a_debugs
			selected_target_set: selected_target = a_target
		end

	make (a_system: like conf_system; a_factory: like conf_factory; a_debugs: like debug_clauses; a_pixmaps: CONF_PIXMAPS; a_editor: like external_editor_command) is
			-- Create.
		require
			a_system_not_void: a_system /= Void
			a_system_has_targets: not a_system.targets.is_empty
			a_factory_not_void: a_factory /= Void
			a_editor_not_void: a_editor /= Void
		do
			make_for_target (a_system, a_system.target_order.first.name, a_factory, a_debugs, a_pixmaps, a_editor)
		ensure
			system_set: conf_system = a_system
			factory_set: conf_factory = a_factory
			debug_clauses_set: a_debugs /= Void implies debug_clauses = a_debugs
		end

	initialize is
			-- Initialize `Current'.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l_btn: EV_BUTTON
			l_accel: EV_ACCELERATOR
		do
				-- set default layout values
			set_padding_size (layout_constants.default_padding_size)

				-- window
			Precursor
			set_title (conf_interface_names.configuration_title (conf_system.name))
			set_icon_pixmap (conf_pixmaps.tool_config_icon)
			enable_user_resize

			create vb
			extend (vb)
			vb.set_padding (layout_constants.default_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

				-- toolbar
			create toolbar
			vb.extend (toolbar)
			vb.disable_item_expand (toolbar)
			toolbar.edit_manually_button.select_actions.extend (agent open_text_editor)
			toolbar.edit_manually_button.enable_sensitive
			accelerators.append (toolbar.accelerators)

			create split_area
			vb.extend (split_area)

					-- section tree
			create section_tree
			section_tree.set_minimum_size (160, 230)
			initialize_section_tree
			split_area.set_first (section_tree)

				-- configuration space_g
			create configuration_space
			split_area.set_second (configuration_space)
			configuration_space.set_padding (layout_constants.default_padding_size)

				-- ok and cancel buttons
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)

			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			create ok_button.make_with_text_and_action (names.b_ok, agent on_ok)
			layout_constants.set_default_width_for_button (ok_button)
			hb.extend (ok_button)
			hb.disable_item_expand (ok_button)
			set_default_push_button (ok_button)

			create l_btn.make_with_text_and_action (names.b_cancel, agent on_cancel)
			layout_constants.set_default_width_for_button (l_btn)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)

			show_actions.extend (agent section_tree.set_focus)

				-- add accelerator for opening the context menu
			create l_accel.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_menu), False, False, False)
			l_accel.actions.extend (agent
				local
					l_section: CONFIGURATION_SECTION
				do
					l_section ?= section_tree.selected_item
					check
						configuration_section: l_section /= Void
					end
					l_section.show_context_menu
				end)
			accelerators.extend (l_accel)
		end

feature -- Status

	is_canceled: BOOLEAN
			-- Has the dialog been canceled?

	is_refreshing: BOOLEAN
			-- Are we currently refreshing?

feature -- Access

	conf_factory: CONF_PARSE_FACTORY
			-- Factory to create new nodes.

	selected_target: STRING
			-- Target to select on startup.

	external_editor_command: FUNCTION [ANY, TUPLE [STRING, INTEGER], STRING]
			-- Command that builds an external editor command line by taking a target and a line number.

	split_position: INTEGER is
			-- Split position.
		require
			initialized: is_initialized
		do
			Result := split_area.split_position
		end

feature -- Update

	set_split_position (a_position: like split_position) is
			-- Set split position.
		require
			initialized: is_initialized
		do
			split_area.set_split_position (a_position)
		ensure
			split_position_updated: split_position = a_position
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

	on_cancel is
			-- Quit without saving.
		do
			is_canceled := True
			hide
		end

	on_ok is
			-- Quit with saving
		do
			if conf_system /= Void then
				commit_changes
			end
			hide
		end

feature {CONFIGURATION_SECTION} -- Layout components

	toolbar: CONFIGURATION_TOOLBAR
			-- Toolbar for actions.

feature {NONE} -- Layout components

	ok_button: EV_BUTTON
			-- Ok button

	split_area: EV_HORIZONTAL_SPLIT_AREA
			-- Split area between `section_tree' and `configuration_space'

	section_tree: EV_TREE
			-- Tree to select what information to display.

	grid: ES_GRID
			-- Grid for variables and type mappings.

	add_button: EV_BUTTON
			-- Button to add an item to `grid'.

	remove_button: EV_BUTTON
			-- Button to remove an item from `grid'.

	configuration_space: EV_VERTICAL_BOX
			-- Space to put configuration.

	target_configuration_space: EV_VERTICAL_BOX
			-- Space to put configuration for `current_target'.

feature {NONE} -- Element initialization

	initialize_properties is
			-- Prepare `properties'.
		require
			not_properties_and_grid: properties = Void or grid = Void
		local
			l_frame: EV_FRAME
			l_vbox: EV_VERTICAL_BOX
			l_text: ES_LABEL
		do
			if properties = Void then
				configuration_space.wipe_out

					-- property grid
				create l_frame
				configuration_space.extend (l_frame)
				l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)

				create properties
				l_frame.extend (properties)
				properties.focus_in_actions.extend (agent
					do
						if default_push_button /= Void then
							remove_default_push_button
						end
					end)
				properties.focus_out_actions.extend (agent set_default_push_button (ok_button))

					-- property grid description field
				create l_frame
				configuration_space.extend (l_frame)
				configuration_space.disable_item_expand (l_frame)
				l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)

				create l_text
				properties.set_description_field (l_text)
				l_text.set_minimum_width (100)
				l_text.set_and_wrap_text ("")
				l_text.align_text_left

					-- Create description container and padding
				create l_vbox
				l_vbox.set_border_width (4)
				l_vbox.extend (l_text)
				l_vbox.disable_item_expand (l_text)
				l_vbox.extend (create {EV_CELL})
				l_vbox.set_minimum_height (description_height)

				l_frame.extend (l_vbox)

					-- remove grid
				if grid /= Void then
					grid.destroy
					grid := Void
					add_button.destroy
					add_button := Void
					remove_button.destroy
					remove_button := Void
				end
			else
				properties.reset
			end
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			grid_void: grid = Void
			buttons_void: add_button = Void and remove_button = Void
		end

	initialize_grid is
			-- Prepare `grid'.
		require
			not_properties_and_grid: properties = Void or grid = Void
		local
			vb_grid: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_column_width1, l_column_width2: INTEGER_32
		do
			if grid = Void then
				configuration_space.wipe_out

					-- border
				create vb_grid
				vb_grid.set_border_width (1)
				vb_grid.set_background_color ((create {EV_STOCK_COLORS}).black)
				configuration_space.extend (vb_grid)

					-- grid
				create grid
				vb_grid.extend (grid)
				grid.set_column_count_to (2)
				grid.column (1).set_width (200)
				grid.column (2).set_width (200)
				grid.focus_in_actions.extend (agent
					do
						if default_push_button /= Void then
							remove_default_push_button
						end
					end)
				grid.focus_out_actions.extend (agent set_default_push_button (ok_button))

					-- add add and remove buttons
				create hb
				hb.set_padding (layout_constants.default_padding_size)
				configuration_space.extend (hb)
				configuration_space.disable_item_expand (hb)
				hb.extend (create {EV_CELL})
				create add_button.make_with_text (conf_interface_names.general_add)
				add_button.set_pixmap (conf_pixmaps.general_add_icon)
				layout_constants.set_default_width_for_button (add_button)
				hb.extend (add_button)
				hb.disable_item_expand (add_button)
				create remove_button.make_with_text (conf_interface_names.general_remove)
				remove_button.set_pixmap (conf_pixmaps.general_remove_icon)
				layout_constants.set_default_width_for_button (remove_button)
				hb.extend (remove_button)
				hb.disable_item_expand (remove_button)

					-- remove properties
				if properties /= Void then
					properties.destroy
					properties := Void
				end
			else
				l_column_width1 := grid.column (1).width
				l_column_width2 := grid.column (2).width
				grid.wipe_out
				grid.set_column_count_to (2)
				grid.column (1).set_width (l_column_width1)
				grid.column (2).set_width (l_column_width2)

					-- clear button actions
				add_button.select_actions.wipe_out
				remove_button.select_actions.wipe_out
			end

			grid.enable_border
			grid.enable_last_column_use_all_width
			grid.enable_single_row_selection
		ensure
			grid_ok: grid /= Void and then not grid.is_destroyed
			add_button_ok: add_button /= Void and then not add_button.is_destroyed
			remove_button_ok: remove_button /= Void and then not remove_button.is_destroyed
			properties_void: properties = Void
		end

	initialize_section_tree is
			-- Initialize `section_tree'.
		do
				-- system section
			section_tree.extend (create {SYSTEM_SECTION}.make (conf_system, Current))

				-- recursively add targets
			conf_system.target_order.do_if (agent add_target_sections (?, section_tree), agent (a_target: CONF_TARGET): BOOLEAN
				do
					Result := a_target.extends = Void
				end
			)
		ensure
			section_tree_not_void: section_tree /= Void
		end

feature {TARGET_SECTION, SYSTEM_SECTION} -- Target creation

	add_target_sections (a_target: CONF_TARGET; a_root: EV_TREE_NODE_LIST) is
			-- Add sections for `a_target' under `a_root'.
		require
			a_target_not_void: a_target /= Void
			a_root_ok: a_root /= Void and then not a_root.is_destroyed and a_root.extendible
		local
			l_target: TARGET_SECTION
			l_target_tasks: TARGET_TASKS_SECTION
			l_target_externals: TARGET_EXTERNALS_SECTION
			l_target_advanced: TARGET_ADVANCED_SECTION
			l_target_groups: TARGET_GROUPS_SECTION
			l_node: EV_TREE_NODE
		do
				-- target
			create l_target.make (a_target, Current)
			a_root.extend (l_target)

				-- assertions section
			l_target.extend (create {TARGET_ASSERTIONS_SECTION}.make (a_target, Current))

				-- groups section
			create l_target_groups.make (a_target, Current)
			l_target.extend (l_target_groups)
			l_target_groups.set_clusters (a_target.internal_clusters)
			l_target_groups.set_overrides (a_target.internal_overrides)
			l_target_groups.set_assemblies (a_target.internal_assemblies)
			l_target_groups.set_libraries (a_target.internal_libraries)
			l_target_groups.set_precompile (a_target.internal_precompile)

				-- advanced section
			create l_target_advanced.make (a_target, Current)
			l_target.extend (l_target_advanced)

				-- advanced warning section
			l_target_advanced.extend (create {TARGET_WARNINGS_SECTION}.make (a_target, Current))

				-- advanced debug section
			l_target_advanced.extend (create {TARGET_DEBUG_SECTION}.make (a_target, Current))

				-- advanced external section
			create l_target_externals.make (a_target, Current)
			l_target_advanced.extend (l_target_externals)
			l_target_externals.set_includes (a_target.internal_external_include)
			l_target_externals.set_objects (a_target.internal_external_object)
			l_target_externals.set_libraries (a_target.internal_external_library)
			l_target_externals.set_makefiles (a_target.internal_external_make)
			l_target_externals.set_resources (a_target.internal_external_resource)

				-- advanced tasks section
			create l_target_tasks.make (a_target, Current)
			l_target_advanced.extend (l_target_tasks)
			l_target_tasks.set_pre_compilation (a_target.internal_pre_compile_action)
			l_target_tasks.set_post_compilation (a_target.internal_post_compile_action)

				-- advanced variables section
			l_target_advanced.extend (create {TARGET_VARIABLES_SECTION}.make (a_target, Current))

				-- advanced mapping section
			l_target_advanced.extend (create {TARGET_MAPPING_SECTION}.make (a_target, Current))

				-- expand if this is the selected target
			if a_target.name.is_equal (selected_target) then
				from
					l_node := l_target
				until
					l_node = Void
				loop
					l_node.expand
					l_node ?= l_node.parent
				end
			end

				-- add child targets
			a_target.child_targets.do_all (agent add_target_sections (?, l_target))
		end

feature {CONFIGURATION_SECTION} -- Section tree selection agents

	show_empty_section (a_message: STRING_GENERAL)
			-- Show `a_message' for an empty section.
		local
			l_label: ES_LABEL
		do
			lock_update

			configuration_space.wipe_out

				-- Create label with informations
			if a_message /= Void and then not a_message.is_empty then
				configuration_space.extend (create {EV_CELL})

				create l_label

				configuration_space.extend (l_label)
				configuration_space.disable_item_expand (l_label)
				l_label.set_and_wrap_text (a_message)

				configuration_space.extend (create {EV_CELL})
			end

				-- remove grid
			if grid /= Void then
				grid.destroy
				grid := Void
				add_button.destroy
				add_button := Void
				remove_button.destroy
				remove_button := Void
			end

				-- remove properties
			if properties /= Void then
				properties.destroy
				properties := Void
			end

			unlock_update
		end

	show_properties_system is
			-- Show configuration for system properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			refresh_current := agent show_properties_system
			lock_update

			initialize_properties

			initialize_properties_system

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_general (a_target: CONF_TARGET) is
			-- Show general properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_general (a_target)
			lock_update

			initialize_properties

			current_target := a_target
			add_general_properties

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_warning (a_target: CONF_TARGET) is
			-- Show warning properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_warning (a_target)
			lock_update

			initialize_properties

			current_target := a_target
			add_warning_option_properties (a_target.changeable_internal_options, a_target.options, a_target.extends /= Void)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_debugs (a_target: CONF_TARGET) is
			-- Show debug properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_debugs (a_target)
			lock_update

			initialize_properties

			current_target := a_target
			add_debug_option_properties (a_target.changeable_internal_options, a_target.options, a_target.extends /= Void)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_assertions (a_target: CONF_TARGET) is
			-- Show assertion properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_assertions (a_target)
			lock_update

			initialize_properties

			current_target := a_target
			add_assertion_option_properties (a_target.changeable_internal_options, a_target.options, a_target.extends /= Void)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_externals (a_target: CONF_TARGET; a_external: CONF_EXTERNAL) is
			-- Show external properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
			a_external_not_void: a_external /= Void
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_externals (a_target, a_external)
			lock_update

			initialize_properties

			current_target := a_target
			initialize_properties_target_externals (a_external)

			unlock_update
			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
			properties_ok: properties /= Void and then not properties.is_destroyed
		end

	show_properties_target_tasks (a_target: CONF_TARGET; a_task: CONF_ACTION; a_type: STRING_32) is
			-- Show task properties for `a_task'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
			a_task_not_void: a_task /= Void
			a_type_not_void: a_type /= Void
			a_type_ok: a_type.is_equal (conf_interface_names.task_pre) or a_type.is_equal (conf_interface_names.task_post)
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_tasks (a_target, a_task, a_type)
			lock_update

			initialize_properties

			current_target := a_target
			initialize_properties_target_tasks (a_task, a_type)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_groups (a_target: CONF_TARGET; a_group: CONF_GROUP) is
			-- Show groups properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
			a_group_not_void: a_group /= Void
		do
			is_refreshing := True
			refresh_current := agent show_properties_target_groups (a_target, a_group)
			lock_update

			initialize_properties

			current_target := a_target
			add_group_properties (a_group, current_target)
			properties.set_expanded_section_store (group_section_expanded_status)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_variables (a_target: CONF_TARGET) is
			-- Show variables properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_vars, l_inh_vars: EQUALITY_HASH_TABLE [STRING, STRING]
			i: INTEGER
			l_item: STRING_PROPERTY
			l_var_key: STRING
		do
			current_target := a_target
			is_refreshing := True
			refresh_current := agent show_properties_target_variables (a_target)
			lock_update

				-- prepare grid
			initialize_grid
			grid.column (1).set_title (conf_interface_names.variables_name)
			grid.column (2).set_title (conf_interface_names.variables_value)

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
				l_var_key := l_vars.key_for_iteration
				l_item.set_value (l_var_key)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent (s: STRING_32; a_var_key: STRING)
					require
						s_not_void: s /= Void
						a_var_key_not_void: a_var_key /= Void
					do
						update_variable_key (a_var_key, s.as_string_8)
					end (?, l_var_key))
				grid.set_item (1, i + 1, l_item)
				create l_item.make ("")
				l_item.set_value (l_vars.item_for_iteration)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent (s: STRING_32; a_var_key: STRING)
					require
						s_not_void: s /= Void
						a_var_key_not_void: a_var_key /= Void
					do
						update_variable_value (a_var_key, s.as_string_8)
					end (?, l_var_key))
				grid.set_item (2, i + 1, l_item)
				l_inh_vars.search (l_var_key)
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

			add_button.select_actions.extend (agent add_variable)
			remove_button.select_actions.extend (agent remove_variable)

			unlock_update
			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
			grid_ok: grid /= Void and then not grid.is_destroyed
		end

	show_properties_target_mapping (a_target: CONF_TARGET) is
			-- Show mapping properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_vars, l_inh_vars: EQUALITY_HASH_TABLE [STRING, STRING]
			i: INTEGER
			l_item: STRING_PROPERTY
			l_var_key: STRING
		do
			current_target := a_target
			is_refreshing := True
			refresh_current := agent show_properties_target_mapping (a_target)
			lock_update

			initialize_grid

			grid.column (1).set_title (conf_interface_names.mapping_old_name)
			grid.column (2).set_title (conf_interface_names.mapping_new_name)
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
				l_var_key := l_vars.key_for_iteration
				l_item.set_value (l_var_key)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent (s: STRING_32; a_var_key: STRING)
					require
						s_not_void: s /= Void
						a_var_key_not_void: a_var_key /= Void
					do
						update_mapping_key (a_var_key, s.as_string_8)
					end (?, l_var_key))
				grid.set_item (1, i + 1, l_item)
				create l_item.make ("")
				l_item.set_value (l_vars.item_for_iteration)
				l_item.pointer_button_press_actions.wipe_out
				l_item.pointer_double_press_actions.force_extend (agent l_item.activate)
				l_item.change_value_actions.extend (agent (s: STRING_32; a_var_key: STRING)
					require
						s_not_void: s /= Void
						a_var_key_not_void: a_var_key /= Void
					do
						update_mapping_key (a_var_key, s.as_string_8)
					end (?, l_var_key))
				grid.set_item (2, i + 1, l_item)
				l_inh_vars.search (l_var_key)
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

			add_button.select_actions.extend (agent add_mapping)
			remove_button.select_actions.extend (agent remove_mapping)

			unlock_update
			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
			grid_ok: grid /= Void and then not grid.is_destroyed
		end

	show_properties_target_advanced (a_target: CONF_TARGET) is
			-- Show advanced properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			current_target := a_target
			is_refreshing := True
			refresh_current := agent show_properties_target_advanced (a_target)
			lock_update

			initialize_properties

			add_advanced_properties

			unlock_update
			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
			properties_ok: properties /= Void and then not properties.is_destroyed
		end

feature {NONE} -- Implementation

	commit_changes is
			-- Commits configuration changes
		require
			conf_system_attached: conf_system /= Void
		do
			conf_system.store
			conf_system.set_file_date
		end

	group_section_expanded_status: HASH_TABLE [BOOLEAN, STRING_GENERAL] is
			-- Expanded status of sections of groups.
		once
			create Result.make (5)
			Result.force (True, conf_interface_names.section_general)
			Result.force (True, conf_interface_names.section_assertions)
			Result.force (False, conf_interface_names.section_warning)
			Result.force (False, conf_interface_names.section_debug)
			Result.force (False, conf_interface_names.section_advanced)
		end

	refresh is
			-- Regenerate currently displayed data.
		do
			if refresh_current /= Void then
				refresh_current.call (Void)
				set_focus
				section_tree.set_focus
			end
		end

	handle_value_changes (a_has_group_changed: BOOLEAN) is
			-- Store changes to disk.
		local
			l_section: CONFIGURATION_SECTION
			l_lib_grp: GROUP_SECTION
			l_lib_sec: LIBRARY_SECTION
		do
				-- check if the name of the current selected section has changed and update
			if section_tree.selected_item /= Void then
				l_section ?= section_tree.selected_item
				check
					section: l_section /= Void
				end
				if not l_section.name.as_string_32.is_equal (l_section.text.as_string_32) then
					l_section.set_text (l_section.name)
				end

					-- for groups, update the pixmap
				l_lib_grp ?= l_section
				if l_lib_grp /= Void then
					l_lib_grp.update_pixmap
				end
			end
		end

	open_text_editor is
			-- Open editor to edit the configuration file by hand.
		local
			l_cmd_string: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			l_cmd_string := external_editor_command.item ([conf_system.file_name, 1])
			if l_cmd_string /= Void and then not l_cmd_string.is_empty then
					-- Commit changes
				if conf_system /= Void then
					commit_changes
				end
				create l_env
				l_env.launch (l_cmd_string)
			end
		end

	initialize_properties_system is
			-- Initialize `properties' for system settings.
		require
			properties_ok: properties /= Void and then not properties.is_destroyed
		local
			l_string_prop: STRING_PROPERTY
			l_bool_prop: BOOLEAN_PROPERTY
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_choice_prop: STRING_CHOICE_PROPERTY
			l_targ_ord: ARRAYED_LIST [CONF_TARGET]
			l_targets, l_targets_none: ARRAYED_LIST [STRING_32]
		do
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

			properties.add_section (conf_interface_names.section_general)

				-- name
			create l_string_prop.make (conf_interface_names.system_name_name)
			l_string_prop.set_description (conf_interface_names.system_name_description)
			l_string_prop.set_value (conf_system.name)
			l_string_prop.validate_value_actions.extend (agent (s: STRING_32): BOOLEAN
				require
					s_not_void: s /= Void
				do
					Result := (create {EIFFEL_SYNTAX_CHECKER}).is_valid_system_name (s.as_string_8)
				end)
			l_string_prop.change_value_actions.extend (agent (s: STRING_32)
				require
					s_not_void: s /= Void
				do
					conf_system.set_name (s.as_string_8)
				end)
			l_string_prop.change_value_actions.extend (agent (s: STRING_32)
				require
					s_not_void: s /= Void
				do
					set_title (conf_interface_names.configuration_title (s))
				end)
			l_string_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32} ?, agent handle_value_changes (False)))
			properties.add_property (l_string_prop)

				-- description
			create l_mls_prop.make (conf_interface_names.system_description_name)
			l_mls_prop.enable_text_editing
			l_mls_prop.set_description (conf_interface_names.system_description_description)
			if conf_system.description /= Void then
				l_mls_prop.set_value (conf_system.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent conf_system.set_description))
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_mls_prop)

				-- library target
			create l_choice_prop.make_with_choices (conf_interface_names.system_library_target_name, l_targets_none)
			l_choice_prop.set_description (conf_interface_names.system_library_target_description)
			if conf_system.library_target /= Void then
				l_choice_prop.set_value (conf_system.library_target.name)
			end
			l_choice_prop.validate_value_actions.extend (agent check_library_target)
			l_choice_prop.change_value_actions.extend (agent simple_wrapper({STRING_32}?, agent conf_system.set_library_target_by_name))
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_choice_prop)

				-- readonly
			l_bool_prop := new_boolean_property (conf_interface_names.system_readonly_name, conf_system.is_readonly)
			l_bool_prop.set_description (conf_interface_names.system_readonly_description)
			l_bool_prop.change_value_actions.extend (agent conf_system.set_readonly)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_bool_prop)

				-- file name
			create l_string_prop.make (conf_interface_names.system_file_name)
			l_string_prop.set_description (conf_interface_names.system_file_description)
			l_string_prop.enable_readonly
			l_string_prop.set_value (conf_system.file_name)
			properties.add_property (l_string_prop)

				-- uuid
			create l_string_prop.make (conf_interface_names.system_uuid_name)
			l_string_prop.set_description (conf_interface_names.system_uuid_description)
			l_string_prop.enable_readonly
			l_string_prop.set_value (conf_system.uuid.out)
			properties.add_property (l_string_prop)

			properties.current_section.expand
		end

	initialize_properties_target_externals (an_external: CONF_EXTERNAL) is
			-- Initialize `properties' for externals target settings.
		require
			properties_ok: properties /= Void and then not properties.is_destroyed
			an_external_not_void: an_external /= Void
		local
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_dir_prop: DIRECTORY_PROPERTY
			l_file_prop: FILE_PROPERTY
			l_dial: DIALOG_PROPERTY [CONF_CONDITION_LIST]
			l_prop: STRING_PROPERTY
		do
			properties.add_section (conf_interface_names.section_general)

				-- type
			create l_prop.make ("Type")
			if an_external.is_include then
				l_prop.set_value (conf_interface_names.external_include)
			elseif an_external.is_object then
				l_prop.set_value (conf_interface_names.external_object)
			elseif an_external.is_library then
				l_prop.set_value (conf_interface_names.external_library)
			elseif an_external.is_make then
				l_prop.set_value (conf_interface_names.external_make)
			elseif an_external.is_resource then
				l_prop.set_value (conf_interface_names.external_resource)
			else
				check should_not_read: False end
			end
			l_prop.enable_readonly
			properties.add_property (l_prop)

				-- location
			if an_external.is_include then
				create l_dir_prop.make (conf_interface_names.external_location_name)
				l_dir_prop.set_description (conf_interface_names.external_location_description)
				l_dir_prop.enable_text_editing
				l_dir_prop.set_value (an_external.location)
				l_dir_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?,  agent an_external.set_location))
				l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
				properties.add_property (l_dir_prop)
			else
				create l_file_prop.make (conf_interface_names.external_location_name)
				l_file_prop.set_description (conf_interface_names.external_location_description)
				l_file_prop.enable_text_editing
				l_file_prop.set_value (an_external.location)
				l_file_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?,  agent an_external.set_location))
				l_file_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
				if an_external.is_resource then
					l_file_prop.add_filters (text_files_filter, text_files_description)
					l_file_prop.add_filters (resx_files_filter, resx_files_description)
					l_file_prop.add_filters (all_files_filter, all_files_description)
				end
				properties.add_property (l_file_prop)
			end

				-- description
			create l_mls_prop.make (conf_interface_names.external_description_name)
			l_mls_prop.set_description (conf_interface_names.external_description_description)
			l_mls_prop.enable_text_editing
			if an_external.description /= Void then
				l_mls_prop.set_value (an_external.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent an_external.set_description))
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_mls_prop)

				-- condition
			create l_dial.make_with_dialog (conf_interface_names.external_condition_name, create {CONDITION_DIALOG})
			l_dial.set_description (conf_interface_names.external_condition_description)
			l_dial.set_value (an_external.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent an_external.set_conditions)
			l_dial.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_CONDITION_LIST}?, agent handle_value_changes (False)))
			properties.add_property (l_dial)

			properties.current_section.expand
		end

	initialize_properties_target_tasks (a_task: CONF_ACTION; a_type: STRING_GENERAL) is
			-- Initialize `properties' for task target settings.
		require
			properties_ok: properties /= Void and then not properties.is_destroyed
			a_task_not_void: a_task /= Void
			a_type_ok: a_type /= Void and then not a_type.is_empty
		local
			l_mls_prop: MULTILINE_STRING_PROPERTY
			l_dir_prop: DIRECTORY_LOCATION_PROPERTY
			l_dial: DIALOG_PROPERTY [CONF_CONDITION_LIST]
			l_prop: STRING_PROPERTY
			l_bool_prop: BOOLEAN_PROPERTY
		do
			properties.add_section (conf_interface_names.section_general)

				-- type
			create l_prop.make (conf_interface_names.task_type_name)
			l_prop.set_description (conf_interface_names.task_type_description)
			l_prop.set_value (a_type)
			l_prop.enable_readonly
			properties.add_property (l_prop)

				-- command
			create l_prop.make (conf_interface_names.task_command_name)
			l_prop.set_description (conf_interface_names.task_command_description)
			l_prop.set_value (a_task.command)
			l_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent a_task.set_command))
			l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_prop)

				-- description
			create l_mls_prop.make (conf_interface_names.task_description_name)
			l_mls_prop.set_description (conf_interface_names.task_description_description)
			l_mls_prop.enable_text_editing
			if a_task.description /= Void then
				l_mls_prop.set_value (a_task.description)
			end
			l_mls_prop.change_value_actions.extend (agent simple_wrapper ({STRING_32}?, agent a_task.set_description))
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_mls_prop)

				-- working directory
			create l_dir_prop.make (conf_interface_names.task_working_directory_name)
			l_dir_prop.set_target (current_target)
			l_dir_prop.set_description (conf_interface_names.task_working_directory_description)
			if a_task.working_directory /= Void then
				l_dir_prop.set_value (a_task.working_directory.original_path)
			end
			l_dir_prop.enable_text_editing
			l_dir_prop.change_value_actions.extend (agent (a_dir: STRING_32; ia_task: CONF_ACTION)
				do
					if a_dir = Void or else a_dir.is_empty then
						ia_task.set_working_directory (Void)
					else
						ia_task.set_working_directory (conf_factory.new_location_from_path (a_dir, current_target))
					end
				end (?, a_task)
			)
			l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_dir_prop)

				-- must succeed
			l_bool_prop := new_boolean_property (conf_interface_names.task_succeed_name, a_task.must_succeed)
			l_bool_prop.set_description (conf_interface_names.task_succeed_description)
			l_bool_prop.change_value_actions.extend (agent a_task.set_must_succeed)
			l_bool_prop.change_value_actions.extend (agent change_no_argument_boolean_wrapper (?, agent handle_value_changes (False)))
			properties.add_property (l_bool_prop)

				-- condition
			create l_dial.make_with_dialog (conf_interface_names.task_condition_name, create {CONDITION_DIALOG})
			l_dial.set_description (conf_interface_names.task_condition_description)
			l_dial.set_value (a_task.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent a_task.set_conditions)
			l_dial.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_CONDITION_LIST}?, agent handle_value_changes (False)))
			properties.add_property (l_dial)

			properties.current_section.expand
		end

feature {NONE} -- Configuration setting

	add_variable is
			-- Add a new variable.
		require
			current_target: current_target /= Void
		do
			if not current_target.variables.has ("new") then
				current_target.add_variable ("new", "new_value")
				show_properties_target_variables (current_target)
			end
		end

	remove_variable is
			-- Remove a variable.
		require
			current_target: current_target /= Void
			variables: grid /= Void
		local
			l_item: TEXT_PROPERTY [STRING_GENERAL]
		do
			if grid.selected_rows /= Void and then not grid.selected_rows.is_empty then
				l_item ?= grid.selected_rows.first.item (1)
				check
					valid_item: l_item /= Void
					valid_value: l_item.value /= Void
				end
				current_target.remove_variable (l_item.value.as_string_8)
				show_properties_target_variables (current_target)
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
				current_target.internal_variables.replace_key (a_new_key.as_lower, an_old_key)
			end
			show_properties_target_variables (current_target)
		end

	update_variable_value (a_key: STRING; a_value: STRING) is
			-- Update value part of a variable.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			a_key_valid: current_target.variables.has (a_key)
		do
			if a_value /= Void then
				current_target.add_variable (a_key, a_value)
			end
			show_properties_target_variables (current_target)
		end

	add_mapping is
			-- Add a new mapping.
		require
			current_target: current_target /= Void
		do
			if not current_target.mapping.has ("new") then
				current_target.add_mapping ("new", "new_value")
				show_properties_target_mapping (current_target)
			end
		end

	remove_mapping is
			-- Remove a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
		local
			l_item: TEXT_PROPERTY [STRING_GENERAL]
		do
			if grid.selected_rows /= Void and then not grid.selected_rows.is_empty then
				l_item ?= grid.selected_rows.first.item (1)
				check
					valid_item: l_item /= Void
				end
				current_target.remove_mapping (l_item.text.as_string_8)
				show_properties_target_mapping (current_target)
			end
		end

	update_mapping_key (an_old_key: STRING; a_new_key: STRING) is
			-- Update key part of a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			an_old_key_valid: current_target.mapping.has (an_old_key)
		do
			if (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_new_key) then
				current_target.internal_mapping.replace_key (a_new_key.as_upper, an_old_key)
			end
			show_properties_target_mapping (current_target)
		end

	update_mapping_value (a_key: STRING; a_value: STRING) is
			-- Update value part of a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			a_key_valid: current_target.mapping.has (a_key)
		do
			if (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_value) then
				current_target.add_mapping (a_key, a_value.as_upper)
			end
			show_properties_target_mapping (current_target)
		end

feature {NONE} -- Validation and warning generation

	check_library_target (a_target: STRING_32): BOOLEAN is
			-- Is `a_target' a valid library target?
		require
			target_of_system: a_target /= Void and then not a_target.is_empty implies conf_system.targets.has (a_target)
		local
			l_target: CONF_TARGET
		do
			if a_target /= Void and then not a_target.is_empty then
				l_target := conf_system.targets.item (a_target)
				if not l_target.overrides.is_empty then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.library_target_override, Current, Void)
				else
					Result := True
				end
			else
				Result := True
			end
		end

feature {NONE} -- Wrappers

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

	description_height: INTEGER is 50

invariant
	configuration_space: is_initialized implies configuration_space /= Void
	section_tree: is_initialized implies section_tree /= Void
	toolbar: is_initialized implies toolbar /= Void
	split_area: is_initialized implies split_area /= Void
	grid_implies_add_button: grid /= Void implies add_button /= Void and then not add_button.is_destroyed
	grid_implies_remove_button: grid /= Void implies remove_button /= Void and then not remove_button.is_destroyed
	debug_clauses: debug_clauses /= Void
	group_section_expanded_status: group_section_expanded_status /= Void
	conf_system: conf_system /= Void
	ok_button: is_initialized implies ok_button /= Void
	external_editor_command_ok: is_initialized implies external_editor_command /= Void
	hide_actions_not_void: is_initialized implies hide_actions /= Void
	selected_target_ok: selected_target /= Void and then not selected_target.is_empty

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
