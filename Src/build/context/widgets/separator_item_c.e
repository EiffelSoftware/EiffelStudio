indexing
	description: "Context that represents an separator item (EV_SEPARATOR_ITEM)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SEPARATOR_ITEM_C

inherit
	ITEM_C
		redefine
			gui_object
		end

feature -- Implementation

	gui_object: EV_SEPARATOR_ITEM

end -- class SEPARATOR_ITEM_C

