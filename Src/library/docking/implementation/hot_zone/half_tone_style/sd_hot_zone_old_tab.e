indexing
	description: "SD_HOT_ZONE for SD_TAB_ZONE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_TAB

inherit
	SD_HOT_ZONE_OLD_DOCKING
		rename
			make as make_docking
		redefine
			apply_change
		end
create
	make

feature {NONE}  -- Initlization

	make (a_tab_zone: SD_TAB_ZONE) is
			-- Creation method
		require
			not_void: a_tab_zone /= Void
		do
			create internal_shared
			internal_zone := a_tab_zone
			set_rectangle (create {EV_RECTANGLE}.make (a_tab_zone.screen_x, a_tab_zone.screen_y, a_tab_zone.width, a_tab_zone.height))
		ensure
			set: internal_zone = a_tab_zone
		end

feature -- Redefine

	apply_change  (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Redefine.
		local
			l_tab_zone: SD_TAB_ZONE
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
				l_tab_zone ?= internal_zone
				check must_be_tab_zone: l_tab_zone /= Void end
				caller.state.move_to_tab_zone (l_tab_zone, 0)
				Result := True
			end
			internal_shared.feedback.reset_feedback_clearing
		end

end
