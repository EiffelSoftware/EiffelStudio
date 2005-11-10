indexing
	description: "Objects with response for communicate between client programmer and the library. A mediator."
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
			internal_window := a_window

			create internal_viewport
			internal_viewport.resize_actions.extend (agent handle_resize)

			top_container.extend (internal_viewport)

			create menu_container
			internal_viewport.extend (menu_container)

			create internal_fixed
			menu_container.center.extend (internal_fixed)


			create internal_main_container
			internal_fixed.extend (internal_main_container)
			-- Insert auto hide panels.
			create internal_auto_hide_panel_left.make (True)
			create internal_auto_hide_panel_right.make (True)
			create internal_auto_hide_panel_top.make (False)
			create internal_auto_hide_panel_bottom.make (False)
			internal_main_container.left_bar.extend (internal_auto_hide_panel_left)
			internal_main_container.right_bar.extend (internal_auto_hide_panel_right)
			internal_main_container.top_bar.extend (internal_auto_hide_panel_top)
			internal_main_container.bottom_bar.extend (internal_auto_hide_panel_bottom)

			create internal_contents.make (1)
			create internal_zones

			internal_zones.add_actions.extend (agent handle_inserted_zone)
			internal_zones.remove_actions.extend (agent handle_pruned_zone)

			internal_shared.set_docking_manager (Current)

			-- Insert inner contianer
			create l_inner_container.make
			internal_main_container.center_area.extend (l_inner_container)
			create internal_inner_containers.make (1)
			internal_inner_containers.extend (l_inner_container)
			l_inner_container.set_background_color ((create {EV_STOCK_COLORS}).black)


--			internal_shared.set_hot_zone_factory (create {SD_HOT_ZONE_QUICK_FACTORY})
			internal_shared.set_hot_zone_factory (create {SD_HOT_ZONE_TRIANGLE_FACTORY})

			create menu_manager.make

			create l_app
			l_app.application.pointer_button_release_actions.extend (agent set_zone_focus_internal)
		ensure
			a_container_filled: a_container.has (internal_viewport)
		end

--FIXIT:	make_with_container_and_factory is

--FIXIT: add a mapper class to select factorys. HASH_TABLE

	set_feedback_style (a_style: INTEGER) is
			--
		do

		end

	set_zone_focus_internal (a_widget: EV_WIDGET; a_button, a_x, a_y: INTEGER) is
			--
		local
			l_container: EV_CONTAINER
		do
			from

				internal_zones.start
			until
				internal_zones.after
			loop
				l_container ?= internal_zones.item
				check l_container /= Void end
				if l_container.has_recursive (a_widget) then
					if internal_last_focus_zone /= internal_zones.item then
						internal_last_focus_zone := internal_zones.item
						internal_zones.item.on_focus_in

					end
				end

				if not internal_zones.after then -- FIXIT: Why should check? ACTIVE LIST's bug?
					internal_zones.forth
				end
			end
		end

feature -- Properties

	remove_empty_split_area  is
		-- Remove emplt split area in SD_MULTI_DOCK_AREA.
		do
		-- FIXIT: should get a SD_MULTI_DOCK_AREA base on SD_ZONE.
			from
				internal_inner_containers.start
			until
				internal_inner_containers.after
			loop
				if internal_inner_containers.item /= Void then
					internal_inner_containers.item.remove_empty_split_area
				end
				internal_inner_containers.forth
			end
		end

	contents: like internal_contents is
			-- Get client programmmer's contents
		do
			Result := internal_contents
		end

	has_content (a_content: SD_CONTENT): BOOLEAN is
			-- If internal_contents has a_content?
		do
			Result := internal_contents.has (a_content)
		end



feature {SD_FLOATING_ZONE, SD_FLOATING_MENU_ZONE, SD_MENU_ZONE}
	main_window: EV_WINDOW is
			--
		do
			Result := internal_window
		end



feature {SD_CONFIG}

	content_by_title (a_title: STRING): SD_CONTENT is
			-- Content by `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			from
				internal_contents.start
			until
				internal_contents.after or Result /= Void
			loop
				if internal_contents.item.title.is_equal (a_title) then
					Result := internal_contents.item
				end
				internal_contents.forth
			end
		ensure
			not_void: Result /= Void
		end

feature {SD_STATE, SD_CONFIG, SD_HOT_ZONE, SD_ZONE}

	lock_update is
			--
		do
			if (create {EV_ENVIRONMENT}).application.locked_window = Void then
				internal_window.lock_update
			end
			lock_call_time := lock_call_time + 1

		end

	unlock_update is
			--
		do
			lock_call_time := lock_call_time - 1
			if lock_call_time = 0 then
				internal_window.unlock_update
--				remove_empty_split_area
			end
		end

	lock_call_time: INTEGER
			-- Used for remember how many times client call `lock_update'.

