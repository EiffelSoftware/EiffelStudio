indexing
	description: "Hash tables, used to store items identified by hashable keys"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class HASH_TABLE [G, H -> HASHABLE] inherit

	UNBOUNDED [G]
		rename
			has as has_item
		redefine
			has_item, copy, is_equal
		end

	TABLE [G, H]
		rename
			has as has_item
		export
			{NONE} prune_all
		redefine
			copy, is_equal, wipe_out, has_item
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate hash table for at least `n' items.
			-- The table will be resized automatically
			-- if more than `n' items are inserted.
		local
			clever: PRIMES
			table_size: INTEGER
			l_content: ARRAY [G]
			l_keys: ARRAY [H]
			l_deleted_marks: ARRAY [BOOLEAN]
		do
			create clever
			table_size := clever.higher_prime ((High_ratio * n) // Low_ratio)
			if table_size < Minimum_size then
				table_size := Minimum_size
			end
			create l_content.make (0, table_size - 1)
			content := l_content.area
			create l_keys.make (0, table_size - 1)
			keys := l_keys.area
			create l_deleted_marks.make (0, table_size - 1)
			deleted_marks := l_deleted_marks.area
			iteration_position := table_size
		ensure
			keys_big_enough: keys.capacity >= n and keys.capacity >= Minimum_size
			content_big_enough: content.capacity >= n and content.capacity >= Minimum_size
			deleted_marks_big_enough: deleted_marks.capacity >= n and deleted_marks.capacity >= Minimum_size
		end

feature -- Access

	item, infix "@" (key: H): G is
			-- Item associated with `key', if present;
			-- otherwise default value of type `G'
		local
			old_control: INTEGER
		do
			old_control := control
			internal_search (key)
			if control = Found_constant then
				Result := content.item (position)
			end
			control := old_control
		end

	has (key: H): BOOLEAN is
			-- Is there an item in the table with key `key'?
		require
			valid_key: valid_key (key)
		local
			old_control: INTEGER
			default_value: G
		do
			old_control := control
			internal_search (key)
			Result := (control = Found_constant)
			if Result then
				found_item := content.item (position)
			else
				found_item := default_value
			end
			control := old_control
		end

	has_item (v: G): BOOLEAN is
			-- Does structure include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			i, bound: INTEGER
			l_content: like content
		do
			l_content := content
			bound := l_content.count - 1
			if object_comparison then
				if v /= Void then
					from
					until
						i > bound or else Result
					loop
						Result := l_content.item (i) /= Void and then v.is_equal (l_content.item (i))
						i := i + 1
					end
				end
			else
				from
				until
					i > bound or else Result
				loop
					Result := l_content.item (i) = v
					i := i + 1
				end
			end
		end

	key_at (n: INTEGER): H is
			-- Key corresponding to entry `n'
		do
			if n >= 0 and n < keys.count then
				Result := keys.item (n)
			end
		end

	current_keys: ARRAY [H] is
			-- Array of actually used keys, from 1 to `count'
		local
			i, j, table_size: INTEGER
			scanned_key: H
			l_keys: like keys
		do
			from
				l_keys := keys
				table_size := l_keys.count - 1
				create Result.make (1, count)
			until
				i > table_size
			loop
				scanned_key := l_keys.item (i)
				if valid_key (scanned_key) then
					j := j + 1
					Result.put (scanned_key, j)
				end
				i := i + 1
			end
		ensure
			good_count: Result.count = count
 		end

	dead_key: H is
			-- Special key used to mark deleted items
		do
		end

	found_item: G
			-- Item found during a search with `has' to reduce the number of
			-- search for clients

	position: INTEGER
			-- Hash table cursor, updated after each operation:
			-- put, remove, has, replace, force, change_key...

	item_for_iteration: G is
			-- Element at current iteration position
		require
			not_off: not off
		do
			Result := content.item (iteration_position)
		end

	key_for_iteration: H is
			-- Key at current iteration position
		require
			not_off: not off
		do
			Result := keys.item (iteration_position)
		end

	cursor: CURSOR is
			-- Current cursor position
		do
			create {HASH_TABLE_CURSOR} Result.make (iteration_position)
		ensure
			cursor_not_void: Result /= Void
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in table

	capacity: INTEGER is
			-- Number of items that may be stored.
		do
			Result := keys.count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does table contain the same information as `other'?
		do
			Result :=
				equal (keys, other.keys) and
				equal (content, other.content) and
				equal (deleted_marks, other.deleted_marks)
		end

feature -- Status report

	full: BOOLEAN is False
			-- Is structured filled to capacity? (Answer: no.)

	extendible: BOOLEAN is True
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := True
		end

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
			-- Answer: yes if and only if `k' is not the default
			-- value of type `H'.
		local
			dkey: H
		do
			Result := k /= dkey and then k.is_hashable
		ensure then
			Result = (k /= dead_key and then k.is_hashable)
		end

	conflict: BOOLEAN is
			-- Did last operation cause a conflict?
		do
			Result := (control = Conflict_constant)
		end

	inserted: BOOLEAN is
			-- Did last operation insert an item?
		do
			Result := (control = Inserted_constant)
		end

	replaced: BOOLEAN is
			-- Did last operation replace an item?
		do
			Result := (control = Changed_constant)
		end

	removed: BOOLEAN is
			-- Did last operation remove an item?
		do
			Result := (control = Removed_constant)
		end

	found: BOOLEAN is
			-- Did last operation find the item sought?
		do
			Result := (control = Found_constant)
		end

	after, off: BOOLEAN is
			-- Is cursor past last item?
		do
			Result := iteration_position >= keys.count
		end

	search (key: H) is
			-- Search for item of key `key'
			-- If found, set `found' to True, and set
			-- `found_item' to item associated with `key'.
		local
			default_value: G
		do
			internal_search (key)
			if found then
				found_item := content.item (position)
			else
				found_item := default_value 
			end
		ensure
			found_or_not_found: found or not found
			item_if_found: found implies (found_item = content.item (position)) 
		end

	valid_cursor (c: CURSOR): BOOLEAN is
			-- Can cursor be moved to position `c'?
		require
			c_not_void: c /= Void
		local
			ht_cursor: HASH_TABLE_CURSOR
			cursor_position: INTEGER
		do
			ht_cursor ?= c
			if ht_cursor /= Void then
				cursor_position := ht_cursor.position
				if cursor_position >= keys.count then
					Result := True
				elseif cursor_position >= 0 then
					Result := valid_key (keys.item (cursor_position))
				end
			end
		end

feature -- Cursor movement

	start is
			-- Bring cursor to first position.
		do
			iteration_position := -1
			forth
		end

	forth is
			-- Advance cursor by one position.
		require
			not_off: not off
		local
			stop: BOOLEAN
			l_keys: like keys
			pos_for_iter, table_size: INTEGER
		do
			from
				l_keys := keys
				table_size := l_keys.count - 1
				pos_for_iter := iteration_position
			until
				stop
			loop
				pos_for_iter := pos_for_iter + 1
				stop := pos_for_iter > table_size or else valid_key (l_keys.item (pos_for_iter))
			end
			iteration_position := pos_for_iter
		end

	go_to (c: CURSOR) is
			-- Move to position `c'.
		require
			c_not_void: c /= Void
			valid_cursor: valid_cursor (c)
		local
			ht_cursor: HASH_TABLE_CURSOR
		do
			ht_cursor ?= c
			if ht_cursor /= Void then
				iteration_position := ht_cursor.position
			end
		end

feature -- Element change

	put (new: G; key: H) is
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
			-- Make `inserted' true if and only if an insertion has
			-- been made (i.e. `key' was not present).
		do
			internal_search (key)
			if control = Found_constant then
				control := Conflict_constant
			else
				if soon_full then
					add_space
					internal_search (key)
				end
				content.put (new, position)
				keys.put (key, position)
				count := count + 1
				control := Inserted_constant
			end
		ensure then
			insertion_done: inserted implies item (key) = new
		end

	replace (new: G; key: H) is
			-- Replace item at `key', if present,
			-- with `new'; do not change associated key.
			-- Make `replaced' true if and only if a replacement has
			-- been made (i.e. `key' was present).
		require
			valid_key (key)
		do
			internal_search (key)
			if control = Found_constant then
				content.put (new, position)
				control := Changed_constant
			else
				control := Not_found_constant
			end
		ensure
			insertion_done: replaced implies item (key) = new
		end

	force (new: G; key: H) is
			-- If `key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `key'.
			-- Make `inserted' true.
		require
			valid_key (key)
		do
			internal_search (key)
			if control /= Found_constant then
				if soon_full then
					add_space
					internal_search (key)
				end
				keys.put (key, position)
				count := count + 1
			end
			content.put (new, position)
			control := Inserted_constant
		ensure then
			insertion_done: item (key) = new
		end

	replace_key (new_key: H; old_key: H) is
			-- If table contains an item at `old_key',
			-- replace its key by `new_key'.
			-- Make `replaced' true if and only if a replacement has
			-- been made (i.e. `old_key' was present).
		require
			valid_keys: valid_key (new_key) and valid_key (old_key)
		local
			old_index: INTEGER
			dead_item: G
			dkey: H
		do
			internal_search (old_key)
			if control = Found_constant then
				old_index := position
				put (content.item (old_index), new_key)
				if control /= Conflict_constant then
					count := count - 1
					if position /= old_index then
						keys.put (dkey, old_index)
						content.put (dead_item, old_index)
						deleted_marks.put (True, old_index)
					end
					control := Changed_constant
				end
			end
		ensure
			changed: replaced implies not has (old_key)
		end

	merge (other: HASH_TABLE [G, H]) is
			-- Merge `other' into Current. If `other' has some elements
			-- with same key as in `Current', replace them by one from
			-- `other'.
		require
			other_not_void: other /= Void
		do
			from
				other.start
			until
				other.after
			loop
				force (other.item_for_iteration, other.key_for_iteration)
				other.forth
			end
		ensure
			inserted: other.current_keys.linear_representation.for_all (agent has)
		end
		
feature -- Removal

	remove (key: H) is
			-- Remove item associated with `key', if present.
			-- Make `removed' true if and only if an item has been
			-- removed (i.e. `key' was not present).
		require
			valid_key: valid_key (key)
		local
			dkey: H
			dead_item: G
		do
			internal_search (key)
			if control = Found_constant then
				keys.put (dkey, position)
				content.put (dead_item, position)
				deleted_marks.put (True, position)
				control := Removed_constant
				count := count - 1
			end
		ensure
			removed: not has (key)
		end

	wipe_out, clear_all is
			-- Reset all items to default values.
		local
			default_value: G
		do
			content.clear_all
			keys.clear_all
			deleted_marks.clear_all
			count := 0
			control := 0
			position := 0
			found_item := default_value
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (order is same as original order of insertion)
		local
			i, table_size: INTEGER
			l_keys: like keys
			l_content: like content
		do
			from
				l_content := content
				l_keys := keys
				create Result.make (count)
				table_size := l_content.count - 1
			until
				i > table_size
			loop
				if valid_key (l_keys.item (i)) then
					Result.extend (l_content.item (i))
				end
				i := i + 1
			end
		ensure then
			Result_exists: Result /= Void
			good_count: Result.count = count
		end

feature -- Duplication

	copy (other: like Current) is
			-- Re-initialize from `other'.
		do
			standard_copy (other)
			set_keys (other.keys.twin)
			set_content (other.content.twin)
			set_deleted_marks (other.deleted_marks.twin)
		end

feature {HASH_TABLE} -- Implementation

	content: SPECIAL [G]
			-- Array of contents

	keys: SPECIAL [H]
			-- Array of keys

	deleted_marks: SPECIAL [BOOLEAN]
			-- Array of deleted marks

	Size_threshold: INTEGER is 80
			-- Filling percentage over which some resizing is done

	set_content (c: like content) is
			-- Assign `c' to `content'.
		do
			content := c
		end

	set_keys (c: like keys) is
			-- Assign `c' to `keys'.
		do
			keys := c
		end

	set_deleted_marks (c: like deleted_marks) is
			-- Assign `c' to `deleted_marks'.
		do
			deleted_marks := c
		end

	set_replaced is
		do
			control := changed_constant
		end

feature {NONE} -- Inapplicable

	prune (v: G) is
			-- Remove one occurrence of `v' if any.
		do
		end

	extend (v: G) is
			-- Insert a new occurrence of `v'
		do
		end

	occurrences (v: G): INTEGER is
			-- Here temporarily; must be brought back as
			-- exported feature!
		do
		end

feature {NONE} -- Implementation

	iteration_position: INTEGER
			-- Cursor for iteration primitives

	internal_search (search_key: H) is
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
			old_key, default_key: H
			stop: BOOLEAN
			l_keys: like keys
			l_deleted_marks: like deleted_marks
		do
			from
				l_keys := keys
				l_deleted_marks := deleted_marks
				first_deleted_position := -1
				table_size := l_keys.count
				hash_code := search_key.hash_code
				-- Increment computed for no cycle: `table_size' is prime
				increment := 1 + hash_code \\ (table_size - 1)
				pos := (hash_code \\ table_size) - increment
			until
				stop or else visited_count >= table_size
			loop
				pos := (pos + increment) \\ table_size
				visited_count := visited_count + 1
				old_key := l_keys.item (pos)
				if old_key = default_key then
					if not l_deleted_marks.item (pos) then
						control := Not_found_constant
						stop := True
						if first_deleted_position >= 0 then
							pos := first_deleted_position
						end
					elseif first_deleted_position < 0 then
						first_deleted_position := pos
					end
				elseif search_key.is_equal (old_key) then
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

	Inserted_constant: INTEGER is unique
			-- Insertion successful

	Found_constant: INTEGER is unique
			-- Key found

	Changed_constant: INTEGER is unique
			-- Change successful

	Removed_constant: INTEGER is unique
			-- Remove successful

	Conflict_constant: INTEGER is unique
			-- Could not insert an already existing key

	Not_found_constant: INTEGER is unique
			-- Key not found

	add_space is
			-- Increase capacity.
		local
			i, table_size: INTEGER
			current_key: H
			other: HASH_TABLE [G, H]
			l_keys: like keys
			l_content: like content
		do
			from
				l_content := content
				l_keys := keys
				table_size := l_keys.count
				create other.make ((High_ratio * table_size) // Low_ratio)
			until
				i >= table_size
			loop
				current_key := l_keys.item (i)
				if valid_key (current_key) then
					other.put (l_content.item (i), current_key)
				end
				i := i + 1
			end
			content := other.content
			keys := other.keys
			deleted_marks := other.deleted_marks
		end

	soon_full: BOOLEAN is
			-- Is table close to being filled to current capacity?
			-- (If so, resizing is needed to avoid performance degradation.)
		do
			Result := (keys.count * Size_threshold <= 100 * count)
		end

	control: INTEGER
			-- Control code set by operations that may produce
			-- several possible conditions.

	Minimum_size: INTEGER is 5

	High_ratio: INTEGER is 3

	Low_ratio: INTEGER is 2

invariant

	count_big_enough: 0 <= count
	content_not_void: content /= Void
	keys_not_void: keys /= Void
	deleted_marks_not_void: deleted_marks /= Void

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class HASH_TABLE



