note
	description: "EiffelVision popup window, implementation interface "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POPUP_WINDOW_I

inherit
	EV_WINDOW_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_POPUP_WINDOW note option: stable attribute end;

feature -- Access

	is_disconnected_from_window_manager: BOOLEAN
		-- Has `Current' been disconnected from the Window Manager meaning that
		-- its focus may only be controlled programatically.

	has_shadow: BOOLEAN
		-- Is `Current' created with a shadow?

feature -- Status Setting

	disconnect_from_window_manager
			-- Show popup window disconnected from Window manager.
			-- By default when shown the window will have full capture
			-- and be setup so that clicking on an area outside the window
			-- or pressing the Escape key will hide it.
		do
			is_disconnected_from_window_manager := True
		end

	initialize_with_shadow
			-- Initialize `Current' with a shadow.
		do
			has_shadow := True
			make
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




end