feature {SD_STATE, SD_DOCKER_MEDIATOR, SD_CONFIG} -- Properties

	zones: like internal_zones is
			-- Get all the SD_ZONEs.
		do
			Result := internal_zones
		end

	zone_by_content (a_content: SD_CONTENT): SD_ZONE is
			-- If main container has zone with a_content?
		do
			from
				internal_zones.start
			until
				internal_zones.after or
				Result /= Void
			loop
				if internal_zones.item.content = a_content then
					Result := internal_zones.item
				end
				internal_zones.forth
			end
		end



	auto_hide_panel (a_direction: INTEGER): SD_AUTO_HIDE_PANEL is
			--
		require
			a_direction_valid:
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

	auto_hide_panel_left: like internal_auto_hide_panel_left is
			-- Get auto hide panel at left.
		do
			Result := internal_auto_hide_panel_left
		end

	auto_hide_panel_right: like internal_auto_hide_panel_right is
			-- Get auto hide panel at right.
		do
			Result := internal_auto_hide_panel_right
		end

	auto_hide_panel_top: like internal_auto_hide_panel_top is
			-- Get auto hide panel at top.
		do
			Result := internal_auto_hide_panel_top
		end

	auto_hide_panel_bottom: like internal_auto_hide_panel_bottom is
			-- Get auto hide panel at bottom.
		do
			Result := internal_auto_hide_panel_bottom
		end

feature {SD_HOT_ZONE, SD_STATE, SD_DOCKER_MEDIATOR, SD_CONFIG, SD_CONTENT}

	inner_container (a_zone: SD_ZONE): SD_MULTI_DOCK_AREA is
			-- The split area which is at topmost area.
		require
			a_zone_not_void: a_zone /= Void
		do
			from
				internal_inner_containers.start
			until
				internal_inner_containers.after or Result /= Void
			loop
				if internal_inner_containers.item.has_zone (a_zone) then
					Result := internal_inner_containers.item
				end
				internal_inner_containers.forth
			end
		ensure
			not_void: Result /= Void
		end
feature {SD_STATE}

	add_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			--
		require
			a_area_not_void: a_area /= Void
		do
			internal_inner_containers.extend (a_area)
		end

	prune_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			--
		require
			a_area_not_void: a_area /= Void
			a_area_not_first_one: not container_first_one (a_area)
		do
			internal_inner_containers.start
			internal_inner_containers.prune (a_area)
		end

	container_first_one (a_area: SD_MULTI_DOCK_AREA): BOOLEAN is
			-- Contract support.
		require
			a_area_not_void: a_area /= Void
		do
			internal_inner_containers.start
			Result := internal_inner_containers.item = a_area
		end

feature {SD_CONTENT, SD_STATE, SD_DOCKER_MEDIATOR, SD_CONFIG, SD_HOT_ZONE}

	inner_container_main: SD_MULTI_DOCK_AREA is
			-- The center main container.
		do
			internal_inner_containers.start
			Result := internal_inner_containers.item
		ensure
			not_void: Result /= Void
		end


feature {SD_STATE, SD_ZONE, SD_HOT_ZONE} -- Command

	add_zone (a_zone: SD_ZONE) is
			-- Add a zone to show.

		do
			remove_auto_hide_zones
			internal_zones.extend (a_zone)
		end

	prune_zone (a_zone: SD_ZONE) is
			-- Prune a zone which was managed by docking manager.
		require
			a_zone_not_void: a_zone /= Void
			a_zone_widget_parent_not_void: a_zone.content.user_widget.parent /= Void
			a_zone_parent_not_void: not zone_parent_void (a_zone)
		local
			l_container: EV_CONTAINER
		do
			l_container ?= a_zone
			check l_container /= Void end
			if l_container.parent /= Void then
				l_container.parent.prune (l_container)
			end

			internal_zones.start
			internal_zones.prune (a_zone)
			-- FIXIT: call prune_all from ACTIVE_LIST contract broken
--			internal_zones.prune_all (a_zone)
--			if a_zone.content.user_widget.parent /= Void then
				a_zone.content.user_widget.parent.prune (a_zone.content.user_widget)
