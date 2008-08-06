indexing
	description: "Docking manager commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_COMMAND

inherit
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SD_ACCESS

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
			if not internal_docking_manager.property.is_opening_config then
				l_widget := internal_docking_manager.internal_viewport
				internal_docking_manager.agents.on_resize (l_widget.x_position, l_widget.y_position, l_widget.width, l_widget.height, a_force)
			end
		end

	lock_update (a_zone: EV_WIDGET; a_main_window: BOOLEAN) is
			-- Lock window update.
		require
			a_zone_not_void_when_not_main_window: not a_main_window implies a_zone /= Void
		do
			if not internal_docking_manager.is_closing_all then
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
		end

	unlock_update is
			-- Unlock window update.
		do
			if not internal_docking_manager.is_closing_all then
				lock_call_time := lock_call_time - 1
				if lock_call_time = 0 then
					if not ignore_update then
						unlock_update_internal
					end
					ignore_update := False
				end
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
			restore_editor_area
			restore_editor_area_for_minimized
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

	recover_normal_state_in (a_dock_area: SD_MULTI_DOCK_AREA) is
			-- Recover zone which is in `a_dock_area' normal state.
		require
			not_void: a_dock_area /= Void
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			if is_main_inner_container (a_dock_area) then
				restore_editor_area
				restore_editor_area_for_minimized
			end

			from
				l_zones := internal_docking_manager.zones.zones.twin
				l_zones.start
			until
				l_zones.after
			loop
				if l_zones.item /= Void and then a_dock_area.has_recursive (l_zones.item) then
					l_zones.item.recover_to_normal_state
				end
				l_zones.forth
			end
		end

	recover_normal_state_in_dock_area_of (a_zone: SD_ZONE) is
			-- Recover zone normal state in the SD_MULTI_DOCK_AREA which has `a_zone'.
		local
			l_area: SD_MULTI_DOCK_AREA
		do
			if a_zone /= Void then
				l_area := internal_docking_manager.query.inner_container_include_hidden (a_zone)
				if l_area /= Void then
					if is_main_inner_container (l_area) then
						restore_editor_area
						restore_editor_area_for_minimized
					end
					recover_normal_state_in (l_area)
				end
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
		do
			if a_content /= Void then
				a_content.update_mini_tool_bar_size
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
			if internal_docking_manager.query.has_content_visible then
				create l_dialog.make (a_shift_pressed, internal_docking_manager)
				l_x := internal_docking_manager.main_window.screen_x + internal_docking_manager.main_window.width // 2 - l_dialog.width // 2
				l_y := internal_docking_manager.main_window.screen_y + internal_docking_manager.main_window.height // 2 - l_dialog.height // 2
				l_dialog.set_position (l_x, l_y)
				l_dialog.show
			end
		end

	propagate_accelerators is
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

	restore_editor_area_for_minimized is
			-- Restore editors area to normal.
		local
			l_main_area: SD_MULTI_DOCK_AREA
			l_parent: EV_CONTAINER
		do
			if minimized_editor_area /= Void then

				l_main_area := internal_docking_manager.query.inner_container_main

				if {lt_upper_zone: SD_PLACE_HOLDER_ZONE} minimized_editor_area  then

					if not is_minimize_orignally then
						lt_upper_zone.recover_normal_size_from_minimize
					end
					-- If codes above executed, parent will change
					l_parent := lt_upper_zone.parent

					lt_upper_zone.clear_for_minimized_area
				end

				l_parent.prune (minimized_editor_area)
				l_parent.extend (orignal_whole_item_for_minimized)
				if is_minimize_orignally then
					if {lt_box: EV_BOX} l_parent then
						lt_box.disable_item_expand (orignal_whole_item_for_minimized)
					end
				end

				internal_docking_manager.command.resize (True)
				l_main_area.restore_spliter_position (l_parent)

				orignal_whole_item_for_minimized := Void
				minimized_editor_area := Void

				if internal_docking_manager.query.internal_restore_whole_editor_area_for_minimized_actions /= Void then
					internal_docking_manager.query.internal_restore_whole_editor_area_for_minimized_actions.call (Void)
				end
			end
		ensure
			cleared: minimized_editor_area = Void
		end

	minimize_editor_area is
			-- Minimize whole editor area
		local
			l_editor_parent: EV_CONTAINER
			l_editor_area: SD_MULTI_DOCK_AREA
			l_has_maximized_zone: BOOLEAN
			l_parent_parent: EV_CONTAINER
		do
			if not internal_docking_manager.zones.place_holder_content.is_docking_manager_attached then

				if internal_docking_manager.is_editor_area_maximized then
					restore_editor_area
				end

				l_editor_parent := internal_docking_manager.query.inner_container_main.editor_parent
				l_editor_area := internal_docking_manager.query.inner_container_main

				l_has_maximized_zone := internal_docking_manager.zones.maximized_zone_in_main_window /= Void

				if l_editor_parent /= Void and not l_has_maximized_zone then
					if l_editor_parent = l_editor_area then
						-- Only editor zone in container main area now. Nothing to do.
					else
						l_parent_parent := l_editor_parent.parent

						orignal_whole_item_for_minimized := l_editor_parent

						l_editor_area.save_spliter_position (l_parent_parent)

						if {lt_parent_parent: EV_BOX} l_parent_parent then
							is_minimize_orignally := True
						else
							is_minimize_orignally := False
						end

						l_parent_parent.prune (l_editor_parent)

						minimized_editor_area := internal_shared.widget_factory.docking_zone (internal_docking_manager.zones.place_holder_content)

						l_parent_parent.extend (minimized_editor_area)
						if {lt_upper_zone: SD_PLACE_HOLDER_ZONE} minimized_editor_area  then
							lt_upper_zone.prepare_for_minimized_editor_area (internal_docking_manager)
							lt_upper_zone.minimize
						end

						internal_docking_manager.command.resize (True)
					end
				end
			end
		end

	maximize_editor_area is
			-- Maximize whole editor area.
		local
			l_editor_parent: EV_CONTAINER
			l_editor_area: SD_MULTI_DOCK_AREA
			l_has_maximized_zone: BOOLEAN
		do
			if internal_docking_manager.is_editor_area_minimized then
				restore_editor_area_for_minimized
			end
			-- We have to restore minimized editors first if all editors minimized.
			-- See bug#13648.
			restore_minimized_editors_for_maximize_editor_area

			l_editor_parent := internal_docking_manager.query.inner_container_main.editor_parent
			l_editor_area := internal_docking_manager.query.inner_container_main

			l_has_maximized_zone := internal_docking_manager.zones.maximized_zone_in_main_window /= Void

			if l_editor_parent /= Void and not l_has_maximized_zone then
				if l_editor_parent = l_editor_area then
					-- Only editor zone in container main area now. Nothing to do.
				else
					orignal_editor_parent := l_editor_parent.parent

					orignal_whole_item := l_editor_area.item
					l_editor_area.save_spliter_position (orignal_whole_item)

					orignal_editor_parent.prune (l_editor_parent)

					l_editor_area.wipe_out
					l_editor_area.extend (l_editor_parent)

					internal_docking_manager.command.resize (True)
				end
			end
		end

	restore_editor_area is
			-- Restore editors area to normal.
		local
			l_editor_area: EV_WIDGET
			l_main_area: SD_MULTI_DOCK_AREA
		do
			if orignal_editor_parent /= Void then
				l_main_area := internal_docking_manager.query.inner_container_main
				l_editor_area := l_main_area.item
				l_main_area.wipe_out

				orignal_editor_parent.extend (l_editor_area)

				l_main_area.extend (orignal_whole_item)

				internal_docking_manager.command.resize (True)
				l_main_area.restore_spliter_position (orignal_whole_item)

				orignal_editor_parent := Void
				orignal_whole_item := Void

				if internal_docking_manager.query.internal_restore_whole_editor_area_actions /= Void then
					internal_docking_manager.query.internal_restore_whole_editor_area_actions.call (Void)
				end
			end
		ensure
			cleared: orignal_editor_parent = Void
			cleared: orignal_whole_item = Void
		end

	minimize_editors is
			-- Minimize all editors.
		local
			l_upper_zones: ARRAYED_LIST [SD_UPPER_ZONE]
		do
			if not internal_docking_manager.is_editor_area_maximized and then
				not internal_docking_manager.is_editor_area_minimized then
				from
					l_upper_zones := internal_docking_manager.zones.upper_zones
					l_upper_zones.start
				until
					l_upper_zones.after
				loop
					if not l_upper_zones.item.is_minimized then
						l_upper_zones.item.on_minimize
					end
					l_upper_zones.forth
				end
			end
		end

	restore_minimized_editors is
			-- Restore all minimized editors
			local
				l_upper_zones: ARRAYED_LIST [SD_UPPER_ZONE]
			do
				if not internal_docking_manager.is_editor_area_maximized and then
					not internal_docking_manager.is_editor_area_minimized then
					from
						l_upper_zones := internal_docking_manager.zones.upper_zones
						l_upper_zones.finish
					until
						l_upper_zones.before
					loop
						if l_upper_zones.item.is_minimized then
							l_upper_zones.item.on_minimize
						end
						l_upper_zones.back
					end
				end
			end

	show_displayed_floating_windows_in_idle is
			-- Show all displayed floating windows again for Solaris CDE.
			-- This feature fix bug#13645
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.do_once_on_idle (agent show_all_floating_zones)
		end

