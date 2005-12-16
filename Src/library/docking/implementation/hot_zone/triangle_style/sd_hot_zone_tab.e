indexing
	description: "SD_HOT_ZONEs for SD_TAB_ZONEs."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TAB

inherit
	SD_HOT_ZONE_DOCKING
		rename
			make as make_docking,
			internal_zone as internal_zone_docking
		redefine
			apply_change
		end

create
	make

feature {NONE} -- Initlization

	make (a_zone: SD_TAB_ZONE; a_rect: EV_RECTANGLE; a_docker_mediator: SD_DOCKER_MEDIATOR) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
			a_rect_not_void: a_rect /= Void
			a_docker_mediator_not_void: a_docker_mediator /= Void
		do
			create internal_shared
			internal_docker_mediator := a_docker_mediator
			internal_zone := a_zone
			set_rectangle (a_rect)
		ensure
			set: internal_docker_mediator =  a_docker_mediator
		end

feature -- Redefine

	apply_change  (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Redefine.
		do
			if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_top)
				Result := True
			elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_bottom)
				Result := True
			elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_left)
				Result := True
			elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
				caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_right)
				Result := True
			elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
				caller.state.move_to_tab_zone (internal_zone)
				Result := True
			end
		end

feature {NONE} -- Implementation

	internal_zone: SD_TAB_ZONE
			-- Caller.

invariant

	internal_zone_not_void: internal_zone /= Void

end
