indexing
	description: "Objects that represent windows in a GB_WINDOW_SELECTOR"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WINDOW_SELECTOR_ITEM
	
inherit
	EV_TREE_ITEM

create
	make_with_object
	
feature {NONE} -- Initialization

	make_with_object (an_object: GB_TITLED_WINDOW_OBJECT) is
			-- Create `Current' and associate with `an_object'.
		require
			object_not_void: an_object /= Void
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			default_create
			if an_object.output_name.is_empty then
				set_text (an_object.short_type)
			else
				set_text (an_object.output_name)
			end
			object := an_object
			
				-- Assign the appropriate pixmap.
			create pixmaps
			set_pixmap (pixmaps.pixmap_by_name (object.type.as_lower))
			
				-- Set a pebble for transport
			set_pebble (object)
				
				-- Make `Current' available from `an_object'.
			an_object.set_window_selector_item (Current)
		ensure
			object_set: object = an_object
		end

feature -- Access

	object: GB_TITLED_WINDOW_OBJECT
		-- Object referenced by `Current'.

end -- class GB_WINDOW_SELECTOR_ITEM
