indexing
	description: "Objects that with responsibility for save/open all docking library config."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONFIG_MEDIATOR

create
	make

feature {NONE} -- Initlization

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

feature -- Save/Open inner container data.

	save_config (a_file: STRING) is
			-- Save all docking library datas to `a_file'.
		require
			a_file_not_void: a_file /= Void
		local
			l_file: RAW_FILE
			l_config_data: SD_CONFIG_DATA
			l_facility: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
		do
			debug ("docking")
				io.put_string ("%N ================= SD_CONFIG_MEDIATOR save config ===============")
			end

			create l_config_data.make
			create l_file.make_create_read_write (a_file)

			save_all_inner_containers_data (l_config_data)

			-- Second save auto hide zones data.
			save_auto_hide_panel_data (l_config_data.auto_hide_panels_datas)

			save_tool_bar_datas (l_config_data.tool_bar_datas)

			create l_writer.make (l_file)
			create l_facility
			l_facility.independent_store (l_config_data, l_writer, True)
			l_file.close
		end

	open_config (a_file: STRING) is
			-- Open all docking library datas from `a_file'.
		require
			a_file_not_void: a_file /= Void
		local
			l_file: RAW_FILE
			l_config_data: SD_CONFIG_DATA
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
		do
			create l_file.make_open_read (a_file)
			create l_reader.make (l_file)
			l_reader.set_for_reading
			create l_config_data.make
			create l_facility
			l_config_data ?=  l_facility.retrieved (l_reader, True)
			check l_config_data /= Void end
			internal_docking_manager.command.lock_update (Void, True)
			-- First we clear all areas.
			clear_up_containers
			clean_up_tool_bars
			check not internal_docking_manager.query.inner_container_main.full end
			open_all_inner_containers_data (l_config_data)

			-- Restore auto hide zone.
			open_auto_hide_panel_data (l_config_data.auto_hide_panels_datas)

			open_tool_bar_datas (l_config_data.tool_bar_datas)

			l_file.close

			internal_docking_manager.command.resize (True)
			internal_docking_manager.command.remove_empty_split_area
			internal_docking_manager.command.update_title_bar
			internal_docking_manager.command.unlock_update
		end

