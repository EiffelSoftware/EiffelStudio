note
	description: "Desktop device context."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DESKTOP_DC

inherit
	WEL_DISPLAY_DC
		undefine
			destroy_item
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Makes a DC associated with the Desktop Window
		do
			hwindow := cwin_get_desktop_window
		end

feature -- Basic operations

	get
			-- Get the device context
		do
			item := cwin_get_dc (hwindow)
		end

	release
			-- Release the device context
		do
			unselect_all
			cwin_release_dc (hwindow, item)
			item := default_pointer
		end

	quick_release
		do
			cwin_release_dc (hwindow, item)
			item := default_pointer
		end

feature {NONE} -- Implementation

	hwindow: POINTER
			-- Window handle associated with the device context

feature {NONE} -- Removal

	destroy_item
		do
			unselect_all
			cwin_release_dc (hwindow, item)
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_get_desktop_window: POINTER
			-- SDK GetDesktopWindow
		external
			"C [macro <wel.h>]: EIF_POINTER"
		alias
			"GetDesktopWindow ()"
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




end -- class WEL_DESKTOP_DC

