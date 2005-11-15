indexing
	description: "Objects that with responsibility for save/open widgets config."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONFIG -- FIXIT: a name should not be a verb. What about SD_CONFIG_MEDIATOR ?

create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method.
		do
			create internal_shared
		end

feature -- Save/Open inner container data.

	save_config (a_file: STRING) is
			--
		local
			l_file: RAW_FILE
			l_config_data: SD_CONFIG_DATA
			l_facility: SED_STORABLE_FACILITIES
			l_writer: SED_MEDIUM_READER_WRITER
		do

			debug ("larry")
				io.put_string ("%N ================= SD_CONFIG save config ===============")
			end

			create l_config_data.make
			create l_file.make_create_read_write (a_file)
--			if l_file.exists then
--				l_file.delete
--			end

			save_all_inner_containers_data (l_config_data)

			-- Second save auto hide zones data.
			save_auto_hide_zone_config (l_config_data.auto_hide_zones_data)

			create l_writer.make (l_file)
			create l_facility
			l_facility.basic_store (l_config_data, l_writer, True)
			l_file.close

		end

	open_config (a_file: STRING) is
			--
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
			internal_shared.docking_manager.lock_update
			-- First clear all areas.
			clear_up_containers

			open_all_inner_containers_data (l_config_data)

			-- Restore auto hide zone.
			open_auto_hide_zone_data (l_config_data.auto_hide_zones_data)

			l_file.close
			internal_shared.docking_manager.unlock_update
		end

