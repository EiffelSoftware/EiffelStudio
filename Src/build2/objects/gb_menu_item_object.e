indexing
	description: "Objects that represent an EiffelBuild menu item."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_MENU_ITEM_OBJECT

inherit
	GB_OBJECT
		redefine
			object, display_object
		end
		
create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_MENU_ITEM
		-- A representation of `Current' used
		-- in the display_window.
	
	display_object: EV_MENU_ITEM
		-- A representation of `Current' used
		-- in the builder_window

end -- class GB_MENU_ITEM_OBJECT