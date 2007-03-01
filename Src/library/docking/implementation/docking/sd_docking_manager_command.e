indexing
	description: "Docking manager commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_COMMAND

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_key: EV_KEY
			l_acc: EV_ACCELERATOR
			l_window: EV_TITLED_WINDOW
		do
			internal_docking_manager := a_docking_manager
			create locked_windows.make_default

			create internal_shared
			-- Initialize zone navigation accelerator key.
			create l_key.make_with_code (internal_shared.zone_navigation_accelerator_key)

			create l_acc.make_with_key_combination (l_key, internal_shared.zone_navigation_accelerator_ctrl, internal_shared.zone_navigation_accelerator_alt, internal_shared.zone_navigation_accelerator_shift)
			l_acc.actions.extend (agent on_zone_navigation (False))
			l_window ?= internal_docking_manager.main_window
			if l_window /= Void then
				l_window.accelerators.extend (l_acc)
			end

			-- We must set another accelerator, otherwise shift+ctrl+tab will not invoke actions.
			create l_acc.make_with_key_combination (l_key, True, False, True)
			l_acc.actions.extend (agent on_zone_navigation (True))
			if l_window /= Void then
				l_window.accelerators.extend (l_acc)
			end
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Commands

	resize (a_force: BOOLEAN) is
			-- Resize fixed area.
			-- `a_force' is always perform resize actions, even it's same size.
		local
			l_widget: EV_WIDGET
		do
			l_widget := internal_docking_manager.internal_viewport
			internal_docking_manager.agents.on_resize (l_widget.x_position, l_widget.y_position, l_widget.width, l_widget.height, a_force)
		end

	lock_update (a_zone: EV_WIDGET; a_main_window: BOOLEAN) is
			-- Lock window update.
		require
			a_zone_not_void_when_not_main_window: not a_main_window implies a_zone /= Void
		do
			if lock_call_time = 0 then
				if ev_application.locked_window /= Void then
						-- We should ignore these lock window update calls.
					ignore_update := True
				else
					lock_update_internal (a_zone, a_main_window)
				end
			else
				-- Nothing to be done, since we have already locked it, or it was already locked.
			end
			lock_call_time := lock_call_time + 1

		end

	unlock_update is
			-- Unlock window update.
		do
			lock_call_time := lock_call_time - 1
			if lock_call_time = 0 then
				if not ignore_update then
					unlock_update_internal
				end
				ignore_update := False
			end
		end

	add_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			-- Add `a_area'.
		require
			a_area_not_void: a_area /= Void
		do
			internal_docking_manager.inner_containers.extend (a_area)
		end

	prune_inner_container (a_area: SD_MULTI_DOCK_AREA) is
			-- Prune `a_area'.
		require
			a_area_not_void: a_area /= Void
			a_area_not_first_one: not is_main_inner_container (a_area)
		do
			internal_docking_manager.inner_containers.start
			internal_docking_manager.inner_containers.prune (a_area)
		end

	remove_empty_split_area  is
			-- Remove empty split area in SD_MULTI_DOCK_AREA.
		local
			l_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			from
				l_containers := internal_docking_manager.inner_containers
				l_containers.start
			until
				l_containers.after
			loop
				if l_containers.item /= Void then
					l_containers.item.remove_empty_split_area
				end
				l_containers.forth
			end
		end

	remove_auto_hide_zones (a_animation: BOOLEAN) is
			-- Remove all auto hide zones in `zones'.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_zones_snapshot: ARRAYED_LIST [SD_ZONE]
			l_auto_hide_state: SD_AUTO_HIDE_STATE
		do
			l_zones_snapshot := internal_docking_manager.zones.zones.twin
			from
				l_zones_snapshot.start
			until
				l_zones_snapshot.after
			loop
				l_auto_hide_zone ?= l_zones_snapshot.item
				if l_auto_hide_zone /= Void then
					if not a_animation then
						internal_docking_manager.zones.zones.prune (l_auto_hide_zone)
						l_auto_hide_zone.content.state.record_state
						internal_docking_manager.fixed_area.prune (l_auto_hide_zone)
					else
						l_auto_hide_state ?= l_auto_hide_zone.content.state
						check not_void: l_auto_hide_state /= Void end
						l_auto_hide_state.close_animation
					end
				end
				l_zones_snapshot.forth
			end
		ensure
