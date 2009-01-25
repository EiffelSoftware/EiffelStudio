note
	description: "Window's client area device context."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIENT_DC

inherit
	WEL_DISPLAY_DC
		redefine
			destroy_item
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_window: WEL_WINDOW)
			-- Makes a DC associated with `a_window'
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			window := a_window
			hwindow := a_window.item
		ensure
			has_window: has_window
			window_set: window = a_window
		end

feature -- Access

	window: ?WEL_WINDOW
			-- Window associated with the device context

feature -- Status report

	has_window: BOOLEAN
			-- Is current associated with a window?
		local
			l_window: like window
		do
			l_window := window
			Result := l_window /= Void and then l_window.exists
		end

feature -- Basic operations

	get
			-- Get the device context
		do
			check has_window: has_window end
			item := cwin_get_dc (hwindow)
		end

	release
			-- Release the device context
		local
			a_default_pointer: POINTER
		do
			check has_window: has_window end
			unselect_all
			cwin_release_dc (hwindow, item)
			item := a_default_pointer
		end

	quick_release
			-- Release the device context
		local
			a_default_pointer: POINTER
		do
			check has_window: has_window end
			cwin_release_dc (hwindow, item)
			item := a_default_pointer
		end

feature {NONE} -- Implementation

	hwindow: POINTER
			-- Window handle associated with the device context

feature {NONE} -- Removal

	destroy_item
			-- Delete the current device context.
		local
			a_default_pointer: POINTER	-- Default_pointer
		do
				-- Protect the call to DeleteDC, because `destroy_item' can 
				-- be called by the GC so without assertions.
			if item /= a_default_pointer then
				unselect_all
				cwin_release_dc (hwindow, item)
				item := a_default_pointer
			end
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

end -- class WEL_CLIENT_DC
