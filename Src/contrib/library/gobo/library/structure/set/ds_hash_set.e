note

	description:

		"Sets implemented with single arrays. Items are hashed %
		%using `hash_code' from HASHABLE by default."

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 1999-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class DS_HASH_SET [G -> HASHABLE]

inherit

	DS_ARRAYED_SPARSE_SET [G]
		redefine
			new_cursor
		end

create

	make,
	make_equal,
	make_default

feature -- Access

	new_cursor: DS_HASH_SET_CURSOR [G]
			-- New external cursor for traversal
		do
			create Result.make (Current)
		end

feature -- Hashing

	hash_function: KL_HASH_FUNCTION [G]
			-- Hash function to compute position in the container

	set_hash_function (a_hash_function: like hash_function)
			-- Set `hash_function' to `a_hash_function'.
		require
			empty: is_empty
		do
			hash_function := a_hash_function
		ensure
			hash_function_set: hash_function = a_hash_function
		end

feature {NONE} -- Implementation

	hash_position (v: G): INTEGER
			-- Hash position of `v' in `slots';
			-- Use `hash_function' as hashing function
			-- if not Void, `v.hash_code' otherwise.
		do
			if v /= Void then
				if hash_function /= Void then
					Result := hash_function.hash_code (v) \\ modulus
				else
					Result := v.hash_code \\ modulus
				end
			else
				Result := modulus
			end
		end

end
