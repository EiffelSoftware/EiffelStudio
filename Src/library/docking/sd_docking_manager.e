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
		local
			l_inner_container: SD_MULTI_DOCK_AREA
			l_app: EV_ENVIRONMENT
		do
			create internal_shared
			top_container := a_container
			main_window := a_window
			create internal_viewport
			internal_viewport.resize_actions.extend (agent on_resize)
			top_container.extend (internal_viewport)
			create menu_container
			internal_viewport.extend (menu_container)
			menu_container.set_minimum_size (0, 0)
			create main_container
			menu_container.center.extend (main_container)
			create fixed_area
			main_container.center_area.extend (fixed_area)
			-- Insert auto hide panels.
			create internal_auto_hide_panel_left.make (dock_left)
			create internal_auto_hide_panel_right.make (dock_right)
			create internal_auto_hide_panel_top.make (dock_top)
			create internal_auto_hide_panel_bottom.make (dock_bottom)
			main_container.left_bar.extend (internal_auto_hide_panel_left)
			main_container.right_bar.extend (internal_auto_hide_panel_right)
			main_container.top_bar.extend (internal_auto_hide_panel_top)
			main_container.bottom_bar.extend (internal_auto_hide_panel_bottom)
			create contents
			create zones
			zones.add_actions.extend (agent on_added_zone)
			zones.remove_actions.extend (agent on_pruned_zone)
			internal_shared.set_docking_manager (Current)
			-- Insert inner contianer
			create l_inner_container.make
			fixed_area.extend (l_inner_container)
			l_inner_container.set_minimum_size (0, 0)
			create inner_containers.make (1)
			inner_containers.extend (l_inner_container)
			internal_shared.set_hot_zone_factory (create {SD_HOT_ZONE_TRIANGLE_FACTORY})
			create menu_manager.make
			create l_app
			l_app.application.pointer_button_press_actions.extend (agent on_widget_pointer_press)
		ensure
			a_container_filled: a_container.has (internal_viewport)
		end

feature -- Query

	contents: ACTIVE_LIST [SD_CONTENT]
			-- Client programmer's contents managed by docking library.

	has_content (a_content: SD_CONTENT): BOOLEAN is
			-- If contents has a_content?
		do
			Result := contents.has (a_content)
		end

	menu_manager: SD_MENU_MANAGER
			-- Manager control all menus.

feature -- Command

	set_main_area_background_color (a_color: EV_COLOR) is
			-- Set main area background color.
		require
			a_color_not_void: a_color /= Void
		do
			 inner_container_main.set_background_color (a_color)
		ensure
			set: inner_container_main.background_color.is_equal (a_color)
		end

	save_config (a_file: STRING) is
			-- Save current docking config.
		require
			a_file_not_void: a_file /= Void
		local
			l_config: SD_CONFIG_MEDIATOR
		do
			create l_config.make
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
			create l_config.make
			l_config.open_config (a_file)
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

feature {SD_MENU_HOT_ZONE, SD_FLOATING_MENU_ZONE, SD_CONTENT, SD_STATE,
	SD_DOCKER_MEDIATOR, SD_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, MAIN_WINDOW,
	 SD_MENU_DOCKER_MEDIATOR, SD_MENU_MANAGER} -- Library internals zone issues.
-- FIXIT: export to MAIN_WINDOW is for debug, remove it in future.

	zones: ACTIVE_LIST [SD_ZONE]
			-- All the SD_ZONE in current system.

	zone_by_content (a_content: SD_CONTENT): SD_ZONE is
			-- If main container has zone with a_content?
		do
			from
				zones.start
			until
				zones.after or
				Result /= Void
			loop
				if zones.item.content = a_content then
					Result := zones.item
				end
				zones.forth
			end
		end

	has_zone (a_zone: SD_ZONE): BOOLEAN is
			-- If the main container has zone?
		do
			Result := zones.has (a_zone)
		end

	has_zone_by_content (a_content: SD_CONTENT): BOOLEAN is
			-- If the main container has zone with a_content?
		do
			from
				zones.start
			until
				zones.after or
				Result
			loop
				Result := zones.item.has (a_content)
				zones.forth
			end
		end

	zone_parent_void (a_zone: SD_ZONE): BOOLEAN is
			-- Contract support
		require
			a_zone_not_void: a_zone /= Void
		local
			l_widget: EV_WIDGET
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_floating_zone ?= a_zone
			if l_floating_zone /= Void then
				-- Allow a SD_FLOATING_ZONE parent void
				Result := False
			else
				l_widget ?= a_zone
				check l_widget /= Void end
				Result := l_widget.parent = Void
			end
		end

	add_zone (a_zone: SD_ZONE) is
			-- Add a zone to show.
		require
			a_zone_not_void: a_zone /= Void
		do
			remove_auto_hide_zones
			zones.extend (a_zone)
		ensure
			extended: zones.has (a_zone)
		end

	prune_zone (a_zone: SD_ZONE) is
			-- Prune a zone which was managed by docking manager.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_container: EV_CONTAINER
		do
			l_container ?= a_zone
			check l_container /= Void end
			if l_container.parent /= Void then
				l_container.parent.prune (l_container)
			end

			zones.start
			zones.prune (a_zone)
			-- FIXIT: call prune_all from ACTIVE_LIST contract broken