--			end

		ensure
			a_zone_pruned: not internal_zones.has (a_zone)
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

	prune_zone_by_content (a_content: SD_CONTENT) is
			-- Prune a zone which contain a_content.
		local
			l_pruned: BOOLEAN
		do
			from
				internal_zones.start
			until
				internal_zones.after or l_pruned
			loop
				if internal_zones.item.content = a_content then
					prune_zone (internal_zones.item)
					l_pruned := True
				end
				if not l_pruned then
					internal_zones.forth
				end
--				-- Then clear user widget's parent.
--				if a_content.user_widget.parent /= Void then
--					a_content.user_widget.parent.prune (a_content.user_widget)					
--				end
			end
		end

	set_zone_size (a_zone: SD_ZONE; a_width, a_height: INTEGER) is
			-- Set a zone size.
		require
			has_zone: has_zone (a_zone)
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
		do
			l_auto_hide_zone ?= a_zone
			if l_auto_hide_zone /= Void then
				internal_fixed.set_item_size (l_auto_hide_zone, a_width, a_height)
			else -- It must be some zone in the inner container(the table).
--				debug ("larry")
--					io.put_string ("%N orignal zone's minimum width is: " + a_zone.minimum_width.out)
--				end
--				a_zone.set_minimum_size (a_width, a_height)
--				debug ("larry")
--					io.put_string ("%N new     zone's minimum width is: " + a_zone.minimum_width.out)
--				end
			end
		end

	disable_all_zones_focus_color is
			--
		do
			from
				internal_zones.start
			until
				internal_zones.after
			loop
				internal_zones.item.handle_zone_focus_out
				internal_zones.forth
			end
		end

feature {SD_STATE, SD_ZONE, SD_HOT_ZONE} -- State report

	has_zone (a_zone: SD_ZONE): BOOLEAN is
			-- If the main container has zone?
		do
			Result := internal_zones.has (a_zone)
		end

--	has_zone_inner (a_zone: SD_ZONE): BOOLEAN is
--			-- If the inner container in the main container has zone?
--		do
--			Result := internal_inner_container.has (a_zone)
--		end

	has_zone_by_content (a_content: SD_CONTENT): BOOLEAN is
			-- If the main container has zone with a_content?
		do
			from
				internal_zones.start
			until
				internal_zones.after or
				Result
			loop
				Result := internal_zones.item.content = a_content
				internal_zones.forth
			end
		end

	zone_max_screen_x (a_zone: SD_ZONE): INTEGER is
			-- The max screen x of a_zone.
		require
--			has_zone: has_zone (a_zone)
		do
			Result := top_container.screen_x + top_container.width
		end



	container_rectangle: EV_RECTANGLE is
			-- The rectangle area of the `internal_fixed'.
		do
			create Result.make (internal_main_container.center_area.x_position, internal_main_container.center_area.y_position + auto_hide_panel_top.height, internal_main_container.center_area.width, internal_main_container.center_area.height)
		end

	container_rectangle_screen: EV_RECTANGLE is
			-- The rectangle area of the `internal_fixed' base on screen.
		do
			create Result.make (internal_main_container.center_area.screen_x, internal_main_container.center_area.screen_y, internal_main_container.center_area.width, internal_main_container.center_area.height)
		end

feature {SD_AUTO_HIDE_STATE, SD_ZONE, MAIN_WINDOW, SD_CONFIG} -- Zone operation

	remove_auto_hide_zones is
			-- Remove all auto hide zones in the `internal_zones'.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
		do
			from
				internal_zones.start
			until
				internal_zones.after
			loop
				-- When show a auto hide zone, first remove other auto hide zone already in the interal container.
				l_auto_hide_zone ?= internal_zones.item
				if l_auto_hide_zone /= Void then
					internal_zones.prune (l_auto_hide_zone)
					l_auto_hide_zone.content.state.close_window
					internal_fixed.prune (l_auto_hide_zone)
				end
				if not internal_zones.after then
					internal_zones.forth
				end
			end
		end

feature {NONE}

	handle_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize zone event. Resize all the widgets in internal_fixed (EV_FIXED).
		do
			remove_auto_hide_zones
			menu_container.set_minimum_size (0, 0)
			internal_main_container.set_minimum_size (0, 0)
			internal_fixed.set_minimum_size (0, 0)
			if a_width > 0 then
--				if a_width > menu_container.minimum_width then


--				end
					internal_viewport.set_item_width (a_width)
--				if internal_fixed.width > internal_main_container.minimum_width then
					internal_fixed.set_item_width (internal_main_container, internal_fixed.width)
--				end
			end

			if a_height > 0 then
--				if a_height > menu_container .minimum_height then
					internal_viewport.set_item_height (a_height)
--				end
--				if internal_fixed.height > internal_main_container.minimum_height then
					internal_fixed.set_item_height (internal_main_container, internal_fixed.height)
--				end
			end
		end

	handle_inserted_zone (a_zone: SD_ZONE) is
			-- Handle inserted a zone event.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
		do

			l_auto_hide_zone ?= a_zone
			-- If this is a zone auto hide
		end

	handle_pruned_zone (a_zone: SD_ZONE) is
			-- Handle pruned a zone event.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_floating_zone: SD_FLOATING_ZONE
		do
			a_zone.destroy_focus_in
			l_floating_zone ?= a_zone
			if l_floating_zone /= Void then
				l_floating_zone.destroy
			end
		ensure

		end

feature -- Save or Resotre config

	save_config (a_file: STRING) is
			-- Save current docking config.
		require
			a_file_not_void: a_file /= Void
		local
			l_config: SD_CONFIG
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
			l_config: SD_CONFIG
		do
			create l_config.make
			l_config.open_config (a_file)
		end

	file_exist (a_file_name: STRING): BOOLEAN is
			-- If `a_file_name' exist?
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_read (a_file_name)
			Result := l_file.exists
		end
