indexing
	description: "Manager that control SD_MENU_ZONE and SD_MENU_HOT_ZONE when user drag a SD_MENU_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_DOCKER_MEDIATOR

create
	make

feature {NONE} -- Initialization

	make (a_caller: SD_MENU_ZONE; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method
		require
			a_caller_not_void: a_caller /= Void
		do
			create internal_shared
			docking_manager := a_docking_manager

			internal_menus := docking_manager.menu_manager.menus

			caller := a_caller

			create internal_top_hot_zone.make (docking_manager.menu_container.top, False, Current)
			create internal_bottom_hot_zone.make (docking_manager.menu_container.bottom, False, Current)
			create internal_left_hot_zone.make (docking_manager.menu_container.left, True, Current)
			create internal_right_hot_zone.make (docking_manager.menu_container.right, True, Current)

			internal_top_hot_zone.start_drag
			internal_bottom_hot_zone.start_drag
			internal_left_hot_zone.start_drag
			internal_right_hot_zone.start_drag

			if a_caller.is_floating then
				internal_last_floating := True
			end


		ensure
			set: docking_manager = a_docking_manager
			a_caller_set: a_caller = caller
		end

feature -- Docking issues.

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- Handle user drag menu events.
		local
			l_in_four_side: BOOLEAN
		do

			l_in_four_side := on_motion_in_four_side (a_screen_x, a_screen_y)

			if not l_in_four_side then

				if not internal_last_floating then
					docking_manager.command.lock_update (Void, True)
					caller.float
					docking_manager.command.unlock_update
				end

				internal_last_floating := True
				caller.set_position (a_screen_x, a_screen_y)

			else
				internal_last_floating := False
			end

		end

	apply_change (a_screen_x, a_screen_y: INTEGER) is
			-- Apply change.
		local
			l_docking_manager: SD_DOCKING_MANAGER
		do
			l_docking_manager := docking_manager
			notify_row (l_docking_manager.menu_container.top)
			notify_row (l_docking_manager.menu_container.bottom)
			notify_row (l_docking_manager.menu_container.left)
			notify_row (l_docking_manager.menu_container.right)
		end

feature -- Access

	caller: SD_MENU_ZONE
			-- Caller.

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

feature {NONE} -- Implementation

	on_motion_in_four_side (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Handle pointer in four menu area.
		local
			l_changed: BOOLEAN
		do
			if internal_left_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y) then
				l_changed := internal_left_hot_zone.on_pointer_motion (a_screen_x)
				Result := True
			elseif internal_right_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y)	then
				l_changed := internal_right_hot_zone.on_pointer_motion (a_screen_x)
				Result := True
			elseif internal_top_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y)  then
				l_changed := internal_top_hot_zone.on_pointer_motion (a_screen_y)
				Result := True
			elseif internal_bottom_hot_zone.area_managed.has_x_y (a_screen_x, a_screen_y) then
				l_changed := internal_bottom_hot_zone.on_pointer_motion (a_screen_y)
				Result := True
			end
			if Result then
				if not caller.row.is_vertical then
					caller.row.set_item_position (caller, a_screen_x)
				else
					caller.row.set_item_position (caller, a_screen_y)
				end
			end
			debug ("docking")
--				internal_shared.feedback.draw_red_rectangle (internal_top_hot_zone.area_managed.left, internal_top_hot_zone.area_managed.top, internal_top_hot_zone.area_managed.width, internal_top_hot_zone.area_managed.height)
--				internal_shared.feedback.draw_red_rectangle (internal_bottom_hot_zone.area_managed.left, internal_bottom_hot_zone.area_managed.top, internal_bottom_hot_zone.area_managed.width, internal_bottom_hot_zone.area_managed.height)
--				internal_shared.feedback.draw_red_rectangle (internal_left_hot_zone.area_managed.left, internal_left_hot_zone.area_managed.top, internal_left_hot_zone.area_managed.width, internal_left_hot_zone.area_managed.height)
--				internal_shared.feedback.draw_red_rectangle (internal_right_hot_zone.area_managed.left, internal_right_hot_zone.area_managed.top, internal_right_hot_zone.area_managed.width, internal_right_hot_zone.area_managed.height)
			end
		ensure
			changed:
		end

	notify_row (a_box: EV_BOX) is
			-- Notify a SD_MENU_ROW to apply change.
		require
			a_box_not_void: a_box /= Void
		local
			l_menu_row: SD_MENU_ROW
		do
			from
				a_box.start
			until
				a_box.after
			loop
				l_menu_row ?= a_box.item
				check l_menu_row /= Void end
				l_menu_row.apply_change
				a_box.forth
			end
		end

	internal_last_floating: BOOLEAN
			-- If last pointer motion `caller' is floating?

	internal_menus: ARRAYED_LIST [SD_MENU_ZONE]
			-- All SD_MENU_ZONEs in current system.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_top_hot_zone, internal_bottom_hot_zone, internal_left_hot_zone, internal_right_hot_zone: SD_MENU_HOT_ZONE
			-- Four area hot zone.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_top_hot_zone_not_void: internal_top_hot_zone /= Void
	internal_bottom_hot_zone_not_void: internal_bottom_hot_zone /= Void
	internal_left_hot_zone_not_void: internal_left_hot_zone /= Void
	internal_right_hot_zone_not_void: internal_right_hot_zone /= Void

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
