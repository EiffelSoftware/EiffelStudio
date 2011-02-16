note
	description: "Summary description for {EV_RIBBON_SPLIT_BUTTON}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_SPLIT_BUTTON

inherit
	EV_RIBBON_BUTTON

feature -- Query

	buttons: detachable ARRAYED_LIST [EV_RIBBON_ITEM]
			-- All items in current group

end
