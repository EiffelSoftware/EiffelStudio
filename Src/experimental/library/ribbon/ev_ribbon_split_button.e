note
	description: "[
					The Split Button is a composite control with which the user can select a
					default value bound to a primary button, or select from a list of mutually
					exclusive values displayed in a drop-down list bound to a secondary button.
																								]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_SPLIT_BUTTON

inherit
	EV_RIBBON_BUTTON

feature -- Query

	buttons: ARRAYED_LIST [EV_RIBBON_ITEM]
			-- All items in current group

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
