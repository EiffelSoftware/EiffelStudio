note
	description: "[
					Fack focus popup window which will let other EV_FAKE_FOCUS_GROUPABLEs looks like have focus
																												]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FAKE_FOCUS_POPUP_WINDOW

inherit
	EV_POPUP_WINDOW

	EV_FAKE_FOCUS_GROUPABLE
		undefine
			default_create,
			copy
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
