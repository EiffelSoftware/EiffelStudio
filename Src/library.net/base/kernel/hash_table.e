indexing
	external_name: "ISE.Base.HashTable"

class
	HASH_TABLE [G, H]

inherit
	FINITE [G]
		rename
			has as has_item
		undefine
			is_equal
		end

	TABLE [G, H]
		undefine
			is_equal
		end

creation
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate hash table for at least `n' items.
			-- The table will be resized automatically
			-- if more than `n' items are inserted.
		local
			table_size: INTEGER
		do
			table_size := higher_prime ((High_ratio * n) // Low_ratio);
			if table_size < Minimum_size then
				table_size := Minimum_size
			end;
			create internal_implementation.make_1 (table_size)
		ensure
--			keys_big_enough: keys.capacity >= n and keys.capacity >= Minimum_size;
--			content_big_enough: content.capacity >= n and content.capacity >= Minimum_size;
--			deleted_marks_big_enough: deleted_marks.capacity >= n and deleted_marks.capacity >= Minimum_size
		end;

feature -- Access

	item, infix "@" (key: H): G is
			-- Item associated with `key', if present;
			-- otherwise default value of type `G'
		do
			Result ?= internal_implementation.get_item (key)
		end;

	has (key: H): BOOLEAN is
			-- Is there an item in the table with key `key'?
		local
			default_value: G
		do
			Result := internal_implementation.has (key)
			if Result then
				found_item ?= internal_implementation.get_item (key)
			else
				found_item := default_value
			end
		end

	has_item (v: G): BOOLEAN is
			-- Does structure include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.
			-- if True use `is_equal' else
			-- `reference_equal')
		local
			i, bound: INTEGER
		do
			bound := current_keys.upper
			if object_comparison then
				Result := internal_implementation.contains_value (v)
			else
				from
				until
					i > bound or else Result
				loop
					Result := reference_equal (internal_implementation.get_item (key_at (i)), v)
					i := i + 1
				end
			end
		end;

	key_at (n: INTEGER): H is
			-- Key corresponding to entry `n'
		do
			if n >=0 and n < current_keys.count then
				Result := current_keys.item (n);
			end;
		end;

	current_keys: ARRAY [H] is
			-- Array of actually used keys, from 1 to `count'
			local
			i, j, table_size: INTEGER;
			scanned_key: H
			local_keys: ARRAY [H]
		do
			create Result.make (internal_implementation.get_count)
			internal_implementation.get_keys.copy_to (Result, 0)
		ensure
			good_count: Result.count = count
 		end;

	dead_key: H is
			-- Special key used to mark deleted items
		do
		end

	found_item: G
			-- Item found during a search with `has' to reduce the number of
			-- search for clients

	item_for_iteration: G is
			-- Element at current iteration position
		require
			not_off: not off
		do
			Result ?= internal_implementation.get_dictionary_enumerator.get_value
		end;

	key_for_iteration: H is
			-- Key at current iteration position
		require
			not_off: not off
		do
			Result ?= internal_implementation.get_dictionary_enumerator.get_key
		end;

feature -- Measurement

	count, capacity: INTEGER is
			-- Number of items in table
		do
			Result := internal_implementation.get_count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does table contain the same information as `other'?
		do
			Result := implementation.is_equal (other.implementation)
		end;

feature -- Status report

	object_comparison: BOOLEAN is
			-- Must search operations use `equal' rather than `='
			-- for comparing references? (Default: no, use `='.)
		do
			Result := internal_object_comparison
		end

	full: BOOLEAN is
			-- Is structured filled to capacity? (Answer: no.)
		do
			Result := False
		end

	extendible: BOOLEAN is
			-- May new items be added? (Answer: yes.)
		do
			Result := True
		end

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := True
		end;

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
			-- Answer: yes if and only if `k' is not the default
			-- value of type `H'.
		local
			dkey: H
		do
			Result := k /= dkey
		ensure then
			Result = (k /= dead_key)
		end

	conflict: BOOLEAN
			-- Did last operation cause a conflict?

	inserted: BOOLEAN
			-- Did last operation insert an item?

	replaced: BOOLEAN
			-- Did last operation replace an item?

	removed: BOOLEAN
			-- Did last operation remove an item?

	found: BOOLEAN
			-- Did last operation find the item sought?

	after, off: BOOLEAN is
			-- Is cursor past last item?
		do
			Result := internal_after
		end;

	search (key: H) is
			-- Search for item of key `key'
			-- If found, set `found' to True, and set
			-- `found_item' to item associated with `key'.
		do
			reset
			found := has (key)
		ensure
			found_or_not_found: found or not found
			item_if_found: found implies (found_item = internal_implementation.get_item (key)) 
		end

	is_inserted (v: G): BOOLEAN is
			-- Has `v' been inserted by the most recent insertion?
			-- (By default, the value returned is equivalent to calling
			-- `has_item (v)'. However, descendants might be able to provide more
			-- efficient implementations.)
		do
			Result := has_item (v)
		end
		
	is_empty: BOOLEAN is
			-- Is there no element?
		do
			Result := (count = 0)
		end

	changeable_comparison_criterion: BOOLEAN is
			-- May `object_comparison' be changed?
			-- (Answer: yes by default.)
		do
			Result := True
		end

feature -- Status report

	compare_objects is
			-- Ensure that future search operations will use `equal'
			-- rather than `=' for comparing references.
		do
			internal_object_comparison := True
		end

	compare_references is
			-- Ensure that future search operations will use `='
			-- rather than `equal' for comparing references.
		do
			internal_object_comparison := False
		end

feature -- Cursor movement

	start is
			-- Bring cursor to first position.
		do
			internal_implementation.get_dictionary_enumerator.Reset
			forth
		end;

	forth is
			-- Advance cursor by one position.
		require
			not_off: not off
		local
			moved: BOOLEAN
		do
			internal_after := internal_implementation.get_dictionary_enumerator.move_next
		end;

feature -- Element change

	put (new: G; key: H) is
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
			-- Make `inserted' true if and only if an insertion has
			-- been made (i.e. `key' was not present).
		do
			internal_implementation.extend (key, new)
			reset
			conflict := not has (key) or not has_item (new)
			inserted := has (key) and has_item (new)
		ensure then
			insertion_done: inserted implies item (key) = new
		end;

	replace (new: G; key: H) is
			-- Replace item at `key', if present,
			-- with `new'; do not change associated key.
			-- Make `replaced' true if and only if a replacement has
			-- been made (i.e. `key' was present).
		require
			valid_key (key)
		do
			reset
			if has (key) then
				internal_implementation.put_i_th (key, new)
				check
					has (key) and has_item (new)
				end
				replaced := True
			end
		ensure
			insertion_done: replaced implies item (key) = new
		end;

	force (new: G; key: H) is
			-- If `key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `key'.
			-- Make `inserted' true.
		require else
			valid_key (key);
		do
			internal_implementation.put_i_th (key, new)
			reset
			inserted := True
		ensure then
			insertion_done: item (key) = new
		end;

	replace_key (new_key: H; old_key: H) is
			-- If table contains an item at `old_key',
			-- replace its key by `new_key'.
			-- Make `replaced' true if and only if a replacement has
			-- been made (i.e. `old_key' was present).
		require
			valid_keys: valid_key (new_key) and valid_key (old_key)
		local
			dead_item, current_item: G;
		do
			reset
			if has (old_key) then
				current_item ?= internal_implementation.get_item (old_key)
				put (current_item, new_key);
				put (dead_item, old_key)
				conflict := not has (new_key)
				replaced := has (new_key)
			end
		ensure
			changed: replaced implies not has (old_key)
		end;

feature -- Removal

	remove (key: H) is
			-- Remove item associated with `key', if present.
			-- Make `removed' true if and only if an item has been
			-- removed (i.e. `key' was not present).
		require
			valid_key: valid_key (key)
		do
			reset
			if has (key) then
				internal_implementation.remove (key)
			end
			removed := not has (key)
		ensure
			removed: not has (key)
		end;

	wipe_out, clear_all is
			-- Reset all items to default values.
		local
			default_value: G
		do
			internal_implementation.clear
			found_item := default_value
		end;

feature -- Conversion
		
	linear_representation: LINEAR [G] is
--	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (order is same as original order of insertion)
		local
			i: INTEGER
			local_content: ARRAY [G]
--			local_result: ARRAYED_LIST [G]
		do
--			create local_content.make (count)
--			internal_implementation.values.copy_to (local_content, 0)
--			create local_result.make (count)
--			from
--				i := 1
--			until
--				i > count
--			loop
--				if valid_key (current_keys.get_item (i)) then
--					local_result.extend (local_content.get_item(i))
--				end				
--			end
--			Result := local_result
--		ensure then
--			Result_exists: Result /= Void;
----			good_count: Result.count = count
		end;

feature -- Duplication

	copy (other: like Current) is
			-- Re-initialize from `other'.
		do
			internal_implementation ?= other.internal_implementation.Clone
		end;


feature {NONE} -- Inapplicable

	fill (other: CONTAINER [G]) is
			-- Fill with as many items of `other' as possible.
			-- The representations of `other' and current structure
			-- need not be the same.
		do
		end
		
	extend (v: G) is
			-- Insert a new occurrence of `v'
		do
		end;

feature {NONE} -- Implementation

	internal_after: BOOLEAN

	Minimum_size : INTEGER is 5;

	High_ratio : INTEGER is 3;

	Low_ratio : INTEGER is 2;

	Smallest_prime: INTEGER is 2;

	Smallest_odd_prime: INTEGER is 3;

	higher_prime (n: INTEGER): INTEGER is
			-- Lowest prime greater than or equal to `n'
		do
			if n <= Smallest_prime then
				Result := Smallest_prime
			else
					check
						n > Smallest_prime
					end
				from
					if n \\ Smallest_prime = 0 then
							-- Make sure that `Result' is odd
						Result := n + 1
					else
						Result := n
					end
				until
					is_prime (Result)
				loop
					Result := Result + Smallest_prime
				end
			end
		end;

	is_prime (n: INTEGER): BOOLEAN is
			-- Is `n' a prime number?
		local
			divisor: INTEGER
		do
			if n <= 1 then
				Result := false
			elseif n = Smallest_prime then
				Result := true
			elseif n \\ Smallest_prime /= 0 then
				from
					divisor := Smallest_odd_prime
				until
					(n \\ divisor = 0) or else (divisor * divisor >= n)
				loop
					divisor := divisor + Smallest_prime
				end;
				if divisor * divisor > n then
					Result := true
				end
			end
		end

	reset is
			-- Reset attributes to false.
		do
			conflict := False
			inserted := False
			replaced := False
			removed := False
			found := False
		end

feature -- Implementation

--	implementation: SYSTEM_COLLECTIONS_HASHTABLE is
	implementation: SYSTEM_COLLECTIONS_ICOLLECTION is
			-- Object for .NET access and implementation
		do
			Result := internal_implementation
		end
			
feature {HASH_TABLE} -- Implementation

	internal_implementation: SYSTEM_COLLECTIONS_HASHTABLE
	
	internal_object_comparison: BOOLEAN

invariant

	count_big_enough: 0 <= count

end -- class HASH_TABLE
