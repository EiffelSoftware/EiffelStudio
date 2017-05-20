note
	description: "SD_HOT_ZONE for SD_DOCKING_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_DOCKING

inherit
	SD_HOT_ZONE_CONTENT
		redefine
			set_rectangle,
			zone
		end

create
	make

feature -- Redefine

	apply_change  (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_caller: SD_ZONE
		do
			l_caller := internal_mediator.caller
			if internal_mediator.is_dockable then
				if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.top)
					Result := True
				elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.bottom)
					Result := True
				elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.left)
					Result := True
				elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (zone, {SD_ENUMERATION}.right)
					Result := True
				elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) or internal_rectangle_title_area.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.move_to_docking_zone (zone, False)
					Result := True
				end
			end
		end

feature -- Access

	zone: SD_DOCKING_ZONE
			-- <Precursor>

feature {NONE} -- Implementation functions

	set_rectangle (a_rect: like internal_rectangle)
			-- Set the rectangle which allow user to dock
		do
			Precursor (a_rect)
			internal_rectangle_title_area := zone.title_area
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
