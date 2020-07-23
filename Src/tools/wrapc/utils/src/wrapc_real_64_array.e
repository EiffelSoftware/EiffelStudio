note
	description: "Object representing a C double array"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_REAL_64_ARRAY

inherit

	WRAPC_ARRAY

create

	make_unshared,
	make_shared,
	make_new_unshared,
	make_new_shared

feature {ANY} -- Access

	item alias "[]" (i: INTEGER): REAL_64 assign put
			-- Return the address of the `i'-th item
		require
			exists: exists
			valid_index: is_valid_index (i)
		do
			Result := read_real_64 (i * item_size)
		end

	put (a_value: REAL_64; i: INTEGER)
			-- Put `a_value' at the `i'-th position in the array.
		require
			exists: exists
			valid_index: is_valid_index (i)
		do
			put_real_64 (a_value, i * item_size)
		ensure
			written: item (i) = a_value
		end

feature {NONE} -- Implementation

	item_size: INTEGER
			-- Size of one element
			-- In C thats: sizeof (void*)
		once
			Result := {PLATFORM}.real_64_bytes
		end

end
