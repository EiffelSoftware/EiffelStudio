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

end