feature -- Enumeration

	Dock_top: INTEGER is 1
	Dock_bottom: INTEGER is 2
	Dock_left: INTEGER is 3
	Dock_right: INTEGER is 4
--	Dock_in: INTEGER is 5

feature {SD_AUTO_HIDE_STATE, SD_AUTO_HIDE_ZONE, MAIN_WINDOW} --Implementation

	internal_fixed: SD_FIXED
			-- The internal_fixed for DOCKING_MANAGER manage widgets.

feature {SD_MENU_DOCKER_MEDIATOR, MAIN_WINDOW}
	top_container: EV_CONTAINER
			-- The topest level container. It contains EV_VIWEPORT which contains internal_fixed.	

feature {SD_MENU_DOCKER_MEDIATOR, SD_MENU_MANAGER, MAIN_WINDOW}
	menu_container: SD_MENU_CONTAINER
			-- Container for menus on four sides.	

feature {NONE} -- Implementation

	internal_viewport: EV_VIEWPORT
			-- The viewport which contain `internal_fixed'.

	internal_contents: SD_ARRAYED_LIST [SD_CONTENT]
			-- The client programmer's internal_contents.

	internal_shared: SD_SHARED
			-- All singletons

	internal_window: EV_WINDOW
			-- Client programmer's window.

	internal_last_focus_zone: SD_ZONE
			-- Last focused zone.
feature

	menu_manager: SD_MENU_MANAGER
			-- Manager control all menus.

feature {SD_CONFIG, SD_AUTO_HIDE_PANEL}

	internal_main_container: SD_MAIN_CONTAINER
			-- 		

feature {SD_CONFIG, SD_FLOATING_ZONE}

	internal_zones: ACTIVE_LIST [SD_ZONE]
			-- All the SD_ZONE in current system.

	internal_inner_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			-- All contaiers.

	internal_auto_hide_panel_left, internal_auto_hide_panel_right, internal_auto_hide_panel_top, internal_auto_hide_panel_bottom: SD_AUTO_HIDE_PANEL
			-- Auto hide panels

feature {MAIN_WINDOW} -- For debug.

	show_inner_container_structure is
			-- For debug.
		local
--			l_main_inner: SD_MULTI_DOCK_AREA
		do
			io.put_string ("%N --------------------- SD_DOCKING_MANAGER inner container -------------------")
			internal_inner_containers.start
			show_inner_container_structure_imp (internal_inner_containers.item.item, " ")
		end

	show_inner_container_structure_imp (a_container: EV_WIDGET; a_indent: STRING) is
			--
		local
			l_split_area: EV_SPLIT_AREA
			l_docking_zone: SD_DOCKING_ZONE
		do
			l_docking_zone ?= a_container
			if l_docking_zone /= Void then
				io.put_string ("%N " + a_indent + a_container.generating_type + " " + l_docking_zone.content.title)
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
	internal_fixed_not_void: internal_fixed /= Void
	internal_main_container_not_void: internal_main_container /= Void
	internal_inner_container_not_void: internal_inner_containers /= Void and internal_inner_containers.count >= 1

	internal_contents_not_void: internal_contents /= Void
	internal_zones_not_void: internal_zones /= Void
end
