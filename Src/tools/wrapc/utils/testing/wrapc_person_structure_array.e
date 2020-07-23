note
	description: "Summary description for {WRAPC_PERSON_STRUCTURE_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_PERSON_STRUCTURE_ARRAY

inherit

	WRAPC_STRUCTURE_ARRAY [PERSON_STRUCT]

create

	make_unshared,
	make_shared,
	make_new_unshared,
	make_new_shared


feature --Measurement

	item_size: INTEGER
			-- Size of one element
			-- In C thats: sizeof (void*)
		once
			Result := {PERSON_STRUCT}.structure_size
		end


feature {NONE} -- Implementation

	new_shared_structure_wrapper_from_pointer (a_pointer: POINTER): PERSON_STRUCT
		do
			create Result.make_by_pointer (a_pointer)
		end

end
