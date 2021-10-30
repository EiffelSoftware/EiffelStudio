note
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
			create_interface_objects,
			initialize,
			is_in_default_state,
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
			{ANY} conf_system, current_target
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

	make_for_target (a_system: like conf_system; a_target: STRING_32; a_factory: like conf_factory; a_debugs: like debug_clauses; a_pixmaps: CONF_PIXMAPS; a_editor: like external_editor_command)
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
			current_target := a_factory.new_target ({STRING_32} "*", a_system)
			selected_target := a_target
			set_pixmaps (a_pixmaps)
			conf_system := a_system
			conf_factory := a_factory
			external_editor_command := a_editor
			default_create
			set_refresh_current (Void)
			window := Current
			config_windows.force (Current, conf_system.file_name)
		ensure
			system_set: conf_system = a_system
			factory_set: conf_factory = a_factory
			debug_clauses_set: a_debugs /= Void implies debug_clauses = a_debugs
			selected_target_set: selected_target = a_target
		end

	make (a_system: like conf_system; a_factory: like conf_factory; a_debugs: like debug_clauses; a_pixmaps: CONF_PIXMAPS; a_editor: like external_editor_command)
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

	create_interface_objects
		do
			Precursor
			create properties
			create grid
			create toolbar.make
			create section_tree
			create configuration_space
			create split_area
			create ok_button.make_with_text (names.b_ok)
		end

	initialize
			-- Initialize `Current'.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l_btn: EV_BUTTON
			l_accel: EV_ACCELERATOR
			l_title: STRING_32
		do
				-- set default layout values
			set_padding_size (layout_constants.default_padding_size)

				-- window
			Precursor
			l_title := conf_interface_names.configuration_title (conf_system.name)
			if not conf_system.is_storable then
				l_title.append (conf_interface_names.readonly_warning)
			end
			set_title (l_title)
			set_icon_pixmap (conf_pixmaps.tool_config_icon)
			enable_user_resize

			create vb
			extend (vb)
			vb.set_padding (layout_constants.default_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

				-- toolbar
			vb.extend (toolbar)
			vb.disable_item_expand (toolbar)
			toolbar.edit_manually_button.select_actions.extend (agent open_text_editor)
			toolbar.edit_manually_button.enable_sensitive
			accelerators.append (toolbar.accelerators)

			vb.extend (split_area)

					-- section tree
			section_tree.set_minimum_size (220, 230)
			initialize_section_tree
			split_area.set_first (section_tree)

				-- configuration space_g
			split_area.set_second (configuration_space)
			configuration_space.set_padding (layout_constants.default_padding_size)

				-- ok and cancel buttons
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)

			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			ok_button.select_actions.extend (agent on_ok)
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
				do
					if attached {CONFIGURATION_SECTION} section_tree.selected_item as l_section then
						l_section.show_context_menu
					else
						check expected_selected_item_type: False end
					end
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

	selected_target: STRING_32
			-- Target to select on startup.

	external_editor_command: FUNCTION [READABLE_STRING_GENERAL, INTEGER, READABLE_STRING_GENERAL]
			-- Command that builds an external editor command line by taking a target and a line number.

	split_position: INTEGER
			-- Split position.
		require
			initialized: is_initialized
		do
			Result := split_area.split_position
		end

feature -- Update

	set_split_position (a_position: like split_position)
			-- Set split position if possible to `a_position' otherwise
			-- closer to the range of possible position of `split_area'.
		require
			initialized: is_initialized
		local
			l_pos: INTEGER
		do
			if split_area.full then
				if a_position < split_area.minimum_split_position then
					l_pos := split_area.minimum_split_position
				elseif a_position > split_area.maximum_split_position then
					l_pos := split_area.maximum_split_position
				else
					l_pos := a_position
				end
				split_area.set_split_position (l_pos)
			end
		end

feature -- Command

	destroy
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			Precursor
			config_windows.remove (conf_system.file_name)
		end

feature {NONE} -- Agents

	set_refresh_current (proc: like refresh_current_procedure)
		do
			refresh_current_procedure := proc
		end

	refresh_current
		do
			if attached refresh_current_procedure as proc then
				proc.call (Void)
			end
		end

	refresh_current_procedure: detachable PROCEDURE
			-- What to call to refresh the current view.

	on_cancel
			-- Quit without saving.
		do
			is_canceled := True
			hide
		end

	on_ok
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

feature {NONE} -- Layout status

	reset_grid
		do
			grid.wipe_out
				-- Remove grid associated button
			if attached add_button as but then
				add_button := Void
				but.destroy
			end
			if attached remove_button as but then
				remove_button := Void
				but.destroy
			end
			grid_used := False
		ensure
			not grid_used
		end

	reset_properties
		do
			properties.reset
			properties_used := False
		ensure
			not properties_used
		end

	use_properties
		do
			reset_grid
			properties_used := True
		ensure
			not grid_used
			properties_used
		end

	use_grid
		do
			reset_properties
			grid_used := True
		ensure
			not properties_used
			grid_used
		end

	properties_used: BOOLEAN

	grid_used: BOOLEAN

feature {NONE} -- Layout components

	ok_button: EV_BUTTON
			-- Ok button

	split_area: EV_HORIZONTAL_SPLIT_AREA
			-- Split area between `section_tree' and `configuration_space'

	section_tree: EV_TREE
			-- Tree to select what information to display.

	grid: ES_GRID
			-- Grid for variables and type mappings.

	add_button: detachable EV_BUTTON
			-- Button to add an item to `grid'.

	remove_button: detachable EV_BUTTON
			-- Button to remove an item from `grid'.

	configuration_space: EV_VERTICAL_BOX
			-- Space to put configuration.

feature {NONE} -- Element initialization

	initialize_properties_for (container: EV_VERTICAL_BOX)
			-- Prepare `properties' to be used in `container'.
		local
			l_frame: EV_FRAME
			l_description_area: ES_SCROLLABLE_LABEL
			p: like properties
		do
				-- Property grid.
			create l_frame
			container.extend (l_frame)
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)

			p := properties
