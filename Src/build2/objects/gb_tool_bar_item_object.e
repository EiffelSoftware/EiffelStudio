indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TOOL_BAR_ITEM_OBJECT

inherit
	GB_OBJECT
		redefine
			object, display_object
		end
		
create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_TOOL_BAR_ITEM
		-- A representation of `Current' used
		-- in the display_window.
	
	display_object: EV_TOOL_BAR_ITEM
		-- A representation of `Current' used
		-- in the builder_window

end -- class GB_TOOL_BAR_ITEM_OBJECT