--			zones.prune_all (a_zone)
			if a_zone.content.user_widget.parent /= Void then
				a_zone.content.user_widget.parent.prune (a_zone.content.user_widget)
			end
		ensure
			a_zone_pruned: not zones.has (a_zone)
		end

	prune_zone_by_content (a_content: SD_CONTENT) is
			-- Prune a zone which contain a_content.
		require
			has_content: has_content (a_content)
		local
			l_pruned: BOOLEAN
		do
			from
				zones.start
			until
				zones.after or l_pruned
			loop
				if zones.item.content = a_content then
					prune_zone (zones.item)
					l_pruned := True
				end
				if not l_pruned then
					zones.forth
				end
			end
		end

	set_zone_size (a_zone: SD_ZONE; a_width, a_height: INTEGER) is
			-- Set a zone size.
		require
			has_zone: has_zone (a_zone)
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_width, l_height: INTEGER
		do
			l_width := a_width
			l_height := a_height
			l_auto_hide_zone ?= a_zone
			if l_auto_hide_zone /= Void then
				if l_width < a_zone.minimum_width then
					l_width := a_zone.minimum_width
				end
				if l_height < a_zone.minimum_height then
					l_height := a_zone.minimum_height
				end
				fixed_area.set_item_size (l_auto_hide_zone, l_width, l_height)
			end
		ensure
			-- FIXIT: a_zone should inherit from EV_WIDGET
--			set: a_zone.width =
		end

	disable_all_zones_focus_color is
			-- Disable all zones focus color.
		do
			from
				zones.start
			until
				zones.after
			loop
				zones.item.on_focus_out
				zones.forth
			end
		end

feature {SD_MENU_HOT_ZONE, SD_FLOATING_MENU_ZONE, SD_CONTENT, SD_STATE,
	SD_DOCKER_MEDIATOR, SD_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, MAIN_WINDOW,
	 SD_MENU_DOCKER_MEDIATOR, SD_MENU_MANAGER, SD_AUTO_HIDE_PANEL, SD_MENU_ZONE,
	  SD_TAB_STUB} -- Library internals querys.

	auto_hide_panel (a_direction: INTEGER): SD_AUTO_HIDE_PANEL is
			-- Auto hide panel at `a_direction'.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			if a_direction = dock_bottom then
				Result := internal_auto_hide_panel_bottom
			elseif a_direction = dock_top then
				Result := internal_auto_hide_panel_top
			elseif a_direction = dock_left then
				Result := internal_auto_hide_panel_left
			elseif a_direction = dock_right then
				Result := internal_auto_hide_panel_right
			end
		ensure
			not_void: Result /= Void
		end

	content_by_title (a_title: STRING): SD_CONTENT is
			-- Content by `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			from
				contents.start
			until
				contents.after or Result /= Void
			loop
				if contents.item.unique_title.is_equal (a_title) then
					Result := contents.item
				end
				contents.forth
			end
		ensure
			not_void: Result /= Void
		end

	inner_container (a_zone: SD_ZONE): SD_MULTI_DOCK_AREA is
			-- SD_MULTI_DOCK_AREA which `a_zone' in.
		require
			a_zone_not_void: a_zone /= Void
		do
			from
				inner_containers.start
			until
				inner_containers.after or Result /= Void
			loop
				if inner_containers.item.has_recursive (a_zone) then
					Result := inner_containers.item
				end
				inner_containers.forth
			end
			if Result = Void then
				Result := inner_container_main
			end
		ensure
			not_void: Result /= Void
		end

	is_main_inner_container (a_area: SD_MULTI_DOCK_AREA): BOOLEAN is
			-- Contract support. If a_area is first one in `inner_containers'.
		require
			a_area_not_void: a_area /= Void
		do
			inner_containers.start
			Result := inner_containers.item = a_area
		end

	inner_container_main: SD_MULTI_DOCK_AREA is
			-- Container in main window.
		do
			inner_containers.start
			Result := inner_containers.item
		ensure
			not_void: Result /= Void
		end

	zone_max_screen_x (a_zone: SD_ZONE): INTEGER is
			-- Max screen x of a_zone.
		do
			Result := top_container.screen_x + top_container.width
		end

	container_rectangle: EV_RECTANGLE is
			-- Rectangle area of the `fixed_area'.
		do
			create Result.make (main_container.center_area.x_position, main_container.center_area.y_position + internal_auto_hide_panel_top.height, main_container.center_area.width, main_container.center_area.height)
		ensure
			not_void: Result /= Void
		end

	container_rectangle_screen: EV_RECTANGLE is
			-- Rectangle area of the `fixed_area' base on screen.
		do
			create Result.make (main_container.center_area.screen_x, main_container.center_area.screen_y, main_container.center_area.width, main_container.center_area.height)
		ensure
			not_void: Result /= Void
		end

	golbal_accelerators: SEQUENCE [EV_ACCELERATOR] is
			-- Golbal accelerators.
		local
			l_titled_window: EV_TITLED_WINDOW
		do
			l_titled_window ?= main_window
			if l_titled_window /= Void then
				Result := l_titled_window.accelerators
			end
		end

