note
	description:
		"[
			Press button for use with EV_TOOL_BAR
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON

inherit
	EV_TOOL_BAR_ITEM
		redefine
			implementation,
			is_in_default_state,
			parent
		end

	EV_TEXTABLE
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_TOOLTIPABLE
		undefine
			initialize
		redefine
			is_in_default_state,
			implementation
		end

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES
		redefine
			implementation
		end

	EV_DOCKABLE_SOURCE
		redefine
			is_in_default_state,
			implementation
		end

	EV_SENSITIVE
		redefine
			is_in_default_state,
			implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	parent: EV_TOOL_BAR
			-- Parent of the current item.
		do
			Result ?= Precursor {EV_TOOL_BAR_ITEM}
		end

	gray_pixmap: EV_PIXMAP
			-- Gray image displayed when the button is not hot
			-- i.e. when the mouse cursor is not over it.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.gray_pixmap
		ensure
			bridge_ok: (Result = Void and implementation.gray_pixmap = Void) or
				Result.is_equal (implementation.gray_pixmap)
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP)
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		require
			not_destroyed: not is_destroyed
			gray_pixmap_not_void: a_gray_pixmap /= Void
		do
			implementation.set_gray_pixmap (a_gray_pixmap)
		ensure
			pixmap_assigned: a_gray_pixmap.is_equal (gray_pixmap) and
							 gray_pixmap /= a_gray_pixmap
		end

	remove_gray_pixmap
			-- Make `gray_pixmap' `Void'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_gray_pixmap
		ensure
			gray_pixmap_remove: gray_pixmap = Void
		end

feature -- Obsolete

	align_text_left
			-- Display text left aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end

	align_text_center
			-- Display text center aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end

	align_text_right
			-- Display text right aligned
		obsolete "Was not implemented on all platforms."
		require
			not_destroyed: not is_destroyed
		do
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TOOL_BAR_ITEM}
				and Precursor {EV_TEXTABLE} and Precursor {EV_TOOLTIPABLE}
				and Precursor {EV_SENSITIVE} and Precursor {EV_DOCKABLE_SOURCE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TOOL_BAR_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TOOL_BAR_BUTTON_IMP} implementation.make (Current)
		end

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




end -- class EV_TOOL_BAR_BUTTON

