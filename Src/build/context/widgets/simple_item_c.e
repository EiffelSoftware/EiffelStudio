indexing
	description: "Context that represents an item (EV_SIMPLE_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIMPLE_ITEM_C

inherit
	ITEM_C
		redefine
			gui_object
		end

feature -- Status report

feature -- Status setting

feature -- Implementation

	gui_object: EV_SIMPLE_ITEM

end -- class SIMPLE_ITEM_C

