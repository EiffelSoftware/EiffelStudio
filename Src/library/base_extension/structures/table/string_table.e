note
	description: "[
		Hash tables, used to store items identified by string keys that are compared with our without case sensivity.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	warning: "[
		Modifying an object used as a key by an item present in a table will
		cause incorrect behavior. If you will be modifying key objects,
		pass a clone, not the object itself, or an immutable object, as key argument to
		`put' and `replace_key'.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_TABLE [G]

inherit
	HASH_TABLE [G, READABLE_STRING_GENERAL]
		redefine
			same_keys, hash_code_of
		end

create
	make, make_caseless

feature {NONE} -- Initialization

	make_caseless (n: INTEGER)
			-- Allocate hash table for at least `n' items.
			-- The table will be resized automatically
			-- if more than `n' items are inserted.
			-- Keys will be compared caseless.
		require
			n_non_negative: n >= 0
		do
			is_case_insensitive := True
			make (n)
		ensure
			breathing_space: n < capacity
			more_than_minimum: capacity > Minimum_capacity
			no_status: not special_status
			is_case_insensitive: is_case_insensitive
		end

feature -- Hash code

	hash_code_of (a_key: READABLE_STRING_GENERAL): INTEGER
			-- Hash code value
		local
			i, nb: INTEGER
			l_props: like character_properties
		do
			if is_case_insensitive then
					-- The magic number `8388593' below is the greatest prime lower than
					-- 2^23 so that this magic number shifted to the left does not exceed 2^31.
				from
					i := 1
					nb := a_key.count
					l_props := character_properties
				until
					i > nb
				loop
					Result := ((Result \\ 8388593) |<< 8) + l_props.to_lower (a_key.item (i)).code
					i := i + 1
				end
			else
				Result := a_key.hash_code
			end
		end

feature -- Status report

	is_case_insensitive: BOOLEAN
			-- Ignoring case when comparing keys?
			-- (Default: False)

feature -- Comparison

	same_keys (a_search_key, a_key: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_search_key' the same key as `a_key' ?
		do
			if is_case_insensitive then
				Result := a_search_key.is_case_insensitive_equal (a_key)
			else
				Result := a_search_key.same_string (a_key)
			end
		end

feature {NONE} -- Helper

	character_properties: CHARACTER_32_PROPERTY
			-- Helper for efficient case conversions.
		once
			create Result.make
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
