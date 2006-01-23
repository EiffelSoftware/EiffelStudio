indexing
	description:
		" EiffelVision Toolbar button, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_BUTTON_I

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_SENSITIVE_I
		redefine
			interface
		end
		
	EV_DOCKABLE_SOURCE_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES_I

feature -- Access

	gray_pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		require
			gray_pixmap_not_void: a_gray_pixmap /= Void
		deferred
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		deferred
		end
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	is_sensitive: BOOLEAN is
			-- Is `Current' sensitive?
		deferred
		end

feature {NONE} -- Implementation

	enable_sensitive is
			-- Enable sensitivity to user input events.
		deferred
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		deferred
		end

	parent_is_sensitive: BOOLEAN is
			-- Is `parent' sensitive?
		deferred
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		deferred
		end

	interface: EV_TOOL_BAR_BUTTON;

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




end -- class EV_TOOL_BAR_BUTTON_I

