indexing
	description: "A invisible control window used to store an%
		% unpositionnable window as a toolbar. This one is%
		% repositionned automatically. You can then put the%
		% window anywhere in another window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UNPOSITIONABLE_CONTROL_CONTAINER

inherit
	WEL_CONTROL_WINDOW
		rename
			make as control_make
		redefine
			on_size,
			on_wm_erase_background
		end

create
	make

feature {NONE} -- Initialization

		make (a_parent: WEL_COMPOSITE_WINDOW; a_window: WEL_WINDOW) is
			-- Make the window as a child of `a_parent' and
			-- `a_window' as window.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			control_make (a_parent, "WEL_UNPOSITIONABLE_CONTROL_CONTAINER")
			a_window.set_parent (Current)
			set_window (a_window)
		end

feature -- Access

	window: WEL_WINDOW
		-- window inside the container window

feature -- Element change

	set_window (a_window: WEL_WINDOW) is
			-- Make `a_window' the new `window'.
		do
			window := a_window
		end

feature {NONE} -- Implementation

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			window.resize (0, 0)
		end

	on_wm_erase_background (wparam: POINTER) is
			-- Wm_erasebkgnd message.
		do
			disable_default_processing
		end

invariant

	window_not_void: window /= Void
	window_exists: window.exists

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




end -- class WEL_UNPOSITIONNABLE_CONTROL_CONTAINER

