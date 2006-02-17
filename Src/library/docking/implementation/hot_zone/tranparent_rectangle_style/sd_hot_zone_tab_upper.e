indexing
	description: "SD_HOT_ZONEs for SD_TAB_ZONE_UPPERs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TAB_UPPER

inherit
	SD_HOT_ZONE_TAB
		redefine
			update_feedback,
			apply_change
		end
create
	make

feature {NONE} -- Redefine

	update_feedback (a_screen_x, a_screen_y: INTEGER; a_rect: EV_RECTANGLE) is
			-- Redefine
		local
			l_shared: like internal_shared
			l_icons: SD_ICONS_SINGLETON
			l_rect: like internal_rectangle
			l_center_rect, l_top_rect: EV_RECTANGLE
		do
			l_rect := a_rect
			l_shared := internal_shared
			l_icons := l_shared.icons

			if a_rect = internal_rectangle_left then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.left, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_right then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle.right - (internal_rectangle.width * 0.5).ceiling, internal_rectangle.top, (internal_rectangle.width* 0.5).ceiling, internal_rectangle.height )
			elseif a_rect = internal_rectangle_top then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.top, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_bottom then
				internal_shared.feedback.draw_transparency_rectangle (internal_rectangle .left, internal_rectangle.bottom - (internal_rectangle.height * 0.5).ceiling, internal_rectangle.width, (internal_rectangle.height * 0.5).ceiling)
			elseif a_rect = internal_rectangle_center then
				create l_center_rect.make (internal_rectangle.left, internal_rectangle.top + internal_shared.title_bar_height, internal_rectangle.width, internal_rectangle.height - internal_shared.title_bar_height)
				create l_top_rect.make (internal_rectangle.left + internal_shared.title_bar_height, internal_rectangle.top, internal_shared.title_bar_height * 3, internal_shared.title_bar_height)
				internal_shared.feedback.draw_transparency_rectangle_for_tab (l_top_rect, l_center_rect)
			end
		end

	apply_change (a_screen_x: INTEGER; a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		local
			l_caller: SD_ZONE
		do
			l_caller := internal_mediator.caller
			if internal_mediator.is_dockable then
				if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_top)
					Result := True
				elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_bottom)
					Result := True
				elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_left)
					Result := True
				elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.change_zone_split_area (internal_zone, {SD_DOCKING_MANAGER}.dock_right)
					Result := True
				elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) then
					l_caller.state.move_to_tab_zone (internal_zone, internal_zone.contents.count + 1)
					Result := True
				else
					from
						internal_tab_area.start
					until
						internal_tab_area.after or Result
					loop
						if internal_tab_area.item_for_iteration.has_x_y (a_screen_x, a_screen_y) then
							Result := True
							debug ("docking")
								print ("%NSD_HOT_ZONE_TAB apply_change move_to_tab_zone index is " + internal_tab_area.key_for_iteration.out)
							end
							l_caller.state.move_to_tab_zone (internal_zone, internal_tab_area.key_for_iteration)
						end
						internal_tab_area.forth
					end
				end
			end
		end

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
