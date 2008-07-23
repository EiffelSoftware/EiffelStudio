indexing
	description: "Objects that with responsibility for open all docking library config."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_OPEN_CONFIG_MEDIATOR

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

feature -- Open inner container data.

	open_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Open all docking library data from `a_file'.
		require
			a_file_not_void: a_file /= Void
		local
			l_config_data: SD_CONFIG_DATA
		do
			Result := open_all_config (a_file)
			l_config_data := config_data_from_file (a_file)
			internal_open_maximized_tool_data (l_config_data)
			internal_docking_manager.command.resize (True)

			call_show_actions
		end

	open_editors_config (a_file: STRING_GENERAL) is
			-- Open main window eidtor config data.
		require
			not_void: a_file /= Void
		local
			l_top_parent: EV_CONTAINER
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_data: SD_INNER_CONTAINER_DATA
			l_split_area: EV_SPLIT_AREA
		do
			-- We have to set all zones to normal state, otherwise we can't find the editor parent.
			internal_docking_manager.command.recover_normal_state

			internal_docking_manager.command.resize (True)
			internal_docking_manager.property.set_is_opening_config (True)

			create l_file.make_open_read (a_file.as_string_8)
			create l_reader.make (l_file)
			l_reader.set_for_reading
			create l_facility
			l_data ?= l_facility.retrieved (l_reader, True)
			if l_data /= Void then
				l_top_parent := editor_top_parent_for_restore
				internal_docking_manager.command.lock_update (Void, True)

				clean_up_all_editors

				open_inner_container_data (l_data, l_top_parent)
				l_split_area ?= l_top_parent
				if l_split_area /= Void then
					if l_split_area.first /= Void then
						l_split_area ?= l_split_area.first
						if l_split_area /= Void then
							open_inner_container_data_split_position (l_data, l_split_area)
						end
					end
				end

				-- If this time we only restore a editor place holder zone? No real editors restored.
				if not internal_docking_manager.main_container.has_recursive (internal_docking_manager.zones.place_holder_content.state.zone) then
					-- We should close place holder content if exist. Because there is(are) already normal editor zone(s).				
					internal_docking_manager.zones.place_holder_content.close
				end

				-- We have to call `remove_empty_split_area' first to make sure no void widget when update_middle_container.
				internal_docking_manager.property.set_is_opening_config (False)
				internal_docking_manager.query.inner_container_main.remove_empty_split_area

				internal_docking_manager.query.inner_container_main.update_middle_container

				internal_docking_manager.command.resize (True)
				internal_docking_manager.command.unlock_update
			end

			call_show_actions
		end

	open_tools_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Open tools config, except all editors
		require
			not_called: top_container = Void
		local
			l_has_place_holder: BOOLEAN
			l_place_holder_zone: SD_ZONE
			l_parent: EV_CONTAINER
			l_split: EV_SPLIT_AREA
			l_split_position: INTEGER
			l_only_one_item: EV_WIDGET
			l_temp_split: SD_VERTICAL_SPLIT_AREA
			l_container: EV_CONTAINER
			l_config_data: SD_CONFIG_DATA
			l_env: EV_ENVIRONMENT
		do
			-- We have to set all zones to normal state, otherwise we can't find the editor parent.
			internal_docking_manager.command.recover_normal_state

			-- We have to open unminimized editor data here. Because after the following codes which will INSERT `l_temp_split' to the docking tree
			-- when editor top parent is SD_MULTI_DOCK_AREA, the docking logic tree is not a full two fork tree. Then there will be problems
			-- in `update_middle_container' which called by `recover_normal_size_from_minimize' from SD_UPPER_ZONE. See bug#12427.
			l_config_data := config_data_from_file (a_file)
			open_editor_minimized_data_unminimized (l_config_data)

			if not internal_docking_manager.has_content (internal_docking_manager.zones.place_holder_content) then
				top_container := internal_docking_manager.query.inner_container_main.editor_parent
				if top_container = internal_docking_manager.query.inner_container_main then
					l_container ?= top_container
					if l_container /= Void then
						-- It must be only one zone in top container
						l_only_one_item := l_container.item
						if l_only_one_item /= Void then
							l_container.wipe_out
							create l_temp_split
							l_container.extend (l_temp_split)
							l_temp_split.extend (l_only_one_item)
							top_container := l_temp_split
						else
							check not_possible: False end
						end
					else
						check not_possible: False end
					end
				end
				if top_container /= Void then
					internal_docking_manager.query.inner_container_main.save_spliter_position (top_container)
				else
					check not_possible: False end
				end
				internal_docking_manager.contents.extend (internal_docking_manager.zones.place_holder_content)
			else
				l_has_place_holder := True
			end

			-- Different from normal `open_config', we don't clear editors related things.
			Result := open_all_config (a_file)

			if not l_has_place_holder then
				check has_place_holder: internal_docking_manager.has_content (internal_docking_manager.zones.place_holder_content) end
				l_place_holder_zone ?= internal_docking_manager.zones.place_holder_content.state.zone
				if l_place_holder_zone /= Void then
				-- l_place_holder_zone maybe void because open_config fail.
					l_parent := l_place_holder_zone.parent
					if l_parent /= Void then
						l_split ?= l_parent
						if l_split /= Void then
							l_split_position := l_split.split_position
						end
						l_parent.prune (l_place_holder_zone)

						if top_container /= Void then
							if top_container.parent /= Void then
								top_container.parent.prune (top_container)
							end
							l_parent.extend (top_container)
						else
							check not_possible: False end
						end

						if l_split /= Void and then l_split.minimum_split_position <= l_split_position and l_split_position <= l_split.maximum_split_position then
							l_split.set_split_position (l_split_position)
						end
					else
						check not_possible: False end
					end

				end
				if top_container /= Void then
					internal_docking_manager.query.inner_container_main.restore_spliter_position (top_container)
				else
					check not_possible: False end
				end

				internal_docking_manager.zones.place_holder_content.close
				if l_place_holder_zone /= Void then
					internal_docking_manager.query.inner_container_main.update_middle_container
					internal_docking_manager.command.resize (False)
				end
			end
			top_container := Void

			if Result then
				open_editor_minimized_data_minimize (l_config_data)
			end

			internal_docking_manager.command.resize (True)

			-- We have to do it on idle, otherwise, maximized mini tool bar buttons positions in floating zone not correct.
			create l_env
			l_env.application.do_once_on_idle (agent internal_open_maximized_tool_data (l_config_data))

			call_show_actions
		ensure
			cleared: top_container = Void
		end

	open_maximized_tool_data (a_file: STRING_GENERAL) is
			-- Open maximized tool data.
		require
			a_file_not_void: a_file /= Void
		local
			l_data: SD_CONFIG_DATA
		do
			l_data := config_data_from_file (a_file)
			internal_open_maximized_tool_data (l_data)
		end

	open_tool_bar_item_data (a_file: STRING_GENERAL) is
			-- Restore SD_TOOL_BAR_RESIZABLE_ITEM's width.
		require
			a_file_not_void: a_file /= Void
		local
			l_data: SD_CONFIG_DATA
		do
			l_data := config_data_from_file (a_file)
			internal_open_tool_bar_item_data (l_data)
		end

feature -- Query

	config_data_from_file (a_file: STRING_GENERAL): SD_CONFIG_DATA is
			-- Config data readed from `a_file'
		require
			not_void: a_file /= Void
		local
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
		do
			create l_file.make (a_file.as_string_8)
			if l_file.exists then
				l_file.open_read
				create l_reader.make (l_file)
				l_reader.set_for_reading
				create l_facility
				Result ?= l_facility.retrieved (l_reader, True)
			end
			if not l_file.is_closed then
				l_file.close
			end
		end

	top_container: EV_WIDGET
		-- When only save tools config, and zone place holder not in, this is top contianer of all editors.

