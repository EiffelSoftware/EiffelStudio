indexing
	description: "Objects that hold one or more children."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_PARENT_OBJECT
	
feature -- Access

	layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM is
			-- Representation of `object' used in GB_LAYOUT_CONSTRUCTOR.
		deferred
		end

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		deferred
		end
	
end -- class GB_CONTAINABLE_OBJECT
