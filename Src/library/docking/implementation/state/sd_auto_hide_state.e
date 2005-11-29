indexing
	description: "SD_STATE for  SD_AUTO_HIDE_ZONE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_STATE

inherit
	SD_STATE
		redefine
			show,
			close,
			stick,
			change_title
		end

create
	make,
	make_with_size

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER) is
			-- Creation method.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			create internal_shared
			internal_content := a_content
			direction := a_direction
			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				width_height := (internal_shared.docking_manager.fixed_area.width * internal_shared.default_docking_width_rate).ceiling
			else
				width_height := (internal_shared.docking_manager.fixed_area.height * internal_shared.default_docking_height_rate).ceiling
			end
			auto_hide_panel := internal_shared.docking_manager.auto_hide_panel (a_direction)
			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				create internal_tab_stub.make (internal_content.title, internal_content.pixmap, True)
			elseif direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom then
				create internal_tab_stub.make (internal_content.title, internal_content.pixmap, False)
			end
			debug ("larry")
				io.put_string ("%N ************************** SD_AUTO_HIDE_STATE: insert tab stubs.")
			end
			internal_tab_stub.pointer_enter_actions.extend (agent show)
			auto_hide_panel.tab_stubs.extend (internal_tab_stub)
		ensure
			set: internal_content = a_content
			set: direction = a_direction
		end

	make_with_size (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER) is
			-- Creation with a size.
		require
			a_content_not_void: a_content /= Void
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			make (a_content, a_direction)
			width_height := a_width_height
		ensure
			set: width_height = a_width_height
		end

feature {NONE} -- Auto hide functions.

	on_timer_for_close is
			-- Handle close timer event.
		require
			internal_timer_not_void: internal_close_timer /= Void
		do
			if pointer_outside and not zone.has_focus then
				remove_close_timer
			end
		ensure
