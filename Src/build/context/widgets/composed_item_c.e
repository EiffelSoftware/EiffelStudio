indexing
	description: "Context that represent a composed item (EV_COMPOSED_ITEM)."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPOSED_ITEM_C

inherit
	ITEM_C
		redefine
			gui_object
		end

feature -- Status report

feature -- Status setting

feature -- Implementation

	gui_object: EV_COMPOSED_ITEM

end -- class COMPOSED_ITEM_C

