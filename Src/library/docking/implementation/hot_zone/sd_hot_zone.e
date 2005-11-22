indexing
	description: "[
			SD_HOT_ZONE that draw feedback rectangle or triangle feedbacks (or transparent feedback or ...)
			 when user dragging a window for docking.
																						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_HOT_ZONE

feature -- Commands

	apply_change (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Apply change when user pointer stop dragging. It something changed, result is true.
		require
			caller_not_void: caller /= Void
		deferred
		end

	update_for_pointer_position (a_mediator: SD_DOCKER_MEDIATOR; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Update feedback when user move pointer.
		require
			a_mediator_not_void: a_mediator /= Void
		deferred
		end

	pointer_out is
			-- Handle pointer outside `Current'.
		do
			internal_shared.feedback.clear_screen
			internal_pointer_last_in_area := internal_pointer_outside
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `Current' area will process `a_screen_x', `a_screen_y'?
		do
		end

	type: INTEGER
			-- Hot zone type.

	set_type (a_type: INTEGER) is
			-- Set `type'.
		require
			a_type_valid: a_type = {SD_SHARED}.type_normal or a_type = {SD_SHARED}.type_editor
		do
			type := a_type
		ensure
			set: type = a_type
		end

feature {NONE}

	internal_shared: SD_SHARED
			-- All singletons.

	internal_zone: SD_ZONE
			-- SD_ZONE which `Current' belong to.

	internal_mediator: SD_DOCKER_MEDIATOR

feature {NONE} -- Implementation for draw feedback

	internal_pointer_last_in_area: INTEGER
			-- Pointer in which area last time?

	internal_pointer_outside: INTEGER is 0
			-- Pointer is outside.
	internal_pointer_in_top_area: INTEGER is 1
			-- Pointer is in top area.
	internal_pointer_in_bottom_area: INTEGER is 2
			-- Pointer is in bottom area.
	internal_pointer_in_left_area: INTEGER is 3
			-- Pointer is in left area.
	internal_pointer_in_right_area: INTEGER is 4
			-- Pointer is in right area.
	internal_pointer_in_main_area: INTEGER is 5
			-- Pointer is in main area.

invariant

	type_valid: type = {SD_SHARED}.type_editor or type = {SD_SHARED}.type_normal
end
