indexing
	description: "Context that represents a menu item holder (EV_MENU_ITEM_CONTAINER)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MENU_ITEM_HOLDER_C

inherit
	CONTEXT
		redefine
			gui_object
		end

	HOLDER_C
		redefine
			gui_object
		end

feature -- Implementation

	gui_object: EV_MENU_ITEM_HOLDER

end -- class MENU_ITEM_HOLDER_C

