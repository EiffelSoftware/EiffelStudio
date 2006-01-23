indexing
	description:
		"[
			A window which does not appear in the task bar and is, by default, borderless.
			Useful for simulation of graphical elements such as tooltips and in-place editing.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW

inherit
	EV_WINDOW
		redefine
			implementation,
			create_implementation,
			user_can_resize_default_state,
			is_border_enabled_default_state
		end

feature {NONE} -- Contract support

	user_can_resize_default_state: BOOLEAN is
			-- Is the default state of `Current' `user_can_resize'?
		do
			Result := False
		end

	is_border_enabled_default_state: BOOLEAN is
			-- Is the default state of `Current' `is_border_enabled'?
		do
			Result := False
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_POPUP_WINDOW_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_POPUP_WINDOW_IMP} implementation.make (Current)
		end

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




end