--			no_auto_hide_zone_left: internal_docking_manager.fixed_area.count = 1
		end

	recover_normal_state is
			-- Recover all zone's state to normal state.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			from
				l_zones := internal_docking_manager.zones.zones.twin
				l_zones.start
			until
				l_zones.after
			loop
				if l_zones.item /= Void then
					l_zones.item.recover_to_normal_state
				end
				l_zones.forth
			end
		end

	update_title_bar is
			-- Update all title bar.
			-- Also prune and destroy floating zones which are not used anymore.
		local
			l_inner_container_snapshot: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			l_inner_container_snapshot := internal_docking_manager.inner_containers.twin
			from
				l_inner_container_snapshot.start
			until
				l_inner_container_snapshot.after
			loop
				if l_inner_container_snapshot.item /= Void then
					l_inner_container_snapshot.item.update_title_bar
				end
					l_inner_container_snapshot.forth
			end
		end

	update_mini_tool_bar_size (a_content: SD_CONTENT) is
			-- Update all zones' title bar size for mini tool bar widgets new size.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_zone: SD_ZONE
		do
			if a_content /= Void then
				l_zone := a_content.state.zone
				if l_zone /= Void then
					l_zone.update_mini_tool_bar_size
				end
			else
				from
					l_zones := internal_docking_manager.zones.zones.twin
					l_zones.start
				until
					l_zones.after
				loop
					if l_zones.item /= Void then
						l_zones.item.update_mini_tool_bar_size
					end
					l_zones.forth
				end
			end
		end

	on_zone_navigation (a_shift_pressed: BOOLEAN) is
			-- User request to show zone navigation.
		local
			l_dialog: SD_ZONE_NAVIGATION_DIALOG
			l_x, l_y: INTEGER
		do
			create l_dialog.make (a_shift_pressed, internal_docking_manager)
			l_x := internal_docking_manager.main_window.screen_x + internal_docking_manager.main_window.width // 2 - l_dialog.width // 2
			l_y := internal_docking_manager.main_window.screen_y + internal_docking_manager.main_window.height // 2 - l_dialog.height // 2
			l_dialog.set_position (l_x, l_y)
			l_dialog.show
		end

	proporgate_accelerators is
			-- If `main_window' of SD_DOCKING_MANAGER accelerators changed, we update all floating zones accelerators.
		local
			l_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
			l_global_accelerators: SEQUENCE [EV_ACCELERATOR]
		do
			from
				l_zones := internal_docking_manager.query.floating_zones
				l_global_accelerators := internal_docking_manager.query.golbal_accelerators
				l_zones.start
			until
				l_zones.after
			loop
				l_zones.item.accelerators.wipe_out
				if l_global_accelerators /= Void then
					l_zones.item.accelerators.append (l_global_accelerators)
				end
				l_zones.forth
			end
		end

feature -- Contract Support

	is_main_inner_container (a_container: SD_MULTI_DOCK_AREA): BOOLEAN is
			-- If `a_container' is main contianer?
		do
			Result := internal_docking_manager.query.is_main_inner_container (a_container)
		end

	lock_call_time: INTEGER
			-- Used for remember how many times client call `lock_update'.

	find_window (a_zone: EV_WIDGET): EV_WINDOW is
			-- Function wrapper for contract support.
		require
			a_zone_not_void: a_zone /= Void
		do
			Result := internal_docking_manager.query.find_window_by_zone (a_zone)
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All Singletons.

	ignore_update: BOOLEAN
			-- If ignore update?

	lock_update_internal (a_zone: EV_WIDGET; a_main_window: BOOLEAN) is
			-- Lock window update.
		require
			a_zone_not_void_when_not_main_window: not a_main_window implies a_zone /= Void
		local
			l_lock_window: EV_WINDOW
		do
			if lock_call_time = 0 then
				if a_main_window then
					locked_windows.force_last (internal_docking_manager.main_window, 0)
				else
					locked_windows.force_last (internal_docking_manager.query.find_window_by_zone (a_zone), 0)
				end
				locked_windows.item (0).lock_update
			else
				if a_main_window then
					l_lock_window := internal_docking_manager.main_window
				else
					l_lock_window := find_window(a_zone)
				end
				if  l_lock_window /= locked_windows.last then
					locked_windows.last.unlock_update
					locked_windows.force_last (l_lock_window, lock_call_time)
					locked_windows.last.lock_update
				end
			end
		end

	unlock_update_internal is
			-- Unlock window update.
		do
			if lock_call_time = 0 then
				if not locked_windows.last.is_destroyed then
					locked_windows.last.unlock_update
				end
				locked_windows.remove (0)
				remove_empty_split_area
				check no_windows_in_locked_window: locked_windows.count = 0 end
			else
				if locked_windows.has (lock_call_time) then
					if not locked_windows.item (lock_call_time).is_destroyed then
						locked_windows.item (lock_call_time).unlock_update
					end
					locked_windows.remove (lock_call_time)
					if not locked_windows.last.is_destroyed then
						locked_windows.last.lock_update
					end
				end
			end
		end

	locked_windows: DS_HASH_TABLE [EV_WINDOW, INTEGER]
			-- Which window is locked. Works like a stack. Used by lock_update and unlock_update.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

invariant

	locked_windows_not_void: locked_windows /= Void
	internal_docking_manager_not_void: internal_docking_manager /= Void

indexing
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
