note
	description: "Summary description for {SD_FEEDBACK_RECT_I}."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_FEEDBACK_RECT_I

inherit
	EV_POPUP_WINDOW_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: SD_FEEDBACK_RECT
			-- <Precursor>

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
