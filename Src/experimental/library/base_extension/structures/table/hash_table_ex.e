note
	description: "Hash tables, used to store items identified by hashable keys using a EQUALITY_TESTER for comparison."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	warning: "[
		Modifying an object used as a key by an item present in a table will
		cause incorrect behavior. If you will be modifying key objects,
		pass a clone, not the object itself, as key argument to
		`put' and `replace_key'.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HASH_TABLE_EX [G, K -> HASHABLE]

inherit
	HASH_TABLE [G, K]
		redefine
			same_keys, copy, is_equal, empty_duplicate
		end

create
	make,
	make_with_key_tester

feature -- Initialization

	make_with_key_tester (n: INTEGER; a_key_tester: detachable EQUALITY_TESTER [K])
			-- Allocate hash table for at least `n' items with `a_key_tester' to compare keys.
			-- The table will be resized automatically if more than `n' items are inserted.
		require
			n_non_negative: n >= 0
		do
			key_tester := a_key_tester
			make (n)
		ensure
			breathing_space: n < capacity
			more_than_minimum: capacity > minimum_capacity
			key_tester_set: key_tester = a_key_tester
			no_status: not special_status
		end

feature -- Duplication

	copy (other: like Current)
			-- Re-initialize from `other'.
		do
			if other /= Current then
				Precursor {HASH_TABLE} (other)
			end
		end

feature {NONE} -- Duplication

	empty_duplicate (n: INTEGER_32): like Current
			-- <Precursor>
		do
			create Result.make_with_key_tester (n, key_tester)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does table contain the same information as `other'?
		do
			Result := Precursor {HASH_TABLE} (other) and key_tester ~ other.key_tester
		end

	same_keys (a_search_key, a_key: K): BOOLEAN
			-- If `key_tester' is attached, does `a_search_key' equal to `a_key' based on `key_tester'?
			-- Otherwise using ~.
		do
			if attached key_tester as l_tester then
				Result := l_tester.test (a_search_key, a_key)
			else
				Result := a_search_key ~ a_key
			end
		end

feature {HASH_TABLE_EX} -- Implementation

	key_tester: detachable EQUALITY_TESTER [K];
			-- Tester used for comparing keys.	

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
