note
	description: "[
					Sepcial docking layout helper for editor stuffs
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_EDITOR_CONFIG_HELPER

inherit
	SD_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_open_config_manager: SD_OPEN_CONFIG_MEDIATOR)
			-- Creation method
		require
			a_open_config_manager_not_void: a_open_config_manager /= Void
		do
			open_config_manager := a_open_config_manager
		ensure
			set: open_config_manager = a_open_config_manager
		end

feature -- Command

	remember_editors_state (a_config_data: SD_CONFIG_DATA)
			-- Remeber editors state before execute operations like {SD_OPEN_CONFIG_MEDITOR}.`open_tools_config'
		local
			l_only_one_item: EV_WIDGET
			l_temp_split: SD_VERTICAL_SPLIT_AREA
			l_container: EV_CONTAINER
			l_cleaner: SD_WIDGET_CLEANER
		do
			internal_docking_manager.query.set_opening_tools_layout (True)

			-- We have to set all zones to normal state, otherwise we can't find the editor parent.
			internal_docking_manager.command.recover_normal_state

			-- We have to open unminimized editor data here. Because after the following codes which will INSERT `l_temp_split' to the docking tree
			-- when editor top parent is SD_MULTI_DOCK_AREA, the docking logic tree is not a full two fork tree. Then there will be problems
			-- in `update_middle_container' which called by `recover_normal_size_from_minimize' from SD_UPPER_ZONE. See bug#12427.
			open_editor_minimized_data_unminimized (a_config_data)

			if not has_place_holder (internal_docking_manager.query.inner_container_main) then
				if internal_docking_manager.has_content (internal_docking_manager.zones.place_holder_content) then
					-- Editor is missing now
					-- Reset tools layout to have place holder zone
					-- Otherwise following `real_has_place_holder_zone' check would fail
					create l_cleaner.make (internal_docking_manager)
					l_cleaner.reset_all_to_default (True)

					was_place_holder_exists := True
				else
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
						internal_docking_manager.query.inner_container_main.save_spliter_position (top_container, generating_type)
					else
						check not_possible: False end
					end
					internal_docking_manager.contents.extend (internal_docking_manager.zones.place_holder_content)
				end
			else
				check real_has_place_holder_zone end
				was_place_holder_exists := True
			end
		end

	restore_editor_state (a_config_data: SD_CONFIG_DATA; a_prior_work_success: BOOLEAN)
			-- Restore editors state which recorded by `remember_editors_state'
			-- `a_top_container' can be void
			-- `a_prior_work_success' means if prior operation failed, this function will not try to restore editors, only do clean up works
		require
			ready_and_valid: (a_prior_work_success and was_place_holder_exists) implies real_has_place_holder_zone
		local
			l_place_holder_zone: SD_ZONE
			l_parent: EV_CONTAINER
			l_split: EV_SPLIT_AREA
			l_split_proportion: REAL
			l_env: EV_ENVIRONMENT
		do
			if a_prior_work_success then
				if not was_place_holder_exists then
					check has_place_holder: internal_docking_manager.has_content (internal_docking_manager.zones.place_holder_content) end
					l_place_holder_zone ?= internal_docking_manager.zones.place_holder_content.state.zone
					if l_place_holder_zone /= Void then
					-- l_place_holder_zone maybe void because open_config fail.
						if attached {EV_CONTAINER} l_place_holder_zone as lt_container then
							l_parent := lt_container.parent
						else
							check not_possible: False end
						end

						if l_parent /= Void then
							l_split ?= l_parent
							if l_split /= Void then
								l_split_proportion := l_split.proportion
							end
							if attached {EV_WIDGET} l_place_holder_zone as lt_widget then
								l_parent.prune (lt_widget)
							else
								check not_possible: False end
							end

							if top_container /= Void then
								if top_container.parent /= Void then
									top_container.parent.prune (top_container)
								end
								l_parent.extend (top_container)
							else
								check not_possible: False end
							end

							if l_split /= Void and then 0 <= l_split_proportion and l_split_proportion <= 1 then
								l_split.set_proportion (l_split_proportion)
							end
						else
							check not_possible: False end
						end

					end
					if top_container /= Void then
						internal_docking_manager.query.inner_container_main.restore_spliter_position (top_container, generating_type)
					else
						check not_possible: False end
					end

					internal_docking_manager.zones.place_holder_content.close
					if l_place_holder_zone /= Void then
						internal_docking_manager.query.inner_container_main.update_middle_container
						internal_docking_manager.command.resize (False)
					end
				else
					check real_has_place_holder_zone end
				end
			end
			top_container := Void

			if a_prior_work_success then
				open_editor_minimized_data_minimize (a_config_data)
			end

			internal_docking_manager.command.resize (True)

			if a_prior_work_success then
				-- We have to do it on idle, otherwise, maximized mini tool bar buttons positions in floating zone not correct.
				create l_env
				l_env.application.do_once_on_idle (agent open_config_manager.internal_open_maximized_tool_data (a_config_data))

				-- Only place holder content exists if `not Result'
				open_config_manager.call_show_actions
			end

			internal_docking_manager.query.set_opening_tools_layout (False)
		end

feature -- Query

	real_has_place_holder_zone: BOOLEAN
			-- Check if both place holder' SD_CONTENT and its zone exist in current docking widget structure
		do
			Result := has_place_holder (internal_docking_manager.query.inner_container_main) and
							internal_docking_manager.has_content (internal_docking_manager.zones.place_holder_content)
		end

	is_top_container_recorded: BOOLEAN
			-- If `top_container' not void?
		do
			Result := top_container /= Void
		end

	top_container: EV_WIDGET
			-- When only save tools config, and zone place holder not in, this is top contianer of all editors.

	has_editor_or_place_holder (a_top_container: EV_CONTAINER): BOOLEAN
			-- If `a_top_container' has any editor related widget?
		require
			a_top_container_not_void: a_top_container /= Void
		local
			l_editors: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_editors := internal_docking_manager.query.contents_editors
				l_editors.start
			until
				l_editors.after or Result
			loop
				if a_top_container.has_recursive (l_editors.item.user_widget) then
					Result := True
				end
				l_editors.forth
			end

			if not Result then
				Result := has_place_holder (a_top_container)
			end
		end

	has_place_holder (a_top_container: EV_CONTAINER): BOOLEAN
			-- If `a_top_container' has place holder widget?
		do
			if attached {EV_WIDGET} internal_docking_manager.zones.place_holder_content.state.zone as lt_widget then
				Result := a_top_container.has_recursive (lt_widget)
			end
		end

	was_place_holder_exists: BOOLEAN
			-- If there was place holder when executing `remember_editors_state'?

	is_editor_state_valid: BOOLEAN
			-- If editor state valid?
		do
			Result := (was_place_holder_exists = real_has_place_holder_zone)
		end

feature {NONE} -- Implementation

	open_editor_minimized_data_minimize (a_config_data: SD_CONFIG_DATA)
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

	open_editor_minimized_data_unminimized (a_config_data: SD_CONFIG_DATA)
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

	open_config_manager: SD_OPEN_CONFIG_MEDIATOR
			-- Docking data open config manager

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager
		do
			Result := open_config_manager.internal_docking_manager
		ensure
			not_void: Result /= Void
		end

invariant
	open_config_manager_not_void: open_config_manager /= Void

note
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
