indexing
	description: "Objects that remember restore information when is showing on SD_AUTO_HIDE_PANEL"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_STATE

inherit
	SD_STATE
		redefine
			show_window,
			close_window,
			stick_window,
			change_title
		end

create
	make,
	make_with_size

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_direction: INTEGER) is
			-- Let it dock at a_direciton
		require
			a_content_not_void: a_content /= Void
--			a_direction_valid: a_direction /= {SD_SHARED}.dock_in
		do
			create internal_shared
			internal_content := a_content
			internal_direction := a_direction
			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				internal_width_height := (internal_shared.docking_manager.internal_fixed.width * 0.2).ceiling
			else
				internal_width_height := (internal_shared.docking_manager.internal_fixed.height * 0.2).ceiling
			end

			if internal_direction = {SD_DOCKING_MANAGER}.dock_left then
				auto_hide_panel := internal_shared.docking_manager.auto_hide_panel_left
				create internal_tab_stub.make (internal_content.title, internal_content.pixmap, True)
			elseif internal_direction = {SD_DOCKING_MANAGER}.dock_right then
				auto_hide_panel := internal_shared.docking_manager.auto_hide_panel_right
				create internal_tab_stub.make (internal_content.title, internal_content.pixmap, True)
			elseif internal_direction = {SD_DOCKING_MANAGER}.dock_top then
				auto_hide_panel := internal_shared.docking_manager.auto_hide_panel_top
				create internal_tab_stub.make (internal_content.title, internal_content.pixmap, False)
			elseif internal_direction = {SD_DOCKING_MANAGER}.dock_bottom then
				auto_hide_panel := internal_shared.docking_manager.auto_hide_panel_bottom
				create internal_tab_stub.make (internal_content.title, internal_content.pixmap, False)
			end
			debug ("larry")
				io.put_string ("%N ************************** SD_AUTO_HIDE_STATE: insert tab stubs.")
			end
			internal_tab_stub.pointer_enter_actions.extend (agent show_window)
			auto_hide_panel.tab_stubs.extend (internal_tab_stub)

		end

	make_with_size (a_content: SD_CONTENT; a_direction: INTEGER; a_width_height: INTEGER) is
			--
		do
			make (a_content, a_direction)
			internal_width_height := a_width_height
		end

feature -- Basic operation


feature {NONE} -- Implementation
	zone: SD_AUTO_HIDE_ZONE
			-- Zone which current is in.

feature -- Perform Restore

	restore (a_content: SD_CONTENT; a_container: EV_CONTAINER) is
			--
		do
			-- This class can created by make (not like SD_DOCKING_STATE, created by INTERNAL), so this routine do less work.

--			dock_at_top_level ()
			change_state (Current)
		end

	record_state is
			--
		do
			if internal_direction = {SD_DOCKING_MANAGER}.dock_left or internal_direction = {SD_DOCKING_MANAGER}.dock_right then
				internal_width_height := zone.width
			else
				internal_width_height := zone.height
			end


		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Perform a restore. To make the window appear.
		do

		end

	show_window is
			-- Add zone which contain user widget.
		local
			l_rect: EV_RECTANGLE
--			l_timer: EV_TIMEOUT
		do
			internal_shared.docking_manager.lock_update
			if not internal_shared.docking_manager.has_zone_by_content (internal_content) then

				create zone.make (internal_content, internal_direction)
				-- Before add the zone to the fixed area, first clear the other zones in the area except the main_container.
				internal_shared.docking_manager.remove_auto_hide_zones

				internal_shared.docking_manager.add_zone (zone)

				-- First, put the zone in a viewport, make a animation here.

				internal_shared.docking_manager.internal_fixed.extend (zone)
				-- FIXIT: Below line is used when EV_FIXED removed contract.
--				create l_timer
--				l_timer.actions.extend (agent handle_timer (l_timer))
--				l_timer.set_interval (20)

				l_rect := internal_shared.docking_manager.container_rectangle

				if internal_direction = {SD_DOCKING_MANAGER}.dock_left or internal_direction = {SD_DOCKING_MANAGER}.dock_right then
					-- Slide here. not implemented.
					if internal_width_height > zone.minimum_width then
						internal_shared.docking_manager.internal_fixed.set_item_width (zone, internal_width_height)
					end



					if l_rect.height > zone.minimum_height then
						internal_shared.docking_manager.internal_fixed.set_item_height (zone, l_rect.height)
					end
				else
					if l_rect.width > zone.minimum_width then
						internal_shared.docking_manager.internal_fixed.set_item_width (zone, l_rect.width)
					end
					if internal_width_height > zone.minimum_height then
						internal_shared.docking_manager.internal_fixed.set_item_height (zone, internal_width_height)
					end
				end

				if internal_direction = {SD_DOCKING_MANAGER}.dock_left then