feature -- Query

	orignal_editor_parent: EV_CONTAINER
			-- The orignal editor area parent which stored by `maximize_editor_area'

	orignal_whole_item: EV_WIDGET
			-- The orignal whole widget in main docking area which stored by `maximize_editor_area'.

	orignal_whole_item_for_minimized: EV_WIDGET
			-- The orignal whole widget in main docking area which stored by `minimize_editor_area'.

	minimized_editor_area: SD_DOCKING_ZONE
			-- SD_PLACE_HOLDER_ZONE that represent minimized editor area

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

	restore_minimized_editors_for_maximize_editor_area is
			-- Restore all minimized editors if all editors minimized.
			local
				l_upper_zones: ARRAYED_LIST [SD_UPPER_ZONE]
				l_all_editors_minimized: BOOLEAN
			do
				if not internal_docking_manager.is_editor_area_maximized then
					from
						l_all_editors_minimized := True
						l_upper_zones := internal_docking_manager.zones.upper_zones
						l_upper_zones.finish
					until
						l_upper_zones.before or not l_all_editors_minimized
					loop
						if not l_upper_zones.item.is_minimized then
							l_all_editors_minimized := False
						end
						l_upper_zones.back
					end
				end
				if l_all_editors_minimized then
					restore_minimized_editors
				end
			end

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

	show_all_floating_zones is
			-- This fix bug#13645 which only happens on Solaris CDE.
			-- The bug is a floating tool `is_displayed' is true but actually not displayed. We have to call show again in idle actions.
		local
			l_floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
			l_item: SD_FLOATING_ZONE
			l_width, l_height: INTEGER
			l_checker: SD_DEPENDENCY_CHECKER
		do
			create {SD_DEPENDENCY_CHECKER_IMP} l_checker
			if l_checker.is_solaris_cde then

				from
					l_floating_zones := internal_docking_manager.query.floating_zones
					l_floating_zones.start
				until
					l_floating_zones.after
				loop
					l_item := l_floating_zones.item
					if not l_item.is_destroyed and then l_item.is_displayed then
						l_width := l_item.width
						l_height := l_item.height
						l_item.hide

						l_item.show
						l_item.set_size (l_width, l_height)
					end

					l_floating_zones.forth
				end
			end
		end

	locked_windows: DS_HASH_TABLE [EV_WINDOW, INTEGER]
			-- Which window is locked. Works like a stack. Used by lock_update and unlock_update.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	is_minimize_orignally: BOOLEAN
			-- Used by `minimize_editor_area'
			-- Indicate whether editor top parent's EV_BOX is minimized originally

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