--			if p = Void then
--				create p
--				properties := p
--			end
			l_frame.extend (p)
			p.focus_in_actions.extend (agent
				do
					if default_push_button /= Void then
						remove_default_push_button
					end
				end)
			p.focus_out_actions.extend (agent set_default_push_button (ok_button))

				-- property grid description field
			create l_frame
			container.extend (l_frame)
			container.disable_item_expand (l_frame)
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
				-- Set padding.
			l_frame.set_border_width (4)

				-- Create description container.
			create l_description_area
			p.set_description_field (l_description_area)
			l_description_area.set_minimum_height (description_height)
			l_description_area.set_minimum_width (100)
			l_frame.extend (l_description_area)
		ensure
			properties_attached: properties_used
		end

	initialize_properties
			-- Prepare `properties'.
		require
			not_properties_and_grid: not properties_used or not grid_used
		local
			p: like properties
		do
			if not properties_used or else attached tabs then
				configuration_space.wipe_out

				use_properties
				p := properties
				create p
				properties := p

					-- Remove tabs.
				if attached tabs as t then
					t.destroy
					tabs := Void
				end

				initialize_properties_for (configuration_space)
			else
				if properties.is_destroyed then
					check not properties_used end
				else
					properties.reset
				end
			end
		ensure
			properties_ok: properties_used and then not properties.is_destroyed
			grid_void: not grid_used
			buttons_void: add_button = Void and remove_button = Void
		end

	initialize_grid
			-- Prepare `grid'.
		require
			not_properties_and_grid: not properties_used or not grid_used
		local
			vb_grid: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_column_width1, l_column_width2: INTEGER_32
			b: EV_BUTTON
			g: ES_GRID
		do
			g := grid
			if not grid_used then
				configuration_space.wipe_out

					-- border
				create vb_grid
				vb_grid.set_border_width (1)
				vb_grid.set_background_color ((create {EV_STOCK_COLORS}).black)
				configuration_space.extend (vb_grid)

					-- grid
				use_grid
				g := grid
				create g
				grid := g

				vb_grid.extend (g)
				g.set_column_count_to (2)
				g.column (1).set_width (200)
				g.column (2).set_width (200)
				g.focus_in_actions.extend (agent
					do
						if default_push_button /= Void then
							remove_default_push_button
						end
					end)
				g.focus_out_actions.extend (agent set_default_push_button (ok_button))

					-- add add and remove buttons
				create hb
				hb.set_padding (layout_constants.default_padding_size)
				configuration_space.extend (hb)
				configuration_space.disable_item_expand (hb)
				hb.extend (create {EV_CELL})

				create b.make_with_text (conf_interface_names.general_add)
				add_button := b
				b.set_pixmap (conf_pixmaps.general_add_icon)
				layout_constants.set_default_width_for_button (b)
				hb.extend (b)
				hb.disable_item_expand (b)

				create b.make_with_text (conf_interface_names.general_remove)
				remove_button := b
				b.set_pixmap (conf_pixmaps.general_remove_icon)
				layout_constants.set_default_width_for_button (b)
				hb.extend (b)
				hb.disable_item_expand (b)
			else
				l_column_width1 := g.column (1).width
				l_column_width2 := g.column (2).width
				g.wipe_out
				g.set_column_count_to (2)
				g.column (1).set_width (l_column_width1)
				g.column (2).set_width (l_column_width2)

					-- clear button actions
				check
					attached add_button as l_add_button and
					attached remove_button as l_remove_button
				then
					l_add_button.select_actions.wipe_out
					l_remove_button.select_actions.wipe_out
				end
			end

			g.enable_border
			g.enable_last_column_use_all_width
			g.enable_single_row_selection
		ensure
			grid_ok: grid_used and then not grid.is_destroyed
			add_button_ok: attached add_button as ab and then not ab.is_destroyed
			remove_button_ok: attached remove_button as rb and then not rb.is_destroyed
			properties_not_used: not properties_used
		end

	tabs: detachable EV_NOTEBOOK

	initialize_tabs (t: CONF_TARGET)
			-- Initialize tabs for target `t'.
		local
			notebook: like tabs
			properties_tab: EV_VERTICAL_BOX
			language_tab: EV_VERTICAL_BOX
			options: CONF_TARGET_OPTION
			inherited_options: CONF_TARGET_OPTION
			inherited_void_safety: CONF_ORDERED_CAPABILITY
			inherited_catcall_detection: CONF_ORDERED_CAPABILITY
			inherited_concurrency: CONF_ORDERED_CAPABILITY
			description_frame: EV_FRAME
			description_field: ES_SCROLLABLE_LABEL
		do
			notebook := tabs
			if notebook = Void then
					-- Replace configuration space with tabs.
				configuration_space.wipe_out

				create notebook
				tabs := notebook
				configuration_space.extend (notebook)

					-- Fill properties tab.
				create properties_tab
				notebook.extend (properties_tab)
				notebook.set_item_text (properties_tab, conf_interface_names.tab_properties_name)
				initialize_properties_for (properties_tab)

					-- Fill language tab.
				create language_tab
				notebook.extend (language_tab)
				notebook.set_item_text (language_tab, conf_interface_names.tab_language_name)
			else
				check
					is_initialized_language_tab: attached {EV_VERTICAL_BOX} notebook.i_th (2) as l
				then
					language_tab := l
					l.wipe_out
				end
			end

			debug ("to_implement")
				(create {REFACTORING_HELPER}).to_implement ("Avoid creation of the property page from scratch")
			end
			options := t.changeable_internal_options
			if attached t.extends as inherited_target then
				inherited_options := inherited_target.options
				inherited_void_safety := inherited_options.void_safety_capability
				inherited_catcall_detection := inherited_options.catcall_safety_capability
				inherited_concurrency := inherited_options.concurrency_capability
			end

			create description_field

			add_choice_value (
				conf_interface_names.option_void_safety_name,
				conf_interface_names.option_void_safety_description,
				conf_interface_names.option_void_safety_value,
				options.void_safety_capability,
				inherited_void_safety,
				description_field,
				language_tab
			)

			add_choice_value (
				conf_interface_names.option_catcall_detection_name,
				conf_interface_names.option_catcall_detection_description,
				conf_interface_names.option_catcall_detection_value,
				options.catcall_safety_capability,
				inherited_catcall_detection,
				description_field,
				language_tab
			)

			add_choice_value (
				conf_interface_names.option_concurrency_name,
				conf_interface_names.option_concurrency_description,
				conf_interface_names.option_concurrency_value,
				options.concurrency_capability,
				inherited_concurrency,
				description_field,
				language_tab
			)

			create description_frame
			language_tab.extend (description_frame)
			description_frame.extend (description_field)
			description_field.set_minimum_height (description_height)
			description_field.set_minimum_width (100)
			description_field.set_minimum_height (80)

			notebook.selection_actions.wipe_out
			notebook.selection_actions.extend (agent refresh_current)
		end

	initialize_section_tree
			-- Initialize `section_tree'.
		do
				-- system section
			section_tree.extend (create {SYSTEM_SECTION}.make (conf_system, Current))

				-- recursively add targets
			across
				top_targets (True) as ic
			loop
				add_target_sections (ic, section_tree)
			end
		ensure
			section_tree_not_void: section_tree /= Void
		end

