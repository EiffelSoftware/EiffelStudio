note
	description: "SD_HOT_ZONEs for SD_TAB_ZONEs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TAB

inherit
	SD_HOT_ZONE_DOCKING
		rename
			make as make_docking
		redefine
			apply_change,
			set_rectangle,
			update_for_feedback,
			zone_type_valid
		end

create
	make

feature {NONE} -- Initlization

	make (a_zone: SD_TAB_ZONE; a_rect: EV_RECTANGLE; a_docker_mediator: SD_DOCKER_MEDIATOR)
			-- Creation method
		require
			a_zone_not_void: a_zone /= Void
			a_rect_not_void: a_rect /= Void
			a_docker_mediator_not_void: a_docker_mediator /= Void
		do
			create internal_shared
			internal_mediator := a_docker_mediator
			internal_zone := a_zone
			set_rectangle (a_rect)
			create internal_indicator.make (internal_shared.icons.arrow_indicator_center, internal_shared.feedback.feedback_rect)
			internal_indicator.set_position (internal_rectangle_left.left, internal_rectangle_top.top)

			internal_indicator.show
		ensure
			set: internal_mediator =  a_docker_mediator
		end

feature -- Redefine

	apply_change  (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_caller: SD_ZONE
			l_tab_zone: like tab_zone_of
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
					l_tab_zone := tab_zone_of (zone)
					check l_tab_zone /= Void end -- Implied by curernt is hot zone of tab zone					
					l_caller.state.move_to_tab_zone (l_tab_zone, l_tab_zone.contents.count + 1)
					Result := True
				else
					from
						l_tab_zone := tab_zone_of (zone)
						check l_tab_zone /= Void end -- Implied by curernt is hot zone of tab zone						
						internal_tab_area.start
					until
						internal_tab_area.after or Result
					loop
						if internal_tab_area.item_for_iteration.has_x_y (a_screen_x, a_screen_y) then
							Result := True
							debug ("docking")
								print ("%NSD_HOT_ZONE_TAB apply_change move_to_tab_zone index is " + internal_tab_area.key_for_iteration.out)
							end
							l_caller.state.move_to_tab_zone (l_tab_zone, internal_tab_area.key_for_iteration)
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
					Result := Precursor {SD_HOT_ZONE_DOCKING} (a_screen_x, a_screen_y, a_dockable)
				end
			end
		end

feature -- Query

	tab_zone_of (a_zone: SD_ZONE): detachable SD_TAB_ZONE
			-- Type convertion
		require
			not_void: a_zone /= Void
		do
			Result ?= a_zone
		end

	zone_type_valid (a_zone: SD_ZONE): BOOLEAN
			-- <Precursor>
		do
			Result := tab_zone_of (a_zone) /= Void
		end

feature {NONE} -- Implementation

	set_rectangle (a_rect: EV_RECTANGLE)
			-- <Precursor>
		local
			l_tabs: HASH_TABLE [SD_NOTEBOOK_TAB, INTEGER]
			l_rect: detachable EV_RECTANGLE
			l_tab_behind_last: EV_RECTANGLE
			l_tab_zone: like tab_zone_of
			l_last_key_for_iteration: INTEGER
		do
			l_tab_zone := tab_zone_of (zone)
			check l_tab_zone /= Void end -- Implied by current is hot zone of tab zone
			l_tabs := l_tab_zone.tabs_shown
			create internal_tab_area.make (1)
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				create l_rect.make (l_tabs.item_for_iteration.screen_x, l_tabs.item_for_iteration.screen_y, l_tabs.item_for_iteration.width, l_tabs.item_for_iteration.height)
				internal_tab_area.extend (l_rect, l_tabs.key_for_iteration)
				l_tabs.forth
			end
			check l_rect /= Void end -- Implied by tab zone at least has one tab
			create l_tab_behind_last.make (l_rect.right + 1, l_rect.top, internal_shared.feedback_tab_width, l_rect.height)
			from
			until
				internal_tab_area.after
			loop
				l_last_key_for_iteration := internal_tab_area.key_for_iteration
				internal_tab_area.forth
			end
			internal_tab_area.extend (l_tab_behind_last, l_last_key_for_iteration + 1)

			internal_rectangle := a_rect
			create internal_rectangle_left.make (internal_rectangle.left + internal_rectangle.width // 2 - pixmap_center_width // 2 - pixmap_corner_width, internal_rectangle.top + internal_rectangle.height // 2 - pixmap_corner_width // 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_right.make (internal_rectangle_left.left + pixmap_corner_width + pixmap_center_width - 1, internal_rectangle_left.top, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_top.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top - pixmap_corner_width + 1, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_bottom.make (internal_rectangle_left.left + pixmap_corner_width - 2, internal_rectangle_left.top + pixmap_corner_width - 2, pixmap_corner_width, pixmap_corner_width)
			create internal_rectangle_center.make (internal_rectangle_left.right, internal_rectangle_top.bottom, internal_rectangle_right.left - internal_rectangle_left.right, internal_rectangle_bottom.top - internal_rectangle_top.bottom)

			-- It's not a square, we should adjust it.
			internal_rectangle_top.grow_bottom (-6)
			internal_rectangle_center.set_y (internal_rectangle_center.top - 6)
			internal_rectangle_center.grow_bottom (-3)
			internal_rectangle_bottom.set_y (internal_rectangle_bottom.top - 9)
			internal_rectangle_bottom.grow_bottom (-10)
			internal_rectangle_right.grow_right (-2)

			internal_rectangle_title_area := l_tab_zone.title_area
		end

	internal_tab_area: HASH_TABLE [EV_RECTANGLE, INTEGER];
			-- Tab area's rectangle

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
