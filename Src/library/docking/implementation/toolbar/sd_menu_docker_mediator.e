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
			internal_shared.set_menu_docker_mediator (Current)
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

feature -- Command

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- Handle user drag menu events.
		local
			l_in_four_side: BOOLEAN
		do
			internal_last_screen_x := screen_x
			internal_last_screen_y := screen_y
			screen_x := a_screen_x
			screen_y := a_screen_y

			l_in_four_side := on_motion_in_four_side (a_screen_x, a_screen_y, offset_x, offset_y)

			if not l_in_four_side then
				if not internal_last_floating then
					docking_manager.command.lock_update (Void, True)
					caller.float
					docking_manager.command.unlock_update
				end
				internal_last_floating := True
				caller.set_position (a_screen_x - offset_x, a_screen_y - offset_y)
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

	set_offset (a_start_floating: BOOLEAN; a_offset_x, a_offset_y: INTEGER) is
			-- Set offset when start dragging.
		require
			vaild: a_offset_x >= 0 and a_offset_y >= 0
		do
			offset_x := a_offset_x
			offset_y := a_offset_y
			start_floating := a_start_floating
		ensure
			set: offset_x = a_offset_x
			set: offset_y = a_offset_y
			set: start_floating = a_start_floating
		end

feature -- Query

	caller: SD_MENU_ZONE
			-- Caller.

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	screen_x, screen_y: INTEGER
			-- Current pointer position.

	start_floating: BOOLEAN
			-- When start dragging, is it floating state?

	offset_x, offset_y: INTEGER
			-- Offset when start dragging.

feature {NONE} -- Implementation

	internal_last_screen_x, internal_last_screen_y: INTEGER
			-- Last pointer position.

	on_motion_in_four_side (a_screen_x, a_screen_y: INTEGER; a_offset_x, a_offset_y: INTEGER): BOOLEAN is
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
			elseif internal_top_hot_zone.area_managed.has_x_y (a_screen_x - a_offset_x, a_screen_y - a_offset_y)  then
				l_changed := internal_top_hot_zone.on_pointer_motion (a_screen_y)
				Result := True
			elseif internal_bottom_hot_zone.area_managed.has_x_y (a_screen_x - a_offset_x, a_screen_y - a_offset_y) then
				l_changed := internal_bottom_hot_zone.on_pointer_motion (a_screen_y)
				Result := True
			end
			if Result then
				if not caller.row.is_vertical then
					caller.row.on_pointer_motion (a_screen_x)
				else
					caller.row.on_pointer_motion (a_screen_y)
				end
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