--			timer_wipe_out: old internal_close_timer.actions.count = 0
			timer_void: pointer_outside and not zone.has_focus implies internal_close_timer = Void
		end

	remove_moving_timer is
			-- Remove `internal_moving_timer'.
		do
			if internal_moving_timer /= Void then
				internal_moving_timer.actions.wipe_out
				internal_moving_timer := Void
			end
		ensure
--			timer_wipe_out: old internal_moving_timer.actions.count = 0
			timer_void: internal_moving_timer = Void
		end

	remove_close_timer is
			-- Remove close timer.
		local
			l_env: EV_ENVIRONMENT
		do
			if internal_close_timer /= Void then
				internal_close_timer.actions.wipe_out
				internal_close_timer := Void
				internal_shared.docking_manager.prune_zone (zone)
				create l_env
				l_env.application.pointer_motion_actions.start
				l_env.application.pointer_motion_actions.prune (internal_motion_procudure)
				debug ("larry")
					io.put_string ("%N SD_AUTO_HIDE_STATE on_pointer_motion actions pruned")
				end
			end
		ensure
--			timer_wipe_out: old internal_close_timer.actions.count = 0
			timer_void: internal_close_timer = Void
			applcation_pointer_motion_pruned:
		end

	on_pointer_motion (a_widget: EV_WIDGET; a_screen_x, a_screen_y: INTEGER) is
			-- Use timer to detect pointer outside zone and tab stub?
		do
			if not internal_tab_stub.has_recursive (a_widget) and not zone.has_recursive (a_widget) then
				pointer_outside := True
				debug ("larry")
					io.put_string ("%N SD_AUTO_HIDE_STATE on_pointer_motion pointer_outside := True " + a_screen_x.out + " " + a_screen_y.out)
				end
			else
				pointer_outside := False
			end
		ensure
			set_true: not internal_tab_stub.has_recursive (a_widget) and not zone.has_recursive (a_widget) implies
				pointer_outside = True
			set_false: internal_tab_stub.has_recursive (a_widget) or zone.has_recursive (a_widget) implies
				pointer_outside = False
		end

	on_timer_for_moving  is
			-- Use timer to play a animation.
		do
			inspect
				direction
			when {SD_DOCKING_MANAGER}.dock_left then
				if zone.x_position + show_step >= final_position then
					remove_moving_timer
					internal_shared.docking_manager.fixed_area.set_item_x_position (zone, final_position)
				else
					internal_shared.docking_manager.fixed_area.set_item_x_position (zone, zone.x_position + show_step)
				end
			when {SD_DOCKING_MANAGER}.dock_right then
				if zone.x_position - show_step <= final_position then
					remove_moving_timer
					internal_shared.docking_manager.fixed_area.set_item_x_position (zone, final_position)
				else
					internal_shared.docking_manager.fixed_area.set_item_x_position (zone, zone.x_position - show_step)
				end
			when {SD_DOCKING_MANAGER}.dock_top then
				if zone.y_position + show_step >= final_position then
					remove_moving_timer
					internal_shared.docking_manager.fixed_area.set_item_y_position (zone, final_position)
				else
					internal_shared.docking_manager.fixed_area.set_item_y_position (zone, zone.y_position + show_step)
				end
			when {SD_DOCKING_MANAGER}.dock_bottom then
				if zone.y_position - show_step <= final_position then
					remove_moving_timer
					internal_shared.docking_manager.fixed_area.set_item_y_position (zone, final_position)
				else
					internal_shared.docking_manager.fixed_area.set_item_y_position (zone, zone.y_position - show_step)
				end
			end
		ensure
			final_position_set:
		end

feature {NONE} -- Auto hide attributes.

	internal_motion_procudure: PROCEDURE [ANY, TUPLE [EV_WIDGET, INTEGER, INTEGER]]
			-- Motion procedure for animation.

	show_step: INTEGER is 20
			-- Step when tear-off window appear.

	final_position: INTEGER
			-- Final position when a tear-off window should at.

	internal_moving_timer: EV_TIMEOUT
			-- Timer for moving animation.

	internal_close_timer: EV_TIMEOUT
			-- Timer for close window.

	pointer_outside: BOOLEAN
			-- If pointer outside tab stub and zone?

feature -- Redefine.

	close is
			-- Redefine.
		local
			l_env: EV_ENVIRONMENT
		do
			record_state
			Precursor {SD_STATE}
			if internal_close_timer /= Void then
				internal_close_timer.actions.wipe_out
				internal_close_timer := Void
			end
			create l_env
			l_env.application.pointer_motion_actions.prune_all (internal_motion_procudure)

			-- Remove tab stub from the SD_AUTO_HIDE_PANEL
			auto_hide_panel.tab_stubs.start
			auto_hide_panel.tab_stubs.prune (internal_tab_stub)
		ensure then
			internal_close_timer_void: internal_close_timer = Void
			tab_group_pruned: not auto_hide_panel.has (internal_tab_stub)
		end

	stick (a_direction: INTEGER) is
			-- Redefine. `a_direction' is useless, it's only used for SD_DOCKING_STATE.
		do
			internal_shared.docking_manager.lock_update
			internal_shared.docking_manager.remove_auto_hide_zones
			internal_shared.docking_manager.recover_normal_state

				stick_zones (a_direction)

			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure then
			tab_stubs_pruned: auto_hide_panel.tab_stubs.count < old auto_hide_panel.tab_stubs.count
		end

 	change_title (a_title: STRING; a_content: SD_CONTENT) is
			-- Redefine.
		do
			internal_tab_stub.set_text (a_title)
		ensure then
			set: internal_tab_stub.text = a_title
		end

	restore (titles: ARRAYED_LIST [STRING]; a_container: EV_CONTAINER; a_direction: INTEGER) is
			-- Redefine.
		do
			-- This class can created by make (not like SD_DOCKING_STATE, created by INTERNAL), so this routine do less work.
			change_state (Current)
			direction := a_direction
		end

	record_state is
			-- Redefine.
		do
			if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
				width_height := zone.width
			else
				width_height := zone.height
			end
			remove_close_timer
			remove_moving_timer
		ensure then
			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right
				implies width_height = zone.width
			width_height_set: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
				implies width_height = zone.height
			timer_removed: internal_moving_timer = Void and internal_close_timer = Void
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Redefine.
		do

		end

	show is
			-- Redefine.
		local
			l_rect: EV_RECTANGLE
			l_env: EV_ENVIRONMENT
		do
			internal_shared.docking_manager.lock_update
			if not internal_shared.docking_manager.has_zone_by_content (internal_content) then
				create zone.make (internal_content, direction)
				-- Before add the zone to the fixed area, first clear the other zones in the area except the main_container.
				internal_shared.docking_manager.remove_auto_hide_zones

				internal_shared.docking_manager.add_zone (zone)
				create internal_close_timer.make_with_interval ({SD_SHARED}.Auto_hide_delay)
				internal_close_timer.actions.extend (agent on_timer_for_close)
				create l_env
				l_env.application.pointer_motion_actions.extend (agent on_pointer_motion)
				internal_motion_procudure := l_env.application.pointer_motion_actions.last
				-- First, put the zone in a fixed, make a animation here.
				internal_shared.docking_manager.fixed_area.extend (zone)

				create internal_moving_timer
				internal_moving_timer.actions.extend (agent on_timer_for_moving)
				internal_moving_timer.set_interval (10)

				create l_rect.make (internal_shared.docking_manager.fixed_area.x_position, internal_shared.docking_manager.fixed_area.y_position,
				internal_shared.docking_manager.fixed_area.width, internal_shared.docking_manager.fixed_area.height)

				if direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right then
					if width_height > zone.minimum_width then
						internal_shared.docking_manager.fixed_area.set_item_width (zone, width_height)
					end
					if l_rect.height > zone.minimum_height then
						internal_shared.docking_manager.fixed_area.set_item_height (zone, l_rect.height)
					end
				else
					if l_rect.width > zone.minimum_width then
						internal_shared.docking_manager.fixed_area.set_item_width (zone, l_rect.width)
					end
					if width_height > zone.minimum_height then
						internal_shared.docking_manager.fixed_area.set_item_height (zone, width_height)
						debug ("larry")
							io.put_string ("%N SD_AUTO_HIDE_STATE show width_height " + width_height.out)
						end
					end
				end
				if direction = {SD_DOCKING_MANAGER}.dock_left then
					internal_shared.docking_manager.fixed_area.set_item_position (zone, l_rect.left - zone.width, l_rect.top)
					final_position := l_rect.left

				elseif direction = {SD_DOCKING_MANAGER}.dock_right then
					internal_shared.docking_manager.fixed_area.set_item_position (zone, l_rect.right, l_rect.top)
					final_position := l_rect.right - zone.width

				elseif direction = {SD_DOCKING_MANAGER}.dock_top then
					internal_shared.docking_manager.fixed_area.set_item_position (zone, l_rect.left, l_rect.top - zone.height)
					final_position := l_rect.top

				elseif direction = {SD_DOCKING_MANAGER}.dock_bottom then
					internal_shared.docking_manager.fixed_area.set_item_position (zone, l_rect.left, l_rect.bottom)
					final_position := l_rect.bottom - zone.height
				end
			end

			internal_shared.docking_manager.unlock_update
		ensure then
