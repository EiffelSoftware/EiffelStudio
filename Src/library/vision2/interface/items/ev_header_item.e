indexing
	description: "Objects that represent EiffelVision2 header items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ITEM

inherit
	EV_ITEM
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXT_ALIGNABLE
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create, make_with_text

feature -- Access

	width: INTEGER is
			-- `Result' is width of `Current' used
			-- while parented.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.width
		ensure
			Result_non_negative: Result >= 0
		end

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_width
		ensure
			bridge_ok: Result = implementation.minimum_width
			positive_or_zero: Result >= 0
		end

	maximum_width: INTEGER is
			-- Upper bound on `width' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.maximum_width
		ensure
			bridge_ok: Result = implementation.maximum_width
			positive_or_zero: Result >= 0
		end

	user_can_resize: BOOLEAN is
			-- Can a user resize `Current'?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.user_can_resize
		ensure
			bridge_ok: Result = implementation.user_can_resize
		end

feature -- Status setting

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			not_destroyed: not is_destroyed
			width_non_negative: a_width >= 0
			width_greater_than_or_equal_to_minimum_width: a_width >= minimum_width
			width_less_than_or_equal_to_maximum_width: a_width <= maximum_width
		do
			implementation.set_width (a_width)
		ensure
			width_set: width = a_width
		end

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		require
			not_destroyed: not is_destroyed
			a_minimum_width_positive: a_minimum_width >= 0
			minimum_width_less_than_or_equal_to_maximum_width: minimum_width <= maximum_width
		do
			implementation.set_minimum_width (a_minimum_width)
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
		end

	set_maximum_width (a_maximum_width: INTEGER) is
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		require
			not_destroyed: not is_destroyed
			a_maximum_width_positive: a_maximum_width >= 0
			maximum_width_greater_than_or_equal_to_minimum_width: maximum_width >= minimum_width
		do
			implementation.set_maximum_width (a_maximum_width)
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
		end

	resize_to_content is
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented. Note that the width is still restricted to
			-- `minimum_width' and `maximum_width'.
		require
			not_destroyed: not is_destroyed
			parent_not_void: parent /= Void
		do
			implementation.resize_to_content
		end

	enable_user_resize is
			-- Permit `Current' from being resized by users.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_user_resize
		ensure
			user_can_resize: user_can_resize
		end

	disable_user_resize is
			-- Prevent `Current' from being resized by users.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_user_resize
		ensure
			not_user_can_resize: not user_can_resize
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and precursor {EV_TEXT_ALIGNABLE} and user_can_resize
			and minimum_width = 0 and maximum_width = 32000
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HEADER_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HEADER_ITEM_IMP} implementation.make (Current)
		end

invariant
	width_greater_than_or_equal_to_minimum_width: width >= minimum_width
	width_less_than_or_equal_to_maximum_width: width <= maximum_width
	minimum_width_less_than_or_equal_to_maximum_width: minimum_width <= maximum_width

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




end -- class EV_HEADER_ITEM

