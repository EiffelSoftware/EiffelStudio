indexing
	description: "EiffelVision popup window, GTK+ implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_POPUP_WINDOW_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		redefine
			interface,
			make,
			initialize,
			default_wm_decorations
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
		end

	initialize is
			-- Initialize `Current'.
		do
		end

feature {NONE} -- Implementation

	default_wm_decorations: INTEGER is
			-- Default Window Manager decorations of `Current'.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_POPUP_WINDOW;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

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




end -- class EV_POPUP_WINDOW_IMP