feature -- Access / targets

	container_has_target (a_container: ITERABLE [CONF_TARGET]; a_target: CONF_TARGET): BOOLEAN
			-- Is `a_target` in `a_container`?
		do
			Result := across a_container as ic some a_target.same_as (ic) end
		end

	top_targets (a_remotes_targets_included: BOOLEAN): ARRAYED_LIST [CONF_TARGET]
			-- Top target in the chain or parent target.
			-- Include one level of remote target if any.
		local
			t: CONF_TARGET
		do
			create Result.make (0)
			across
				conf_system.target_order as ic
			loop
				t := top_parent (ic)
				if container_has_target (Result, t) then
						-- Skip
				else
					Result.force (t)
				end
			end
		ensure
			across Result as ic all (ic.extends = Void or is_remote_target (ic)) end
		end

	top_parent (a_target: CONF_TARGET): CONF_TARGET
			-- Top parent, and at most one level of remote target (i.e outside current system).
		do
			if is_remote_target (a_target) then
				Result := a_target
			elseif attached a_target.extends as l_parent then
				Result := top_parent (l_parent)
			else
				Result := a_target
			end
		end

	ordered_parents_until (a_target, a_top_parent: CONF_TARGET): detachable LIST [CONF_TARGET]
			-- Ordered list of parent for `a_target, until `a_top_parent`.
		require
			not_same_targets: not a_target.same_as (a_top_parent)
		local
			t: detachable CONF_TARGET
		do
			create {ARRAYED_LIST [CONF_TARGET]} Result.make (0)
			from
				t := a_target.extends
			until
				t = Void or a_top_parent.same_as (t)
			loop
				Result.extend (t)
				t := t.extends
			end
			if Result.is_empty or not a_top_parent.same_as (t) then
				Result := Void
			end
		end

	child_targets_of (a_target: CONF_TARGET): LIST [CONF_TARGET]
			-- Child target of `a_target`.
		local
			t: CONF_TARGET
		do
			if is_remote_target (a_target) then
					-- This is a remote target, i.e from another conf system.
				create {ARRAYED_LIST [CONF_TARGET]} Result.make (0)
				across
					conf_system.target_order as ic
				loop
					t := ic
					if a_target.same_as (t.extends) then
						Result.force (t)
					elseif attached ordered_parents_until (t, a_target) as lst then
						t := lst.last
						if container_has_target (Result, t) then
								-- Already included
						else
							Result.force (t)
						end
					end
				end
			else
				Result := a_target.child_targets
			end
		ensure
			all_child_of_target: across Result as ic all a_target.same_as (ic.extends) end
		end

	is_remote_target (a_target: CONF_TARGET): BOOLEAN
			-- Is `a_target` outside current `conf_system`?
		do
			if attached a_target.system as sys then
				if sys = conf_system then
					Result := False
				else
					Result := not (sys.name.is_case_insensitive_equal (conf_system.name) and then (sys.uuid ~ conf_system.uuid))
				end
			else
				Result := conf_system /= Void
			end
		end

	remote_target_section_from (a_target: CONF_TARGET; a_root: EV_TREE_NODE_LIST): detachable REMOTE_TARGET_SECTION
			-- Section associated with `a_target` if any.
		do
			across
				a_root as ic
			until
				Result /= Void
			loop
				if
					attached {REMOTE_TARGET_SECTION} ic as l_remote and then
					l_remote.target.same_as (a_target)
				then
					Result := l_remote
				end
			end
		end

feature {NONE} -- Choice options

	heading_rows: INTEGER = 2
			-- Number of rows before buttons to set non-default option values.

	add_choice_value	(
			name, description: STRING_32;
			items: ARRAYED_LIST [STRING_32];
			capability: CONF_ORDERED_CAPABILITY;
			inherited_capability: detachable CONF_ORDERED_CAPABILITY;
			description_field: ES_SCROLLABLE_LABEL;
			container: EV_BOX
		)
			-- Add choice value `option' with specified `name', `description' and item names `items' to the given `container'
			-- with optionally inherited value `inherited_option'.
		require
			container_not_destroyed: not container.is_destroyed
			container_extendible: container.extendible
			consitent_items: items.count = capability.value.count
			consistent_inherited_option: attached inherited_capability implies inherited_capability.same_kind (capability)
		local
			property_frame: EV_FRAME
			property_inner_frame: EV_VERTICAL_BOX
			check_button: EV_CHECK_BUTTON
			radio_button: EV_RADIO_BUTTON
			property_group: EV_TABLE
			column_name: EV_LABEL
			default_capability: EV_CHECK_BUTTON
			default_preference: EV_CHECK_BUTTON
			row: INTEGER
			is_default_capability: BOOLEAN
			is_default_preference: BOOLEAN
			update_preferred_buttons: PROCEDURE
			update_description: PROCEDURE
			option: CONF_VALUE_CHOICE
			inherited_option: CONF_VALUE_CHOICE
		do
			update_description := agent description_field.set_text (description)
			create property_frame.make_with_text (name)
			property_frame.set_border_width (layout_constants.default_border_size)
			container.extend (property_frame)
			container.disable_item_expand (property_frame)
			create property_inner_frame
			property_inner_frame.set_padding_width (layout_constants.default_padding_size)
			property_frame.extend (property_inner_frame)

			create property_group
			property_inner_frame.extend (property_group)

				-- In addition to `items' there are header and default value.
			property_group.resize (4, items.count + heading_rows)
			property_group.disable_homogeneous
			create column_name.make_with_text (conf_interface_names.capability_header_capable_of_name)
			column_name.align_text_left
			property_group.put_at_position (column_name, 1, 1, 2, 1)
			create column_name.make_with_text (conf_interface_names.capability_header_if_root_name)
			column_name.align_text_left
			property_group.put_at_position (column_name, 3, 1, 2, 1)
			option := capability.value
			if attached inherited_capability then
				inherited_option := inherited_capability.value
			end
			if attached inherited_option then
				create default_capability.make_with_text (conf_interface_names.capability_toggle_inherited_name)
			else
				create default_capability.make_with_text (conf_interface_names.capability_toggle_default_name)
			end
				-- Make sure default capability button is properly initialized before registering any actions.
			if option.is_set then
				default_capability.disable_select
			else
				default_capability.enable_select
			end
			on_toggle (agent option.unset, agent set_capability (option, property_group), default_capability)
			default_capability.focus_in_actions.extend (update_description)
			property_group.put_at_position (default_capability, 1, 2, 2, 1)
			if attached inherited_option then
				create default_preference.make_with_text (conf_interface_names.capability_toggle_inherited_name)
					-- TODO: provide implementation.
			else
				create default_preference.make_with_text (conf_interface_names.capability_toggle_default_name)
			end
				-- Make sure default preference button is properly initialized before registering any actions.
			if capability.is_root_set then
				default_preference.disable_select
			else
				default_preference.enable_select
			end
			on_toggle
				(agent disable_custom_root_option (capability, property_group),
				agent enable_custom_root_option (capability, property_group),
				default_preference)
			update_preferred_buttons := agent (default_preference.select_actions).call ([])
			default_preference.focus_in_actions.extend (update_description)
			property_group.put_at_position (default_preference, 3, 2, 2, 1)
			default_capability.select_actions.extend (update_preferred_buttons)
			across
				items.new_cursor.reversed as i
			from
				row := heading_rows + 1
			loop
					-- Test if option index has reached inherited index or default index.
					-- After that it will have a check mark.
				if is_default_capability then
						-- Keep capablity mark for next iterations.
						-- Erase preference mark.
					is_default_preference := False
				elseif attached inherited_option then
					is_default_capability := inherited_option.index = @ i.target_index
					is_default_preference := is_default_capability
				else
					is_default_capability := option.default_index = @ i.target_index
					is_default_preference := is_default_capability
				end
				create check_button.make_with_text (i)
				property_group.put_at_position (check_button, 2, row, 1, 1)
					-- Mark current item as enabled default if needed.
					-- TODO: replace pixmap with pixel buffer and use drawable to avoid cloning.
				if is_default_capability then
					property_group.put_at_position (conf_pixmaps.project_settings_default_icon.twin, 1, row, 1, 1)
						-- Update default icon depending on the state of a default button.
					on_toggle
						(agent property_group.put_at_position (conf_pixmaps.project_settings_default_highlighted_icon.twin, 1, row, 1, 1),
						agent property_group.put_at_position (conf_pixmaps.project_settings_default_icon.twin, 1, row, 1, 1),
						default_capability)
				end
					-- Indicate whether an value is checked.
				if capability.is_capable (@ i.target_index.as_natural_8) then
					check_button.enable_select
				end
					-- Last item is always checked.
				if @ i.is_last then
					check_button.disable_sensitive
				else
						-- Enable or disable current button depending on the state of a default button.
					on_toggle (agent check_button.disable_sensitive, agent check_button.enable_sensitive, default_capability)
						-- Enable or disable other capabilities and preferred buttons depending on the state of the current button.
					on_toggle
						(agent select_smaller_capabilities (option, @ i.target_index.as_natural_8, row, property_group, update_preferred_buttons),
						agent unselect_larger_capabilities (option, @ i.target_index.as_natural_8, row, property_group, update_preferred_buttons),
						check_button)
				end
				check_button.focus_in_actions.extend (update_description)
				check_button.set_tooltip (description)
				create radio_button -- .make_with_text (i.item)
				property_group.put_at_position (radio_button, 4, row, 1, 1)
				radio_button.focus_in_actions.extend (update_description)
				radio_button.select_actions.extend (agent capability.put_root_index (@ i.target_index.as_natural_8))
				row := row + 1
			end
				-- Update with current state.
				-- Update capability buttons.
			if attached {EV_CHECK_BUTTON} property_group.item_at_position (2, property_group.rows - option.index + 1) as b then
				b.enable_select
			end
				-- Refresh all capability-dependent buttons.
			default_capability.select_actions.call
				-- Refresh all preference-dependent buttons.
			default_preference.select_actions.call
		end

	on_toggle (select_action, unselect_action: PROCEDURE; button: EV_CHECK_BUTTON)
			-- Register actions `select_action' and `unselect_action' to be performed
			-- when `button' becomes selected and unselected respectively.
		do
			button.select_actions.extend
				(agent (s, u: PROCEDURE; b: EV_CHECK_BUTTON)
					do
						if b.is_selected then
							s.call
						else
							u.call
						end
					end
				(select_action, unselect_action, button))
		end

	set_capability (o: CONF_VALUE_CHOICE; group: EV_TABLE)
			-- Set capability option `o' from the current state of associated group `group'.
		local
			r: INTEGER
			index: NATURAL_8
		do
			from
					-- Last item is always selected, skip it.
				r := group.rows - 1
					-- `index' corresponds to a knowingly selected item.
				index := 1
			until
				r <= heading_rows or else
				index >= o.count or else
				not attached {EV_CHECK_BUTTON} group.item_at_position (2, r) as b or else
				not b.is_selected
			loop
				index := index + 1
				r := r - 1
			variant
				r
			end
			o.put_index (index)
		end

	enable_custom_root_option (o: CONF_ORDERED_CAPABILITY; group: EV_TABLE)
			-- Enable custom root option for `o' associated with group `group'.
		local
			r: INTEGER
			index: NATURAL_8
		do
				-- Update current root index if required.
			if o.is_root_set and then not o.is_capable (o.custom_root_index) then
					-- Custom root index is no longer valid, update it.
				o.put_root_index (o.root_index)
			end
				-- Update default marks.
			show_default_root_option (False, o, group)
				-- Enable or disable radio buttons depending on whether the corresponding capability is supported.
				-- Mark a current root option.
			from
				index := o.value.count
				r := group.rows - o.value.count + 1
			until
				index <= 0
			loop
				if attached {EV_RADIO_BUTTON} group.item_at_position (4, r) as b then
					if o.is_capable (index) then
							-- Enable allowed option value.
						b.enable_sensitive
						if o.root_index = index then
								-- Mark currently selected option value.
							b.enable_select
						end
					else
							-- Disable non-supported option value.
						b.disable_sensitive
					end
				end
				r := r + 1
				index := index - 1
			variant
				index.as_integer_32
			end
		end

	disable_custom_root_option (o: CONF_ORDERED_CAPABILITY; group: EV_TABLE)
			-- Disable custom root option for `o' associated with group `group'.
		local
			r: INTEGER
		do
				-- Update current root index.
			o.unset_root
				-- Update default marks.
			show_default_root_option (True, o, group)
				-- Disable all radio-buttons.
			from
				r := group.rows
			until
				r <= heading_rows
			loop
				if attached {EV_RADIO_BUTTON} group.item_at_position (4, r) as b then
						-- Disable non-supported option value.
					b.disable_sensitive
				end
				r := r - 1
			variant
				r
			end
		end

	show_default_root_option (is_highlighted: BOOLEAN; o: CONF_ORDERED_CAPABILITY; group: EV_TABLE)
			-- Update a mark that indicates a default root option of `o' in associated group `group'.
		local
			r: INTEGER
			index: NATURAL_8
			default_row: INTEGER
		do
				-- Compute a row that is a default one.
			default_row := group.rows - o.default_root_index + 1
			from
				index := o.value.count
				r := group.rows - o.value.count + 1
			until
				index <= 0
			loop
					-- We cannot put anything to a cell if it contains an item.
				if attached group.item_at_position (3, r) as m then
						-- Remove only non-default mark.
						-- TODO: replace pixmap with pixel buffer and use drawable to avoid cloning.
					group.prune (m)
				end
				if r = default_row then
						-- Put a default mark.
						-- TODO: replace pixmap with pixel buffer and use drawable to avoid cloning.
					group.put_at_position (
						(if is_highlighted then
							conf_pixmaps.project_settings_default_highlighted_icon
						else
							conf_pixmaps.project_settings_default_icon
						end).twin,
						3, r, 1, 1)
				end
				r := r + 1
				index := index - 1
			variant
				index.as_integer_32
			end
		end

	select_smaller_capabilities (o: CONF_VALUE_CHOICE; index: like {CONF_VALUE_CHOICE}.index; line: INTEGER; group: EV_TABLE; update_action: PROCEDURE)
			-- Select all capabilities smaller than this one.
		do
				-- Update options, but avoid setting a lower index.
			if o.index < index then
				o.put_index (index)
			end
				-- It is sufficient to toggle only a next button, it will trigger the rest.
			if
				line < group.rows and then
				attached {EV_CHECK_BUTTON}  group.item_at_position (2, line + 1) as b
			then
				b.enable_select
			end
			update_action.call
		end

	unselect_larger_capabilities (o: CONF_VALUE_CHOICE; index: like {CONF_VALUE_CHOICE}.index; line: INTEGER; group: EV_TABLE; update_action: PROCEDURE)
			-- Unselect all capabilities larger than this one.
			-- It is sufficient to toggle only a next one, it will trigger the rest.
		do
				-- Update options, but avoid setting a higher index.
			if o.index >= index then
				o.put_index (index - 1)
			end
			if
				line > heading_rows + 1 and then
				attached {EV_CHECK_BUTTON} group.item_at_position (2, line - 1) as b
			then
				b.disable_select
			end
			update_action.call
		end

