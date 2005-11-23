indexing
	description: "SD_STATE which in SD_MULTI_DOCK_AREA."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_INNER_STATE

inherit
	SD_STATE
		redefine
			on_normal_max_window,
			close_window
		end

feature -- Redefine.

	on_normal_max_window is
			-- Redefine.
		local
			l_split_area: EV_SPLIT_AREA
			l_zone_widget: EV_WIDGET
		do
--			internal_shared.docking_manager.lock_update
--			main_area := internal_shared.docking_manager.inner_container (zone)
--			l_zone_widget ?= zone
--			check l_zone_widget /= Void end
--
--			if not is_maximized then
--				main_area_widget := main_area.item
--				internal_parent := l_zone_widget.parent
--				l_split_area ?= internal_parent
--				if l_split_area /= Void then
--					internal_parent_split_position := l_split_area.split_position
--				end
--				internal_parent.prune (l_zone_widget)
--				main_area.wipe_out
--				main_area.extend (l_zone_widget)
--				is_maximized := True
--			else
--				recover_to_normal_state
--			end
--			internal_shared.docking_manager.unlock_update
		end

	close_window is
			-- Redefine.
		do
--			internal_shared.docking_manager.lock_update
--			Precursor {SD_STATE}
--			if is_maximized then
--				main_area.extend (main_area_widget)
--				main_area := Void
--				internal_shared.docking_manager.remove_empty_split_area
--			end
--			internal_shared.docking_manager.unlock_update
		end

	recover_to_normal_state is
			-- Redefine.
		local
			l_zone_widget: EV_WIDGET
			l_split_area: EV_SPLIT_AREA
		do
--			if is_maximized then
--				internal_shared.docking_manager.lock_update
--				l_zone_widget ?= zone
--				check l_zone_widget /= Void end
--				main_area.wipe_out
--				internal_parent.extend (l_zone_widget)
--				main_area.extend (main_area_widget)
--				main_area := Void
--
--				l_split_area ?= internal_parent
--				if l_split_area /= Void then
--					l_split_area.set_split_position (internal_parent_split_position)
--				end
--				main_area_widget := Void
--				internal_parent := Void
--				is_maximized := False
--				internal_shared.docking_manager.unlock_update
--			end
		end

feature {SD_TAB_STATE} -- SD_TAB_STATE closing called functions.

--	set_maximized (a_is_maximized: BOOLEAN) is
--			-- Set `is_maximized'.
--		do
--			is_maximized := a_is_maximized
--		ensure
--			set: is_maximized = a_is_maximized
--		end
--
--	set_main_area_widget_main_area (a_widget: EV_WIDGET; a_main_area: SD_MULTI_DOCK_AREA) is
--			-- Set `main_area_widget'.
--		require
--			a_widget_not_void: a_widget /= Void
--			a_main_area_not_void: a_main_area /= Void
--			maximized: is_maximized
--		do
--			main_area_widget := a_widget
--			main_area := a_main_area
--		ensure
--			set: main_area_widget = a_widget
--			set: main_area = a_main_area
--		end

feature -- Query

	is_maximized: BOOLEAN
			-- If SD_ZONE managed by `Current' maximized?

feature {NONE}  -- Implementatin

--	internal_parent_split_position: INTEGER
--			-- Parent split position.
--
--	main_area_widget: EV_WIDGET
--			-- Other user widgets when `Current' is maximized.
--
--	internal_parent: EV_CONTAINER
--			-- Parent.
--
--	main_area: SD_MULTI_DOCK_AREA
--			-- SD_MULTI_DOCK_AREA current zone belong to.

invariant

	direction_valid: direction = {SD_DOCKING_MANAGER}.dock_top or direction = {SD_DOCKING_MANAGER}.dock_bottom
		or direction = {SD_DOCKING_MANAGER}.dock_left or direction = {SD_DOCKING_MANAGER}.dock_right

end
