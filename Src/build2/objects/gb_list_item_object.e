indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_LIST_ITEM_OBJECT

inherit
	GB_OBJECT
		redefine
			object, display_object
		end
		
create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_LIST_ITEM
		-- A representation of `Current' used
		-- in the display_window.
	
	display_object: EV_LIST_ITEM
		-- A representation of `Current' used
		-- in the builder_window

end -- class GB_LIST_ITEM_OBJECT