--			close_timer_created: internal_close_timer /= Void
--			move_timer_created: internal_moving_timer /= Void
			show: internal_shared.docking_manager.has_zone_by_content (internal_content)
		end

feature {NONE} -- Implementation functions.

	stick_zones (a_direction: INTEGER) is
			-- Stick zones which should together with current zone.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		local
			l_docking_state: SD_DOCKING_STATE
			l_tab_state: SD_TAB_STATE
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
			l_tab_stub: SD_TAB_STUB
			l_content: SD_CONTENT

			l_last_tab_zone: SD_TAB_ZONE
		do
			l_tab_group := auto_hide_panel.tab_group (internal_tab_stub)
			from
				l_tab_group.start
			until
				l_tab_group.after
			loop
				l_tab_stub := l_tab_group.item
				auto_hide_panel.tab_stubs.start
				auto_hide_panel.tab_stubs.prune (l_tab_stub)

				l_content := internal_shared.docking_manager.content_by_title (l_tab_stub.text)
				if l_tab_group.index = 1 then
					create l_docking_state.make (l_content, direction, width_height)
					l_docking_state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
					l_content.change_state (l_docking_state)
				else
					if l_content.user_widget.parent /= Void then
						l_content.user_widget.parent.prune (l_content.user_widget)
					end
					if l_last_tab_zone = Void then
						create l_tab_state.make (l_content, l_docking_state.zone, direction)
						l_tab_state.set_width_height (width_height)
						l_tab_state.set_direction (l_docking_state.direction)
					else
						create l_tab_state.make_with_tab_zone (l_content, l_last_tab_zone, direction)
						l_tab_state.set_width_height (width_height)
						l_tab_state.set_direction (l_last_tab_zone.state.direction)
					end

					l_last_tab_zone := l_tab_state.zone
					l_content.change_state (l_tab_state)
				end

				l_tab_group.forth
			end
			if l_tab_group.count > 1 then
				l_tab_state.select_tab (internal_content)
			end
			auto_hide_panel.tab_groups.start
			auto_hide_panel.tab_groups.prune (l_tab_group)
		ensure
			state_changed: content.state /= Current
		end

feature {NONE} -- Implementation attributes.

	zone: SD_AUTO_HIDE_ZONE
			-- Zone which current is in.

	auto_hide_panel: SD_AUTO_HIDE_PANEL
			-- Auto hide panel which current is in.

	internal_tab_stub: SD_TAB_STUB
			-- Tab stub related to `internal_content'.

invariant

	internal_content_not_void: internal_content /= Void
	internal_shared_not_void: internal_shared /= Void
	internal_tab_stub_not_void: internal_tab_stub /= Void
	auto_hide_panel_not_void: auto_hide_panel /= Void
	direction_valid: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
		or direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right

end
