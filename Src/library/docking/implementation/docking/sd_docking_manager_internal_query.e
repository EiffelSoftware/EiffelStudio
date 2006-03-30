indexing
	description: "Docking manager queries."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_QUERY

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Querys

	auto_hide_panel (a_direction: INTEGER): SD_AUTO_HIDE_PANEL is
			-- Auto hide panel at `a_direction'.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			if a_direction = {SD_DOCKING_MANAGER}.dock_bottom then
				Result := internal_docking_manager.internal_auto_hide_panel_bottom
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_top then
				Result := internal_docking_manager.internal_auto_hide_panel_top
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_left then
				Result := internal_docking_manager.internal_auto_hide_panel_left
			elseif a_direction = {SD_DOCKING_MANAGER}.dock_right then
				Result := internal_docking_manager.internal_auto_hide_panel_right
			end
		ensure
			not_void: Result /= Void
		end

	content_by_title (a_unique_title: STRING): SD_CONTENT is
			-- Content by a_title.
		require
			a_title_not_void: a_unique_title /= Void
		do
			Result := content_by_title_for_restore (a_unique_title)
		ensure
			not_void: Result /= Void
		end

	content_by_title_for_restore (a_unique_title: STRING): SD_CONTENT is
			-- Content by a_unique_title. Result = Void if not found.
		require
			a_unique_title_not_void: a_unique_title /= Void
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_contents := internal_docking_manager.contents
				l_contents.start
			until
				l_contents.after or Result /= Void
			loop
				if l_contents.item.unique_title.is_equal (a_unique_title) then
					Result := l_contents.item
				end
				l_contents.forth
			end
		end

	inner_container (a_zone: EV_WIDGET): SD_MULTI_DOCK_AREA is
			-- SD_MULTI_DOCK_AREA which `a_zone' in.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_contaienrs: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			from
				l_contaienrs := internal_docking_manager.inner_containers
				l_contaienrs.start
			until
				l_contaienrs.after or Result /= Void
			loop
				if l_contaienrs.item.has_recursive (a_zone) then
					Result := l_contaienrs.item
				end
				l_contaienrs.forth
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
		local
			l_areas: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			l_areas := internal_docking_manager.inner_containers
			l_areas.start
			Result := l_areas.item = a_area
		end

	inner_container_main: SD_MULTI_DOCK_AREA is
			-- Container in main window.
		local
			l_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			l_containers := internal_docking_manager.inner_containers
			l_containers.start
			Result := l_containers.item
		ensure
			not_void: Result /= Void
		end

	zone_max_screen_x (a_zone: SD_ZONE): INTEGER is
			-- Max screen x of a_zone.
		local
			l_container: EV_WIDGET
		do
			l_container := internal_docking_manager.top_container
			Result := l_container.screen_x + l_container.width
		end

	container_rectangle: EV_RECTANGLE is
			-- Rectangle area of `center_area'
		local
			l_center_area: EV_WIDGET
		do
			l_center_area := internal_docking_manager.main_container.center_area
			create Result.make (l_center_area.x_position, l_center_area.y_position +
				internal_docking_manager.internal_auto_hide_panel_top.height, l_center_area.width, l_center_area.height)
		ensure
			not_void: Result /= Void
		end

	fixed_area_rectangle: EV_RECTANGLE is
			-- Rectangle area of `fixed_area'
		local
			l_widget: EV_WIDGET
		do
			l_widget := internal_docking_manager.fixed_area
			create Result.make (l_widget.x_position, l_widget.y_position, l_widget.width, l_widget.height)
		end

	container_rectangle_screen: EV_RECTANGLE is
			-- Rectangle area of the `fixed_area' base on screen.
		local
			l_center_area: EV_WIDGET
		do
			l_center_area := internal_docking_manager.main_container.center_area
			create Result.make (l_center_area.screen_x, l_center_area.screen_y, l_center_area.width, l_center_area.height)
		ensure
			not_void: Result /= Void
		end

	golbal_accelerators: SEQUENCE [EV_ACCELERATOR] is
			-- Golbal accelerators.
		local
			l_titled_window: EV_TITLED_WINDOW
		do
			l_titled_window ?= internal_docking_manager.main_window
			if l_titled_window /= Void then
				Result := l_titled_window.accelerators
			end
		end

	find_window_by_zone (a_zone: EV_WIDGET): EV_WINDOW is
			-- Find a window which can lock_update.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_main_container: SD_MULTI_DOCK_AREA
		do
			l_main_container := internal_docking_manager.query.inner_container (a_zone)
			if l_main_container.parent_floating_zone = Void then
				Result := internal_docking_manager.main_window
			else
				Result := l_main_container.parent_floating_zone
			end
		ensure
			not_void: Result /= Void
		end

	is_zone_in_same_window (a_zone_one, a_zone_two: SD_ZONE): BOOLEAN is
			-- If a_zone_one and a_zone_two in same window?
		do
			Result := find_window_by_zone (a_zone_one) = find_window_by_zone (a_zone_two)
		end

	floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE] is
			-- All floating zones in Current system.
		local
			l_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_containers := internal_docking_manager.inner_containers
			create Result.make (l_containers.count - 1)
			from
				l_containers.start
			until
				l_containers.after
			loop
				if l_containers.item.parent /= Void then
					l_floating_zone ?= l_containers.item.parent.parent
					if l_floating_zone /= Void then
						Result.extend (l_floating_zone)
					end
				end
				l_containers.forth
			end
			check count_right: l_containers.count - 1 = Result.count end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implemnetation

	internal_docking_manager: SD_DOCKING_MANAGER;
			-- Docking manager which Current belong to.

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
