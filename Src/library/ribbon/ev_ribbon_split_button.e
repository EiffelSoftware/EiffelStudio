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

end
