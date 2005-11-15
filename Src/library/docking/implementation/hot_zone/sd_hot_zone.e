indexing
	description: "[
			Objects that draw shadow rectangle (like Visual Studio 2003) or triangle
			(like Visual Studio 2005) feedback when user dragging a window for docking.
																						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_HOT_ZONE



feature -- Commands

	apply_change (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Apply change when user dragging a window on a position. It something changed, result is true.
		require
			caller_not_void: caller /= Void
		deferred
		end

	update_for_pointer_position (a_mediator: SD_DOCKER_MEDIATOR; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Update feedback when user move the mouse.
		deferred
		end

	pointer_out is
			--
		do
			internal_shared.feedback.clear_screen
			internal_pointer_last_in_area := internal_pointer_outside
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `Current' area has pointer position `a_screen_x', `a_screen_y'.
		do
		end

	type: INTEGER is
			--
		do
			Result := {SD_SHARED}.type_normal
		end

	set_type (a_type: INTEGER) is
			--
		require
			a_type_valid: a_type = {SD_SHARED}.type_normal or a_type = {SD_SHARED}.type_editor
		do
			internal_type := a_type
		end

feature {NONE}
	internal_shared: SD_SHARED
			-- All singletons.

	internal_type: INTEGER
			-- Type of `Current'. One value from SD_SHARED.

	internal_zone: SD_ZONE
			-- SD_ZONE which `Current' belong to.

	internal_mediator: SD_DOCKER_MEDIATOR


feature {NONE} -- Implementation for draw feedback

	internal_pointer_last_in_area: INTEGER
			-- Pointer in which area last time?

	internal_pointer_outside: INTEGER is 0
	internal_pointer_in_top_area: INTEGER is 1
	internal_pointer_in_bottom_area: INTEGER is 2
	internal_pointer_in_left_area: INTEGER is 3
	internal_pointer_in_right_area: INTEGER is 4
	internal_pointer_in_main_area: INTEGER is 5
			-- Main area is the area outside top, bottom, left, right but in `Current' area.

end
