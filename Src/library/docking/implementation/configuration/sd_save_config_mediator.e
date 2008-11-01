indexing
	description: "Objects that with responsibility for save all docking library config."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	SD_SAVE_CONFIG_MEDIATOR

inherit
	SD_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			create internal_shared
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Save inner container data.

	save_config_with_name (a_file: STRING_GENERAL; a_name: STRING_GENERAL): BOOLEAN is
			-- Save all docking library data to `a_file' with `a_name'
		require
			a_file_not_void: a_file /= Void
			a_file_not_void: a_name /= Void
		local
			l_config_data: SD_CONFIG_DATA
		do
			create l_config_data.make
			save_config_with_name_maximized_data (l_config_data, a_name, True)
			Result := save_config_data_to_file (l_config_data, a_file)
		end

	save_config_with_name_maximized_data (a_config_data: SD_CONFIG_DATA; a_name: STRING_GENERAL; a_save_maximized_data: BOOLEAN) is
			-- Save all docking library data to `a_file' with `a_name'
		require
			a_config_data_not_void: a_config_data /= Void
			a_file_not_void: a_name /= Void
		do
			debug ("docking")
				io.put_string ("%N ================= SD_CONFIG_MEDIATOR save config ===============")
			end

			if a_save_maximized_data then
				save_maximized_tool_data (a_config_data)
			end

			internal_docking_manager.command.recover_normal_state

			save_tool_bar_item_data (a_config_data)
			save_editor_minimized_data (a_config_data)

			save_all_inner_containers_data (a_config_data)

			-- Second save auto hide zones data.
			save_auto_hide_panel_data (a_config_data.auto_hide_panels_data)

			save_tool_bar_data (a_config_data.tool_bar_data)

			a_config_data.set_name (a_name)
			a_config_data.set_is_docking_locked (internal_docking_manager.is_locked)
			a_config_data.set_is_editor_docking_locked (internal_docking_manager.is_editor_locked)
			a_config_data.set_is_tool_bar_locked (internal_docking_manager.tool_bar_manager.is_locked)

			top_container := Void
		ensure
			cleared: top_container = Void
		end

	save_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Save all docking library data to `a_file'.
		require
			a_file_not_void: a_file /= Void
		do
			Result := save_config_with_name (a_file, "")
		end

	save_editors_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Save main window editor config data.
		require
			not_void: a_file /= Void
			has_editor:
		local
			l_dock_area: SD_MULTI_DOCK_AREA
			l_container: EV_CONTAINER
			l_config_data: SD_INNER_CONTAINER_DATA
			l_maximized_zone: SD_ZONE
		do
			if not internal_docking_manager.contents.has (internal_docking_manager.zones.place_holder_content) then
				l_dock_area := internal_docking_manager.query.inner_container_main

				l_maximized_zone := internal_docking_manager.zones.maximized_zone_in_main_window
				if l_maximized_zone /= Void then
					l_maximized_zone.on_normal_max_window
				end

				l_container := l_dock_area.editor_parent
				-- Maybe the widget structure is corrupt at the moment.
				if l_container /= Void then
					create l_config_data
					if l_container = internal_docking_manager.query.inner_container_main then
						save_inner_container_data (l_container.item, l_config_data)
					else
						save_inner_container_data (l_container, l_config_data)
					end
				end

				if l_maximized_zone /= Void then
					-- We restore tool maximzied state.
					l_maximized_zone.on_normal_max_window
				end
			else
				-- There is no editor in main window.	
				create l_config_data
				save_place_holder_data (l_config_data)
			end
			if l_config_data /= Void then
				Result := save_config_data_to_file (l_config_data, a_file.as_string_8)
			end
			top_container := Void
		ensure
			cleared: top_container = Void
		end

	save_tools_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Save tools config, except all editors.
		require
			not_void: a_file /= Void
		do
			Result := save_tools_config_with_name (a_file, "")
		end

	save_tools_config_with_name (a_file: STRING_GENERAL; a_name: STRING_GENERAL): BOOLEAN is
			-- Save tools config to `a_file' with `a_name'
		require
			not_called: top_container = Void
			a_file_not_void: a_file /= Void
			a_name_not_void: a_name /= Void
		local
			l_container: EV_CONTAINER
			l_widget_structure_corrupted: BOOLEAN
			l_config_data: SD_CONFIG_DATA
		do
			create l_config_data.make
			save_tool_bar_item_data (l_config_data)
			save_maximized_tool_data (l_config_data)

			internal_docking_manager.command.recover_normal_state

			if not internal_docking_manager.has_content (internal_docking_manager.zones.place_holder_content) then
				top_container := internal_docking_manager.query.inner_container_main.editor_parent
				if top_container = Void then
					l_widget_structure_corrupted := True
				elseif top_container = internal_docking_manager.query.inner_container_main then
					l_container ?= top_container
					check not_void: l_container /= Void end
					top_container := l_container.item
				end
			else
				check real_has_place_holder: internal_docking_manager.zones.place_holder_content.state.zone /= Void end
				check place_holder_visible: internal_docking_manager.zones.place_holder_content.is_visible end
			end

			if not l_widget_structure_corrupted then
				save_config_with_name_maximized_data (l_config_data, a_name, False)
			end

			top_container := Void

			Result := save_config_data_to_file (l_config_data, a_file)
		ensure
			cleared: top_container = Void
		end

	top_container: EV_WIDGET
		-- When only save tools config, and zone place holder not in, this is top contianer of all editors.	

