indexing
	description: "[
			SD_HOT_ZONE that draw feedback rectangle or triangle feedbacks (or transparent feedback or ...)
			 when user dragging a window for docking.
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Update feedback rectangle when user move pointer.
		deferred
		end

	update_for_pointer_position_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Update feedback indicator when user move pointer.
		deferred
		end

	update_for_pointer_position_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Clear indicator if pointer is out of area.
		deferred
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `Current' area will process `a_screen_x', `a_screen_y'?
		do
		end

	clear_indicator is
			-- Clear indicator.
		deferred
		end

	type: INTEGER
			-- Hot zone type.

	set_type (a_type: INTEGER) is
			-- Set `type'.
		require
			a_type_valid: a_type = {SD_SHARED}.type_tool or a_type = {SD_SHARED}.type_editor
		do
			type := a_type
		ensure
			set: type = a_type
		end

feature {NONE}

	need_clear: BOOLEAN
			-- If Current need clear indicator?

	clear_rect (a_orignal_pixmap: EV_PIXMAP; a_clear_rect: EV_RECTANGLE) is
			-- Clear a_clear_rect use a_orignal_pixmap.
		local
			l_screen: EV_SCREEN
			l_pixmap_for_clear: EV_PIXMAP
		do
			l_pixmap_for_clear := a_orignal_pixmap.sub_pixmap (a_clear_rect)
			create l_screen
			l_screen.draw_pixmap (a_clear_rect.x, a_clear_rect.y, l_pixmap_for_clear)
		end

	internal_shared: SD_SHARED
			-- All singletons.

	internal_zone: SD_ZONE
			-- SD_ZONE which `Current' belong to.

	internal_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator which Current is managed by.
invariant

	type_valid: type = {SD_SHARED}.type_editor or type = {SD_SHARED}.type_tool
	internal_shared_not_void: internal_shared /= Void

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
