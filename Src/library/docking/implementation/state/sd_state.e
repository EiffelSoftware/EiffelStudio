indexing
	description: "Objects that represent the states which used for restore, can change window layout. A state pattern."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_STATE

feature -- Properties

	content: like internal_content is
			-- `internal_content'
		do
			Result := internal_content
		end

	set_content (a_content: like internal_content) is
			-- Set a_content.
		do
			internal_content := a_content
		end

	direction: like internal_direction is
			-- `internal_direction'
		do
			Result := internal_direction
		end

	set_direction (a_direction: INTEGER) is
			--
		do
			internal_direction := a_direction
		end


	zone: SD_ZONE is
			-- Zone which is managed by `Current'.
		deferred
		ensure
			not_void: Result /= Void
		end

feature {SD_CONFIG}

	restore (a_content: SD_CONTENT; a_container: EV_CONTAINER) is
			--
		deferred
		end

feature {NONE} -- Implementation

	internal_content: SD_CONTENT

	internal_direction: INTEGER
			-- Dock top or dock bottom or dock left or dock right?
	internal_shared: SD_SHARED
			-- All singletons.

feature -- Commands

	record_state is
			-- Record current state.
		deferred
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA) is
			-- Perform a restore.
		require
			internal_content_not_void: not content_void
		deferred
		end

	show_window is
			-- Show window.
		do
		end

	close_window is
			-- When close window, do this.
		do

			internal_shared.docking_manager.prune_zone_by_content (internal_content)
			if internal_content.internal_close_actions /= Void then
				internal_content.internal_close_actions.call ([])
			end
			internal_shared.docking_manager.remove_empty_split_area
		end

	min_max_window is
			--
		do

		end

	stick_window (a_direction: INTEGER) is
			-- Stick/Unstick a window.
--		require
--			a_direction_valid: internal_shared.direction_valid (a_direction)
		do
		end

	float_window (a_x, a_y: INTEGER) is
			-- Make current window floating.
		do
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER) is
			--
		require
			a_target_zone_not_void: a_target_zone /= Void
--			a_direction_valid: direction_valid (a_direction)
		do
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE) is
			-- Move to a SD_DOCKING_ZONE, then a_target_zone and `Current' became SD_TAB_ZONE.
		require
			a_target_zone_not_void: a_target_zone /= Void
		do

		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE) is
			--
		require
			a_target_zone_not_void: a_target_zone /= Void
		do

		end


feature {SD_CONTENT} -- Called by client programmer from SD_CONTENT.

	change_title (a_title: STRING; a_content: SD_CONTENT) is
			--
		require
			a_title_not_void: a_title /= Void
		do
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			--
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
		end

feature  -- States report

	content_void: BOOLEAN is
			-- If current a_content void?
		do
			Result := internal_content = Void
		end

feature {NONE} -- State changing

	change_state (a_state: SD_STATE) is
			-- Changed the resotre base on different states.
		do
			internal_content.change_state (a_state)
		end

feature {SD_DOCKING_MANAGER} -- Save/open config issues.

	store_data (a_data: SD_CONFIG_DATA) is
			--
		do

		end

end