feature {NONE} -- Implementation

	save_all_inner_containers_data (a_config_data: SD_CONFIG_DATA) is
			-- Save all SD_MULTI_DOCK_AREA data, include main dock area in main window and floating zones.
		require
			a_config_data_not_void: a_config_data /= Void
		local
			l_inner_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			l_datum: SD_INNER_CONTAINER_DATA
			l_data: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_inner_containers := internal_docking_manager.inner_containers
			from
				l_inner_containers.start
				create l_data.make (1)
			until
				l_inner_containers.after
			loop
				if l_inner_containers.item.readable then
					create l_datum
					save_inner_container_data (l_inner_containers.item.item, l_datum)
					l_floating_zone := l_inner_containers.item.parent_floating_zone
					if l_floating_zone /= Void then
						if not l_floating_zone.is_displayed and then l_floating_zone.is_last_size_or_position_recorded then
							-- See bug#13685 which only happens on GTK.
							l_datum.set_screen_x (l_floating_zone.last_screen_x)
							l_datum.set_screen_y (l_floating_zone.last_screen_y)
							l_datum.set_width (l_floating_zone.last_width)
							l_datum.set_height (l_floating_zone.last_height)
						else
							l_datum.set_screen_x (l_floating_zone.screen_x)
							l_datum.set_screen_y (l_floating_zone.screen_y)
							l_datum.set_width (l_floating_zone.width)
							l_datum.set_height (l_floating_zone.height)
						end
					end
				else
					l_datum := Void
				end
				l_data.extend (l_datum)
				l_inner_containers.forth
			end
			a_config_data.set_inner_container_data (l_data)
		end

	save_inner_container_data (a_widget: EV_WIDGET; a_config_data: SD_INNER_CONTAINER_DATA) is
			-- Save one inner container which is SD_MULTI_DOCK_AREA data.
		require
			a_widget_not_void: a_widget /= Void
			a_config_data_not_void: a_config_data /= Void
		local
			l_split_area: SD_MIDDLE_CONTAINER
			l_zone: SD_ZONE
			l_upper_zone: SD_UPPER_ZONE
		do
			if a_widget = top_container then
				-- We are saving tools config data.
				save_place_holder_data (a_config_data)
			else
				l_split_area ?= a_widget
				if l_split_area /= Void then
					save_inner_container_data_split_area (l_split_area, a_config_data)
				else -- It must be a zone area
					l_zone ?= a_widget
					check l_zone /= Void end
					a_config_data.set_is_split_area (False)
					l_zone.save_content_title (a_config_data)
					a_config_data.set_state (l_zone.content.state.generating_type)
					a_config_data.set_direction (l_zone.content.state.direction)
					a_config_data.set_visible (l_zone.is_displayed)
					check valid: l_zone.content.state.last_floating_width > 0 end
					check valid: l_zone.content.state.last_floating_height > 0 end
					a_config_data.set_width (l_zone.content.state.last_floating_width)
					a_config_data.set_height (l_zone.content.state.last_floating_height)
					debug ("docking")
						io.put_string ("%N SD_DOCKING_MANAGER zone")
						io.put_string ("%N  zone: " + l_zone.content.unique_title.as_string_8)
					end
					l_upper_zone ?= a_widget
					if l_upper_zone /= Void then
						a_config_data.set_is_minimized (l_upper_zone.is_minimized)
					end
				end
			end
		end

	save_place_holder_data (a_config_data: SD_INNER_CONTAINER_DATA) is
			-- Save a place holder data.
		require
			not_void: a_config_data /= Void
		do
			a_config_data.set_is_split_area (False)
			a_config_data.add_title (internal_shared.editor_place_holder_content_name)
			-- FIXIT: this line maybe have problem if we changed the name of SD_DOCKING_STATE.
			a_config_data.set_state ("SD_DOCKING_STATE")
			a_config_data.set_direction ({SD_ENUMERATION}.top)
			a_config_data.set_width (1)
			a_config_data.set_height (1)
		ensure
			is_editor: not a_config_data.is_split_area
			title_correct: a_config_data.titles.first.is_equal (internal_shared.editor_place_holder_content_name)
		end

	save_inner_container_data_split_area (a_split_area: SD_MIDDLE_CONTAINER; a_config_data: SD_INNER_CONTAINER_DATA) is
			-- `save_inner_container_data' save split area data part.
		require
			a_split_area_not_void: a_split_area /= Void
			a_config_data_not_void: a_config_data /= Void
		local
			l_temp: SD_INNER_CONTAINER_DATA
		do
			debug ("docking")
				io.put_string ("%N SD_DOCKING_MANAGER ")
				io.put_string ("%N  split area first : " + (a_split_area.first /= Void).out)
				io.put_string ("%N  split area second: " + (a_split_area.second /= Void).out)
			end

			a_config_data.set_is_horizontal_split_area (a_split_area.is_horizontal)

			a_config_data.set_is_split_area (True)

			-- We don't save the split area minized state surround `top_container', this will handled by `save_editor_minimized_data' feature,
			-- otherwise the split position when opening will not correct.
			if a_split_area.first /= top_container and a_split_area.second /= top_container then
				a_config_data.set_is_minimized (a_split_area.is_minimized)
			end

			check a_split_area.first /= Void end
			create l_temp
			a_config_data.set_children_left (l_temp)
			l_temp.set_parent (a_config_data)
			save_inner_container_data (a_split_area.first, l_temp)
			check a_split_area.second /= Void end
			create l_temp
			a_config_data.set_children_right (l_temp)
			l_temp.set_parent (a_config_data)
			save_inner_container_data (a_split_area.second, l_temp)
			if a_split_area.full then
				a_config_data.set_split_position (a_split_area.split_position)
			else
				check all_split_area_must_full: False end
			end
		end

	save_auto_hide_panel_data (a_data: SD_AUTO_HIDE_PANEL_DATA)is
			-- Save auto hide zones config data.
		require
			a_data_not_void: a_data /= Void
		do
			save_one_auto_hide_panel_data (a_data, {SD_ENUMERATION}.top)
			save_one_auto_hide_panel_data (a_data, {SD_ENUMERATION}.bottom)
			save_one_auto_hide_panel_data (a_data, {SD_ENUMERATION}.left)
			save_one_auto_hide_panel_data (a_data, {SD_ENUMERATION}.right)
		end

	save_one_auto_hide_panel_data (a_data: SD_AUTO_HIDE_PANEL_DATA; a_direction: INTEGER) is
			-- Save one auto hide panel tab stub config data.
		require
			not_void: a_data /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_auto_hide_panel: SD_AUTO_HIDE_PANEL
			l_tab_groups: ARRAYED_LIST [ARRAYED_LIST [SD_TAB_STUB]]
			l_one_group_data: ARRAYED_LIST [TUPLE [STRING_GENERAL, INTEGER, INTEGER, INTEGER]]
			l_one_group: ARRAYED_LIST [SD_TAB_STUB]
			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
			l_auto_hide_panel := internal_docking_manager.query.auto_hide_panel (a_direction)
			l_tab_groups := l_auto_hide_panel.tab_groups
			from
				l_tab_groups.start
			until
				l_tab_groups.after
			loop
				create l_one_group_data.make (1)
				from
					l_one_group := l_tab_groups.item
					l_one_group.start
				until
					l_one_group.after
				loop
					l_auto_hide_state ?= l_one_group.item.content.state
					check not_void: l_auto_hide_state /= Void end
					l_one_group_data.extend ([l_one_group.item.content.unique_title, l_auto_hide_state.width_height, l_auto_hide_state.last_floating_width, l_auto_hide_state.last_floating_height])

					l_one_group.forth
				end
				a_data.add_zone_group_data (a_direction, l_one_group_data)
				l_tab_groups.forth
			end
		end

	save_tool_bar_data (a_tool_bar_data: ARRAYED_LIST [SD_TOOL_BAR_DATA]) is
			-- Save four area tool bar and floating tool bar config data.
		require
			not_void: a_tool_bar_data /= Void
		local
			l_tool_bar_data: SD_TOOL_BAR_DATA
			l_float_tool_bars: ARRAYED_LIST [SD_FLOATING_TOOL_BAR_ZONE]
			l_float_tool_bars_item: SD_FLOATING_TOOL_BAR_ZONE
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
			l_tool_bar_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
			l_tool_bar_contents_item: SD_TOOL_BAR_CONTENT
		do
			-- Top
			l_tool_bar_data := save_one_tool_bar_data ({SD_ENUMERATION}.top)
			a_tool_bar_data.extend (l_tool_bar_data)
			-- Bottom
			l_tool_bar_data := save_one_tool_bar_data ({SD_ENUMERATION}.bottom)
			a_tool_bar_data.extend (l_tool_bar_data)
			-- Left
			l_tool_bar_data := save_one_tool_bar_data ({SD_ENUMERATION}.left)
			a_tool_bar_data.extend (l_tool_bar_data)
			-- Right	
			l_tool_bar_data := save_one_tool_bar_data ({SD_ENUMERATION}.right)
			a_tool_bar_data.extend (l_tool_bar_data)

			-- Floating tool bars data
			l_float_tool_bars := internal_docking_manager.tool_bar_manager.floating_tool_bars
			from
				l_float_tool_bars.start
			until
				l_float_tool_bars.after
			loop
				l_float_tool_bars_item := l_float_tool_bars.item
				l_tool_bar_zone := l_float_tool_bars_item.zone
				create l_tool_bar_data.make
				l_tool_bar_data.set_floating (True)
				l_tool_bar_data.set_title (l_tool_bar_zone.content.unique_title)
				l_tool_bar_data.set_screen_x_y (l_float_tool_bars_item.screen_x, l_float_tool_bars_item.screen_y)
				l_tool_bar_zone.assistant.save_items_layout (Void)
				l_tool_bar_data.set_last_state (l_tool_bar_zone.assistant.last_state)
				l_tool_bar_data.set_visible (l_tool_bar_zone.content.is_visible)
				a_tool_bar_data.extend (l_tool_bar_data)
				l_float_tool_bars.forth
			end

			-- Hidden docking tool bar data.
			from
				l_tool_bar_contents := internal_docking_manager.tool_bar_manager.hidden_docking_contents
				l_tool_bar_contents.start
			until
				l_tool_bar_contents.after
			loop
				l_tool_bar_contents_item := l_tool_bar_contents.item
				if not l_tool_bar_contents_item.is_visible then
					create l_tool_bar_data.make
					l_tool_bar_data.set_visible (False)
					l_tool_bar_data.set_floating (False)
					l_tool_bar_data.set_title (l_tool_bar_contents_item.unique_title)

					if
						l_tool_bar_contents_item.zone /= Void
						and then l_tool_bar_contents_item.zone.assistant.last_state /= Void
					then
						l_tool_bar_data.set_last_state (l_tool_bar_contents_item.zone.assistant.last_state)
					end
					a_tool_bar_data.extend (l_tool_bar_data)
				end
				l_tool_bar_contents.forth
			end
		end

	save_one_tool_bar_data (a_direction: INTEGER): SD_TOOL_BAR_DATA is
			-- Save one tool bar area config data.
		require
			a_direction_valid: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		local
			l_tool_bar_area: EV_CONTAINER
			l_rows: LINEAR [EV_WIDGET]
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_zone: SD_TOOL_BAR_ZONE
			l_tool_bar: SD_TOOL_BAR_ROW
			l_row_data: ARRAYED_LIST [TUPLE [STRING_GENERAL, INTEGER, SD_TOOL_BAR_ZONE_STATE]]
		do
			l_tool_bar_area := internal_docking_manager.tool_bar_manager.tool_bar_container (a_direction)
			l_rows := l_tool_bar_area.linear_representation
			create Result.make
			from
				l_rows.start
			until
				l_rows.after
			loop
				l_tool_bar ?= l_rows.item
				check tool_bar_area_only_has_tool_bar_row: l_tool_bar /= Void end
				create l_row_data.make (1)
				Result.rows.extend (l_row_data)
				from
					l_tool_bars := l_tool_bar.zones
					l_tool_bars.start
				until
					l_tool_bars.after
				loop
					l_zone := l_tool_bars.item_for_iteration
					l_zone.assistant.save_items_layout (Void)
					l_row_data.extend ([l_zone.content.unique_title, l_zone.position, l_zone.assistant.last_state])
					l_tool_bars.forth
				end
				l_rows.forth
			end
		ensure
			not_void: Result /= Void
		end

	save_editor_minimized_data (a_config_data: SD_CONFIG_DATA) is
			-- If only one editor zone, save if it's minimized.
		local
			l_editor_zone: SD_UPPER_ZONE
		do
			l_editor_zone := internal_docking_manager.query.only_one_editor_zone
			if l_editor_zone /= Void then
				a_config_data.set_is_one_editor_zone (True)
				if l_editor_zone.is_minimized then
					a_config_data.set_is_editor_minimized (True)
				else
					a_config_data.set_is_editor_minimized (False)
				end
			else
				a_config_data.set_is_one_editor_zone (False)
			end
		end

	save_maximized_tool_data (a_config_data: SD_CONFIG_DATA) is
			-- Save maximized data.
		require
			not_void: a_config_data /= Void
		local
			l_maximized_zones: ARRAYED_LIST [SD_ZONE]
		do
			l_maximized_zones := internal_docking_manager.zones.maximized_zones
			from
				l_maximized_zones.start
			until
				l_maximized_zones.after
			loop
				a_config_data.maximized_tools.extend (l_maximized_zones.item.content.unique_title)
				l_maximized_zones.forth
			end
		ensure
			valid: a_config_data.maximized_tools.count = internal_docking_manager.zones.maximized_zones.count
		end

	save_tool_bar_item_data (a_config_data: SD_CONFIG_DATA) is
			-- Save tool bar resizable item data.
		do
			a_config_data.set_resizable_items_data (internal_docking_manager.property.resizable_items_data)
		end

	save_config_data_to_file (a_config_data: ANY; a_file: STRING_GENERAL): BOOLEAN is
			-- Save `a_config_data' to `a_file'
			-- Result true means saving successed
			-- Result false means saving failed
		require
			a_config_data_not_void: a_config_data /= Void
			a_file_not_void: a_file /= Void
		local
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make_create_read_write (a_file.as_string_8)
				create l_writer.make (l_file)
				create l_facility
				l_facility.independent_store (a_config_data, l_writer, True)
				l_file.close
				Result := True
			end
		rescue
			l_retried := True
			-- see bug#14426
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
			retry
		end

feature {NONE} -- Implementation attributes

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_shared: SD_SHARED;
			-- All singletons.

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
