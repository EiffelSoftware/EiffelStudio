note
	description: "Objects that wrap an Array of EventTypeSpec structs."
	author: "Eiffel.Mac Team"
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_TYPE_SPEC_ARRAY

inherit
	EWG_STRUCT_ARRAY[EVENT_TYPE_SPEC_STRUCT]
	
create
	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {NONE} -- Implementation
	new_shared_struct_wrapper_from_pointer (a_pointer: POINTER): EVENT_TYPE_SPEC_STRUCT
		do
			create Result.make_shared ( a_pointer )
		end
		
	item_size : INTEGER
			-- Size of one item
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct EventTypeSpec)"
		end

invariant
	invariant_clause: True -- Your invariant here

end
