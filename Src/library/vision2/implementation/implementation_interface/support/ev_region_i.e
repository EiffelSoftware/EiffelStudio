note
	description: "Implementation Interface for EV_REGION"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_REGION_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Element Change

	set_rectangle (a_rectangle: EV_RECTANGLE)
			-- Set region to area `a_rectangle'.
		require
			a_rect_not_void: a_rectangle /= Void
		deferred
		end

	offset (a_horizontal_offset, a_vertical_offset: INTEGER)
			-- Move `Current' a `a_horizontal_offset' horizontally and `a_vertical_offset' vertically.
		deferred
		end

feature -- Access

	intersect (a_region: EV_REGION): EV_REGION
			-- Intersection of `a_region' with `Current' .
		require
			a_region_not_void: a_region /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

	union (a_region: EV_REGION): EV_REGION
			-- Union of `a_region' with `Current'.
		require
			a_region_not_void: a_region /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

	subtract (a_region: EV_REGION): EV_REGION
			-- `a_region' subtracted from `Current'.
		require
			a_region_not_void: a_region /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

	exclusive_or (a_region: EV_REGION): EV_REGION
			-- Exclusive or of `a_region' with `Current'
		require
			a_region_not_void: a_region /= Void
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Duplication

	copy_region (other: EV_REGION)
			-- Update `Current' to be the same as `other'.
		deferred
		end

feature -- Comparison

	is_region_equal (other: EV_REGION): BOOLEAN
			-- Does `other' have the same appearance as `Current'.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_REGION;
		-- Interface object for `Current'.

note
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
