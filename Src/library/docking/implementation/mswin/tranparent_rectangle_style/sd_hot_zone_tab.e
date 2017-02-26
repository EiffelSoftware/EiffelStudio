note
	description: "SD_HOT_ZONEs for SD_TAB_ZONEs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TAB

inherit
	SD_HOT_ZONE_CONTENT
		redefine
			set_rectangle,
			update_for_feedback,
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
					l_caller.state.move_to_tab_zone (zone, zone.contents.count + 1)
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
							l_caller.state.move_to_tab_zone (zone, internal_tab_area.key_for_iteration)
						end
						internal_tab_area.forth
					end
				end
			end
		end

	update_for_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN
			-- <Precursor>
		local
			l_item: EV_RECTANGLE
		do
			if a_dockable then
				from
					internal_tab_area.start
				until
					internal_tab_area.after or Result
				loop
					l_item := internal_tab_area.item_for_iteration
					if l_item.has_x_y (a_screen_x, a_screen_y) then
						Result := True
						internal_shared.feedback.draw_transparency_rectangle (l_item.x, l_item.y, l_item.width, l_item.height)
					end
					internal_tab_area.forth
				end
				if not Result then
					Result := Precursor (a_screen_x, a_screen_y, a_dockable)
				end
			end
		end

feature -- Access

	zone: SD_TAB_ZONE
			-- <Precursor>

feature {NONE} -- Implementation

	set_rectangle (a_rect: EV_RECTANGLE)
			-- <Precursor>
		local
			l_tabs: HASH_TABLE [SD_NOTEBOOK_TAB, INTEGER]
			l_rect: EV_RECTANGLE
			l_tab_behind_last: EV_RECTANGLE
			l_last_key_for_iteration: INTEGER
			l_tab_zone: like zone
		do
			create internal_tab_area.make (1)
			l_tab_zone := zone
			l_tabs := l_tab_zone.tabs_shown
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				create l_rect.make (l_tabs.item_for_iteration.screen_x, l_tabs.item_for_iteration.screen_y, l_tabs.item_for_iteration.width, l_tabs.item_for_iteration.height)
				internal_tab_area.extend (l_rect, l_tabs.key_for_iteration)
				l_tabs.forth
			end
			if not attached l_rect then
				create l_rect
			end
			create l_tab_behind_last.make (l_rect.right + 1, l_rect.top, internal_shared.feedback_tab_width, l_rect.height)
			from
				internal_tab_area.start
			until
				internal_tab_area.after
			loop
				l_last_key_for_iteration := internal_tab_area.key_for_iteration
				internal_tab_area.forth
			end
			internal_tab_area.extend (l_tab_behind_last, l_last_key_for_iteration + 1)
			Precursor (a_rect)
			internal_rectangle_title_area := l_tab_zone.title_area
		end

	internal_tab_area: HASH_TABLE [EV_RECTANGLE, INTEGER];
			-- Tab area's rectangle

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
