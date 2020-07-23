note
	description: "Base class for C structures (structs and unions) array wrappers."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WRAPC_STRUCTURE_ARRAY [G -> MEMORY_STRUCTURE]

inherit

	WRAPC_ARRAY

feature -- Access

	item alias "[]" (i: INTEGER): G
			-- Address of the `i'-th item
		require
			exists: exists
			valid_index: is_valid_index (i)
		do
			Result := new_shared_structure_wrapper_from_pointer (array_address + (i * item_size))
		ensure
			item_address_not_default_pointer: Result /= Void
		end


feature {NONE} -- Implementation


	new_shared_structure_wrapper_from_pointer (a_pointer: POINTER): G
			-- Define this routine in your concrete struct array wrapper
			-- Use the `make_shared' create routine to create the struct.
		require
			a_pointer_not_default_pointer: a_pointer /= Default_pointer
		deferred
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
			result_wrapper_a_pointer: Result.item = a_pointer
		end

end
