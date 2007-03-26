indexing
	description: "Manager which communicate between client programmer and whole docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_container: EV_CONTAINER; a_window: EV_WINDOW) is
			-- Creation method.
		require
			a_container_not_void: a_container /= Void
			a_container_not_destroy: not a_container.is_destroyed
			a_container_not_full: not a_container.full
			a_widnow_valid: window_valid (a_window)
		local
			l_checker: SD_DEPENDENCY_CHECKER
		do
			create internal_shared
			create tab_drop_actions

			top_container := a_container
			main_window := a_window

			init_managers
			init_widget_structure
			init_auto_hide_panel

			create contents

			internal_shared.add_docking_manager (Current)

			init_inner_container

			create tool_bar_manager.make (Current)

			agents.init_actions

			contents.extend (zones.place_holder_content)
			zones.place_holder_content.set_top ({SD_ENUMERATION}.top)

			if not internal_shared.is_set_show_all_feedback_indicator_called.item then
				-- We don't override client programmers' setting.
				internal_shared.set_show_all_feedback_indicator (True)
			end

			if not internal_shared.is_set_show_tab_stub_text_called.item then
				-- We don't override client programmers' setting.
				internal_shared.set_show_tab_stub_text (True)
			end

			if {PLATFORM}.is_windows then
				set_main_area_background_color ((create {EV_STOCK_COLORS}).grey)
			end

			create {SD_DEPENDENCY_CHECKER_IMP} l_checker
			l_checker.check_dependency (main_window)
		ensure
			a_container_filled: a_container.has (internal_viewport)
		end

	init_widget_structure is
			-- Build window struture.
		do
			create internal_viewport
			top_container.extend (internal_viewport)

			create tool_bar_container
			internal_viewport.extend (tool_bar_container)
			tool_bar_container.set_minimum_size (0, 0)
			create main_container
			tool_bar_container.center.extend (main_container)
			create fixed_area
			main_container.center_area.extend (fixed_area)
		end

	init_managers is
			-- Init managers.
		do
			create agents.make (Current)
			create query.make (Current)
			create command.make (Current)
			create property.make (Current)
			create zones.make (Current)
		end

	init_auto_hide_panel is
			-- Insert auto hide panels.
		do
			create internal_auto_hide_panel_left.make ({SD_ENUMERATION}.left, Current)
			create internal_auto_hide_panel_right.make ({SD_ENUMERATION}.right, Current)
			create internal_auto_hide_panel_top.make ({SD_ENUMERATION}.top, Current)
			create internal_auto_hide_panel_bottom.make ({SD_ENUMERATION}.bottom, Current)
			main_container.left_bar.extend (internal_auto_hide_panel_left)
			main_container.right_bar.extend (internal_auto_hide_panel_right)
			main_container.top_bar.extend (internal_auto_hide_panel_top)
			main_container.bottom_bar.extend (internal_auto_hide_panel_bottom)
		end

	init_inner_container is
			-- Insert inner contianer
		local
			l_inner_container: SD_MULTI_DOCK_AREA
		do
			create l_inner_container.make (Current)
			fixed_area.extend (l_inner_container)
			l_inner_container.set_minimum_size (0, 0)
			create inner_containers.make (1)
			inner_containers.extend (l_inner_container)
		end

feature -- Query

	contents: ACTIVE_LIST [SD_CONTENT]
			-- Client programmer's contents managed by Current.

	has_content (a_content: SD_CONTENT): BOOLEAN is
			-- If contents has a_content?
		do
			Result := contents.has (a_content)
		end

	tool_bar_manager: SD_TOOL_BAR_MANAGER
			-- Manager control all tool bars.

	tab_drop_actions: SD_PND_ACTION_SEQUENCE
			-- Drop action when drop on a blank tab area.

	open_actions: ACTION_SEQUENCE [ TUPLE [ANY]]
			-- Open actions when open a config.

	focused_content: SD_CONTENT is
			-- Current focused content. Maybe void.
		do
			Result := property.last_focus_content
		end

	is_title_unique (a_title: STRING_GENERAL): BOOLEAN is
			-- If `a_title' unique in all contents `unique_title's ?
		require
			a_title: a_title /= Void
		do
			Result := query.is_title_unique (a_title)
		end

	is_locked: BOOLEAN
			-- If zone can be docked?

	docker_mediator: SD_DOCKER_MEDIATOR is
			-- Manager for user dragging events.
			-- Maybe Void if user is not dragging.
		do
			Result := property.docker_mediator
		end

