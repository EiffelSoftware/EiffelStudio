indexing
	description: "Manager which communicate between client programmer and whole docking library."
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
			a_container_valid: container_valid (a_container, a_window)
		local
			l_app: EV_ENVIRONMENT
		do
			create internal_shared
			create tab_drop_actions
			init_managers

			top_container := a_container
			main_window := a_window

			init_widget_structure
			init_auto_hide_panel

			create contents

			contents.add_actions.extend (agent agents.on_added_content)
			zones.zones.add_actions.extend (agent agents.on_added_zone)
			zones.zones.remove_actions.extend (agent agents.on_pruned_zone)

			internal_shared.add_docking_manager (Current)

			init_inner_container

			internal_shared.set_hot_zone_factory (create {SD_HOT_ZONE_TRIANGLE_FACTORY})
			create menu_manager.make (Current)
			create l_app
			l_app.application.pointer_button_press_actions.extend (agent agents.on_widget_pointer_press)
		ensure
			a_container_filled: a_container.has (internal_viewport)
		end

	init_widget_structure is
			-- Build window struture.
		do
			create internal_viewport
			top_container.extend (internal_viewport)
			internal_viewport.resize_actions.extend (agent agents.on_resize)

			create menu_container
			internal_viewport.extend (menu_container)
			menu_container.set_minimum_size (0, 0)
			create main_container
			menu_container.center.extend (main_container)
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
			create internal_auto_hide_panel_left.make (dock_left, Current)
			create internal_auto_hide_panel_right.make (dock_right, Current)
			create internal_auto_hide_panel_top.make (dock_top, Current)
			create internal_auto_hide_panel_bottom.make (dock_bottom, Current)
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

	menu_manager: SD_MENU_MANAGER
			-- Manager control all menus.

	tab_drop_actions: SD_PND_ACTION_SEQUENCE
			-- Drop action when drop on a blank tab area.

	open_actions: ACTION_SEQUENCE [ TUPLE [ANY]]
			-- Open actions when open a config.

--	save_actions: ACTION_SEQUENCE [ ]

feature -- Command

	save_config (a_file: STRING) is
			-- Save current docking config.
		require
			a_file_not_void: a_file /= Void
		local
			l_config: SD_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			l_config.save_config (a_file)
		end

	open_config (a_file: STRING) is
			-- Open a docking config from a_named_file.
		require
			a_file_not_void: a_file /= Void
			a_file_exist: file_exist (a_file)
		local
			l_config: SD_CONFIG_MEDIATOR
		do
			create l_config.make (Current)
			l_config.open_config (a_file)
		end

	set_main_area_background_color (a_color: EV_COLOR) is
			-- Set main area background color.
		require
			a_color_not_void: a_color /= Void
		do
			 query.inner_container_main.set_background_color (a_color)
		ensure
			set: query.inner_container_main.background_color.is_equal (a_color)
		end

feature -- Contract support

	file_exist (a_file_name: STRING): BOOLEAN is
			-- If `a_file_name' exist?
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_read (a_file_name)
			Result := l_file.exists
		end

	window_valid (a_window: EV_WINDOW): BOOLEAN is
			-- If `a_widnow' already managed?
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
			-- If `a_container' is `a_window' or `a_container' in `a_window'?
		do
			Result := a_window.has_recursive (a_container) or a_container = a_window
		end

feature {SD_MENU_HOT_ZONE, SD_FLOATING_MENU_ZONE, SD_CONTENT, SD_STATE,
	SD_DOCKER_MEDIATOR, SD_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, SD_DEBUG_WINDOW,
	 SD_MENU_DOCKER_MEDIATOR, SD_MENU_MANAGER, SD_AUTO_HIDE_PANEL, SD_MENU_ZONE,
	  SD_TAB_STUB, SD_MULTI_DOCK_AREA, SD_DOCKING_MANAGER_AGENTS,
	  SD_DOCKING_MANAGER_COMMAND, SD_DOCKING_MANAGER_ZONES,
	  SD_DOCKING_MANAGER_QUERY, SD_NOTEBOOK} -- Library internals querys.

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

feature {SD_MENU_HOT_ZONE, SD_FLOATING_MENU_ZONE, SD_CONTENT, SD_STATE, SD_DOCKER_MEDIATOR,
	 SD_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, SD_DEBUG_WINDOW, SD_MENU_DOCKER_MEDIATOR,
	 SD_MENU_MANAGER, SD_AUTO_HIDE_PANEL, SD_DOCKING_MANAGER, SD_DOCKING_MANAGER_AGENTS,
	 SD_DOCKING_MANAGER_QUERY, SD_DOCKING_MANAGER_COMMAND,
	 SD_DOCKING_MANAGER_ZONES} -- Library internal attributes.

	menu_container: SD_MENU_CONTAINER
			-- Container for menus on four sides.

	main_window: EV_WINDOW
			-- Client programmer's window.

	fixed_area: EV_FIXED
			-- EV_FIXED for DOCKING_MANAGER manage widgets.

	top_container: EV_CONTAINER
			-- Topest level container. It contains EV_VIWEPORT which contains fixed_area.	

	inner_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			-- All containers.

	main_container: SD_MAIN_CONTAINER
			-- Container has four tab stub areas in four side and main area in center.

feature -- Enumeration

	Dock_top: INTEGER is 1
	Dock_bottom: INTEGER is 2
	Dock_left: INTEGER is 3
	Dock_right: INTEGER is 4

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

end