-- FIXIT: Below line is used when EV_FIXED removed contract.
--					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.left - zone.width, l_rect.top)
--					final_position := l_rect.left

					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.left, l_rect.top)
				elseif internal_direction = {SD_DOCKING_MANAGER}.dock_right then
--					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.right, l_rect.top)
--					final_position := l_rect.right - zone.width

					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.right - zone.width, l_rect.top)
				elseif internal_direction = {SD_DOCKING_MANAGER}.dock_top then
--					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.left, l_rect.top - zone.height)
--					final_position := l_rect.top

					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.left, l_rect.top)
				elseif internal_direction = {SD_DOCKING_MANAGER}.dock_bottom then
--					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.left, l_rect.bottom)
--					final_position := l_rect.bottom - zone.height

					internal_shared.docking_manager.internal_fixed.set_item_position (zone, l_rect.left, l_rect.bottom - zone.height)
				end

			end

			internal_shared.docking_manager.unlock_update
		end

	show_step: INTEGER is 6
			-- Step when tear-off window appear.

	final_position: INTEGER
			-- Final position when a tear-off window should at.

	handle_timer (a_timer: EV_TIMEOUT) is
			-- Use timer to play a animation.
		do

			inspect
				internal_direction
			when {SD_DOCKING_MANAGER}.dock_left then

					if zone.x_position + show_step >= final_position then
						a_timer.actions.wipe_out
						internal_shared.docking_manager.internal_fixed.set_item_position (zone, final_position, zone.y_position)
					else
						internal_shared.docking_manager.internal_fixed.set_item_position (zone, zone.x_position + show_step, zone.y_position)
					end

			when {SD_DOCKING_MANAGER}.dock_right then

			when {SD_DOCKING_MANAGER}.dock_top then

			when {SD_DOCKING_MANAGER}.dock_bottom then

			end

		end

	close_window is
			--
		do
			record_state
		end

	stick_window (a_direction: INTEGER) is
			-- `a_direction' is useless, it's only used for SD_DOCKING_STATE.
		local
			l_docking_state: SD_DOCKING_STATE
		do
			internal_shared.docking_manager.lock_update
			close_window
			internal_shared.docking_manager.remove_auto_hide_zones
			-- Remove tab stub from the SD_AUTO_HIDE_PANEL
			auto_hide_panel.tab_stubs.start
			auto_hide_panel.tab_stubs.prune (internal_tab_stub)

			-- Change the zone from SD_AUTO_HIDE_ZONE to SD_DOCKING_ZONE
			internal_shared.docking_manager.prune_zone_by_content (internal_content)
			-- Change the state.
			if internal_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				create l_docking_state.make (internal_content, internal_direction, zone.width - internal_shared.resize_bar_width_height)
			else
				create l_docking_state.make (internal_content, internal_direction, zone.height - internal_shared.resize_bar_width_height)
			end

			l_docking_state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
			change_state (l_docking_state)

			internal_shared.docking_manager.remove_empty_split_area
			internal_shared.docking_manager.unlock_update
		ensure then
			tab_stubs_pruned: auto_hide_panel.tab_stubs.count = old auto_hide_panel.tab_stubs.count - 1
		end

	change_title (a_title: STRING) is
			--
		do
			internal_tab_stub.set_title (a_title)
		end

feature -- Propoties

	set_auto_hide_panel (a_panel: SD_AUTO_HIDE_PANEL) is
			--
		do
			auto_hide_panel := 	a_panel
		end

feature {NONE} -- Implementation

--	show_window_animition

	internal_width_height: INTEGER
			-- The width and height when user close_window.

	auto_hide_panel: SD_AUTO_HIDE_PANEL
			-- Auto hide panel which current is in.

	internal_tab_stub: SD_TAB_STUB
			-- Tab stub related to `internal_content'.

end
