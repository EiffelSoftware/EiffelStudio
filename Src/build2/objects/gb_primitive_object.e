indexing
	description: "GB_OBJECT representing an EV_PRIMITIVE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PRIMITIVE_OBJECT

inherit
	GB_OBJECT
		redefine
			object, display_object
		end

create
	make_with_type,
	make_with_type_and_object
	
feature -- Access

	object: EV_PRIMITIVE
		-- The vision2 object that `Current' represents.
	
	display_object: EV_PICK_AND_DROPABLE
		-- The representation of `object' used in `build_window'.

end -- class GB_CONTAINER_OBJECT
