note
	description: "Summary description for {WIZARD_PAGE_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_PAGE_ITEM

feature -- Access

	item_id: detachable READABLE_STRING_8
			-- Optional id to identify related page item.
		deferred
		end

end