feature {NONE} -- Implementation

	open_all_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Open all docking library data from `a_file'.
		require
			a_file_not_void: a_file /= Void
		local
			l_config_data: SD_CONFIG_DATA
			l_called: BOOLEAN
			l_retried: BOOLEAN
			l_cmd: SD_DOCKING_MANAGER_COMMAND
		do
			internal_docking_manager.property.set_is_opening_config (True)
			if not l_retried then
				l_config_data := config_data_from_file (a_file)
				if l_config_data /= Void then
					internal_docking_manager.command.lock_update (Void, True)
					l_called := True

					-- First we clear all areas.
					clean_up_mini_tool_bar

					clear_up_containers

					clear_up_floating_zones
					clean_up_tool_bars
					set_all_visible

					if l_config_data.is_docking_locked then
						internal_docking_manager.lock
					else
						internal_docking_manager.unlock
					end

					if l_config_data.is_editor_docking_locked then
						internal_docking_manager.lock_editor
					else
						internal_docking_manager.unlock_editor
					end

					if l_config_data.is_tool_bar_locked then
						internal_docking_manager.tool_bar_manager.lock
					else
						internal_docking_manager.tool_bar_manager.unlock
					end

					open_tool_bar_data (l_config_data.tool_bar_data)

					check not internal_docking_manager.query.inner_container_main.full end
					open_all_inner_containers_data (l_config_data)

					-- Restore auto hide zone.
					open_auto_hide_panel_data (l_config_data.auto_hide_panels_data)

					l_cmd := internal_docking_manager.command
					l_cmd.resize (True)
					l_cmd.remove_empty_split_area
					l_cmd.update_title_bar
					l_cmd.remove_auto_hide_zones (False)
					l_cmd.unlock_update
					Result := True
				end
			end
			internal_docking_manager.property.set_is_opening_config (False)
		rescue
			if not l_retried then
				if l_called then
					internal_docking_manager.command.unlock_update
				end
				l_retried := True
				clean_up_mini_tool_bar
				clean_up_tool_bars
				clear_up_containers
				internal_docking_manager.unlock
				internal_docking_manager.tool_bar_manager.unlock
				if not internal_docking_manager.has_content (internal_docking_manager.zones.place_holder_content) then
					internal_docking_manager.contents.extend (internal_docking_manager.zones.place_holder_content)
				end
				internal_docking_manager.zones.place_holder_content.set_top ({SD_ENUMERATION}.top)
				retry
			end
		end

	editor_top_parent_for_restore: EV_CONTAINER is
			-- Editor top parent for restore
		local
			l_top_split_area: SD_MIDDLE_CONTAINER
			l_left_zones, l_right_zones: ARRAYED_LIST [SD_ZONE]
			l_temp_split_area: SD_HORIZONTAL_SPLIT_AREA
			l_temp_item: EV_WIDGET
			l_old_split_position: INTEGER
			l_zone: SD_ZONE
		do
			-- There are 3 cases we need to handle
			Result := internal_docking_manager.query.inner_container_main.editor_parent
			if Result /= Void then
				-- Sometime `editor_parent' feature give us a zone as top parent.
				l_zone ?= Result
				if l_zone /= Void then
					Result := l_zone.parent
				end

				l_top_split_area ?= Result

				if Result = internal_docking_manager.query.inner_container_main then
				-- If the l_top_parent is top SD_MULTI_DOCK_AREA
					Result.wipe_out
					create l_temp_split_area
					Result.extend (l_temp_split_area)
					Result := l_temp_split_area
				elseif l_top_split_area /= Void then

					l_left_zones := internal_docking_manager.query.all_zones_in_widget (l_top_split_area.first)
					l_right_zones := internal_docking_manager.query.all_zones_in_widget (l_top_split_area.second)
					if is_all_tools (l_left_zones) or  is_all_tools (l_right_zones) then
						create l_temp_split_area
						if is_all_tools (l_left_zones) then
							-- If the top parent only right side have editors zones
							l_temp_item := l_top_split_area.second
						else
							-- If the top parent only left side have editors zones	
							l_temp_item := l_top_split_area.first
						end
						l_old_split_position := l_top_split_area.split_position
						l_top_split_area.prune (l_temp_item)
						l_top_split_area.extend (l_temp_split_area)
						if l_old_split_position >= l_top_split_area.minimum_split_position and l_old_split_position <= l_top_split_area.maximum_split_position then
							l_top_split_area.set_split_position (l_old_split_position)
						end
						Result := l_temp_split_area
					else
					-- If top parent both side only have editors zones
						check only_editors_zone: not is_all_tools (internal_docking_manager.query.all_zones_in_widget (l_top_split_area)) end
						Result.wipe_out
					end
				end
			end
		ensure
			not_full: Result /= Void implies not Result.full
			parented: Result /= Void implies Result.parent /= Void
		end

	is_all_tools (a_zones: ARRAYED_LIST [SD_ZONE]): BOOLEAN is
			-- If `a_zones' all of tools conentes.
		require
			not_void: a_zones /= Void
			at_least_one: a_zones.count > 0
		do
			from
				a_zones.start
				Result := True
			until
				a_zones.after or not Result
			loop
				if a_zones.item.type /= {SD_ENUMERATION}.tool then
					Result := False
				end
				a_zones.forth
			end
		end

	open_all_inner_containers_data (a_config_data: SD_CONFIG_DATA) is
			-- Open all SD_MULTI_DOCK_AREA data, include main dock area in main window and floating zones.
		require
			a_config_data: a_config_data /= Void
			container_not_full: not internal_docking_manager.query.inner_container_main.full
		local
			l_data: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
			l_data_item: SD_INNER_CONTAINER_DATA
			l_split: EV_SPLIT_AREA
			l_floating_state: SD_FLOATING_STATE
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			l_data := a_config_data.inner_container_data
			from
				l_data.start
			until
				l_data.after
			loop
				l_data_item := l_data.item
				if l_data.index = 1 then
					if l_data_item /= Void then
						open_inner_container_data (l_data_item, internal_docking_manager.query.inner_container_main)
					end
					l_multi_dock_area := internal_docking_manager.query.inner_container_main
				else
					create l_floating_state.make (l_data_item.screen_x, l_data_item.screen_y, internal_docking_manager, l_data_item.is_visible)
					l_floating_state.set_last_floating_height (l_data_item.height)
					l_floating_state.set_last_floating_width (l_data_item.width)
					l_floating_state.set_size (l_data_item.width, l_data_item.height)
					open_inner_container_data (l_data_item, l_floating_state.inner_container)
					l_multi_dock_area := l_floating_state.inner_container
					internal_docking_manager.inner_containers.extend (l_multi_dock_area)
				end
				if l_multi_dock_area.readable then
					l_split ?= l_multi_dock_area.item
				end
				if l_split /= Void then
					open_inner_container_data_split_position (l_data_item, l_split)
				end
				l_data.forth
			end
		end

	clear_up_floating_zones is
			-- Clear up all floating zones
		local
			l_floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
		do
			l_floating_zones := internal_docking_manager.query.floating_zones
			from
				l_floating_zones.start
			until
				l_floating_zones.after
			loop
				l_floating_zones.item.destroy
				internal_docking_manager.inner_containers.start
				internal_docking_manager.inner_containers.prune (l_floating_zones.item.inner_container)
				l_floating_zones.forth
			end
		end

	clean_up_tool_bar_containers is
			-- Wipe out all tool bar containers.
		local
			l_cont: SD_TOOL_BAR_CONTAINER
		do
			l_cont := internal_docking_manager.tool_bar_container
			l_cont.top.wipe_out
			l_cont.bottom.wipe_out
			l_cont.left.wipe_out
			l_cont.right.wipe_out
		end

	clear_up_containers is
			-- Wipe out all containers in docking library.
		local
			l_all_main_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			l_all_contents: ARRAYED_LIST [SD_CONTENT]
			l_content: SD_CONTENT
			l_parent: EV_CONTAINER
			l_floating_tool_bars: ARRAYED_LIST [SD_FLOATING_TOOL_BAR_ZONE]
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_query: SD_DOCKING_MANAGER_QUERY
		do
			internal_docking_manager.command.remove_auto_hide_zones (False)
			l_all_main_containers := internal_docking_manager.inner_containers
			from
				l_all_main_containers.start
			until
				l_all_main_containers.after
			loop
				l_all_main_containers.item.wipe_out

				if l_all_main_containers.index = 1 then
					l_all_main_containers.item.wipe_out
				end
				l_all_main_containers.forth
			end

			-- Remove auto hide panel widgets.
			l_query := internal_docking_manager.query
			l_query.auto_hide_panel ({SD_ENUMERATION}.top).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.top).set_minimum_height (0)

			l_query.auto_hide_panel ({SD_ENUMERATION}.bottom).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.bottom).set_minimum_height (0)

			l_query.auto_hide_panel ({SD_ENUMERATION}.left).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.left).set_minimum_width (0)

			l_query.auto_hide_panel ({SD_ENUMERATION}.right).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.right).set_minimum_width (0)

			l_zones := internal_docking_manager.zones.zones
			if top_container /= Void then
				-- We are only restore tools data now.
                from
                    l_zones.start
                until
                    l_zones.after
                loop
                    if l_zones.item.content.type /= {SD_ENUMERATION}.editor then
                    	l_zones.remove
					else
                    	l_zones.forth
                    end
                end
			else
				l_zones.wipe_out
			end

			-- Remove tool bar containers
			clean_up_tool_bar_containers

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
				l_content := l_all_contents.item
				l_parent := l_content.user_widget.parent
				if top_container /= Void then
					-- We only restore tools config now.
					if l_content.type /= {SD_ENUMERATION}.editor then
						if l_parent /= Void then
							l_parent.prune_all (l_content.user_widget)
						end
					end
				else
					if l_parent /= Void then
						l_parent.prune_all (l_content.user_widget)
					end
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
		do
			from
				l_contents := internal_docking_manager.tool_bar_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				l_contents.item.clear
				l_contents.item.set_visible (False)
				l_contents.forth
			end
		end

	clean_up_mini_tool_bar is
			-- Clean up all mini tool bars' parents.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_mini_tool_bar: EV_WIDGET
			l_parent: EV_CONTAINER
		do
			l_contents := internal_docking_manager.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_mini_tool_bar := l_contents.item.mini_toolbar
				if l_mini_tool_bar /= Void then
					l_parent := l_mini_tool_bar.parent
					if l_parent /= Void then
						l_parent.prune (l_mini_tool_bar)
						l_parent.destroy
					end
				end
				l_contents.forth
			end
		end

	clean_up_all_editors is
			-- Clean up all editors
			-- Remove all parents of all editors.
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_content: SD_CONTENT
			l_parent: EV_CONTAINER
			l_place_holder_widget: EV_WIDGET
		do
			l_contents := internal_docking_manager.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_content := l_contents.item
				if l_content.type = {SD_ENUMERATION}.editor then
					l_parent := l_content.user_widget.parent
					if l_parent /= Void	then
						l_parent.prune (l_content.user_widget)
					end
					-- Maybe uesr_widget is hidden because minimize.
					l_content.user_widget.show
				end
				l_contents.forth
			end
			l_place_holder_widget := internal_docking_manager.zones.place_holder_content.user_widget
			if l_place_holder_widget /= Void then
				l_parent := l_place_holder_widget.parent
				if l_parent /= Void then
					l_parent.prune (l_place_holder_widget)
				end
			end
		end

	set_all_visible is
			-- Set all contents not visible
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_contents := internal_docking_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				if top_container /= Void then
					-- We are restoring tools config
					if l_contents.item.type /= {SD_ENUMERATION}.editor then
						l_contents.item.set_visible (False)
					end
				else
					l_contents.item.set_visible (False)
				end
				l_contents.forth
			end
		end

	open_inner_container_data (a_config_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER) is
			-- Preorder recursive.
		require
			a_config_data_not_void: a_config_data /= Void
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
		local
			l_temp_spliter: SD_MIDDLE_CONTAINER
			l_state: SD_STATE
			l_internal: INTERNAL
			l_type_id: INTEGER
			l_parent: SD_MIDDLE_CONTAINER
		do
			if not a_config_data.is_split_area then -- If it's a zone.
				create l_internal
				l_type_id := l_internal.dynamic_type_from_string (a_config_data.state.as_string_8)
				check a_type_exist: l_type_id /= -1 end
				l_state ?= l_internal.new_instance_of (l_type_id)
				l_state.set_docking_manager (internal_docking_manager)
				l_state.restore (a_config_data, a_container)
				-- We should check if we really restored content.
				if l_state.content /= Void then
					l_state.set_last_floating_height (a_config_data.height)
					l_state.set_last_floating_width (a_config_data.width)
					if not a_config_data.is_visible and l_state.content /= internal_docking_manager.zones.place_holder_content then
						l_state.content.hide
					end
					if a_config_data.is_minimized then
						-- l_state.zone will be void. We should query zone indirectly.
						l_parent ?= l_state.content.state.zone.parent
						if l_parent /= Void and l_parent.is_minimized then
							-- Maybe parent not full now, Current is the first child of parent, parent will fill another child immediately.
							-- check full: l_parent.full end
							l_parent.disable_item_expand (l_state.content.state.zone)
						end
					end
				end
			else	-- If it's a split_area
				l_temp_spliter := new_middle_container (a_config_data)
				a_container.extend (l_temp_spliter)
				-- Go on recurisve.
				check a_config_data.children_left /= Void end
				open_inner_container_data (a_config_data.children_left, l_temp_spliter)
				check a_config_data.children_right /= Void  end
				open_inner_container_data (a_config_data.children_right, l_temp_spliter)
			end
		end

	new_middle_container (a_config_data: SD_INNER_CONTAINER_DATA): SD_MIDDLE_CONTAINER is
			-- Middle container factory method.
		require
			not_void: a_config_data /= Void
			not_split_area: a_config_data.is_split_area
		do
			if a_config_data.is_minimized then
				if a_config_data.is_horizontal_split_area then
					create {SD_HORIZONTAL_BOX} Result
				else
					create {SD_VERTICAL_BOX} Result
				end
			else
				if a_config_data.is_horizontal_split_area then
					create {SD_HORIZONTAL_SPLIT_AREA} Result
				else
					create {SD_VERTICAL_SPLIT_AREA} Result
				end
			end
		ensure
			not_void: Result /= Void
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
				if
					 a_split.full then
					-- a_split may be not full, because when restore client programer may not
					-- supply SD_CONTENT which existed when last saving config.
					if a_split.minimum_split_position <= a_config_data.split_position and a_config_data.split_position <= a_split.maximum_split_position then
						a_split.set_split_position (a_config_data.split_position)
					end
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
			-- Open all auto hide zone data.
		require
			a_data_not_void: a_data /= Void
		do
			open_one_auto_hide_panel_data (a_data.bottom, {SD_ENUMERATION}.bottom)
			open_one_auto_hide_panel_data (a_data.left, {SD_ENUMERATION}.left)
			open_one_auto_hide_panel_data (a_data.right, {SD_ENUMERATION}.right)
			open_one_auto_hide_panel_data (a_data.top, {SD_ENUMERATION}.top)
		end

	open_one_auto_hide_panel_data (a_data: ARRAYED_LIST [ARRAYED_LIST [TUPLE [STRING_GENERAL, INTEGER, INTEGER, INTEGER]]]; a_direction: INTEGER) is
			-- Open one SD_AUTO_HIDE_PANEL's data.
		require
			a_data_not_void: a_data /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_content: SD_CONTENT
			l_panel: SD_AUTO_HIDE_PANEL
			l_list: ARRAYED_LIST [TUPLE [STRING_GENERAL, INTEGER, INTEGER, INTEGER]]
			l_list_item: TUPLE [title: STRING_GENERAL; wh: INTEGER; w: INTEGER; h:INTEGER]
			l_list_for_state: ARRAYED_LIST [STRING_GENERAL]
			l_tab_group: ARRAYED_LIST [SD_CONTENT]
			l_temp_data: SD_INNER_CONTAINER_DATA
			l_string: STRING_GENERAL
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
						l_list_item := l_list.item
						l_list_for_state.extend (l_list_item.title.twin)
						l_list.forth
					end
					l_list.start
				until
					l_list.after
				loop
					l_list_item := l_list.item
					l_string := l_list_item.title
					check not_void: l_string /= Void end
					l_content := internal_docking_manager.query.content_by_title_for_restore (l_string)
					-- If we don't find SD_CONTENT last saved, ignore it.
					if l_content /= Void then
						l_content.set_visible (True)
						create l_auto_hide_state.make (l_content, a_direction)
						l_auto_hide_state.set_last_floating_width (l_list_item.w)
						l_auto_hide_state.set_last_floating_height (l_list_item.h)
						create l_temp_data
						l_temp_data.set_titles (l_list_for_state)
						l_temp_data.set_direction (a_direction)
						l_auto_hide_state.restore (l_temp_data, l_panel)
						l_auto_hide_state.set_width_height (l_list_item.wh)
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

	open_tool_bar_data (a_tool_bar_data: ARRAYED_LIST [SD_TOOL_BAR_DATA]) is
			-- Open four area tool bar data.
		require
			a_tool_bar_data_not_void: a_tool_bar_data /= Void
		local
			l_data: SD_TOOL_BAR_DATA
			l_tool_bar: SD_TOOL_BAR_ZONE
			l_content: SD_TOOL_BAR_CONTENT
			l_state: SD_TOOL_BAR_ZONE_STATE
		do
			-- Top
			a_tool_bar_data.start
			open_one_tool_bar_data ({SD_ENUMERATION}.top, a_tool_bar_data.item)
			-- Bottom
			a_tool_bar_data.forth
			open_one_tool_bar_data ({SD_ENUMERATION}.bottom, a_tool_bar_data.item)
			-- Left
			a_tool_bar_data.forth
			open_one_tool_bar_data ({SD_ENUMERATION}.left, a_tool_bar_data.item)
			-- Right
			a_tool_bar_data.forth
			open_one_tool_bar_data ({SD_ENUMERATION}.right, a_tool_bar_data.item)

			-- Floating tool_bars
			from
				a_tool_bar_data.forth
			until
				a_tool_bar_data.after or else not a_tool_bar_data.item.is_floating
			loop
				l_data := a_tool_bar_data.item
				check is_floating_tool_bar_data: l_data.is_floating end
				l_content := internal_docking_manager.tool_bar_manager.content_by_title (l_data.title)

				-- Reset texts if original docking vertically
				if l_content.zone /= Void then
					l_content.zone.change_direction (True)
				end

				create l_tool_bar.make (False, internal_docking_manager, False)
				l_tool_bar.extend (l_content)
				l_state := l_data.last_state
				l_tool_bar.assistant.set_last_state (l_state)
				if l_state /= Void and then l_state.items_layout /= Void then
					l_tool_bar.assistant.open_items_layout
				end

				l_tool_bar.float (l_data.screen_x, l_data.screen_y, l_data.is_visible)
				l_content.set_visible (l_data.is_visible)

				if l_state.floating_group_info /= Void then
					l_tool_bar.floating_tool_bar.assistant.position_groups (l_state.floating_group_info)
				end
				a_tool_bar_data.forth
			end

			-- Hidden docking tool bars
			from
			until
				a_tool_bar_data.after
			loop
				l_data := a_tool_bar_data.item
				check is_hidden_docking: not l_data.is_floating and not l_data.is_visible end
				l_content := internal_docking_manager.tool_bar_manager.content_by_title (l_data.title)

				-- Reset texts if original docking vertically
				if l_content.zone /= Void then
					l_content.zone.change_direction (True)
				end

				l_state := l_data.last_state
				if l_state /= Void then
					create l_tool_bar.make (l_state.is_vertical, internal_docking_manager, False)
				else
					create l_tool_bar.make (False, internal_docking_manager, False)
				end
				l_tool_bar.extend (l_content)
				l_content.set_zone (l_tool_bar)
				l_content.set_visible (False)
				l_state := l_data.last_state
				if l_state /= Void and then l_state.is_docking_state_recorded then
					l_content.zone.assistant.set_last_state (l_state)
				end
				a_tool_bar_data.forth
			end
		end

	open_one_tool_bar_data (a_direction: INTEGER; a_tool_bar_data: SD_TOOL_BAR_DATA) is
			-- Open one tool bar area config data.
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
			a_tool_bar_data_not_void: a_tool_bar_data /= Void
		local
			l_tool_bar_container: EV_CONTAINER
			l_rows: ARRAYED_LIST [ARRAYED_LIST [TUPLE [STRING_GENERAL, INTEGER, SD_TOOL_BAR_ZONE_STATE]]]
			l_row: ARRAYED_LIST [TUPLE [STRING_GENERAL,INTEGER, SD_TOOL_BAR_ZONE_STATE]]
			l_row_item: TUPLE [title: STRING_GENERAL; pos: INTEGER; state: SD_TOOL_BAR_ZONE_STATE]
			l_content: SD_TOOL_BAR_CONTENT
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
			l_state: SD_TOOL_BAR_ZONE_STATE
			l_string: STRING_GENERAL
		do
			l_tool_bar_container := internal_docking_manager.tool_bar_manager.tool_bar_container (a_direction)
			l_rows := a_tool_bar_data.rows
			from
				l_rows.start
			until
				l_rows.after
			loop
				l_row := l_rows.item
				if a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom then
					create l_tool_bar_row.make (internal_docking_manager, False)
				else
					create l_tool_bar_row.make (internal_docking_manager, True)
				end
				l_tool_bar_container.extend (l_tool_bar_row)
				l_tool_bar_row.set_ignore_resize (True)
				from
					l_row.start
				until
					l_row.after
				loop
					l_row_item := l_row.item
					l_string := l_row_item.title
					check not_void: l_string /= Void end
					l_content := internal_docking_manager.tool_bar_manager.content_by_title (l_string)
					check l_content_not_void: l_content /= Void end
					l_content.set_visible (True)
					create l_tool_bar_zone.make (False, internal_docking_manager, False)

					l_state ?= l_row_item.state
					check not_void: l_state /= Void end
					l_tool_bar_zone.assistant.set_last_state (l_state)

					l_tool_bar_zone.extend (l_content)
					if l_state.items_layout /= Void then
						l_tool_bar_zone.assistant.open_items_layout
					end

					-- Use this function to set all SD_TOOL_BAR_ITEM wrap states.
					l_tool_bar_zone.change_direction (True)

					l_tool_bar_row.extend (l_tool_bar_zone)
					l_tool_bar_row.record_state
					l_tool_bar_row.set_item_position_relative (l_tool_bar_zone.tool_bar, l_row_item.pos)
					l_tool_bar_zone.assistant.record_docking_state
					l_row.forth
				end
				l_tool_bar_row.set_ignore_resize (False)
				l_rows.forth
			end
		end

	open_editor_minimized_data_unminimized (a_config_data: SD_CONFIG_DATA) is
			-- Unminimized editor zone if `a_config_data' is unminimized.
		local
			l_editor_zone: SD_UPPER_ZONE
		do
			if a_config_data /= Void then
				l_editor_zone := internal_docking_manager.query.only_one_editor_zone
				if l_editor_zone /= Void and a_config_data.is_one_editor_zone then
					if not a_config_data.is_editor_minimized and l_editor_zone.is_minimized then
						l_editor_zone.on_minimize
					end
				end
			end
		end

	open_editor_minimized_data_minimize (a_config_data: SD_CONFIG_DATA) is
			-- Minimized editor zone if `a_cofig_data' is minimized.
		local
			l_editor_zone: SD_UPPER_ZONE
		do
			if a_config_data /= Void then
				l_editor_zone := internal_docking_manager.query.only_one_editor_zone
				if l_editor_zone /= Void and a_config_data.is_one_editor_zone then
					if a_config_data.is_editor_minimized and not l_editor_zone.is_minimized then
						l_editor_zone.on_minimize
					end
				end
			end
		end

	internal_open_maximized_tool_data (a_config_data: SD_CONFIG_DATA) is
			-- Open maximized tool data.
		local
			l_content: SD_CONTENT
			l_maximzied_tools: ARRAYED_LIST [STRING_GENERAL]
			l_zone: SD_ZONE
		do
			if a_config_data /= Void then
				from
					l_maximzied_tools := a_config_data.maximized_tools
					l_maximzied_tools.start
				until
					l_maximzied_tools.after
				loop
					l_content := internal_docking_manager.query.content_by_title (l_maximzied_tools.item)
					if l_content /= Void then
						l_zone := l_content.state.zone
						if l_zone /= Void and then not l_zone.is_maximized then
							l_content.state.on_normal_max_window
						end
					end
					l_maximzied_tools.forth
				end
			end
		end

	internal_open_tool_bar_item_data (a_config_data: SD_CONFIG_DATA) is
			-- Open tool bar resizable item data.
		local
			l_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item: SD_TOOL_BAR_RESIZABLE_ITEM
			l_tool_bar_data: ARRAYED_LIST [TUPLE [name: STRING_GENERAL; width: INTEGER_32]]
			l_found: BOOLEAN
		do
			if a_config_data /= Void then
				from
					l_tool_bar_data := a_config_data.resizable_items_data
					l_contents := internal_docking_manager.tool_bar_manager.contents
					l_contents.start
				until
					l_contents.after
				loop
					from
						l_items := l_contents.item.items
						l_items.start
					until
						l_items.after
					loop
						l_item ?= l_items.item
						if l_item /= Void then
							from
								l_tool_bar_data.start
								l_found := False
							until
								l_tool_bar_data.after or l_found
							loop
								if l_item.name.as_string_32.is_equal (l_tool_bar_data.item.name.as_string_32) then
									l_item.widget.set_minimum_width (l_tool_bar_data.item.width)
									l_found := True
								end
								l_tool_bar_data.forth
							end
						end
						l_items.forth
					end
					l_contents.forth
				end
			end
		end

	call_show_actions
			-- Call SD_CONTENT.show_action inner containers.
		local
			l_all_contents: ARRAYED_LIST [SD_CONTENT]
			l_item: SD_CONTENT
			l_docking_state: SD_DOCKING_STATE
			l_tab_state: SD_TAB_STATE
		do
			from
				l_all_contents := internal_docking_manager.contents
				l_all_contents.start
			until
				l_all_contents.after
			loop
				l_item := l_all_contents.item
				if l_item.is_visible then
					l_docking_state ?= l_item.state
					l_tab_state ?= l_item.state
					if l_docking_state /= Void then
						l_item.show_actions.call (Void)
					elseif l_tab_state /= Void then
						if l_tab_state.is_selected then
							l_item.show_actions.call (Void)
						end
					end
				end
				l_all_contents.forth
			end
		end

feature {NONE} -- Internals.

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