feature {NONE} -- Implementation for save config.

	save_inner_container_data (a_widget: EV_WIDGET; a_config_data: SD_INNER_CONTAINER_DATA) is
			--
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
				a_config_data.add_title (l_zone.content.title)

				a_config_data.set_state (l_zone.content.state.generating_type)
				debug ("larry")
					io.put_string ("%N SD_DOCKING_MANAGER zone")
					io.put_string ("%N  zone: " + l_zone.content.title)
				end
			end
		end


	save_inner_container_data_split_area (a_split_area: EV_SPLIT_AREA; a_config_data: SD_INNER_CONTAINER_DATA) is
			-- `save_inner_container_data' split area part.
		local
			l_hor: EV_HORIZONTAL_SPLIT_AREA
			l_temp: SD_INNER_CONTAINER_DATA
		do
				debug ("larry")
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
				if a_split_area.first /= Void then
					create l_temp
					a_config_data.set_children_left (l_temp)
					l_temp.set_parent (a_config_data)
					save_inner_container_data (a_split_area.first, l_temp)
				end
				if a_split_area.second /= Void then
					create l_temp
					a_config_data.set_children_right (l_temp)
					l_temp.set_parent (a_config_data)
					save_inner_container_data (a_split_area.second, l_temp)
				end

				if a_split_area.full then
					a_config_data.set_split_position (a_split_area.split_position)
				end
		end


	save_auto_hide_zone_config (a_data: SD_AUTO_HIDE_ZONE_DATA)is
			-- Save config informations about auto hide zones.
		do
			save_one_auto_hide_panel_data (internal_shared.docking_manager.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_bottom).tab_stubs, a_data.zone_bottom, True)
			save_one_auto_hide_panel_data (internal_shared.docking_manager.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_left).tab_stubs, a_data.zone_left, False)
			save_one_auto_hide_panel_data (internal_shared.docking_manager.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_right).tab_stubs, a_data.zone_right, False)
			save_one_auto_hide_panel_data (internal_shared.docking_manager.auto_hide_panel ({SD_DOCKING_MANAGER}.dock_top).tab_stubs, a_data.zone_top, True)
		end

	save_one_auto_hide_panel_data (a_stubs: ARRAYED_LIST [SD_TAB_STUB]; a_target: ARRAYED_LIST [TUPLE [STRING, INTEGER]]; a_horizontal: BOOLEAN) is
			--
		local
			l_title: STRING
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_auto_hide: SD_AUTO_HIDE_ZONE
			l_width_height: INTEGER
		do
			from
				a_stubs.start
			until
				a_stubs.after
			loop
				l_title := a_stubs.item.title

				-- Find out zone's width/height.
				l_zones := internal_shared.docking_manager.zones
				from
					l_zones.start
				until
					l_zones.after
				loop
					l_auto_hide ?= l_zones.item
					if l_auto_hide /= Void then
						if l_auto_hide.content.title.is_equal (l_title) then
							if a_horizontal then
								l_width_height := l_auto_hide.content.user_widget.width
							else
								l_width_height := l_auto_hide.content.user_widget.height
							end
						end
					end
					l_zones.forth
				end

				a_target.extend ([l_title, l_width_height])
				a_stubs.forth
			end
		end

feature -- Contract support


feature {NONE} -- Implementation for open config.

	open_all_inner_containers_data (a_config_data: SD_CONFIG_DATA) is
			--
		local
			l_datas: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
			l_split: EV_SPLIT_AREA
		do
			l_datas := a_config_data.inner_container_datas
			from
				l_datas.start
			until
				l_datas.after
			loop
				if l_datas.item /= Void then
					open_inner_container_data (l_datas.item, internal_shared.docking_manager.inner_container_main)
					l_split ?= internal_shared.docking_manager.inner_container_main.item
					if l_split /= Void then
						open_inner_container_data_split_position (l_datas.item, l_split)
					end

					-- FIXIT: should create new floating areas.
				end
				l_datas.forth
			end
		end

	save_all_inner_containers_data (a_config_data: SD_CONFIG_DATA) is
			--
		local
			l_inner_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			l_data: SD_INNER_CONTAINER_DATA
			l_datas: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
		do
			l_inner_containers := internal_shared.docking_manager.internal_inner_containers
			from
				l_inner_containers.start
				create l_datas.make (1)
			until
				l_inner_containers.after
			loop
				if l_inner_containers.item.readable then
					create l_data
					save_inner_container_data (l_inner_containers.item.item, l_data)
				else
					l_data := Void
				end
				l_datas.extend (l_data)
				l_inner_containers.forth
			end
			a_config_data.set_inner_container_datas (l_datas)
		end

	clear_up_containers is
			-- Wipe out all containers in SD_DOCKING_MANAGER.
		local
			l_all_main_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]

		do
			internal_shared.docking_manager.remove_auto_hide_zones

			l_all_main_containers := internal_shared.docking_manager.internal_inner_containers
			from
				l_all_main_containers.start
			until
				l_all_main_containers.after
			loop
				l_all_main_containers.item.wipe_out

				l_all_main_containers.forth
			end
			-- FIXIT: should only have one SD_MULTI_DOCK_AREA in l_all_main_containers.

			internal_shared.docking_manager.internal_auto_hide_panel_bottom.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_bottom.tab_stubs.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_bottom.set_minimum_height (0)
			internal_shared.docking_manager.internal_auto_hide_panel_top.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_top.tab_stubs.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_top.set_minimum_height (0)
			internal_shared.docking_manager.internal_auto_hide_panel_left.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_left.tab_stubs.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_left.set_minimum_width (0)
			internal_shared.docking_manager.internal_auto_hide_panel_right.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_right.tab_stubs.wipe_out
			internal_shared.docking_manager.internal_auto_hide_panel_right.set_minimum_width (0)
			internal_shared.docking_manager.internal_zones.wipe_out
		end

	open_inner_container_data (a_config_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER) is
			-- Preorder recursive. (Postorder is hard to think about....)
		local
			l_temp_spliter: EV_SPLIT_AREA
			l_content: SD_CONTENT
			l_state: SD_STATE
			l_internal: INTERNAL
			l_type_id: INTEGER
--			l_tab_state: SD_TAB_STATE
		do
			-- If it's a zone.
			if not a_config_data.is_split_area then

				create l_internal
				l_type_id := l_internal.dynamic_type_from_string (a_config_data.state)
				check a_type_exist: l_type_id /= -1 end
				l_state ?= l_internal.new_instance_of (l_type_id)
--				l_tab_state ?= l_state
--				if l_tab_state = Void then
					-- It SD_DOCKING_STATE
--					a_config_data.titles.start
--					l_content := internal_shared.docking_manager.content_by_title (a_config_data.titles.item)
--				else
					-- It's SD_TAB_STATE
--				end
				l_state.restore (a_config_data.titles, a_container)

--				debug ("larry")
--					io.put_string ("%N SD_DOCKING_MANAGER l_content: " + l_content.title + " first? " + (a_config_data.parent.children_left = a_config_data).out)
--				end		
			else	-- If it's a split_area
				if a_config_data.is_horizontal_split_area then
					create {EV_HORIZONTAL_SPLIT_AREA} l_temp_spliter
				else
					create {EV_VERTICAL_SPLIT_AREA} l_temp_spliter
				end
				a_container.extend (l_temp_spliter)

				-- Go on recurisve.
				if a_config_data.children_left /= Void then
					open_inner_container_data (a_config_data.children_left, l_temp_spliter)
				end

				if a_config_data.children_right /= Void then
					open_inner_container_data (a_config_data.children_right, l_temp_spliter)
				end
			end
		end

	open_inner_container_data_split_position (a_config_data: SD_INNER_CONTAINER_DATA; a_split: EV_SPLIT_AREA) is
			-- After set all zone's postion in split area, this time is set all EV_SPLIT_AREAs' split position.
		local
			l_split, l_split_2: EV_SPLIT_AREA
		do
			if a_config_data.is_split_area then
				a_split.set_split_position (a_config_data.split_position)
				if a_config_data.children_left.is_split_area then
					l_split ?= a_split.first
					check l_split /= Void end
					open_inner_container_data_split_position (a_config_data.children_left, l_split)
				end
				if a_config_data.children_right.is_split_area then
					l_split_2 ?= a_split.second
					check l_split_2 /= Void end
					open_inner_container_data_split_position (a_config_data.children_right, l_split_2)
				end
			end
		end

	open_auto_hide_zone_data (a_data: SD_AUTO_HIDE_ZONE_DATA) is
			--

		do

			open_one_auto_hide_panel (a_data.zone_bottom, {SD_DOCKING_MANAGER}.dock_bottom)
			open_one_auto_hide_panel (a_data.zone_left, {SD_DOCKING_MANAGER}.dock_left)
			open_one_auto_hide_panel (a_data.zone_right, {SD_DOCKING_MANAGER}.dock_right)
			open_one_auto_hide_panel (a_data.zone_top, {SD_DOCKING_MANAGER}.dock_top)

		end

	open_one_auto_hide_panel ( a_data: ARRAYED_LIST [TUPLE [STRING, INTEGER]]; a_direction: INTEGER) is
			--
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_content: SD_CONTENT
			l_panel: SD_AUTO_HIDE_PANEL
			l_list: ARRAYED_LIST [STRING]
		do
			l_panel := internal_shared.docking_manager.auto_hide_panel (a_direction)
			from
				a_data.start
			until
				a_data.after
			loop
				l_content := internal_shared.docking_manager.content_by_title ((a_data.item[1]).out)
				create l_auto_hide_state.make (l_content, a_direction)
				create l_list.make (1)
				l_list.extend ((a_data.item[1]).out)
				l_auto_hide_state.restore (l_list, l_panel)
				a_data.forth
			end
		end

	internal_shared: SD_SHARED
			-- All singletons.
end
