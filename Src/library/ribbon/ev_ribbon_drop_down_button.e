note
	description: "Summary description for {EV_RIBBON_DROP_DOWN_BUTTON}."
	author: ""
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