feature {SD_MENU_HOT_ZONE, SD_FLOATING_MENU_ZONE, SD_CONTENT, SD_STATE,
	SD_DOCKER_MEDIATOR, SD_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, MAIN_WINDOW,
	 SD_MENU_DOCKER_MEDIATOR, SD_MENU_MANAGER, SD_AUTO_HIDE_PANEL, SD_MENU_ZONE, SD_TAB_STUB} -- Library internals commands.

	resize is
			--
		do
			on_resize (internal_viewport.x_position, internal_viewport.y_position, internal_viewport.width, internal_viewport.height)
		end

	lock_update is
			-- Lock window update.
		do
			if (create {EV_ENVIRONMENT}).application.locked_window = Void then
				main_window.lock_update
			end
			lock_call_time := lock_call_time + 1
		end

	unlock_update is
			-- Unlock window update.
		do
			remove_empty_split_area
			update_title_bar
			lock_call_time := lock_call_time - 1
			if lock_call_time = 0 then
				main_window.unlock_update
			end
		end

	add_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			-- Add `a_area'.
		require
			a_area_not_void: a_area /= Void
		do
			inner_containers.extend (a_area)
		end

	prune_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			-- Prune `a_area'.
		require
			a_area_not_void: a_area /= Void
			a_area_not_first_one: not is_main_inner_container (a_area)
		do
			inner_containers.start
			inner_containers.prune (a_area)
		end

	remove_empty_split_area  is
			-- Remove empty split area in SD_MULTI_DOCK_AREA.
		do
			from
				inner_containers.start
			until
				inner_containers.after
			loop
				if inner_containers.item /= Void then
					inner_containers.item.remove_empty_split_area
				end
				inner_containers.forth
			end
		end

	remove_auto_hide_zones is
			-- Remove all auto hide zones in `zones'.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
		do
			from
				zones.start
			until
				zones.after
			loop
				l_auto_hide_zone ?= zones.item
				if l_auto_hide_zone /= Void then
					zones.prune (l_auto_hide_zone)
					l_auto_hide_zone.content.state.record_state
					fixed_area.prune (l_auto_hide_zone)
				end
				if not zones.after then
					zones.forth
				end
			end
		ensure
			no_auto_hide_zone_left: fixed_area.count = 1
		end

	recover_normal_state is
			-- Recover all zone's state to normal state.
		do
			from
				zones.start
			until
				zones.after
			loop
				zones.item.recover_to_normal_state
				zones.forth
			end
		end

	update_title_bar is
			-- Update all title bar.
		local
			l_inner_container_snapshot: like inner_containers
		do
			l_inner_container_snapshot := inner_containers.twin
			from
				l_inner_container_snapshot.start
			until
				l_inner_container_snapshot.after
			loop
				if l_inner_container_snapshot.item /= Void then
					l_inner_container_snapshot.item.update_title_bar
				end
					l_inner_container_snapshot.forth
			end
		end

feature {SD_MENU_HOT_ZONE, SD_FLOATING_MENU_ZONE, SD_CONTENT, SD_STATE, SD_DOCKER_MEDIATOR,
	 SD_CONFIG_MEDIATOR, SD_HOT_ZONE, SD_ZONE, MAIN_WINDOW, SD_MENU_DOCKER_MEDIATOR,
	 SD_MENU_MANAGER, SD_AUTO_HIDE_PANEL} -- Library internal attributes.

	main_window: EV_WINDOW
			-- Client programmer's window.

	fixed_area: EV_FIXED
			-- EV_FIXED for DOCKING_MANAGER manage widgets.

	top_container: EV_CONTAINER
			-- Topest level container. It contains EV_VIWEPORT which contains fixed_area.	

	menu_container: SD_MENU_CONTAINER
			-- Container for menus on four sides.

	inner_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			-- All containers.

	main_container: SD_MAIN_CONTAINER
			-- Container has four tab stub areas in four side and main area in center.

feature {NONE}  -- Agents

	on_widget_pointer_press (a_widget: EV_WIDGET; a_button, a_x, a_y: INTEGER) is
			-- Handle EV_APPLICATION's pointer button press actions.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_zones: ARRAYED_LIST [SD_ZONE]
		do

			l_zones := zones.twin
			from
				l_zones.start
			until
				l_zones.after
			loop
				if l_zones.item.has_recursive (a_widget) then
					if internal_shared.last_focus_content /= l_zones.item.content then
						internal_shared.set_last_focus_content (l_zones.item.content)
						l_zones.item.on_focus_in (Void)
						if l_zones.item.content.focus_in_actions /= Void then
							l_zones.item.content.focus_in_actions.call ([])
						end
					else
						l_auto_hide_zone ?= internal_shared.last_focus_content.state.zone
						if l_auto_hide_zone = Void then
							remove_auto_hide_zones
						end
					end
				end
				l_zones.forth
			end
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize zone event. Resize all the widgets in fixed_area (EV_FIXED).
		do
			debug ("larry")
				io.put_string ("%N SD_DOCKING_MANAGER on_resize ~~~~~~~~~~~~~~~~~~~~")
			end
			remove_auto_hide_zones
			menu_container.set_minimum_size (0, 0)
			fixed_area.set_minimum_size (0, 0)
			inner_container_main.set_minimum_size (0, 0)
			if a_width > 0 then
				internal_viewport.set_item_width (a_width)
				fixed_area.set_item_width (inner_container_main , fixed_area.width)
			end
			if a_height > 0 then
				internal_viewport.set_item_height (a_height)
				fixed_area.set_item_height (inner_container_main, fixed_area.height)
			end
		end

	on_added_zone (a_zone: SD_ZONE) is
			-- Handle inserted a zone event.
		do
		end

	on_pruned_zone (a_zone: SD_ZONE) is
			-- Handle pruned a zone event.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_floating_zone ?= a_zone
			if l_floating_zone /= Void then
				l_floating_zone.destroy
			end
		end

feature -- Enumeration

	Dock_top: INTEGER is 1
	Dock_bottom: INTEGER is 2
	Dock_left: INTEGER is 3
	Dock_right: INTEGER is 4

feature {NONE} -- Implementation

	internal_viewport: EV_VIEWPORT
			-- The viewport which contain `fixed_area'.

	internal_shared: SD_SHARED
			-- All singletons

	lock_call_time: INTEGER
			-- Used for remember how many times client call `lock_update'.

	internal_auto_hide_panel_left, internal_auto_hide_panel_right, internal_auto_hide_panel_top, internal_auto_hide_panel_bottom: SD_AUTO_HIDE_PANEL
			-- Auto hide panels

feature {MAIN_WINDOW} -- For debug.

	show_inner_container_structure is
			-- For debug.
		do
			io.put_string ("%N --------------------- SD_DOCKING_MANAGER inner container -------------------")
			inner_containers.start
			show_inner_container_structure_imp (inner_containers.item.item, " ")
		end

	show_inner_container_structure_imp (a_container: EV_WIDGET; a_indent: STRING) is
			-- For debug.
		local
			l_split_area: EV_SPLIT_AREA
			l_docking_zone: SD_DOCKING_ZONE
		do
			l_docking_zone ?= a_container
			if l_docking_zone /= Void then
				io.put_string ("%N " + a_indent + a_container.generating_type + " " + l_docking_zone.content.unique_title)
			else
				if a_container /= Void then
					io.put_string ("%N " + a_indent + a_container.generating_type)
				else
					io.put_string ("%N " + a_indent + "Void")
				end
			end
			l_split_area ?= a_container
			if l_split_area /= Void then
				show_inner_container_structure_imp (l_split_area.first, a_indent + " ")
				show_inner_container_structure_imp (l_split_area.second, a_indent + " ")
			end
		end

invariant

	internal_viewport_not_void: internal_viewport /= Void
	internal_fixed_not_void: fixed_area /= Void
	internal_main_container_not_void: main_container /= Void
	internal_inner_container_not_void: inner_containers /= Void and inner_containers.count >= 1
	internal_contents_not_void: contents /= Void
	zones_not_void: zones /= Void

end