feature -- Command

	save_config (a_file: STRING_GENERAL) is
			-- Save current docking config.
		require
			a_file_not_void: a_file /= Void
		local
			l_config: SD_SAVE_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			l_config.save_config (a_file)
		end

	save_editors_config (a_file: STRING_GENERAL) is
			-- Save main window editor config.
		require
			not_void: a_file /= Void
		local
			l_config: SD_SAVE_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			l_config.save_editors_config (a_file)
		end

	save_tools_config (a_file: STRING_GENERAL) is
			-- Save tools config
		require
			not_void: a_file /= Void
		local
			l_config: SD_SAVE_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			l_config.save_tools_config (a_file)
		end

	save_tools_config_with_name (a_file: STRING_GENERAL; a_name: STRING_GENERAL) is
			-- Save tools config
		require
			not_void: a_file /= Void
		local
			l_config: SD_SAVE_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			l_config.save_tools_config_with_name (a_file, a_name)
		end

	open_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Open a docking config from a_named_file.
		require
			a_file_not_void: a_file /= Void
			a_file_readable: is_file_readable (a_file)
		local
			l_config: SD_OPEN_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			Result := l_config.open_config (a_file)
		end

	open_editors_config (a_file: STRING_GENERAL) is
			-- Open main window editor config.
		local
			l_config: SD_OPEN_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			l_config.open_editors_config (a_file)
		end

	open_tools_config (a_file: STRING_GENERAL): BOOLEAN is
			-- Save tools contents config.
		local
			l_config: SD_OPEN_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			Result := l_config.open_tools_config (a_file)
		end

	set_main_area_background_color (a_color: EV_COLOR) is
			-- Set main area (editors' area) background color.
		require
			a_color_not_void: a_color /= Void
		do
			 query.inner_container_main.set_background_color (a_color)
			 zones.place_holder_widget.set_background_color (a_color)
		ensure
			set: query.inner_container_main.background_color.is_equal (a_color)
		end

	main_area_drop_action: EV_PND_ACTION_SEQUENCE is
			-- Main area (editor area) drop acitons.
			-- This actions will be called if there is no editor zone and end user drop a stone to the void editor area.
		do
			Result := property.main_area_drop_actions
		ensure
			not_void: Result /= Void
		end

	update_mini_tool_bar_size (a_content: SD_CONTENT) is
			-- After mini tool bar widget size changes, update mini tool bar size to best fit new size of mini tool bar widget.
			-- `a_content' can be void if not known.
		do
			command.update_mini_tool_bar_size (a_content)
		end

	propagate_accelerators is
			-- Proprogate `main_window' accelerators to all floating zones.
		do
			command.propagate_accelerators
		end

	close_editor_place_holder is
			-- Close editors place holder zone.
		do
			zones.place_holder_content.close
		end

	lock is
			-- Set `is_locked' to `True'.
		do
			is_locked := True
		ensure
			locked: is_locked = True
		end

	unlock is
			-- Set `is_locked' to `False'.
		do
			is_locked := False
		ensure
			unlocked: is_locked = False
		end

	destroy is
			-- Destroy all underline objects.
		do
			property.destroy
			agents.destroy
			tool_bar_manager.destroy
			contents.wipe_out
		end

feature -- Contract support

	is_file_readable (a_file_name: STRING_GENERAL): BOOLEAN is
			-- Does `a_file_name' exist?
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name.as_string_8)
			Result := l_file.exists and then l_file.is_readable
		end

	window_valid (a_window: EV_WINDOW): BOOLEAN is
			-- Is `a_window' already managed?
		local
			l_list: ARRAYED_LIST [SD_DOCKING_MANAGER]
		do
			Result := True
			create internal_shared
			l_list := internal_shared.docking_manager_list
			from
				l_list.start
			until
				l_list.after or not Result
			loop
				if l_list.item.main_window = a_window then
					Result := False
				end
				l_list.forth
			end

		end

	container_valid (a_container: EV_CONTAINER; a_window: EV_WINDOW): BOOLEAN is
			-- Is `a_container' in `a_window' or `a_container' in `a_window'?
		do
			Result := a_window.has_recursive (a_container) or a_container = a_window
		end

feature {SD_TOOL_BAR_HOT_ZONE, SD_FLOATING_TOOL_BAR_ZONE, SD_CONTENT, SD_STATE,
		SD_DOCKER_MEDIATOR, SD_OPEN_CONFIG_MEDIATOR, SD_SAVE_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, SD_TOOL_BAR_DOCKER_MEDIATOR,
	 	SD_TOOL_BAR_MANAGER, SD_AUTO_HIDE_PANEL, SD_TOOL_BAR_ZONE,
	  	SD_TAB_STUB, SD_MULTI_DOCK_AREA, SD_DOCKING_MANAGER_AGENTS,
	  	SD_DOCKING_MANAGER_COMMAND, SD_DOCKING_MANAGER_ZONES, SD_AUTO_HIDE_ANIMATION,
	  	SD_DOCKING_MANAGER_QUERY, SD_NOTEBOOK, SD_ZONE_NAVIGATION_DIALOG,
	  	SD_TAB_STATE_ASSISTANT, SD_TOOL_BAR_HOT_ZONE, SD_TOOL_BAR_ZONE_ASSISTANT,
		SD_DEBUG_ACCESS, SD_UPPER_ZONE, SD_DOCKING_MANAGER_PROPERTY} -- Library internals querys.

	query: SD_DOCKING_MANAGER_QUERY
			-- Manager helper Current for querys.

	property: SD_DOCKING_MANAGER_PROPERTY
			-- Manager helper Current for properties

	command: SD_DOCKING_MANAGER_COMMAND
			-- Manager helper Current for commands.

	agents: SD_DOCKING_MANAGER_AGENTS
			-- Manager help Current for agents.

	zones: SD_DOCKING_MANAGER_ZONES
			-- Manager help Current for zones issues.

feature {SD_TOOL_BAR_HOT_ZONE, SD_CONTENT, SD_STATE, SD_DOCKER_MEDIATOR,
	 SD_OPEN_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, SD_DEBUG_ACCESS, SD_TOOL_BAR_DOCKER_MEDIATOR,
	 SD_TOOL_BAR_MANAGER, SD_AUTO_HIDE_PANEL, SD_DOCKING_MANAGER, SD_DOCKING_MANAGER_AGENTS,
	 SD_DOCKING_MANAGER_QUERY, SD_DOCKING_MANAGER_COMMAND, SD_TOOL_BAR_ZONE_ASSISTANT,
	 SD_DOCKING_MANAGER_ZONES, SD_NOTEBOOK_TAB_AREA, SD_NOTEBOOK_TAB, SD_AUTO_HIDE_ANIMATION,
	 SD_FLOATING_TOOL_BAR_ZONE, SD_TOOL_BAR_HIDDEN_ITEM_DIALOG, SD_DOCKING_MANAGER_PROPERTY,
	 SD_ZONE_NAVIGATION_DIALOG, SD_SAVE_CONFIG_MEDIATOR}
	 	 -- Library internal attributes.

	tool_bar_container: SD_TOOL_BAR_CONTAINER
			-- Container for tool bars on four sides.

	main_window: EV_WINDOW
			-- Client programmer's main window.

	fixed_area: EV_FIXED
			-- EV_FIXED for DOCKING_MANAGER manage widgets.

	top_container: EV_CONTAINER
			-- Topest level container. It contains EV_VIWEPORT which contains fixed_area.	

	inner_containers: ARRAYED_SET [SD_MULTI_DOCK_AREA]
			-- All containers.

	main_container: SD_MAIN_CONTAINER
			-- Container has four tab stub areas in four side and main area in center.

feature {SD_DOCKING_MANAGER_AGENTS, SD_DOCKING_MANAGER_QUERY,
	SD_DOCKING_MANAGER_COMMAND} -- Implementation

	internal_viewport: EV_VIEWPORT
			-- The viewport which contain `fixed_area'.

	internal_shared: SD_SHARED
			-- All singletons

	internal_auto_hide_panel_left, internal_auto_hide_panel_right, internal_auto_hide_panel_top, internal_auto_hide_panel_bottom: SD_AUTO_HIDE_PANEL
			-- Auto hide panels

invariant

	internal_viewport_not_void: internal_viewport /= Void
	internal_fixed_not_void: fixed_area /= Void
	internal_main_container_not_void: main_container /= Void
	internal_inner_container_not_void: inner_containers /= Void and inner_containers.count >= 1
	internal_contents_not_void: contents /= Void

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
