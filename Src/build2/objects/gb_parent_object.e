indexing
	description: "Objects that hold one or more children."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_PARENT_OBJECT
	
inherit
	GB_OBJECT
	
feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM} -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		require
			correct_type: accepts_child (an_object.type)
		deferred
		end
	
end -- class GB_CONTAINABLE_OBJECT
