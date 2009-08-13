note
	description: "SD_HOT_ZONE for SD_TAB_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_TAB

inherit
	SD_HOT_ZONE_OLD_DOCKING
		rename
			make as make_docking
		redefine
			apply_change,
			set_rectangle,
			update_for_feedback
		end
create
	make

feature {NONE}  -- Initlization

	make (a_tab_zone: SD_TAB_ZONE; a_docker_mediator: SD_DOCKER_MEDIATOR)
			-- Creation method
		require
			not_void: a_tab_zone /= Void
		do
			create internal_shared
			internal_zone := a_tab_zone
			internal_mediator := a_docker_mediator
			set_rectangle (create {EV_RECTANGLE}.make (a_tab_zone.screen_x, a_tab_zone.screen_y, a_tab_zone.width, a_tab_zone.height))
		ensure
			set: internal_zone = a_tab_zone
			set: internal_mediator = a_docker_mediator
		end

feature -- Redefine

	apply_change  (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		local
			l_tab_zone: detachable SD_TAB_ZONE
			l_caller: SD_ZONE
		do
			l_caller := internal_mediator.caller
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
					l_tab_zone ?= internal_zone
					check must_be_tab_zone: l_tab_zone /= Void end
					l_caller.state.move_to_tab_zone (l_tab_zone, internal_tab_area.key_for_iteration)
				end
				internal_tab_area.forth
			end
			if not Result then
				if internal_rectangle_top.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.top)
					Result := True
				elseif internal_rectangle_bottom.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.bottom)
					Result := True
				elseif internal_rectangle_left.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.left)
					Result := True
				elseif internal_rectangle_right.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
					l_caller.state.change_zone_split_area (internal_zone, {SD_ENUMERATION}.right)
					Result := True
				elseif internal_rectangle_center.has_x_y (a_screen_x, a_screen_y) and internal_mediator.is_dockable then
					l_tab_zone ?= internal_zone
					check must_be_tab_zone: l_tab_zone /= Void end
					l_caller.state.move_to_tab_zone (l_tab_zone, 1)
					Result := True
				end
			end

			internal_shared.feedback.reset_feedback_clearing
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
						internal_shared.feedback.draw_rectangle (l_item.x, l_item.y, l_item.width, l_item.height, internal_shared.line_width)
					end
					internal_tab_area.forth
				end

				if not Result then
					Result := Precursor {SD_HOT_ZONE_OLD_DOCKING} (a_screen_x, a_screen_y, a_dockable)
				end
			end
		end

	set_rectangle (a_rect: EV_RECTANGLE)
			-- <Precursor>
		local
			l_tabs: HASH_TABLE [SD_NOTEBOOK_TAB, INTEGER]
			l_tab_behind_last: EV_RECTANGLE
			l_tab_zone: detachable SD_TAB_ZONE
			l_last: detachable EV_RECTANGLE
		do
			Precursor {SD_HOT_ZONE_OLD_DOCKING} (a_rect)
			l_tab_zone ?= internal_zone
			check tab_hot_zone_only_for_tab_zone: l_tab_zone /= Void end
			l_tabs := l_tab_zone.tabs_shown
			from
				l_tabs.start
				create internal_tab_area.make (10)
			until
				l_tabs.after
			loop
				l_last := create {EV_RECTANGLE}.make (l_tabs.item_for_iteration.screen_x, l_tabs.item_for_iteration.screen_y, l_tabs.item_for_iteration.width, l_tabs.item_for_iteration.height)
				internal_tab_area.extend (l_last, l_tabs.key_for_iteration)
				l_tabs.forth
			end

			check l_last /= Void end -- Implied by tab zone at least has one tab
			create l_tab_behind_last.make (l_last.right + 1, l_last.top, internal_shared.feedback_tab_width, l_last.height)
			internal_tab_area.extend (l_tab_behind_last, internal_tab_area.key_for_iteration + 1)
		end

feature {NONE} -- Implementation

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
