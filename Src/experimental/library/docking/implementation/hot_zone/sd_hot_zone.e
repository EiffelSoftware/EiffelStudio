note
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

inherit
	SD_ACCESS

feature -- Commands

	apply_change (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- Apply change when user pointer stop dragging. It something changed, result is true
		deferred
		end

	update_for_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN
			-- Update feedback rectangle when user move pointer
		deferred
		end

	update_for_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- Update feedback indicator when user move pointer
		deferred
		end

	update_for_indicator_clear (a_screen_x, a_screen_y: INTEGER)
			-- Clear indicator if pointer is out of area
		deferred
		end

	has_x_y (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If `Current' area will process `a_screen_x', `a_screen_y'?
		do
		end

	clear_indicator
			-- Clear indicator
		deferred
		end

	build_indicator
			-- Build indicator
		deferred
		end

feature -- Query

	zone: SD_ZONE
			-- Attached `internal_zone'
		require
			set: is_zone_set
		local
			l_zone: like internal_zone
		do
			l_zone := internal_zone
			check l_zone /= Void end -- Implied by precondition `set'
			Result := l_zone
		end

	is_zone_set: BOOLEAN
			-- If `internal_zone' attached?
		do
			Result := internal_zone /= Void
		end

feature {NONE} -- Implementations

	need_clear: BOOLEAN
			-- If Current need clear indicator?

	internal_shared: SD_SHARED
			-- All singletons

	internal_zone: detachable SD_ZONE
			-- SD_ZONE which `Current' managed

	internal_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator which Current is managed by
invariant

	internal_shared_not_void: internal_shared /= Void

note
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
