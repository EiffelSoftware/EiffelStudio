note
	description: "[
		Manager which communicate between client programmer and whole docking library.
				
		The SD_DOCKING_MANAGER is the key (and the most important one) for client
		programmers to comunicate with docking library. Almost all importantant features
		are listed in SD_DOCKING_MANAGER, such as extend/remove a docking content 
		(which is a docking unit)
				
		Internally, docking manger create left, right, top, bottom areas for toolbars 
		and docking panels.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER

inherit
	SD_ACCESS

	EV_BUILDER

create
	make

feature {NONE} -- Initialization

	make (a_container: EV_CONTAINER; a_window: EV_WINDOW)
			-- Creation method
			-- Between `a_container' and `a_window', there can be other non-dockable widget
			--
			-- `a_container' is the top level container which hold all docking widgets
   			-- `a_window' is the main window which hold `a_container'
			-- `a_window' is used for register global shortcuts (such as `esc' key used for cancel a dragging),
			-- also used for showing a parented floating docking panel, also used for set global cursor icon
			-- when dragging, and ...
		require
			a_container_not_void: a_container /= Void
			a_container_not_destroy: not a_container.is_destroyed
			a_container_not_full: not a_container.full
			a_widnow_valid: window_valid (a_window)
		local
			l_list: ARRAYED_LIST [SD_DOCKING_MANAGER_HOLDER]
			l_left, l_right, l_top, l_bottom: like internal_auto_hide_panel_bottom
		do
			create internal_shared
			create tab_drop_actions

			top_container := a_container
			main_window := a_window

			init_widget_structure

			create l_left.make ({SD_ENUMERATION}.left)
			internal_auto_hide_panel_left := l_left
			create l_right.make ({SD_ENUMERATION}.right)
			internal_auto_hide_panel_right := l_right
			create l_top.make ({SD_ENUMERATION}.top)
			internal_auto_hide_panel_top := l_top
			create l_bottom.make ({SD_ENUMERATION}.bottom)
			internal_auto_hide_panel_bottom := l_bottom

			create contents
			create inner_containers.make (1)

			create agents.make (Current)
			create query.make (Current)
			create command.make (Current)
			create property.make (Current)
			create zones.make (Current)

			create tool_bar_manager.make (Current)

			tool_bar_manager.add_actions

			create l_list.make (20)
			l_list.extend (tool_bar_manager)
			init_managers (l_list)
			init_inner_container (l_list)

			l_left.set_docking_manager (Current)
			main_container.left_bar.extend (l_left)
			l_right.set_docking_manager (Current)
			main_container.right_bar.extend (l_right)
			l_top.set_docking_manager (Current)
			main_container.top_bar.extend (l_top)
			l_bottom.set_docking_manager (Current)
			main_container.bottom_bar.extend (l_bottom)

			contents.extend (zones.place_holder_content)

			if not internal_shared.is_set_show_all_feedback_indicator_called.item then
				-- We don't override client programmers' setting
				internal_shared.set_show_all_feedback_indicator (True)
			end

			if not internal_shared.is_set_show_tab_stub_text_called.item then
				-- We don't override client programmers' setting
				internal_shared.set_show_tab_stub_text (True)
			end

			;(create {SD_DEPENDENCY_CHECKER_IMP}).check_dependency (main_window)

			internal_shared.add_docking_manager (Current)

			attach_docking_manager (l_list)

			agents.init_actions
			zones.place_holder_content.set_top ({SD_ENUMERATION}.top)
			if {PLATFORM}.is_windows then
				set_main_area_background_color ((create {EV_STOCK_COLORS}).grey)
			end
		ensure
			a_container_filled: a_container.has (internal_viewport)
		end

	init_widget_structure
			-- Build window struture
		do
			create internal_viewport
			top_container.extend (internal_viewport)

			create tool_bar_container.make
			internal_viewport.extend (tool_bar_container)
			tool_bar_container.set_minimum_size (1, 1)
			create main_container.make
			tool_bar_container.center.extend (main_container)
			create fixed_area
			main_container.center_area.extend (fixed_area)

			debug ("ev_identifier")
				internal_viewport.set_identifier_name ("SD:Manager:Viewport")
				tool_bar_container.set_identifier_name ("SD:Manager:Toolbar container")
				main_container.set_identifier_name ("SD:Manager:Toolbar>Main container")
				fixed_area.set_identifier_name ("SD:Manager:Toolbar>Main>Fixed area")
			end
		end

	init_managers (a_list: ARRAYED_LIST [SD_DOCKING_MANAGER_HOLDER])
			-- Init managers
		require
			not_void: a_list /= Void
		do
			agents.add_actions
			command.add_actions

			a_list.extend (agents)
			a_list.extend (query)
			a_list.extend (command)
			a_list.extend (property)
			a_list.extend (zones)
		end

	init_inner_container (a_list: ARRAYED_LIST [SD_DOCKING_MANAGER_HOLDER])
			-- Insert inner container
		require
			not_void: a_list /= Void
		local
			l_inner_container: SD_MULTI_DOCK_AREA
		do
			create l_inner_container.make (Current)
			a_list.extend (l_inner_container)
			fixed_area.extend (l_inner_container)
			l_inner_container.set_minimum_size (1, 1)
			inner_containers.extend (l_inner_container)
		end

	attach_docking_manager (a_list: ARRAYED_LIST [SD_DOCKING_MANAGER_HOLDER])
			-- Attach all items of `a_list' with Current
		require
			not_void: a_list /= Void
		do
			from
				a_list.start
			until
				a_list.after
			loop
				a_list.item.set_docking_manager (Current)
				a_list.forth
			end
		end

feature -- Access

	restoration_callback: detachable FUNCTION [TUPLE [title: READABLE_STRING_GENERAL], SD_CONTENT]
			-- Agent to use to attempt to retrieve a {SD_CONTENT} during restoration from a cached
			-- layout file

feature -- Element change

	set_restoration_callback (a_callback: like restoration_callback)
			-- Sets a callback to fetch a content area when it's not already located in a container
		do
			restoration_callback := a_callback
		ensure
			restoration_callback_set: restoration_callback = a_callback
		end

feature -- Query

	contents: ACTIVE_LIST [SD_CONTENT]
			-- Client programmer's contents managed by Current
			-- Be careful when adding/pruning item in this list even after twined the list
			-- There are add/prune actions registered in the list.

	has_content (a_content: SD_CONTENT): BOOLEAN
			-- If Current's `contents' has `a_content'?
		require
			not_destroyed: not is_destroyed
		do
			Result := contents.has (a_content)
		end

	tool_bar_manager: SD_TOOL_BAR_MANAGER
			-- Manager that control all tool bars

	tab_drop_actions: detachable SD_PND_ACTION_SEQUENCE note option: stable attribute end
			-- Drop action when drop on a blank tab area

	restore_editor_area_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- When whole editor area restored automatically for maximized area, actions will be invoked
		require
			not_destroyed: not is_destroyed
		do
			Result := query.restore_whole_editor_area_actions
		ensure
			not_void: Result /= Void
		end

	restore_editor_area_for_minimized_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- When whole editor area restored automatically for minimized area, actions will be invoked
		require
			not_destroyed: not is_destroyed
		do
			Result := query.restore_whole_editor_area_for_minimized_actions
		ensure
			not_void: Result /= Void
		end

	main_area_drop_action: EV_PND_ACTION_SEQUENCE
			-- Main area (editor area) drop acitons
			-- This actions will be called if there is no editor at all and end user drop
			-- a stone to blank editor area (grey by default)
		require
			not_destroyed: not is_destroyed
		do
			Result := property.main_area_drop_actions
		ensure
			not_void: Result /= Void
		end

	focused_content: detachable SD_CONTENT
			-- Current focused content
			-- Maybe void
		require
			not_destroyed: not is_destroyed
		do
			Result := property.last_focus_content
		end

	is_unique_title_free_to_use (a_title: READABLE_STRING_GENERAL): BOOLEAN
			-- If `a_title' unique in all current contents' `unique_title', not already used by other contents?
		require
			a_title: a_title /= Void
			not_destroyed: not is_destroyed
		do
			Result := query.is_unique_title_free_to_use (a_title)
		end

	is_locked: BOOLEAN
			-- If tool type zone can be docked?

	is_editor_locked: BOOLEAN
			-- If editor type zone can be docked?

	is_editor_area_maximized: BOOLEAN
			-- If editor area maximized?
		require
			not_destroyed: not is_destroyed
		do
			Result := command.orignal_editor_parent /= Void
			check two_item_exist_at_same_time: Result implies command.orignal_whole_item /= Void end
		end

	is_editor_area_minimized: BOOLEAN
			-- If editor area minimized?
		require
			not_destroyed: not is_destroyed
		do
			Result := command.orignal_whole_item_for_minimized /= Void
		end

	docker_mediator: detachable SD_DOCKER_MEDIATOR
			-- Manager for user dragging events
			-- Maybe Void if user is not dragging
		require
			not_destroyed: not is_destroyed
		do
			Result := property.docker_mediator
		end

	is_config_data_path_valid (a_file_name: PATH): BOOLEAN
			 -- Is config data in `a_file_name' valid?
		local
			l_file: RAW_FILE
			l_config_mediator: SD_OPEN_CONFIG_MEDIATOR
		do
			create l_file.make_with_path (a_file_name)
			if l_file.exists then
				create l_config_mediator.make (Current)
				if attached l_config_mediator.config_data_from_path (a_file_name) as l_data then
					Result := True
				end
			end
		end

	is_destroyed: BOOLEAN
			-- If current destroyed?

feature -- Command

	save_data_with_path (a_file: PATH): BOOLEAN
			-- Save current docking config data (including tools' data and editors' data) into `a_file'
		require
			a_file_not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := (create {SD_SAVE_CONFIG_MEDIATOR}.make (Current)).save_config_with_path (a_file)
		end

	save_editors_data_with_path (a_file: PATH): BOOLEAN
			-- Save main window's editor layout configuration data into `a_file'
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := (create {SD_SAVE_CONFIG_MEDIATOR}.make (Current)).save_editors_config_with_path (a_file)
		end

	save_tools_data_with_path (a_file: PATH): BOOLEAN
			-- Save tools' layout configuration data into `a_file'
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := (create {SD_SAVE_CONFIG_MEDIATOR}.make (Current)).save_tools_config_with_path (a_file)
		end

	save_tools_data_with_name_and_path (a_file: PATH; a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Save tools' layout configuration data into a file named `a_file' and store `a_name' into the data
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := (create {SD_SAVE_CONFIG_MEDIATOR}.make (Current)).save_tools_config_with_name_and_path (a_file, a_name)
		end

	open_config_with_path (a_file: PATH): BOOLEAN
			-- Open all docking layout configuration data previously stored in `a_file'
			-- Result True means restore docking layout operation executed successfully.
			-- Result False means the operation failed, maybe due to `a_file' not exist, or
			-- data in `a_file' corrupted.
		require
			a_file_not_void: a_file /= Void
			a_file_readable: is_file_path_readable (a_file)
			not_destroyed: not is_destroyed
		do
			Result := (create {SD_OPEN_CONFIG_MEDIATOR}.make (Current)).open_config_with_path (a_file)
		end

	open_editors_config_with_path (a_file: PATH)
			-- Open main window editors' layout configuration data previously stored in `a_file'
		require
			not_destroyed: not is_destroyed
		do
			;(create {SD_OPEN_CONFIG_MEDIATOR}.make (Current)).open_editors_config_with_path (a_file)
		end

	open_tools_config_with_path (a_file: PATH): BOOLEAN
			-- Open tool type contents' layout configuration data previously stored in `a_file'
			-- When editor area available, open all tools' layout except all editor area panels'
			-- It means, when no editor area avaliable, open_tools_config doesn't make sense
			-- Note: If window is minimized, EV_SPLIT_AREA split bar position can't be restored correctly
			-- See bug#14309
		require
			not_destroyed: not is_destroyed
		do
			Result := (create {SD_OPEN_CONFIG_MEDIATOR}.make (Current)).open_tools_config_with_path (a_file)
		end

	open_maximized_tool_config_with_path (a_file: PATH)
			-- Open tool's maximization statues configuration data previously stored in `a_file'
		require
			not_destroyed: not is_destroyed
		do
			;(create {SD_OPEN_CONFIG_MEDIATOR}.make (Current)).open_maximized_tool_data_with_path (a_file)
		end

	open_tool_bar_item_config_with_path (a_file: PATH)
			-- Open tool bar items' layout configuration data previously stored in `a_file'
		require
			not_destroyed: not is_destroyed
		do
			;(create {SD_OPEN_CONFIG_MEDIATOR}.make (Current)).open_tool_bar_item_data_with_path (a_file)
		end

	set_main_area_background_color (a_color: EV_COLOR)
			-- Set main area (editors' area) background color
			-- It will be displayed when no editor available
		require
			a_color_not_void: a_color /= Void
			not_destroyed: not is_destroyed
		do
			 query.inner_container_main.set_background_color (a_color)
			 zones.place_holder_widget.set_background_color (a_color)
		ensure
			set: query.inner_container_main.background_color.is_equal (a_color)
		end

	update_mini_tool_bar_size (a_content: SD_CONTENT)
			-- After mini tool bar widget's size changed, update mini tool bar's size to best
			-- fit new size of mini tool bar widget
			-- `a_content' can be void if not known
		require
			not_destroyed: not is_destroyed
		do
			command.update_mini_tool_bar_size (a_content)
		end

	propagate_accelerators
			-- Proprogate `main_window' accelerators to all floating zones
		require
			not_destroyed: not is_destroyed
		do
			command.propagate_accelerators
		end

	close_editor_place_holder
			-- Close editors place holder zone
			-- Editor place holder means the blank editor area (grey by default) in main window
			-- when no editor available
		require
			not_destroyed: not is_destroyed
		do
			zones.place_holder_content.close
		end

	lock
			-- Set `is_locked' to `True'
		require
			not_destroyed: not is_destroyed
		do
			is_locked := True
		ensure
			locked: is_locked
		end

	unlock
			-- Set `is_locked' to `False'
		require
			not_destroyed: not is_destroyed
		do
			is_locked := False
		ensure
			unlocked: not is_locked
		end

	lock_editor
			-- Set `is_editor_locked' to `True'
		require
			not_destroyed: not is_destroyed
		do
			is_editor_locked := True
		ensure
			locked: is_editor_locked
		end

	unlock_editor
			-- Set `is_editor_locked' to `False'
		require
			not_destroyed: not is_destroyed
		do
			is_editor_locked := False
		ensure
			unlocked: not is_editor_locked
		end

	maximize_editor_area
			-- Maximize whole editor area
			-- Editor area means all editors' area especially for
			-- the area when editors are docked side by side in split areas
		require
			not_destroyed: not is_destroyed
		do
			command.maximize_editor_area
		end

	restore_editor_area
			-- Restore whole editor area if the editor area maximized
		require
			not_destroyed: not is_destroyed
		do
			command.restore_editor_area
		end

	minimize_editor_area
			-- Minimize whole editor area
			-- The whole editor area will be minimized to a small button
			-- If end user clicked the small button, the editor area will be restored
		require
			not_destroyed: not is_destroyed
		do
			command.minimize_editor_area
		end

	restore_editor_area_for_minimized
			-- Restore whole editor area if the editor area minimized
		require
			not_destroyed: not is_destroyed
		do
			command.restore_editor_area_for_minimized
		end

	minimize_editors
			-- Minimize all editors
			-- Not same as `minimize_editor_area', it actually let all editors
			-- minimize separately
		require
			not_destroyed: not is_destroyed
		do
			command.minimize_editors
		end

	restore_minimized_editors
			-- Restore all minimized editors to normal state
		require
			not_destroyed: not is_destroyed
		do
			command.restore_minimized_editors
		end

	restore_maximized_editor
			-- Restore maximized editor in main window if possible
		require
			not_destroyed: not is_destroyed
		do
			command.restore_maximized_editor
		end

	show_displayed_floating_windows_in_idle
			-- Show all displayed floating windows again for Solaris CDE
			-- This feature fix bug#13645
		require
			not_destroyed: not is_destroyed
		do
			command.show_displayed_floating_windows_in_idle
		end

	close_all
			-- Close all contents
			-- All actions in {SD_CONTENT} will NOT be called
		require
			not_destroyed: not is_destroyed
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			from
				is_closing_all := True
				l_contents := contents.twin
				l_contents.start
			until
				l_contents.after
			loop
				l_contents.item.close
				l_contents.forth
			end
			is_closing_all := False
		ensure
			cleared: not is_closing_all
		end

	destroy
			-- Destroy all underline objects
			-- Free all memory if possible
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
			l_notebooks: ARRAYED_LIST [SD_NOTEBOOK]
		do
			internal_shared.docking_manager_list.prune_all (Current)
			property.destroy
			agents.destroy
			tool_bar_manager.destroy

			from
				l_contents := contents
				l_contents.start
			until
				l_contents.after
			loop
				l_contents.item.destroy
				l_contents.forth
			end

			contents.wipe_out

			-- We have to destroy floating zones for Linux implementation, on Windows not needed.
			from
				l_floating_zones := query.floating_zones
				l_floating_zones.start
			until
				l_floating_zones.after
			loop
				if attached {EV_WIDGET} l_floating_zones.item as lt_widget then
					lt_widget.destroy
				else
					check not_possible: False end
				end

				l_floating_zones.forth
			end

			if not internal_auto_hide_panel_top.is_destroyed then
				internal_auto_hide_panel_top.destroy
			end
			if not internal_auto_hide_panel_bottom.is_destroyed then
				internal_auto_hide_panel_bottom.destroy
			end
			if not internal_auto_hide_panel_left.is_destroyed then
				internal_auto_hide_panel_left.destroy
			end
			if not internal_auto_hide_panel_right.is_destroyed then
				internal_auto_hide_panel_right.destroy
			end

			from
				l_notebooks := internal_shared.widgets.all_notebooks
				l_notebooks.start
			until
				l_notebooks.after
			loop
				if l_notebooks.item.docking_manager = Current then
					l_notebooks.item.destroy
				end
				l_notebooks.forth
			end

			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

feature -- Contract support

	is_file_path_readable (a_file_name: PATH): BOOLEAN
			-- Does `a_file_name' exist and readable?
		local
			l_file: RAW_FILE
		do
			create l_file.make_with_path (a_file_name)
			Result := l_file.exists and then l_file.is_readable
		end

	window_valid (a_window: EV_WINDOW): BOOLEAN
			-- Is `a_window' already managed by one docking manager?
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

	container_valid (a_container: EV_CONTAINER; a_window: EV_WINDOW): BOOLEAN
			-- Is `a_container' resides in `a_window' or `a_container' resides in `a_window'?
		do
			Result := a_window.has_recursive (a_container) or a_container = a_window
		end

feature {SD_DEBUG_ACCESS, SD_ACCESS} -- Library internals querys

	query: SD_DOCKING_MANAGER_QUERY
			-- Manager helpe Current for querys features

	property: SD_DOCKING_MANAGER_PROPERTY
			-- Manager helpe Current for properties features

	command: SD_DOCKING_MANAGER_COMMAND
			-- Manager helpe Current for commands features

	agents: SD_DOCKING_MANAGER_AGENTS
			-- Manager help Current for agents features

	zones: SD_DOCKING_MANAGER_ZONES
			-- Manager help Current for zones issues features

feature {SD_ACCESS} -- Library internal attributes

	tool_bar_container: SD_TOOL_BAR_CONTAINER
			-- Container for tool bars on four sides of main window

	main_window: EV_WINDOW
			-- Client programmer's and docking manager's main window

	fixed_area: EV_FIXED
			-- EV_FIXED for DOCKING_MANAGER to manage widgets

	top_container: EV_CONTAINER
			-- Topest level container. It contains EV_VIEWPORT which contains fixed_area	

	inner_containers: ARRAYED_SET [SD_MULTI_DOCK_AREA]
			-- All containers, including main windows' and all floating windows'

	main_container: SD_MAIN_CONTAINER
			-- Container in main window which has four tab stub areas in four side and a main area for docking widgets in center

	is_closing_all: BOOLEAN
			-- Is Current closing all contents now?

feature {SD_DOCKING_MANAGER_AGENTS, SD_DOCKING_MANAGER_QUERY, SD_DOCKING_MANAGER_COMMAND} -- Implementation

	internal_viewport: EV_VIEWPORT
			-- The viewport which contain `fixed_area'

	internal_shared: SD_SHARED
			-- All singletons

	internal_auto_hide_panel_left,
	internal_auto_hide_panel_right,
	internal_auto_hide_panel_top,
	internal_auto_hide_panel_bottom: SD_AUTO_HIDE_PANEL
			-- Auto hide panels

feature -- Obsolete

	save_config (a_file: READABLE_STRING_GENERAL)
			-- Save current docking config
		obsolete
			"Use save_data instead. [2017-05-31]"
		require
			a_file_not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			save_data (a_file).do_nothing
		end

	save_editors_config (a_file: READABLE_STRING_GENERAL)
			-- Save main window editor config
		obsolete
			"Use save_editors_data instead. [2017-05-31]"
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			save_editors_data (a_file).do_nothing
		end

	save_tools_config (a_file: READABLE_STRING_GENERAL)
			-- Save tools config
		obsolete
			"Use save_tools_data instead. [2017-05-31]"
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			save_tools_data (a_file).do_nothing
		end

	save_tools_config_with_name (a_file: READABLE_STRING_GENERAL; a_name: READABLE_STRING_GENERAL)
			-- Save tools config
		obsolete
			"Use save_tools_data_with_name instead. [2017-05-31]"
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			save_tools_data_with_name (a_file, a_name).do_nothing
		end

	is_title_unique (a_title: READABLE_STRING_GENERAL): BOOLEAN
			-- If `a_title' unique in all contents `unique_title's ?
		obsolete
			"Use is_unique_title_free_to_use instead. [2017-05-31]"
		require
			a_title: a_title /= Void
			not_destroyed: not is_destroyed
		do
			Result := is_unique_title_free_to_use (a_title)
		end

	save_data (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Save current docking config data (including tools' data and editors' data) into `a_file'
		obsolete
			"Use save_data_with_path instead. [2017-05-31]"
		require
			a_file_not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := save_data_with_path (create {PATH}.make_from_string (a_file))
		end

	save_editors_data (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Save main window's editor layout configuration data into `a_file'
		obsolete
			"Use save_editors_data_with_path instead. [2017-05-31]"
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := save_editors_data_with_path (create {PATH}.make_from_string (a_file))
		end

	save_tools_data (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Save tools' layout configuration data into `a_file'
		obsolete
			"Use save_tools_data_with_path instead. [2017-05-31]"
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := save_tools_data_with_path (create {PATH}.make_from_string (a_file))
		end

	save_tools_data_with_name (a_file: READABLE_STRING_GENERAL; a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Save tools' layout configuration data into a file named `a_file' and store `a_name' into the data
		obsolete
			"Use save_tools_data_with_name_and_path instead. [2017-05-31]"
		require
			not_void: a_file /= Void
			not_destroyed: not is_destroyed
		do
			Result := save_tools_data_with_name_and_path (create {PATH}.make_from_string (a_file), a_name)
		end

	open_config (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Open all docking layout configuration data previously stored in `a_file'
			-- Result True means restore docking layout operation executed successfully.
			-- Result False means the operation failed, maybe due to `a_file' not exist, or
			-- data in `a_file' corrupted.
		obsolete
			"Use open_config_with_path instead. [2017-05-31]"
		require
			a_file_not_void: a_file /= Void
			a_file_readable: is_file_readable (a_file)
			not_destroyed: not is_destroyed
		do
			Result := open_config_with_path (create {PATH}.make_from_string (a_file))
		end

	open_editors_config (a_file: READABLE_STRING_GENERAL)
			-- Open main window editors' layout configuration data previously stored in `a_file'
		obsolete
			"Use open_editors_config_with_path instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			open_editors_config_with_path (create {PATH}.make_from_string (a_file))
		end

	open_tools_config (a_file: READABLE_STRING_GENERAL): BOOLEAN
			-- Open tool type contents' layout configuration data previously stored in `a_file'
			-- When editor area available, open all tools' layout except all editor area panels'
			-- It means, when no editor area avaliable, open_tools_config doesn't make sense
			-- Note: If window is minimized, EV_SPLIT_AREA split bar position can't be restored correctly
			-- See bug#14309
		obsolete
			"Use open_tools_config_with_path instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			Result := open_tools_config_with_path (create {PATH}.make_from_string (a_file))
		end

	open_maximized_tool_config (a_file: READABLE_STRING_GENERAL)
			-- Open tool's maximization statues configuration data previously stored in `a_file'
		obsolete
			"Use open_maximized_tool_config_with_path instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			open_maximized_tool_config_with_path (create {PATH}.make_from_string (a_file))
		end

	open_tool_bar_item_config (a_file: READABLE_STRING_GENERAL)
			-- Open tool bar items' layout configuration data previously stored in `a_file'
		obsolete
			"Use open_tool_bar_item_config_with_path instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			open_tool_bar_item_config_with_path (create {PATH}.make_from_string (a_file))
		end

	is_file_readable (a_file_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_file_name' exist and readable?
		obsolete
			"Use is_file_path_readable instead. [2017-05-31]"
		do
			Result := is_file_path_readable (create {PATH}.make_from_string (a_file_name))
		end

	is_config_data_valid (a_file_name: READABLE_STRING_GENERAL): BOOLEAN
			 -- Is config data in `a_file_name' valid?
		obsolete
			"Use is_config_data_path_valid instead. [2017-05-31]"
		do
			Result := is_config_data_path_valid (create {PATH}.make_from_string (a_file_name))
		end

invariant

	internal_viewport_not_void: internal_viewport /= Void
	fixed_not_void: fixed_area /= Void
	main_container_not_void: main_container /= Void
	inner_container_not_void: inner_containers /= Void and then inner_containers.count >= 1
	contents_not_void: contents /= Void
	tool_bar_manager_not_void: tool_bar_manager /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
