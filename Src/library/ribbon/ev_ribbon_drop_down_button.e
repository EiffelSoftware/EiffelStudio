note
	description: "[
					The Drop-Down Button consists of a button that when clicked displays 
					a drop-down list of mutually exclusive items.
																						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_DROP_DOWN_BUTTON

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
