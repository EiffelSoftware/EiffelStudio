note
	description: "Set based on implementation of HASH_TABLE for fast lookup."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_TABLE [H -> HASHABLE]

inherit
	ANY
		redefine
			is_equal,
			copy
		end

	ITERABLE [H]
		redefine
			is_equal,
			copy
		end

create
	make,
	make_map,
	make_with_key_tester

feature {NONE} -- Creation

	make (n: INTEGER)
			-- Allocate hash table for at least `n' items using `~' for comparison.
			-- The table will be resized automatically if more than `n' items are inserted.
		require
			n_non_negative: n >= 0
		do
			make_with_key_tester (n, Void)
		ensure
			capacity_big_enough: capacity >= n
		end

	make_map (n: INTEGER)
			-- Allocate hash table for at least `n' items using `=' for comparison.
			-- The table will be resized automatically if more than `n' items are inserted.
		require
			n_non_negative: n >= 0
		do
			make_with_key_tester (n, Void)
			is_map := True
		ensure
			capacity_big_enough: capacity >= n
			is_map: is_map
		end

	make_with_key_tester (n: INTEGER; a_key_tester: detachable EQUALITY_TESTER [H])
			-- Allocate hash table for at least `n' items with `a_key_tester' to compare keys.
			-- If `a_key_tester' is void, it uses `~' for comparison.
			-- The table will be resized automatically if more than `n' items are inserted.
		require
			n_non_negative: n >= 0
		local
			default_value: detachable H
		do
			key_tester := a_key_tester
			capacity := (create {PRIMES}).higher_prime ((3 * n) // 2)
			if capacity < 5 then
				capacity := 5
			end
			create content.make_filled (default_value, capacity)
			create deleted_marks.make_filled (False, capacity)
			count := 0
			control := 0
			position := 0
			iteration_position := 0
			is_map := False
			found_item := default_value
		ensure
			capacity_big_enough: capacity >= n
			count_set: count = 0
		end

feature -- Access and queries

	item (key: H): detachable H
			-- Item associated with `key', if present
			-- otherwise default value of type `G'.
		require
			valid_key: valid_key (key)
		do
			internal_search (key)
			if control = Found_constant then
				Result := content.item (position)
			end
		end

	has (key: H): BOOLEAN
			-- Is `access_key' currently used?
			-- (Shallow equality.)
		require
			valid_key: valid_key (key)
		do
			if count > 0 then
				internal_search (key)
				Result := control = Found_constant
			end
		end

	key_at (n: INTEGER): detachable H
			-- Key corresponding to entry `n'.
		do
			if n >= 0 and n < content.count then
				Result := content.item (n)
			end
		end

	is_empty: BOOLEAN
			-- Is structure empty?
		do
			Result := count = 0
		end

	search (key: H)
			-- Search for item of key `key'.
			-- If found, set `found' to True, and set
			-- `found_item' to item associated with `key'.
		local
			default_value: detachable H
		do
			internal_search (key)
			if control = Found_constant then
				found_item := content.item (position)
			else
				found_item := default_value
			end
		ensure
			item_if_found: found implies (found_item = content.item (position))
		end

	go_to (c: like cursor)
			-- Move to position `c'.
		require
			valid_cursor: valid_cursor (c)
		do
			iteration_position := c
		end

	found_item: detachable H
			-- Item found during a search with `has' to reduce the number of
			-- search for clients.

	found: BOOLEAN
			-- Did last operation find the item sought?
		do
			Result := control = Found_constant
		end

	key_tester: detachable EQUALITY_TESTER [H]
			-- Tester used for comparing keys.

	new_cursor: SEARCH_TABLE_ITERATION_CURSOR [H]
			-- <Precursor>
		do
			create Result.make (Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does table contain the same information as `other'?
		local
			i, table_size: INTEGER
			current_key: detachable H
			local_content: like content
		do
			if Current = other then
				Result := True
			elseif count = other.count and then key_tester ~ other.key_tester then
				from
					local_content := content
					table_size := local_content.count
					Result := True
				until
					i >= table_size or not Result
				loop
					current_key := local_content.item (i)
					if current_key /= Void and then valid_key (current_key) then
						Result := other.has (current_key)
					end
					i := i + 1
				end
			end
		end

	disjoint (other: like Current): BOOLEAN
			-- Is `Current' and `other' disjoint on their keys?
			-- Use `same_keys' for comparison.
		do
			Result := is_empty or else other.is_empty or else not ∃ o: other ¦ has (o)
		end

	same_keys (a_search_key, a_key: H): BOOLEAN
			-- Does `a_search_key' equal to `a_key'?
			--| Default implementation is using ~.
		require
			valid_search_key: valid_key (a_search_key)
			valid_key: valid_key (a_key)
		do
			if attached key_tester as l_tester then
				Result := l_tester.test (a_search_key, a_key)
			else
				Result := a_search_key ~ a_key
			end
		end

feature -- Insertion, deletion

	put (key: H)
			-- Attempt to insert `new' with `key'.
			-- Set `control' to `Inserted' or `Conflict'.
			-- No insertion if conflict.
		require
			valid_key (key)
		do
			internal_search (key)
			if control = Found_constant then
				control := Conflict
			else
				if soon_full then
					add_space
					internal_search (key)
				end
				content.put (key, position)
				count := count + 1
				control := Inserted
			end
		ensure then
			insertion_done: control = Inserted implies item (key) = key
		end

	force (key: H)
			-- If `key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `key'.
			-- Set `control' to `Inserted'.
		require
			valid_key (key)
		do
			internal_search (key)
			if control /= Found_constant then
				if soon_full then
					add_space
					internal_search (key)
				end
				count := count + 1
			end
			content.put (key, position)
			control := Inserted
		ensure then
			insertion_done: item (key) = key
		end

	change_key (new_key: H; old_key: H)
			-- If table contains an item at `old_key',
			-- replace its key by `new_key'.
			-- Set `control' to `Changed', `Conflict' or `Not_found_constant'.
		require
			valid_keys: valid_key (new_key) and valid_key (old_key)
		do
			internal_search (old_key)
			if control = Found_constant then
				content.put (new_key, position)
				if control /= Conflict then
					remove (old_key)
					control := Changed
				end
			end
		ensure
			changed: control = Changed implies not has (old_key)
		end

	remove, prune (key: H)
			-- Remove item associated with `key', if present.
			-- Set `control' to `Removed' or `Not_found_constant'.
		require
			valid_key: valid_key (key)
		do
			internal_search (key)
			if control = Found_constant then
				content.fill_with_default (position, position)
				deleted_marks.put (True, position)
				count := count - 1
			end
		ensure
			not_has: not has (key)
		end

	wipe_out, clear_all
			-- Reset all items to default values.
		local
			default_value: detachable H
		do
			content.fill_with (default_value, {SPECIAL [detachable H]}.lower, content.upper)
			deleted_marks.fill_with (False, {SPECIAL [BOOLEAN]}.lower, deleted_marks.upper)
			count := 0
			control := 0
			position := 0
			found_item := default_value
		end

	merge (other: SEARCH_TABLE [H])
			-- Merge two search_tables.
		require
			other_not_void: other /= Void
		local
			local_other, local_current: like content
			new: like Current
			i, my_size, other_size: INTEGER
			current_key: detachable H
		do
			if other.count /= 0 then
				local_other := other.content
				local_current := content
				other_size := local_other.count
				my_size := local_current.count
				if (my_size + other_size) * Size_threshold <= 100 * count then
					from
						new := empty_duplicate (3 * (capacity + other_size) // 2)
					until
						i >= my_size
					loop
						current_key := local_current.item (i)
						if current_key /= Void and then valid_key (current_key) then
							new.put (current_key)
						end
						i := i + 1
					end
					content := new.content
					deleted_marks := new.deleted_marks
					capacity := new.capacity
				end
				from
					i := 0
				until
					i >= other_size
				loop
					current_key := local_other.item (i)
					if current_key /= Void and then valid_key (current_key) then
						put (current_key)
					end
					i := i + 1
				end
			end
		end

feature -- Resizing

	resize (n: INTEGER)
			-- Resize table to accommodate `n' elements.
		require
			n_non_negative: n >= 0
			n_greater_than_count: n >= count
		local
			i, table_size: INTEGER
			other: like Current
			local_content: like content
		do
			if content.count * Size_threshold <= 100 * n then
				from
					other := empty_duplicate (n)
					local_content := content
					table_size := local_content.count
				until
					i >= table_size
				loop
					if attached local_content.item (i) as current_key and then valid_key (current_key) then
						other.put (current_key)
					end
					i := i + 1
				end
				content := other.content
				deleted_marks := other.deleted_marks
				capacity := other.capacity
			end
		end

feature -- Number of elements

	count: INTEGER
			-- Number of items actually inserted in `Current'.

feature -- Duplication

	copy (other: like Current)
			-- Re-initialize from `other'.
		do
			standard_copy (other)
			content := other.content.twin
			deleted_marks := other.deleted_marks.twin
		end

feature {NONE} -- Duplication

	empty_duplicate (n: INTEGER): like Current
			-- Create an empty copy of Current that can accommodate `n' items.
		require
			n_non_negative: n >= 0
		do
			create Result.make_with_key_tester (n, key_tester)
		ensure
			empty_duplicate_not_void: Result /= Void
			same_key_tester: Result.key_tester = key_tester
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [H]
			-- Representation as a linear structure.
			-- (Order is same as original order of insertion.)
		local
			i, table_size: INTEGER
			l_content: like content
		do
			from
				l_content := content
				create Result.make (count)
				table_size := l_content.count - 1
			until
				i > table_size
			loop
				if attached l_content.item (i) as l_item and then valid_key (l_item) then
					Result.extend (l_item)
				end
				i := i + 1
			end
		ensure then
			Result_exists: Result /= Void
			good_count: Result.count = count
		end

feature {NONE} -- Internal features

	position: INTEGER
			-- Hash table cursor.

	internal_search (search_key: H)
			-- Search for item of `search_key'.
			-- If successful, set `position' to index
			-- of item with this key (the same index as the key's index).
			-- If not, set position to possible position for insertion.
			-- Set `control' to `Found_constant' or `Not_found_constant'.
		require
			good_key: valid_key (search_key)
		local
			increment, hash_code, table_size, pos: INTEGER
			first_deleted_position, visited_count: INTEGER
			old_key, default_key: detachable H
			stop: BOOLEAN
			local_content: like content
			local_deleted_marks: SPECIAL [BOOLEAN]
		do
				-- Per precondition
			check search_key_not_void: search_key /= Void end
			from
				local_content := content
				local_deleted_marks := deleted_marks
				first_deleted_position := -1
				table_size := capacity
				hash_code := search_key.hash_code
					-- Increment computed for no cycle: `table_size' is prime
				increment := 1 + hash_code \\ (table_size - 1)
				pos := (hash_code \\ table_size) - increment
			until
				stop or else visited_count >= table_size
			loop
				pos := (pos + increment) \\ table_size
				visited_count := visited_count + 1
				old_key := local_content.item (pos)
				if old_key = default_key or old_key = Void then
					if not local_deleted_marks.item (pos) then
						control := Not_found_constant
						stop := True
						if first_deleted_position >= 0 then
							pos := first_deleted_position
						end
					elseif first_deleted_position < 0 then
						first_deleted_position := pos
					end
				elseif is_map then
					if search_key = old_key then
						control := Found_constant
						stop := True
					end
				elseif same_keys (search_key, old_key) then
					control := Found_constant
					stop := True
				end
			end
			if not stop then
				control := Not_found_constant
				if first_deleted_position >= 0 then
					pos := first_deleted_position
				end
			end
			position := pos
		end

	add_space
			-- Double the capacity of `Current'.
			-- Transfer everything except deleted keys.
		do
			resize ((3 * capacity) // 2)
		end

	Size_threshold: INTEGER = 80
			-- Filling percentage over which some resizing is done.

	soon_full: BOOLEAN
			-- Is `Current' close to being filled?
			-- (If so, resizing is needed to avoid performance degradation.)
		do
			Result := content.count * Size_threshold <= 100 * count
		end

feature -- Assertion check

	valid_key (k: detachable H): BOOLEAN
			-- Is `k' a valid key?
		local
			l_default_key: detachable H
		do
			Result := k /= l_default_key
		ensure
			definition: Result implies k /= Void
		end

	valid_cursor (c: like cursor): BOOLEAN
			-- Can cursor be moved to position `c'?
		local
			l_default: detachable H
		do
			Result := (c >= capacity) or else (((c >= 0) and (c <= capacity)) and then content.item (c) /= l_default)
		end

feature {NONE} -- Status

	control: INTEGER
			-- Control code set by operations that may return
			-- several possible conditions.
			-- Possible control codes are the following:

	Inserted: INTEGER = 1
			-- Insertion successful.

	Found_constant: INTEGER = 2
			-- Key found.

	Changed: INTEGER = 3
			-- Change successful.

	Removed: INTEGER = 4
			-- Remove successful.

	Conflict: INTEGER = 5
			-- Could not insert an already existing key.

	Not_found_constant: INTEGER = 6
			-- Key not found.

	is_map: BOOLEAN
			-- Is current comparing keys using `='.

feature {SEARCH_TABLE, SEARCH_TABLE_ITERATION_CURSOR} -- Implementation: Access

	capacity: INTEGER
			-- Size of the table.

	deleted_marks: SPECIAL [BOOLEAN]
			-- Deleted marks.

	content: SPECIAL [detachable H]
			-- Content.

feature -- Iteration

	start
			-- Iteration initialization.
		do
			iteration_position := -1
			forth
		end

	forth
			-- Advance cursor to next occupied position,
			-- or `off' if no such position remains.
		require
			not_off: not off
		do
			iteration_position := next_iteration_position (iteration_position)
		end

	next_iteration_position (a_position: like iteration_position): like iteration_position
			-- Given an iteration position `a_position', compute the next one.
		local
			stop: BOOLEAN
			l_content: like content
			table_size: INTEGER
		do
			from
				l_content := content
				Result := a_position
				table_size := capacity - 1
			until
				stop
			loop
				Result := Result + 1
				stop := Result > table_size or else valid_key (l_content.item (Result))
			end
		end

	after, off: BOOLEAN
			-- Is the iteration cursor off?
		do
			Result := iteration_position > capacity - 1
		end

	item_for_iteration, key_for_iteration: H
			-- Item at cursor position.
		require
			not_off: not after
		do
			check attached content.item (iteration_position) as l_item then
				Result := l_item
			end
		end

	cursor: INTEGER
			-- Cursor.
		do
			Result := iteration_position
		end

feature {NONE} -- Iteration cursor

	iteration_position: INTEGER
			-- Iteration position value.

invariant
	count_big_enough: 0 <= count

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
