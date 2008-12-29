note
	description:
		"[
			Top level titled window. Contains a single widget.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			 __________________ 
			|`title'       _[]X|
			|------------------|
			|                  |
			|       item       |
			|__________________|
		]"
	status: "See notice at end of class."
	keywords: "window, title bar, title"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TITLED_WINDOW

inherit
	EV_WINDOW
		redefine
			implementation,
			create_implementation,
			initialize
		end

	EV_TITLED_WINDOW_ACTION_SEQUENCES
		redefine
			implementation
		end

create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize
   			-- Mark `Current' as initialized.
   			-- This must be called during the creation procedure
   			-- to satisfy the `is_initialized' invariant.
   			-- Descendants may redefine initialize to perform
   			-- additional setup tasks.
		do
			set_icon_pixmap (default_pixmaps.Default_window_icon)
			Precursor {EV_WINDOW}
		end

feature -- Access

	icon_name: STRING_32
			-- Name displayed when `Current is minimized.
			-- If `is_empty' then `title' is displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.icon_name
		ensure
			bridge_ok: equal (Result, implementation.icon_name)
			result_not_void: Result /= Void
			cloned: Result /= implementation.icon_name
		end

	icon_pixmap: EV_PIXMAP
			-- Window icon.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.icon_pixmap
		ensure
			bridge_ok: Result.is_equal (implementation.icon_pixmap)
		end

feature -- Status report

	is_minimized: BOOLEAN
			-- Is displayed iconified/minimised?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_minimized
		ensure
			bridge_ok: Result = implementation.is_minimized
		end

	is_maximized: BOOLEAN
			-- Is displayed at maximum size?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_maximized
		ensure
			bridge_ok: Result = implementation.is_maximized
		end

feature -- Status setting

	raise
			-- Request that window be displayed above all other windows
			-- (if `is_minimized', window is restored).
		require
			not_destroyed: not is_destroyed
		do
			implementation.raise
		end

	lower
			-- Request that window be displayed below all other windows.
		require
			not_destroyed: not is_destroyed
		do
			implementation.lower
		end

	minimize
			-- Display iconified/minimised.
			-- It is not possible to guarantee this on some
			-- platform configurations.
		require
			not_destroyed: not is_destroyed
			shown: is_show_requested
		do
			implementation.minimize
		ensure
			not_displayed: not is_displayed
		end

	maximize
			-- Display at maximum size.
		require
			not_destroyed: not is_destroyed
			shown: is_show_requested
		do
			implementation.maximize
		ensure
			is_maximized: is_maximized
		end

	restore
			-- Restore to original position when minimized or maximized.
		require
			not_destroyed: not is_destroyed
		do
			implementation.restore
		ensure
			minimize_restored: old is_minimized implies not is_minimized
			maximize_restored: old is_maximized implies not is_maximized
		end

feature -- Element change

	set_icon_name (an_icon_name: STRING_GENERAL)
			-- Assign `an_icon_name' to `icon_name'.
		require
			not_destroyed: not is_destroyed
			an_icon_name_not_void: an_icon_name /= Void
		do
			implementation.set_icon_name (an_icon_name)
		ensure
			icon_name_assigned: icon_name.is_equal (an_icon_name)
			cloned: icon_name /= an_icon_name
		end

	remove_icon_name
			-- Make `icon_name' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_icon_name ("")
		ensure
			icon_name_removed: icon_name.is_empty
		end


	set_icon_pixmap (an_icon: EV_PIXMAP)
			-- Assign `an_icon' to `icon'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: an_icon /= void
		do
			implementation.set_icon_pixmap (an_icon)
		ensure
			icon_pixmap_assigned: icon_pixmap.is_equal (an_icon)
		end

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_TITLED_WINDOW_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- Responsible for interaction with native graphics toolkit.
		do
			create {EV_TITLED_WINDOW_IMP} implementation.make (Current)
		end

invariant
	accelerators_not_void: is_usable implies accelerators /= Void

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




end -- class EV_TITLED_WINDOW