feature {REMOTE_TARGET_SECTION, TARGET_SECTION, SYSTEM_SECTION} -- Target creation

	add_target_sections (a_target: CONF_TARGET; a_root: EV_TREE_NODE_LIST)
			-- Add sections for `a_target' under `a_root'.
		require
			a_target_not_void: a_target /= Void
			a_root_ok: a_root /= Void and then not a_root.is_destroyed and a_root.extendible
		local
			l_parent: EV_TREE_NODE_LIST
			l_remote_target: REMOTE_TARGET_SECTION
			l_target: TARGET_SECTION
			l_target_tasks: TARGET_TASKS_SECTION
			l_target_externals: TARGET_EXTERNALS_SECTION
			l_target_advanced: TARGET_ADVANCED_SECTION
			l_target_groups: TARGET_GROUPS_SECTION
			l_list: EV_TREE_NODE_LIST
		do
			if is_remote_target (a_target) then
					-- target
				create l_remote_target.make (a_target, Void, Current)
				a_root.extend (l_remote_target)

				l_parent := l_remote_target
			else
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
				l_target_externals.set_cflag (a_target.internal_external_cflag)
				l_target_externals.set_objects (a_target.internal_external_object)
				l_target_externals.set_libraries (a_target.internal_external_library)
				l_target_externals.set_resources (a_target.internal_external_resource)
				l_target_externals.set_linker_flag (a_target.internal_external_linker_flag)
				l_target_externals.set_makefiles (a_target.internal_external_make)

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
				if a_target.name.is_case_insensitive_equal_general (selected_target) then
					from
						l_list := l_target
					until
						not attached {EV_TREE_NODE} l_list as l_node
					loop
						l_node.expand
						l_list := l_node.parent
					end
				end
				l_parent := l_target
			end
				-- add child targets
			across
				child_targets_of (a_target) as ic
			loop
				add_target_sections (ic, l_parent)
			end
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

				create l_label.make (a_message)
				configuration_space.extend (l_label)
				configuration_space.disable_item_expand (l_label)

				configuration_space.extend (create {EV_CELL})
			end

				-- remove grid
			reset_grid

				-- Remove properties.
			reset_properties

				-- Remove tabs.
			if attached tabs as t then
				t.destroy
				tabs := Void
			end

			unlock_update
		end

	show_properties_system
			-- Show configuration for system properties.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_system)
			lock_update

			initialize_properties

			initialize_properties_system

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_remote_target_general (a_target: CONF_TARGET)
			-- Show general properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
			is_remote_target: is_remote_target (a_target)
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_remote_target_general (a_target))
			lock_update

			initialize_properties

			current_target := a_target

			add_remote_target_properties

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_general (a_target: CONF_TARGET)
			-- Show general properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_target_general (a_target))
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

	show_properties_target_warning (a_target: CONF_TARGET)
			-- Show warning properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_target_warning (a_target))
			lock_update

			initialize_properties

			current_target := a_target
			add_warning_option_properties (a_target.changeable_internal_options, a_target.options, a_target.extends /= Void, False)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_debugs (a_target: CONF_TARGET)
			-- Show debug properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_target_debugs (a_target))
			lock_update

			initialize_properties

			current_target := a_target
			add_debug_option_properties (a_target.changeable_internal_options, a_target.options, a_target.extends /= Void, False)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_assertions (a_target: CONF_TARGET)
			-- Show assertion properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_target_assertions (a_target))
			lock_update

			initialize_properties

			current_target := a_target
			add_assertion_option_properties (a_target.changeable_internal_options, a_target.options, a_target.extends /= Void, False)

			unlock_update
			is_refreshing := False
		ensure
			properties_ok: properties /= Void and then not properties.is_destroyed
			not_refreshing: not is_refreshing
		end

	show_properties_target_externals (a_target: CONF_TARGET; a_external: CONF_EXTERNAL)
			-- Show external properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
			a_external_not_void: a_external /= Void
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_target_externals (a_target, a_external))
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

	show_properties_target_tasks (a_target: CONF_TARGET; a_task: CONF_ACTION; a_type: STRING_32)
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
			set_refresh_current (agent show_properties_target_tasks (a_target, a_task, a_type))
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

	show_properties_target_groups (a_target: CONF_TARGET; a_group: CONF_GROUP)
			-- Show groups properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
			a_group_not_void: a_group /= Void
		do
			is_refreshing := True
			set_refresh_current (agent show_properties_target_groups (a_target, a_group))
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

	show_properties_target_variables (a_target: CONF_TARGET)
			-- Show variables properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_vars, l_inh_vars: like {CONF_TARGET}.variables
			i: INTEGER
			l_item: STRING_PROPERTY
			l_var_key: READABLE_STRING_GENERAL
		do
			current_target := a_target
			is_refreshing := True
			set_refresh_current (agent show_properties_target_variables (a_target))
			lock_update

				-- prepare grid
			initialize_grid
			check attached grid as g then

				g.column (1).set_title (conf_interface_names.variables_name)
				g.column (2).set_title (conf_interface_names.variables_value)

				if attached current_target.extends as l_extends then
					l_inh_vars := l_extends.variables
				else
					create l_inh_vars.make_equal (0)
				end
				from
					l_vars := current_target.variables
					l_vars.start
				until
					l_vars.after
				loop
					i := g.row_count
					create l_item.make ("")
					l_var_key := l_vars.key_for_iteration
					l_item.set_value (l_var_key)
					l_item.pointer_button_press_actions.wipe_out
					l_item.activate_when_pointer_is_double_pressed
					l_item.change_value_actions.extend (agent update_variable_key (l_var_key, {READABLE_STRING_32} ?))
					g.set_item (1, i + 1, l_item)
					create l_item.make ("")
					l_item.set_value (l_vars.item_for_iteration)
					l_item.pointer_button_press_actions.wipe_out
					l_item.activate_when_pointer_is_double_pressed
					l_item.change_value_actions.extend (agent update_variable_value (l_var_key, {READABLE_STRING_32} ?))
					g.set_item (2, i + 1, l_item)
					l_inh_vars.search (l_var_key)
					if attached l_inh_vars.found_item as l_found_item then
						if l_found_item.is_equal (l_vars.item_for_iteration) then
							-- inherited
							g.row (i + 1).set_background_color (inherit_color)
						else
							-- overriden
							g.row (i + 1).set_background_color (override_color)
						end
					end
					l_vars.forth
				end
				check
					attached add_button as l_add_button and
					attached remove_button as l_remove_button
				then
					l_add_button.select_actions.extend (agent add_variable)
					l_remove_button.select_actions.extend (agent remove_variable)
				end
			end

			unlock_update
			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
			grid_ok: attached grid as el_grid and then not el_grid.is_destroyed
		end

	show_properties_target_mapping (a_target: CONF_TARGET)
			-- Show mapping properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
		local
			l_vars, l_inh_vars: STRING_TABLE [READABLE_STRING_32]
			i: INTEGER
			l_item: STRING_PROPERTY
			l_var_key: READABLE_STRING_GENERAL
		do
			current_target := a_target
			is_refreshing := True
			set_refresh_current (agent show_properties_target_mapping (a_target))
			lock_update

			if attached current_target.extends as l_extends then
				l_inh_vars := l_extends.mapping
			else
				create l_inh_vars.make_equal (0)
			end

			initialize_grid
			check attached grid as g then
				g.column (1).set_title (conf_interface_names.mapping_old_name)
				g.column (2).set_title (conf_interface_names.mapping_new_name)

				from
					l_vars := current_target.mapping
					l_vars.start
				until
					l_vars.after
				loop
					i := g.row_count
					create l_item.make ("")
					l_var_key := l_vars.key_for_iteration
					l_item.set_value (l_var_key)
					l_item.pointer_button_press_actions.wipe_out
					l_item.activate_when_pointer_is_double_pressed
					l_item.change_value_actions.extend (agent update_mapping_key (l_var_key, ?))
					g.set_item (1, i + 1, l_item)
					create l_item.make ("")
					l_item.set_value (l_vars.item_for_iteration)
					l_item.pointer_button_press_actions.wipe_out
					l_item.activate_when_pointer_is_double_pressed
					l_item.change_value_actions.extend (agent update_mapping_value (l_var_key, ?))
					g.set_item (2, i + 1, l_item)
					l_inh_vars.search (l_var_key)
					if attached l_inh_vars.found_item as l_found_item then
						if l_found_item.is_equal (l_vars.item_for_iteration) then
							-- inherited
							g.row (i + 1).set_background_color (inherit_color)
						else
							-- overriden
							g.row (i + 1).set_background_color (override_color)
						end
					end
					l_vars.forth
				end
				check
					attached add_button as l_add_button and
					attached remove_button as l_remove_button
				then
					l_add_button.select_actions.extend (agent add_mapping)
					l_remove_button.select_actions.extend (agent remove_mapping)
				end
			end

			unlock_update
			is_refreshing := False
		ensure
			not_refreshing: not is_refreshing
			grid_ok: attached grid as el_grid and then not el_grid.is_destroyed
		end

	show_properties_target_advanced (a_target: CONF_TARGET)
			-- Show advanced properties for `a_target'.
		require
			is_initialized: is_initialized
			not_refreshing: not is_refreshing
			a_target_not_void: a_target /= Void
		do
			current_target := a_target
			is_refreshing := True
			set_refresh_current (agent show_properties_target_advanced (a_target))
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

	commit_changes
			-- Commits configuration changes
		require
			conf_system_attached: conf_system /= Void
		do
			conf_system.store
			conf_system.set_file_date
		end

	group_section_expanded_status: HASH_TABLE [BOOLEAN, STRING_GENERAL]
			-- Expanded status of sections of groups.
		once
			create Result.make (5)
			Result.force (True, conf_interface_names.section_general)
			Result.force (True, conf_interface_names.section_assertions)
			Result.force (False, conf_interface_names.section_warning)
			Result.force (False, conf_interface_names.section_debug)
			Result.force (False, conf_interface_names.section_advanced)
		end

	refresh
			-- Regenerate currently displayed data.
		do
			if attached refresh_current_procedure as act then
				act.call (Void)
				set_focus
				section_tree.set_focus
			end
		end

	handle_value_changes (a_has_group_changed: BOOLEAN)
			-- Store changes to disk.
		do
				-- check if the name of the current selected section has changed and update
			if attached {CONFIGURATION_SECTION} section_tree.selected_item as l_section then
				if not l_section.name.same_string (l_section.text) then
					l_section.set_text (l_section.name)
				end
					-- for groups, update the pixmap
				if attached {GROUP_SECTION} l_section as l_lib_grp then
					l_lib_grp.update_pixmap
				end
			end
		end

	open_text_editor
			-- Open editor to edit the configuration file by hand.
		local
			l_cmd_string: like external_editor_command.item
		do
			l_cmd_string := external_editor_command.item ([conf_system.file_name, 1])
			if l_cmd_string /= Void and then not l_cmd_string.is_empty then
					-- Commit changes
				if conf_system /= Void then
					commit_changes
				end
				(create {EXECUTION_ENVIRONMENT}).launch (l_cmd_string)
			end
		end

	initialize_properties_system
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
			l_string_prop.validate_value_actions.extend (agent (s: READABLE_STRING_32): BOOLEAN
				require
					s_not_void: s /= Void
				do
					Result := (create {EIFFEL_SYNTAX_CHECKER}).is_valid_system_name (s)
				end)
			l_string_prop.change_value_actions.extend (agent conf_system.set_name)
			l_string_prop.change_value_actions.extend (agent (s: READABLE_STRING_32)
				require
					s_not_void: s /= Void
				do
					set_title (conf_interface_names.configuration_title (s))
				end)
			l_string_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32} ?, agent handle_value_changes (False)))
			properties.add_property (l_string_prop)

				-- description
			create l_mls_prop.make (conf_interface_names.system_description_name)
			l_mls_prop.enable_text_editing
			l_mls_prop.set_description (conf_interface_names.system_description_description)
			if attached conf_system.description as desc then
				l_mls_prop.set_value (desc)
			end
			l_mls_prop.change_value_actions.extend (agent conf_system.set_description ({READABLE_STRING_32}?))
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_mls_prop)

				-- library target
			create l_choice_prop.make_with_choices (conf_interface_names.system_library_target_name, l_targets_none)
			l_choice_prop.set_description (conf_interface_names.system_library_target_description)
			if attached conf_system.library_target as l_lib_target then
				l_choice_prop.set_value (l_lib_target.name)
			end
			l_choice_prop.validate_value_actions.extend (agent check_library_target)
			l_choice_prop.change_value_actions.extend (agent conf_system.set_library_target_by_name)
			l_choice_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
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

			if attached properties.current_section as l_current_section then
				l_current_section.expand
			end
		end

	initialize_properties_target_externals (an_external: CONF_EXTERNAL)
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

				-- Type.
			create l_prop.make ("Type")
			if an_external.is_include then
				l_prop.set_value (conf_interface_names.external_include)
			elseif an_external.is_cflag then
				l_prop.set_value (conf_interface_names.external_cflag)
			elseif an_external.is_object then
				l_prop.set_value (conf_interface_names.external_object)
			elseif an_external.is_library then
				l_prop.set_value (conf_interface_names.external_library)
			elseif an_external.is_resource then
				l_prop.set_value (conf_interface_names.external_resource)
			elseif an_external.is_linker_flag then
				l_prop.set_value (conf_interface_names.external_linker_flag)
			elseif an_external.is_make then
				l_prop.set_value (conf_interface_names.external_make)
			else
				check known_external_type: False end
			end
			l_prop.enable_readonly
			properties.add_property (l_prop)

				-- Location/value.
			if an_external.is_include then
					-- Value is a directory name.
				create l_dir_prop.make (conf_interface_names.external_location_name)
				l_dir_prop.set_description (conf_interface_names.external_location_description)
				l_dir_prop.enable_text_editing
				l_dir_prop.set_value (an_external.location)
				l_dir_prop.change_value_actions.extend (agent (v: detachable READABLE_STRING_32; ian_external: CONF_EXTERNAL)
							do
								if v /= Void then
									ian_external.set_location (v)
								end
							end(?, an_external)
						)
				l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
				properties.add_property (l_dir_prop)
			elseif an_external.is_cflag or else an_external.is_linker_flag then
					-- Value is a string.
				create l_prop.make (conf_interface_names.external_value_name)
				l_prop.set_description (conf_interface_names.external_value_description)
				l_prop.set_value (an_external.location)
				l_prop.change_value_actions.extend (agent an_external.set_location)
				l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
				properties.add_property (l_prop)
			else
					-- Value is a file name.
				create l_file_prop.make (conf_interface_names.external_location_name)
				l_file_prop.set_description (conf_interface_names.external_location_description)
				l_file_prop.enable_text_editing
				l_file_prop.set_value (an_external.location)
				l_file_prop.change_value_actions.extend ( agent an_external.set_location)
				l_file_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
				if an_external.is_resource then
					l_file_prop.add_filters (text_files_filter, text_files_description)
					l_file_prop.add_filters (resx_files_filter, resx_files_description)
					l_file_prop.add_filters (all_files_filter, all_files_description)
				end
				properties.add_property (l_file_prop)
			end

				-- Description.
			create l_mls_prop.make (conf_interface_names.external_description_name)
			l_mls_prop.set_description (conf_interface_names.external_description_description)
			l_mls_prop.enable_text_editing
			if an_external.description /= Void then
				l_mls_prop.set_value (an_external.description)
			end
			l_mls_prop.change_value_actions.extend (agent an_external.set_description)
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_mls_prop)

				-- Condition.
			create l_dial.make_with_dialog (conf_interface_names.external_condition_name, create {CONDITION_DIALOG})
			l_dial.set_description (conf_interface_names.external_condition_description)
			l_dial.set_display_agent (agent {CONF_CONDITION_LIST}.text)
			l_dial.set_value (an_external.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent an_external.set_conditions)
			l_dial.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_CONDITION_LIST}?, agent handle_value_changes (False)))
			properties.add_property (l_dial)

			if attached properties.current_section as l_current_section then
				l_current_section.expand
			end
		end

	initialize_properties_target_tasks (a_task: CONF_ACTION; a_type: STRING_GENERAL)
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
			l_prop.validate_value_actions.extend (agent (a_name: READABLE_STRING_32): BOOLEAN
					require
						a_name_not_void: a_name /= Void
					do
						Result := not a_name.is_empty
					end)
			l_prop.change_value_actions.extend (agent a_task.set_command)
			l_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_prop)

				-- description
			create l_mls_prop.make (conf_interface_names.task_description_name)
			l_mls_prop.set_description (conf_interface_names.task_description_description)
			l_mls_prop.enable_text_editing
			if a_task.description /= Void then
				l_mls_prop.set_value (a_task.description)
			end
			l_mls_prop.change_value_actions.extend (agent a_task.set_description)
			l_mls_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
			properties.add_property (l_mls_prop)

				-- working directory
			create l_dir_prop.make (conf_interface_names.task_working_directory_name, current_target)
			l_dir_prop.set_description (conf_interface_names.task_working_directory_description)
			if attached a_task.working_directory as wd then
				l_dir_prop.set_value (wd.original_path)
			end
			l_dir_prop.enable_text_editing
			l_dir_prop.change_value_actions.extend (agent (a_dir: detachable READABLE_STRING_32; ia_task: CONF_ACTION)
				do
					if a_dir = Void or else a_dir.is_empty then
						ia_task.set_working_directory (Void)
					else
						ia_task.set_working_directory (conf_factory.new_location_from_path (a_dir, current_target))
					end
				end (?, a_task)
			)
			l_dir_prop.change_value_actions.extend (agent change_no_argument_wrapper ({READABLE_STRING_32}?, agent handle_value_changes (False)))
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
			l_dial.set_display_agent (agent {CONF_CONDITION_LIST}.text)
			l_dial.set_value (a_task.internal_conditions)
			l_dial.disable_text_editing
			l_dial.change_value_actions.extend (agent a_task.set_conditions)
			l_dial.change_value_actions.extend (agent change_no_argument_wrapper ({CONF_CONDITION_LIST}?, agent handle_value_changes (False)))
			properties.add_property (l_dial)

			if attached properties.current_section as l_current_section then
				l_current_section.expand
			end
		end

feature {NONE} -- Configuration setting

	add_variable
			-- Add a new variable.
		require
			current_target: current_target /= Void
		do
			if not current_target.variables.has ("new") then
				current_target.add_variable ("new", "new_value")
				show_properties_target_variables (current_target)
			end
		end

	remove_variable
			-- Remove a variable.
		require
			current_target: current_target /= Void
			variables: grid /= Void
		do
			if attached grid as g and then g.has_selected_row then
				if attached {TEXT_PROPERTY [READABLE_STRING_GENERAL]} g.selected_rows.first.item (1) as l_item then
					check
						valid_value: attached l_item.value as v
					then
						current_target.remove_variable (v)
					end
				else
					check expected_selected_row_item_type: False end
				end
				show_properties_target_variables (current_target)
			else
				check has_grid: False end
			end
		end

	update_variable_key (an_old_key: READABLE_STRING_GENERAL; a_new_key: READABLE_STRING_GENERAL)
			-- Update key part of a variable.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			an_old_key_valid: current_target.variables.has (an_old_key)
		do
			if a_new_key /= Void and then not a_new_key.is_empty then
				current_target.internal_variables.replace_key (a_new_key, an_old_key)
			end
			show_properties_target_variables (current_target)
		end

	update_variable_value (a_key: READABLE_STRING_GENERAL; a_value: READABLE_STRING_32)
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

	add_mapping
			-- Add a new mapping.
		require
			current_target: current_target /= Void
		do
			if not current_target.mapping.has ("new") then
				current_target.add_mapping ("new", "new_value")
				show_properties_target_mapping (current_target)
			end
		end

	remove_mapping
			-- Remove a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
		do
			if attached grid as g and then g.has_selected_row then
				if attached {TEXT_PROPERTY [READABLE_STRING_GENERAL]} g.selected_rows.first.item (1) as l_item then
					current_target.remove_mapping (l_item.text)
				else
					check expected_selected_row_item_type: False end
				end
				show_properties_target_mapping (current_target)
			else
				check has_grid: False end
			end
		end

	update_mapping_key (an_old_key: READABLE_STRING_GENERAL; a_new_key: READABLE_STRING_32)
			-- Update key part of a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			an_old_key_valid: current_target.mapping.has (an_old_key)
		do
			if (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_new_key) then
				if attached current_target.internal_mapping as m then
					m.replace_key (a_new_key.as_upper, an_old_key)
				else
					check has_internal_mapping: False end
				end
			end
			show_properties_target_mapping (current_target)
		end

	update_mapping_value (a_key: READABLE_STRING_GENERAL; a_value: READABLE_STRING_32)
			-- Update value part of a mapping.
		require
			current_target: current_target /= Void
			variables: grid /= Void
			a_key_valid: current_target.mapping.has (a_key)
		do
			if (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (a_value) then
				current_target.add_mapping (a_key, a_value)
			end
			show_properties_target_mapping (current_target)
		end

feature {NONE} -- Validation and warning generation

	check_library_target (a_target: READABLE_STRING_32): BOOLEAN
			-- Is `a_target' a valid library target?
		require
			target_of_system: a_target /= Void and then not a_target.is_empty implies conf_system.targets.has (a_target)
		local
			l_target: CONF_TARGET
		do
			if a_target /= Void and then not a_target.is_empty then
				l_target := conf_system.targets.item (a_target)
				if l_target /= Void and then not l_target.overrides.is_empty then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.library_target_override, Current, Void)
				else
					Result := True
				end
			else
				Result := True
			end
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN = True
			-- Is `Current' in its default state?

feature {NONE} -- Constants

	description_height: INTEGER = 50

invariant
	configuration_space: is_initialized implies configuration_space /= Void
	section_tree: is_initialized implies section_tree /= Void
	toolbar: is_initialized implies toolbar /= Void
	split_area: is_initialized implies split_area /= Void
	grid_implies_add_button: grid_used implies attached add_button as l_add_button and then not l_add_button.is_destroyed
	grid_implies_remove_button: grid_used implies attached remove_button as l_remove_button and then not l_remove_button.is_destroyed
	debug_clauses: debug_clauses /= Void
	group_section_expanded_status: group_section_expanded_status /= Void
	conf_system: conf_system /= Void
	ok_button: is_initialized implies ok_button /= Void
	external_editor_command_ok: is_initialized implies external_editor_command /= Void
	hide_actions_not_void: is_initialized implies hide_actions /= Void
	selected_target_ok: selected_target /= Void and then not selected_target.is_empty

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
