note
	description: "Objects that represent EiffelVision2 header items. Implementation Interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HEADER_ITEM_I

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_TEXT_ALIGNABLE_I
		redefine
			interface
		end

feature -- Access

	user_can_resize: BOOLEAN
			-- Can a user resize `Current'?
		deferred
		end

	maximum_width: INTEGER
			-- Upper bound on `width' in pixels.
		deferred
		ensure
			positive_or_zero: Result >= 0
		end

feature -- Status setting

	set_width (a_width: INTEGER)
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
		deferred
		ensure
			width_set: width = a_width
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		require
			a_minimum_width_positive: a_minimum_width >= 0
		deferred
		ensure
			minimum_width_assigned: minimum_width = a_minimum_width
		end

	set_maximum_width (a_maximum_width: INTEGER)
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		require
			a_maximum_width_positive: a_maximum_width >= 0
		deferred
		ensure
			maximum_width_assigned: maximum_width = a_maximum_width
		end

	resize_to_content
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		require
			parent_not_void: parent /= Void
		deferred
		end

	enable_user_resize
			-- Permit `Current' from being resized by users.
		deferred
		ensure
			user_can_resize: user_can_resize
		end

	disable_user_resize
			-- Prevent `Current' from being resized by users.
		deferred
		ensure
			not_user_can_resize: not user_can_resize
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_HEADER_ITEM note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_HEADER_ITEM_I