feature {NONE} -- Implementation for save config.

	save_all_inner_containers_data (a_config_data: SD_CONFIG_DATA) is
			-- Save all SD_MULTI_DOCK_AREA datas, include main dock area in main window and floating zones.
		require
			a_config_data_not_void: a_config_data /= Void
		local
			l_inner_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			l_data: SD_INNER_CONTAINER_DATA
			l_datas: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
		do
			l_inner_containers := internal_docking_manager.inner_containers
			from
				l_inner_containers.start
				create l_datas.make (1)
			until
				l_inner_containers.after
			loop
				if l_inner_containers.item.readable then
					create l_data
					save_inner_container_data (l_inner_containers.item.item, l_data)
					l_data.set_screen_x (l_inner_containers.item.screen_x)
					l_data.set_screen_y (l_inner_containers.item.screen_y)
					if l_inner_containers.item.parent_floating_zone /= Void then
						l_data.set_width (l_inner_containers.item.parent_floating_zone.width)
						l_data.set_height (l_inner_containers.item.parent_floating_zone.height)
					end
				else
					l_data := Void
				end
				l_datas.extend (l_data)
				l_inner_containers.forth
			end
			a_config_data.set_inner_container_datas (l_datas)
		end

	save_inner_container_data (a_widget: EV_WIDGET; a_config_data: SD_INNER_CONTAINER_DATA) is
			-- Save one inner container which is SD_MULTI_DOCK_AREA data.
		require
			a_widget_not_void: a_widget /= Void
			a_config_data_not_void: a_config_data /= Void
		local
			l_split_area: EV_SPLIT_AREA
			l_zone: SD_ZONE
		do
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
				check valid: l_zone.content.state.last_floating_width > 0 end
				check valid: l_zone.content.state.last_floating_height > 0 end
				a_config_data.set_width (l_zone.content.state.last_floating_width)
				a_config_data.set_height (l_zone.content.state.last_floating_height)
				debug ("docking")
					io.put_string ("%N SD_DOCKING_MANAGER zone")
					io.put_string ("%N  zone: " + l_zone.content.unique_title)
				end
			end
		end

	save_inner_container_data_split_area (a_split_area: EV_SPLIT_AREA; a_config_data: SD_INNER_CONTAINER_DATA) is
			-- `save_inner_container_data' save split area data part.
		require
			a_split_area_not_void: a_split_area /= Void
			a_config_data_not_void: a_config_data /= Void
		local
			l_hor: SD_HORIZONTAL_SPLIT_AREA
			l_temp: SD_INNER_CONTAINER_DATA
		do
			debug ("docking")
				io.put_string ("%N SD_DOCKING_MANAGER ")
				io.put_string ("%N  split area first : " + (a_split_area.first /= Void).out)
				io.put_string ("%N  split area second: " + (a_split_area.second /= Void).out)
			end
			l_hor ?= a_split_area
			if l_hor /= Void then
				a_config_data.set_is_horizontal_split_area (True)
			else
				a_config_data.set_is_horizontal_split_area (False)
			end
			a_config_data.set_is_split_area (True)
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
				check all_split_area_should_full: False end
			end
		end


	save_auto_hide_panel_data (a_data: SD_AUTO_HIDE_PANEL_DATA)is
			-- Save auto hide zones config data.
		require
			a_data_not_void: a_data /= Void
		do
			save_one_auto_hide_panel_data (a_data, {SD_DOCKING_MANAGER}.dock_top)
			save_one_auto_hide_panel_data (a_data, {SD_DOCKING_MANAGER}.dock_bottom)
			save_one_auto_hide_panel_data (a_data, {SD_DOCKING_MANAGER}.dock_left)
			save_one_auto_hide_panel_data (a_data, {SD_DOCKING_MANAGER}.dock_right)
		end

	save_one_auto_hide_panel_data (a_data: SD_AUTO_HIDE_PANEL_DATA; a_direction: INTEGER) is
			-- Save one auto hide panel tab stub config data.
		require
			not_void: a_data /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		local
			l_auto_hide_panel: SD_AUTO_HIDE_PANEL
			l_tab_groups: ARRAYED_LIST [ARRAYED_LIST [SD_TAB_STUB]]
			l_one_group_data: ARRAYED_LIST [TUPLE [STRING, INTEGER, INTEGER, INTEGER]]
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

	save_tool_bar_datas (a_tool_bar_datas: ARRAYED_LIST [SD_TOOL_BAR_DATA]) is
			-- Save four area tool bar and floating tool bar config datas.
		require
			not_void: a_tool_bar_datas /= Void
		local
			l_tool_bar_data: SD_TOOL_BAR_DATA
			l_float_tool_bars: ARRAYED_LIST [SD_FLOATING_TOOL_BAR_ZONE]
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
		do
			-- Top
			l_tool_bar_data := save_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_top)
			a_tool_bar_datas.extend (l_tool_bar_data)
			-- Bottom
			l_tool_bar_data := save_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_bottom)
			a_tool_bar_datas.extend (l_tool_bar_data)
			-- Left
			l_tool_bar_data := save_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_left)
			a_tool_bar_datas.extend (l_tool_bar_data)
			-- Right	
			l_tool_bar_data := save_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_right)
			a_tool_bar_datas.extend (l_tool_bar_data)

			l_float_tool_bars := internal_docking_manager.tool_bar_manager.floating_tool_bars
			from
				l_float_tool_bars.start
			until
				l_float_tool_bars.after
			loop
				l_tool_bar_zone := l_float_tool_bars.item.zone
				create l_tool_bar_data.make
				l_tool_bar_data.set_floating (True)
				l_tool_bar_data.set_title (l_tool_bar_zone.content.title)
				l_tool_bar_data.set_screen_x_y (l_float_tool_bars.item.screen_x, l_float_tool_bars.item.screen_y)
				l_tool_bar_data.set_last_state (l_float_tool_bars.item.zone.assistant.last_state)
				a_tool_bar_datas.extend (l_tool_bar_data)
				l_float_tool_bars.forth
			end
		end

	save_one_tool_bar_data (a_direction: INTEGER): SD_TOOL_BAR_DATA is
			-- Save one tool bar area config data.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		local
			l_tool_bar_area: EV_CONTAINER
			l_rows: LINEAR [EV_WIDGET]
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_tool_bar: SD_TOOL_BAR_ROW
			l_row_data: ARRAYED_LIST [TUPLE [STRING, INTEGER, SD_TOOL_BAR_ZONE_STATE]]
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
					l_row_data.extend ([l_tool_bars.item_for_iteration.content.title, l_tool_bars.item_for_iteration.position, l_tool_bars.item_for_iteration.assistant.last_state])
					l_tool_bars.forth
				end
				l_rows.forth
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation for open config.

	open_all_inner_containers_data (a_config_data: SD_CONFIG_DATA) is
			-- Open all SD_MULTI_DOCK_AREA datas, include main dock area in main window and floating zones.
		require
			a_config_data: a_config_data /= Void
			container_not_full: not internal_docking_manager.query.inner_container_main.full
		local
			l_datas: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
			l_split: EV_SPLIT_AREA
			l_floating_state: SD_FLOATING_STATE
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			l_datas := a_config_data.inner_container_datas
			from
				l_datas.start
			until
				l_datas.after
			loop
				if l_datas.index = 1 then
					if l_datas.item /= Void then
						open_inner_container_data (l_datas.item, internal_docking_manager.query.inner_container_main)
					end
					l_multi_dock_area := internal_docking_manager.query.inner_container_main
				else
					create l_floating_state.make (l_datas.item.screen_x, l_datas.item.screen_y, internal_docking_manager)
					l_floating_state.set_last_floating_height (l_datas.item.height)
					l_floating_state.set_last_floating_width (l_datas.item.width)
					l_floating_state.set_size (l_datas.item.width, l_datas.item.height)
					open_inner_container_data (l_datas.item, l_floating_state.inner_container)
					l_multi_dock_area := l_floating_state.inner_container
					internal_docking_manager.inner_containers.extend (l_multi_dock_area)
				end
				if l_multi_dock_area.readable then
					l_split ?= l_multi_dock_area.item
				end
				if l_split /= Void then
					open_inner_container_data_split_position (l_datas.item, l_split)
				end
				l_datas.forth
			end
		end

	clear_up_containers is
			-- Wipe out all containers in docking library.
		local
			l_all_main_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			l_all_contents: ARRAYED_LIST [SD_CONTENT]
			l_floating_tool_bars: ARRAYED_LIST [SD_FLOATING_TOOL_BAR_ZONE]
		do
			internal_docking_manager.command.remove_auto_hide_zones (False)
			l_all_main_containers := internal_docking_manager.inner_containers
			from
				l_all_main_containers.start
			until
				l_all_main_containers.after
			loop
				l_all_main_containers.item.wipe_out
				l_all_main_containers.forth
			end
			-- Remove auto hide panel widgets.

			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_top).tab_stubs.wipe_out
			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_top).set_minimum_height (0)

			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_bottom).tab_stubs.wipe_out
			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_bottom).set_minimum_height (0)

			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_left).tab_stubs.wipe_out
			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_left).set_minimum_width (0)

			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_right).tab_stubs.wipe_out
			internal_docking_manager.query.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_right).set_minimum_width (0)
			internal_docking_manager.zones.zones.wipe_out
			-- Remove tool bar containers
			internal_docking_manager.tool_bar_container.top.wipe_out
			internal_docking_manager.tool_bar_container.bottom.wipe_out
			internal_docking_manager.tool_bar_container.left.wipe_out
			internal_docking_manager.tool_bar_container.right.wipe_out
			-- Remove floating tool bar containers.
			l_floating_tool_bars := internal_docking_manager.tool_bar_manager.floating_tool_bars
			from
				l_floating_tool_bars.start
			until
				l_floating_tool_bars.after
			loop
				l_floating_tool_bars.item.destroy
				l_floating_tool_bars.forth
			end
			l_floating_tool_bars.wipe_out

			l_all_contents := internal_docking_manager.contents
			from
				l_all_contents.start
			until
				l_all_contents.after
			loop
				if l_all_contents.item.user_widget.parent /= Void then
					l_all_contents.item.user_widget.parent.prune_all (l_all_contents.item.user_widget)
				end
				l_all_contents.forth
			end
		ensure
			cleared: not internal_docking_manager.query.inner_container_main.full
		end

	clean_up_tool_bars is
			-- Clean up all tool bars.
		local
			l_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
			l_parent: EV_CONTAINER
		do
			from
				l_contents := internal_docking_manager.tool_bar_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				l_items := l_contents.item.items
				from
					l_items.start
				until
					l_items.after
				loop
					l_widget_item ?= l_items.item
					if l_widget_item /= Void then
						l_parent := l_widget_item.widget.parent
						if l_parent /= Void then
							l_parent.prune (l_widget_item.widget)
						end
					end
					l_items.forth
				end
				l_contents.forth
			end
		end

	open_inner_container_data (a_config_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER) is
			-- Preorder recursive. (Postorder is hard to think about....)
		require
			a_config_data_not_void: a_config_data /= Void
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
		local
			l_temp_spliter: EV_SPLIT_AREA
			l_state: SD_STATE
			l_internal: INTERNAL
			l_type_id: INTEGER
		do
			-- If it's a zone.
			if not a_config_data.is_split_area then
				create l_internal
				l_type_id := l_internal.dynamic_type_from_string (a_config_data.state)
				check a_type_exist: l_type_id /= -1 end
				l_state ?= l_internal.new_instance_of (l_type_id)
				l_state.set_docking_manager (internal_docking_manager)
				l_state.restore (a_config_data.titles, a_container, a_config_data.direction)
				l_state.set_last_floating_height (a_config_data.height)
				l_state.set_last_floating_width (a_config_data.width)
			else	-- If it's a split_area
				if a_config_data.is_horizontal_split_area then
					create {SD_HORIZONTAL_SPLIT_AREA} l_temp_spliter
				else
					create {SD_VERTICAL_SPLIT_AREA} l_temp_spliter
				end
				a_container.extend (l_temp_spliter)
				-- Go on recurisve.
				check a_config_data.children_left /= Void end
				open_inner_container_data (a_config_data.children_left, l_temp_spliter)
				check a_config_data.children_right /= Void  end
				open_inner_container_data (a_config_data.children_right, l_temp_spliter)
			end
		end

	open_inner_container_data_split_position (a_config_data: SD_INNER_CONTAINER_DATA; a_split: EV_SPLIT_AREA) is
			-- After set all zone's postion in split area, this time is set all EV_SPLIT_AREAs' split position.
		require
			a_config_data_not_void: a_config_data /= Void
			a_split_not_void: a_split /= Void
		local
			l_split, l_split_2: EV_SPLIT_AREA
		do
			if a_config_data.is_split_area then
				if a_split.minimum_split_position <= a_config_data.split_position
					 and a_split.maximum_split_position >= a_config_data.split_position
					 	and a_split.full then
					-- a_split may be not full, because when restore client programer may not
					-- supply SD_CONTENT which existed when last saving config.
					a_split.set_split_position (a_config_data.split_position)
				end

				if a_config_data.children_left.is_split_area then
					l_split ?= a_split.first
					if l_split /= Void then
						open_inner_container_data_split_position (a_config_data.children_left, l_split)
					end
				end
				if a_config_data.children_right.is_split_area then
					l_split_2 ?= a_split.second
					if l_split_2 /= Void then
						open_inner_container_data_split_position (a_config_data.children_right, l_split_2)
					end
				end
			end
		end

	open_auto_hide_panel_data (a_data: SD_AUTO_HIDE_PANEL_DATA) is
			-- Open all auto hide zone datas.
		require
			a_data_not_void: a_data /= Void
		do
			open_one_auto_hide_panel_data (a_data.bottom, {SD_DOCKING_MANAGER}.dock_bottom)
			open_one_auto_hide_panel_data (a_data.left, {SD_DOCKING_MANAGER}.dock_left)
			open_one_auto_hide_panel_data (a_data.right, {SD_DOCKING_MANAGER}.dock_right)
			open_one_auto_hide_panel_data (a_data.top, {SD_DOCKING_MANAGER}.dock_top)
		end

	open_one_auto_hide_panel_data (a_data: ARRAYED_LIST [ARRAYED_LIST [TUPLE [STRING, INTEGER, INTEGER, INTEGER]]]; a_direction: INTEGER) is
			-- Open one SD_AUTO_HIDE_PANEL's data.
		require
			a_data_not_void: a_data /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_content: SD_CONTENT
			l_panel: SD_AUTO_HIDE_PANEL
			l_list: ARRAYED_LIST [TUPLE [STRING, INTEGER]]
			l_list_for_state: ARRAYED_LIST [STRING]
			l_tab_group: ARRAYED_LIST [SD_CONTENT]
		do
			l_panel := internal_docking_manager.query.auto_hide_panel (a_direction)
			from
				a_data.start
			until
				a_data.after
			loop
				create l_tab_group.make (1)
				l_list := a_data.item
				from
					create l_list_for_state.make (1)
					from
						l_list.start
					until
						l_list.after
					loop
						l_list_for_state.extend ((l_list.item[1]).out)
						l_list.forth
					end
					l_list.start
				until
					l_list.after
				loop
					l_content := internal_docking_manager.query.content_by_title_for_restore ((l_list.item[1]).out)
					-- If we don't find SD_CONTENT last saved, ignore it.
					if l_content /= Void then
						create l_auto_hide_state.make (l_content, a_direction)
						l_auto_hide_state.set_last_floating_width (l_list.item.integer_32_item (3))
						l_auto_hide_state.set_last_floating_height (l_list.item.integer_32_item (4))
						l_auto_hide_state.restore (l_list_for_state, l_panel, a_direction)
						l_auto_hide_state.set_width_height (l_list.item.integer_32_item (2))
						l_tab_group.extend (l_content)
					end
					l_list.forth
				end
				if l_tab_group.count > 1 then
					l_panel.set_tab_group (l_tab_group)
				end

				a_data.forth
			end
			l_panel.update_tab_group
		end

	open_tool_bar_datas (a_tool_bar_datas: ARRAYED_LIST [SD_TOOL_BAR_DATA]) is
			-- Open four area tool bar datas.
		require
			a_tool_bar_datas_not_void: a_tool_bar_datas /= Void
		local
			l_tool_bar_on_floating: SD_TOOL_BAR_ZONE
			l_content: SD_TOOL_BAR_CONTENT
		do
			-- Top
			a_tool_bar_datas.start
			open_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_top, a_tool_bar_datas.item)
			-- Bottom
			a_tool_bar_datas.forth
			open_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_bottom, a_tool_bar_datas.item)
			-- Left
			a_tool_bar_datas.forth
			open_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_left, a_tool_bar_datas.item)
			-- Right
			a_tool_bar_datas.forth
			open_one_tool_bar_data ({SD_DOCKING_MANAGER}.dock_right, a_tool_bar_datas.item)

			-- Floating tool_bars
			from
				a_tool_bar_datas.forth
			until
				a_tool_bar_datas.after
			loop
				check is_floating_tool_bar_data: a_tool_bar_datas.item.is_floating end
				l_content := internal_docking_manager.tool_bar_manager.content_by_title (a_tool_bar_datas.item.title)
				create l_tool_bar_on_floating.make (False, internal_docking_manager)
				l_tool_bar_on_floating.extend (l_content)
				l_tool_bar_on_floating.float (a_tool_bar_datas.item.screen_x, a_tool_bar_datas.item.screen_y)
				l_tool_bar_on_floating.assistant.set_last_state (a_tool_bar_datas.item.last_state)
				if a_tool_bar_datas.item.last_state.floating_group_info /= Void then
					l_tool_bar_on_floating.floating_tool_bar.assistant.position_groups (a_tool_bar_datas.item.last_state.floating_group_info)
				end

				a_tool_bar_datas.forth
			end
		end

	open_one_tool_bar_data (a_direction: INTEGER; a_tool_bar_data: SD_TOOL_BAR_DATA) is
			-- Open one mene area config datas.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
			a_tool_bar_data_not_void: a_tool_bar_data /= Void
		local
			l_tool_bar_container: EV_CONTAINER
			l_rows: ARRAYED_LIST [ARRAYED_LIST [TUPLE [STRING, INTEGER, SD_TOOL_BAR_ZONE_STATE]]]
			l_row: ARRAYED_LIST [TUPLE [STRING, INTEGER]]
			l_content: SD_TOOL_BAR_CONTENT
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
			l_state: SD_TOOL_BAR_ZONE_STATE
		do
			l_tool_bar_container := internal_docking_manager.tool_bar_manager.tool_bar_container (a_direction)
			l_rows := a_tool_bar_data.rows
			from
				l_rows.start
			until
				l_rows.after
			loop
				l_row := l_rows.item
				if a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom then
					create l_tool_bar_row.make (False)
				else
					create l_tool_bar_row.make (True)
				end
				l_tool_bar_container.extend (l_tool_bar_row)
				l_tool_bar_row.set_ignore_resize (True)
				from
					l_row.start
				until
					l_row.after
				loop
					l_content := internal_docking_manager.tool_bar_manager.content_by_title ((l_row.item @ 1).out)
					check l_content_not_void: l_content /= Void end
					create l_tool_bar_zone.make (False, internal_docking_manager)

					l_state ?= l_row.item.item (3)
					check not_void: l_state /= Void end
					l_tool_bar_zone.assistant.set_last_state (l_state)

					l_tool_bar_zone.extend (l_content)
					if l_state.items_layout /= Void then
						l_tool_bar_zone.assistant.open_items_layout
					end
					l_tool_bar_row.extend (l_tool_bar_zone)
					l_tool_bar_row.record_state
					l_tool_bar_row.set_item_position_relative (l_tool_bar_zone.tool_bar, l_row.item.integer_32_item (2))
					l_row.forth
				end
				l_tool_bar_row.set_ignore_resize (False)
				l_rows.forth
			end
		end

feature {NONE} -- Internals.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_shared: SD_SHARED;
			-- All singletons.
indexing
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
