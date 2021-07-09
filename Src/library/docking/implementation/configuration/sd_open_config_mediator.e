note
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

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			create internal_shared
			internal_docking_manager := a_docking_manager

			create cleaner.make (a_docking_manager)
			create editor_helper.make (Current)
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Open inner container data

	open_config_with_path (a_file: PATH): BOOLEAN
			-- Open all docking library data from `a_file'
		require
			a_file_not_void: a_file /= Void
		local
			l_config_data: detachable SD_CONFIG_DATA
		do
			Result := open_all_config (a_file)
			if Result then
				l_config_data := config_data_from_path (a_file)
				if l_config_data /= Void then
					internal_open_maximized_tool_data (l_config_data)
					internal_docking_manager.command.resize (True)

					call_show_actions
				end
			end
		end

	open_editors_config_with_path (a_file: PATH)
			-- Open main window editor config data
		require
			not_void: a_file /= Void
		local
			l_top_parent: detachable EV_CONTAINER
			l_file: RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			l_place_holder_content: SD_CONTENT
		do
				-- We have to set all zones to normal state, otherwise we can't find the editor parent.
			internal_docking_manager.command.recover_normal_state

			internal_docking_manager.command.resize (True)

			debug ("to_implement")
				(create {REFACTORING_HELPER}).to_implement ("Use FILE_UTILITIES to deal with `a_file' when available in a library.")
			end
			create l_file.make_with_path (a_file)
			l_file.open_read
			create l_reader.make (l_file)
			l_reader.set_for_reading
			create l_facility
			if attached {SD_INNER_CONTAINER_DATA} l_facility.retrieved (l_reader, True) as l_data then
				l_top_parent := editor_top_parent_for_restore
				if l_top_parent /= Void then
					internal_docking_manager.command.lock_update (Void, True)
					internal_docking_manager.property.set_is_opening_config (True)

					cleaner.clean_up_all_editors
					check not l_top_parent.full end
					if not l_top_parent.full then
						open_inner_container_data (l_data, l_top_parent)
					end

					if
						attached {EV_SPLIT_AREA} l_top_parent as l_split_area and then
						attached {EV_SPLIT_AREA} l_split_area.first as l_split_area_2
					then
						open_inner_container_data_split_position (l_data, l_split_area_2)
					end

					l_place_holder_content := internal_docking_manager.zones.place_holder_content
					if editor_helper.has_editor_or_place_holder (l_top_parent) then
						if attached {EV_WIDGET} l_place_holder_content.state.zone as lt_widget then
								-- If this time we only restore a editor place holder zone? No real editors restored.
							if not internal_docking_manager.main_container.has_recursive (lt_widget) then
									-- We should close place holder content if exist. Because there is(are) already normal editor zone(s).
								l_place_holder_content.close
							end
						else
							check l_place_holder_content.state.zone = Void end -- When the state is {STATE_VOID}, {SD_STATE}.zone query return void
						end
					else
							-- Maybe nothing restored, we should restore place holder zone
							-- Otherwise, editor will missing, see bug#15253

							-- `l_top_parent' is not full before `open_inner_container_data',
							-- `open_inner_container_data' restored nothing, so it should not full here
							-- However, if `l_top_parent' has restored somethings (such as EV_SPLIT_AREA), we
							-- can wipe out it, since `editor_top_parent_for_restore' guranntee not has tools' widgets
						if l_top_parent.full then
							l_top_parent.wipe_out
						end

						if attached {SD_PLACE_HOLDER_ZONE} l_place_holder_content.state.zone as lt_zone then
							lt_zone.add_to_container (l_top_parent)
						end
					end

					internal_docking_manager.property.set_is_opening_config (False)
						-- We have to call `remove_empty_split_area' first to make sure no void widget when update_middle_container.
					internal_docking_manager.query.inner_container_main.remove_empty_split_area
					internal_docking_manager.query.inner_container_main.update_middle_container

					internal_docking_manager.command.resize (True)
					internal_docking_manager.command.unlock_update
				end
			end

			call_show_actions
		end

	open_tools_config_with_path (a_file: PATH): BOOLEAN
			-- Open tools config, except all editors
			-- Not same as normal `open_config', it doesn't clear editors related things.
		local
			l_config_data: detachable SD_CONFIG_DATA
		do
			l_config_data := config_data_from_path (a_file)
			if l_config_data /= Void then
				Result := open_tools_config_imp (l_config_data, agent open_all_config (a_file))
			end
		end

	open_maximized_tool_data_with_path (a_file: PATH)
			-- Open maximized tool data.
		require
			a_file_not_void: a_file /= Void
		local
			l_data: detachable SD_CONFIG_DATA
		do
			l_data := config_data_from_path (a_file)
			if l_data /= Void then
				internal_open_maximized_tool_data (l_data)
			end
		end

	open_tool_bar_item_data_with_path (a_file: PATH)
			-- Restore SD_TOOL_BAR_RESIZABLE_ITEM's width.
		require
			a_file_not_void: a_file /= Void
		local
			l_data: detachable SD_CONFIG_DATA
		do
			l_data := config_data_from_path (a_file)
			if l_data /= Void then
				internal_open_tool_bar_item_data (l_data)
			end
		end

feature -- Obsolete

	open_config (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Open all docking library data from `a_file'.
		obsolete
			"Use open_config_with_path instead. [2017-05-31]"
		require
			a_file_not_void: a_file /= Void
		do
			Result := open_config_with_path (create {PATH}.make_from_string (a_file))
		end

	open_editors_config (a_file: READABLE_STRING_GENERAL)
			-- Open main window eidtor config data.
		obsolete
			"Use open_editors_config_with_path instead. [2017-05-31]"
		require
			not_void: a_file /= Void
		do
			open_editors_config_with_path (create {PATH}.make_from_string (a_file))
		end

	open_tools_config (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Open tools config, except all editors.
			-- Not same as normal `open_config', it doesn't clear editors related things.
		obsolete
			"Use open_tools_config_with_path instead. [2017-05-31]"
		do
			Result := open_tools_config_with_path (create {PATH}.make_from_string (a_file))
		end

	open_maximized_tool_data (a_file: READABLE_STRING_GENERAL)
			-- Open maximized tool data.
		obsolete
			"Use open_maximized_tool_data_with_path instead. [2017-05-31]"
		require
			a_file_not_void: a_file /= Void
		do
			open_maximized_tool_data_with_path (create {PATH}.make_from_string (a_file))
		end

	open_tool_bar_item_data (a_file: READABLE_STRING_GENERAL)
			-- Restore SD_TOOL_BAR_RESIZABLE_ITEM's width.
		obsolete
			"Use open_tool_bar_item_data_with_path instead. [2017-05-31]"
		require
			a_file_not_void: a_file /= Void
		do
			open_tool_bar_item_data_with_path (create {PATH}.make_from_string (a_file))
		end

feature -- Query

	config_data_from_path (a_file: PATH): detachable SD_CONFIG_DATA
			-- Config data readed from `a_file'
		require
			not_void: a_file /= Void
		local
			l_file: detachable RAW_FILE
			l_facility: SED_STORABLE_FACILITIES
			l_reader: SED_MEDIUM_READER_WRITER
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_with_path (a_file)
				if l_file.exists then
					l_file.open_read
					if l_file.readable then
						create l_reader.make (l_file)
						l_reader.set_for_reading
						create l_facility
						if attached {SD_CONFIG_DATA} l_facility.retrieved (l_reader, True) as l_result then
							Result := l_result
						end
					else
							-- May be empty..
					end
				end
			end
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	config_data_from_file (a_file: READABLE_STRING_GENERAL): detachable SD_CONFIG_DATA
			-- Config data readed from `a_file'
		obsolete
			"Use config_data_from_path instead. [2017-05-31]"
		require
			not_void: a_file /= Void
		do
			Result := config_data_from_path (create {PATH}.make_from_string (a_file))
		end

	editor_helper: SD_EDITOR_CONFIG_HELPER
			-- Editor config helper

feature {NONE} -- Implementation

	open_all_config (a_file: PATH): BOOLEAN
			-- Open all docking library data from `a_file'.
		require
			a_file_not_void: a_file /= Void
		local
			l_config_data: detachable SD_CONFIG_DATA
			l_called: BOOLEAN
			l_retried: BOOLEAN
			l_cmd: SD_DOCKING_MANAGER_COMMAND
			l_inner_container_main: EV_CONTAINER
			l_tool_bar_data: ARRAYED_LIST [SD_TOOL_BAR_DATA]
		do
			found_place_holder_already := False
			internal_docking_manager.property.set_is_opening_config (True)
			if not l_retried then
				l_config_data := config_data_from_path (a_file)
				if l_config_data /= Void then
					internal_docking_manager.command.lock_update (Void, True)
					l_called := True

						-- First we clear all areas.
					cleaner.clean_up_for_open_all_config (editor_helper.is_top_container_recorded)

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

					l_tool_bar_data := l_config_data.tool_bar_data
					if l_tool_bar_data.count >= 4 then
						open_tool_bar_data (l_tool_bar_data)
					end

					l_inner_container_main := internal_docking_manager.query.inner_container_main
					check not l_inner_container_main.full end
					if not l_inner_container_main.full then
						open_all_inner_containers_data (l_config_data)
					end

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
				cleaner.reset_all_to_default (editor_helper.is_top_container_recorded)
				retry
			end
		end

	open_tools_config_imp (a_config_data: SD_CONFIG_DATA; a_after_editor_prepared: PREDICATE): BOOLEAN
			-- Open tools config, except all editors
			-- Not same as normal `open_config', it doesn't clear editors related things.
			-- `a_config_data' can be void
		require
			not_called: not editor_helper.is_top_container_recorded
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				editor_helper.remember_editors_state (a_config_data)
					-- Editor related data prepared
				Result := a_after_editor_prepared.item (void)
					-- We restore editor
				editor_helper.restore_editor_state (a_config_data, Result)
				if (not Result) or else (not editor_helper.is_editor_state_valid) then
					cleaner.reset_all_to_default (editor_helper.is_top_container_recorded)
					Result := False
				end
			else
				editor_helper.restore_editor_state (a_config_data, False)
			end
		ensure
			cleared: not editor_helper.is_top_container_recorded
		rescue
				-- If something bad happen, we restore all to default
			if not l_retried then
				l_retried := True
				cleaner.reset_all_to_default (editor_helper.is_top_container_recorded)
				retry
			end
		end

	editor_top_parent_for_restore: detachable EV_CONTAINER
			-- Editor top parent for restore
		local
			l_left_zones, l_right_zones: detachable ARRAYED_LIST [SD_ZONE]
			l_temp_split_area: SD_HORIZONTAL_SPLIT_AREA
			l_temp_item: detachable EV_WIDGET
			l_old_split_position: INTEGER
			l_result: like editor_top_parent_for_restore
		do
				-- There are 3 cases we need to handle
			Result := internal_docking_manager.query.inner_container_main.editor_parent

			if Result /= Void then
					-- Sometime `editor_parent' feature give us a zone as top parent.
				if attached {SD_ZONE} Result as l_zone then
					if attached {EV_WIDGET} l_zone as lt_widget then
						Result := lt_widget.parent
					else
						check not_possible: False end
					end
				end

				l_result := internal_docking_manager.query.inner_container_main
				if Result = l_result then
						-- If the l_top_parent is top SD_MULTI_DOCK_AREA.
					l_result.wipe_out
					create l_temp_split_area
					l_result.extend (l_temp_split_area)
					Result := l_temp_split_area
				elseif attached {SD_MIDDLE_CONTAINER} Result as l_top_split_area then
					if attached l_top_split_area.first as l_first then
						l_left_zones := internal_docking_manager.query.all_zones_in_widget (l_first)
					else
						check False end -- Implied by docking widget must not have an empty child.
					end

					if attached l_top_split_area.second as l_second then
						l_right_zones := internal_docking_manager.query.all_zones_in_widget (l_second)
					else
						check False end -- Implied by docking widget must not have an empty child.
					end
					if is_all_tools (l_left_zones) or is_all_tools (l_right_zones) then
						create l_temp_split_area
						if is_all_tools (l_left_zones) then
								-- If the top parent only right side have editors zones
							l_temp_item := l_top_split_area.second
						else
								-- If the top parent only left side have editors zones
							l_temp_item := l_top_split_area.first
						end
						l_old_split_position := l_top_split_area.split_position
						if l_temp_item /= Void then
							l_top_split_area.prune (l_temp_item)
						end
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
			result_not_have_tool_widgets:
		end

	is_all_tools (a_zones: detachable ARRAYED_LIST [SD_ZONE]): BOOLEAN
			-- Does `a_zones' contain only tools?
		do
			Result := attached a_zones implies ∀ z: a_zones ¦ z.type = {SD_ENUMERATION}.tool
		end

	open_all_inner_containers_data (a_config_data: SD_CONFIG_DATA)
			-- Open all SD_MULTI_DOCK_AREA data, include main dock area in main window and floating zones.
		require
			a_config_data: a_config_data /= Void
			container_not_full: not internal_docking_manager.query.inner_container_main.full
		local
			l_data: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
			l_data_item: SD_INNER_CONTAINER_DATA
			l_floating_state: SD_FLOATING_STATE
			l_multi_dock_area: SD_MULTI_DOCK_AREA
			l_inner_container_main, l_inner_container: EV_CONTAINER
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
						l_inner_container_main := internal_docking_manager.query.inner_container_main
						check not l_inner_container_main.full end
						if not l_inner_container_main.full then
							open_inner_container_data (l_data_item, l_inner_container_main)
						end
					end
					l_multi_dock_area := internal_docking_manager.query.inner_container_main
				else
					create l_floating_state.make (l_data_item.screen_x, l_data_item.screen_y, internal_docking_manager, l_data_item.is_visible)
					l_floating_state.set_last_floating_height (l_data_item.height)
					l_floating_state.set_last_floating_width (l_data_item.width)
					l_floating_state.set_size (l_data_item.width, l_data_item.height)
					l_inner_container := l_floating_state.inner_container
					check not l_inner_container.full end
					if not l_inner_container.full then
						open_inner_container_data (l_data_item, l_inner_container)
					end

					l_multi_dock_area := l_floating_state.inner_container
					internal_docking_manager.inner_containers.extend (l_multi_dock_area)
				end
				if l_multi_dock_area.readable and then attached {EV_SPLIT_AREA} l_multi_dock_area.item as l_split then
					open_inner_container_data_split_position (l_data_item, l_split)
				end
				l_data.forth
			end
		end

	set_all_visible
			-- Set all contents not visible
		local
			l_content: SD_CONTENT
		do
			across
				internal_docking_manager.contents as ic
			loop
				l_content := ic
				if editor_helper.is_top_container_recorded then
						-- We are restoring tools config
					if l_content.type /= {SD_ENUMERATION}.editor then
						l_content.set_visible (False)
					end
				else
					l_content.set_visible (False)
				end
			end
		end

	open_inner_container_data (a_config_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER)
			-- Preorder recursive.
		require
			a_config_data_not_void: a_config_data /= Void
			a_container_not_void: a_container /= Void
			a_container_not_full: not a_container.full
		local
			l_temp_spliter: SD_MIDDLE_CONTAINER
			l_internal: INTERNAL
			l_type_id: INTEGER
		do
			if not a_config_data.is_split_area then
					-- If it's a zone.
				debug ("refactor_fixme")
						-- TODO: Replace indirect object creation with the direct one.
					(create {REFACTORING_HELPER}).fixme
						("Creation of SD_STATE_WITH_CONTENT objects shouold be done directly to avoid potential void-safety violations if not all attached attributes are properly set.")
				end
				create l_internal
				if attached a_config_data.state as l_state then
					l_type_id := l_internal.dynamic_type_from_string (l_state)
				end

				check a_type_exist: l_type_id /= -1 end
				if attached {SD_STATE_WITH_CONTENT} l_internal.new_instance_of (l_type_id) as l_state then
					l_state.set_docking_manager (internal_docking_manager)

					if attached a_config_data.titles as l_titles and then not l_titles.is_empty
						and then l_titles.first.same_string (internal_shared.editor_place_holder_content_name) then
							-- We do something special for place holder zone.
							-- Ignore duplicated place holder zones
							-- Because, sometimes the docking data saved is strange such as the docking data in bug#14698
						if not found_place_holder_already then
							found_place_holder_already := True
							l_state.restore (a_config_data, a_container)
						end
					else
						l_state.restore (a_config_data, a_container)
					end

						-- We should check if we really restored content.
					l_state.set_last_floating_height (a_config_data.height)
					l_state.set_last_floating_width (a_config_data.width)
					if not a_config_data.is_visible and l_state.content /= internal_docking_manager.zones.place_holder_content then
						l_state.content.hide
					end
					if a_config_data.is_minimized then
							-- l_state.zone will be void. We should query zone indirectly.
						if attached {EV_WIDGET} l_state.content.state.zone as lt_widget then
							if attached {SD_MIDDLE_CONTAINER} lt_widget.parent as l_parent and then l_parent.is_minimized then
									-- Maybe parent not full now, Current is the first child of parent, parent will fill another child immediately.
									-- check full: l_parent.full end
								if attached {EV_WIDGET} l_state.content.state.zone as lt_widget_2 then
									l_parent.disable_item_expand (lt_widget_2)
								else
									check not_possible: False end
								end
							end
						else
							check not_possible: False end
						end
					end
				end
			else -- If it's a split_area
				l_temp_spliter := new_middle_container (a_config_data)
				a_container.extend (l_temp_spliter)
					-- Go on recurisve
				if attached a_config_data.children_left as l_left_data then
					check not l_temp_spliter.full end
					if not l_temp_spliter.full then
						open_inner_container_data (l_left_data, l_temp_spliter)
					end
				else
					check False end -- Implied by basic design of {SD_INNER_CONTAINER_DATA} and it's split area data
				end

				if attached a_config_data.children_right as l_right_data then
					check not l_temp_spliter.full end
					if not l_temp_spliter.full then
						open_inner_container_data (l_right_data, l_temp_spliter)
					end
				else
					check a_config_data.children_right /= Void end
				end
			end
		end

	new_middle_container (a_config_data: SD_INNER_CONTAINER_DATA): SD_MIDDLE_CONTAINER
			-- Middle container factory method.
		require
			not_void: a_config_data /= Void
			not_split_area: a_config_data.is_split_area
		do
			if a_config_data.is_minimized then
				if a_config_data.is_horizontal_split_area then
					create {SD_HORIZONTAL_BOX} Result.make
				else
					create {SD_VERTICAL_BOX} Result.make
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

	open_inner_container_data_split_position (a_config_data: SD_INNER_CONTAINER_DATA; a_split: EV_SPLIT_AREA)
			-- After set all zone's postion in split area, this time is set all EV_SPLIT_AREAs' split position.
		require
			a_config_data_not_void: a_config_data /= Void
			a_split_not_void: a_split /= Void
		do
			if a_config_data.is_split_area then
				if
						-- `a_split` may be not full, because when restore client programer may not
						-- supply SD_CONTENT which existed when last saving config.
					a_split.full and then
					0 <= a_config_data.split_proportion and a_config_data.split_proportion <= 1
				then
					a_split.set_proportion (a_config_data.split_proportion)
				end

				if
					attached a_config_data.children_left as l_left and then
					l_left.is_split_area and then
					attached {EV_SPLIT_AREA} a_split.first as l_split
				then
					open_inner_container_data_split_position (l_left, l_split)
				end
				if
					attached a_config_data.children_right as l_right and then
					l_right.is_split_area and then
					attached {EV_SPLIT_AREA} a_split.second as l_split
				then
					open_inner_container_data_split_position (l_right, l_split)
				end
			end
		end

	open_auto_hide_panel_data (a_data: SD_AUTO_HIDE_PANEL_DATA)
			-- Open all auto hide zone data.
		require
			a_data_not_void: a_data /= Void
		do
			open_one_auto_hide_panel_data (a_data.bottom, {SD_ENUMERATION}.bottom)
			open_one_auto_hide_panel_data (a_data.left, {SD_ENUMERATION}.left)
			open_one_auto_hide_panel_data (a_data.right, {SD_ENUMERATION}.right)
			open_one_auto_hide_panel_data (a_data.top, {SD_ENUMERATION}.top)
		end

	open_one_auto_hide_panel_data (a_data: ARRAYED_LIST [ARRAYED_LIST [TUPLE [READABLE_STRING_GENERAL, INTEGER, INTEGER, INTEGER]]]; a_direction: INTEGER)
			-- Open one SD_AUTO_HIDE_PANEL's data.
		require
			a_data_not_void: a_data /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_content: detachable SD_CONTENT
			l_panel: SD_AUTO_HIDE_PANEL
			l_list: ARRAYED_LIST [TUPLE [READABLE_STRING_GENERAL, INTEGER, INTEGER, INTEGER]]
			l_list_item: TUPLE [title: READABLE_STRING_GENERAL; wh: INTEGER; w: INTEGER; h: INTEGER]
			l_list_for_state: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_tab_group: ARRAYED_LIST [SD_CONTENT]
			l_temp_data: SD_INNER_CONTAINER_DATA
			l_string: READABLE_STRING_GENERAL
			l_docking_manager_query: like internal_docking_manager.query
		do
			l_docking_manager_query := internal_docking_manager.query
			l_panel := l_docking_manager_query.auto_hide_panel (a_direction)
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
					l_content := l_docking_manager_query.content_by_title_for_restore (l_string)
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

	open_tool_bar_data (a_tool_bar_data: ARRAYED_LIST [SD_TOOL_BAR_DATA])
			-- Open four area tool bar data.
		require
			a_tool_bar_data_not_void: a_tool_bar_data /= Void
			count_valid: a_tool_bar_data.count >= 4
		local
			l_data: SD_TOOL_BAR_DATA
			l_tool_bar: SD_TOOL_BAR_ZONE
			l_content: SD_TOOL_BAR_CONTENT
			l_state: SD_TOOL_BAR_ZONE_STATE
			l_internal_docking_manager: like internal_docking_manager
			l_tool_bar_manager: like internal_docking_manager.tool_bar_manager
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

			l_internal_docking_manager := internal_docking_manager
			l_tool_bar_manager := l_internal_docking_manager.tool_bar_manager

				-- Floating tool_bars
			from
				a_tool_bar_data.forth
			until
				a_tool_bar_data.after or else not a_tool_bar_data.item.is_floating
			loop
				l_data := a_tool_bar_data.item
				check is_floating_tool_bar_data: l_data.is_floating end
				if attached l_data.title as l_title then
					l_content := l_tool_bar_manager.content_by_title (l_title)

						-- Reset texts if original docking vertically
					if attached l_content.zone as l_zone then
						l_zone.change_direction (True)
					end

					create l_tool_bar.make (False, False, l_content, l_internal_docking_manager)
					l_state := l_data.last_state
					if l_state /= Void then
						l_tool_bar.assistant.set_last_state (l_state)
						if l_state.items_layout /= Void then
							l_tool_bar.assistant.open_items_layout
						end
					end

					l_tool_bar.float (l_data.screen_x, l_data.screen_y, l_data.is_visible)
					l_content.set_visible (l_data.is_visible)

					if
						attached l_state and then
						attached l_state.floating_group_info as l_info and then
						attached l_tool_bar.floating_tool_bar as b
					then
						b.assistant.position_groups (l_info)
					end
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
					-- We check that the toolbar still exists in the current version of the application
					-- before trying to retrieve its state.
				if
					attached l_data.title as l_title_2 and then
					l_tool_bar_manager.has (l_title_2)
				then
					l_content := l_tool_bar_manager.content_by_title (l_title_2)

						-- Reset texts if original docking vertically
					if attached l_content.zone as l_zone then
						l_zone.change_direction (True)
					end

					if attached l_data.last_state as l_state_2 then
						create l_tool_bar.make (l_state_2.is_vertical, False, l_content, l_internal_docking_manager)
					else
						create l_tool_bar.make (False, False, l_content, l_internal_docking_manager)
					end
					l_content.set_zone (l_tool_bar)
					l_content.set_visible (False)
					l_state := l_data.last_state
					if attached l_state and then l_state.is_docking_state_recorded then
						l_tool_bar.assistant.set_last_state (l_state)
					end
				end

				a_tool_bar_data.forth
			end
		end

	open_one_tool_bar_data (a_direction: INTEGER; a_tool_bar_data: SD_TOOL_BAR_DATA)
			-- Open one tool bar area config data.
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
			a_tool_bar_data_not_void: a_tool_bar_data /= Void
		local
			l_tool_bar_container: EV_CONTAINER
			l_rows: ARRAYED_LIST [ARRAYED_LIST [TUPLE [READABLE_STRING_GENERAL, INTEGER, SD_TOOL_BAR_ZONE_STATE]]]
			l_row: ARRAYED_LIST [TUPLE [READABLE_STRING_GENERAL, INTEGER, SD_TOOL_BAR_ZONE_STATE]]
			l_row_item: TUPLE [title: READABLE_STRING_GENERAL; pos: INTEGER; state: SD_TOOL_BAR_ZONE_STATE]
			l_content: SD_TOOL_BAR_CONTENT
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
			l_string: READABLE_STRING_GENERAL
			l_tool_bar_manager: like internal_docking_manager.tool_bar_manager
			l_state: SD_TOOL_BAR_ZONE_STATE
		do
			l_tool_bar_manager := internal_docking_manager.tool_bar_manager
			l_tool_bar_container := l_tool_bar_manager.tool_bar_container (a_direction)
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
					l_content := l_tool_bar_manager.content_by_title (l_string)
					check l_content_not_void: l_content /= Void end
					l_content.set_visible (True)
					create l_tool_bar_zone.make (False, False, l_content, internal_docking_manager)

					l_state := l_row_item.state
					l_tool_bar_zone.assistant.set_last_state (l_state)

					if l_state.items_layout /= Void then
						l_tool_bar_zone.assistant.open_items_layout
					end

						-- Use this function to set all SD_TOOL_BAR_ITEM wrap states.
					l_tool_bar_zone.change_direction (True)

					l_tool_bar_row.extend (l_tool_bar_zone)
					l_tool_bar_row.record_state
					if attached {EV_WIDGET} l_tool_bar_zone.tool_bar as lt_widget then
						l_tool_bar_row.set_item_position_relative (lt_widget, l_row_item.pos)
					else
						check not_possible: False end
					end

					l_tool_bar_zone.assistant.record_docking_state

					l_row.forth
				end
				l_tool_bar_row.set_ignore_resize (False)
				l_rows.forth
			end
		end

	internal_open_tool_bar_item_data (a_config_data: SD_CONFIG_DATA)
			-- Open tool bar resizable item data.
		local
			l_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_tool_bar_data: ARRAYED_LIST [TUPLE [name: READABLE_STRING_GENERAL; width: INTEGER_32]]
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
						if attached {SD_TOOL_BAR_RESIZABLE_ITEM} l_items.item as l_item then
							from
								l_tool_bar_data.start
								l_found := False
							until
								l_tool_bar_data.after or l_found
							loop
								if l_item.name.same_string_general (l_tool_bar_data.item.name) then
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

	found_place_holder_already: BOOLEAN
			-- When executing `open_tools_config', does place holder content already restored?

	cleaner: SD_WIDGET_CLEANER
			-- Widget cleaner

feature {SD_EDITOR_CONFIG_HELPER} -- Internals

	internal_open_maximized_tool_data (a_config_data: SD_CONFIG_DATA)
			-- Open maximized tool data.
		local
			l_maximized_tools: LIST [READABLE_STRING_GENERAL]
		do
			if a_config_data /= Void then
				from
					l_maximized_tools := a_config_data.maximized_tools
					l_maximized_tools.start
				until
					l_maximized_tools.after
				loop
					if
						attached internal_docking_manager.query.content_by_title (l_maximized_tools.item) as l_content and then
						attached l_content.state.zone as z and then
						not z.is_maximized
					then
						l_content.state.on_normal_max_window
					end
					l_maximized_tools.forth
				end
			end
		end

	call_show_actions
			-- Call SD_CONTENT.show_action inner containers.
		local
			l_all_contents: ARRAYED_LIST [SD_CONTENT]
			l_item: SD_CONTENT
		do
			from
				l_all_contents := internal_docking_manager.contents
				l_all_contents.start
			until
				l_all_contents.after
			loop
				l_item := l_all_contents.item
				if l_item.is_visible then
					if attached {SD_DOCKING_STATE} l_item.state as l_docking_state then
						l_item.show_actions.call (Void)
					elseif attached {SD_TAB_STATE} l_item.state as l_tab_state then
						if l_tab_state.is_selected then
							l_item.show_actions.call (Void)
						end
					end
				end
				l_all_contents.forth
			end
		end

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to

	internal_shared: SD_SHARED
			-- All singletons

invariant
	editor_helper_not_void: editor_helper /= Void

note
	library: "SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
