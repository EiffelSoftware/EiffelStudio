indexing

	description:
		"Hash tables, used to store items identified by hashable keys"

	compatibility:
		"This version of the class accepts any value of type H as key. %
		%Previous versions did not accept the default value as a key; %
		%this restriction no longer applies. Most clients of the old version %
		%should work correctly with this one; a client that explicitly relied %
		%on the default value not being hashable should use the old version %
		%available in the EiffelBase 3.3 compatibility cluster." 

	storable_compatibility:
		"Persistent instances of the old version of this class will not be %
		% retrievable with the present version."

	warning:
		"Modifying an object used as a key by an item present in a table will %
		%cause incorrect behavior. If you will be modifying key objects, %
		%pass a clone, not the object itself, as key argument to %
		%`put' and `replace_key'."

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
			has as has_item,
			wipe_out as clear_all
		export
			{NONE} prune_all
		redefine
			copy, is_equal, clear_all, has_item
		end

creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate hash table for at least `n' items.
			-- The table will be resized automatically
			-- if more than `n' items are inserted.
		local
			clever: PRIMES
		do
			!! clever
			capacity := clever.higher_prime ((High_ratio * n) // Low_ratio)
			if capacity < Minimum_size then
				capacity := Minimum_size
			end
			!! content.make (0, capacity)
			!! keys.make (0, capacity)
					-- Position `capacity' ignored by hash sequences,
					-- used to store value for default key.

			!! deleted_marks.make (0, capacity-1)
			iteration_position := capacity + 1
		ensure
			capacity_big_enough: capacity >= n and capacity >= Minimum_size
		end

feature -- Access

	item, infix "@" (key: H): G is
			-- Item associated with `key', if present
			-- otherwise default value of type `G'
		local
			old_control, old_position: INTEGER
		do
			old_control := control; old_position := position
			internal_search (key)
			if found then
				Result := content.item (position)
			end
			control := old_control; position := old_position
		end

	has (key: H): BOOLEAN is
			-- Is there an item in the table with key `key'?
		local
			old_control, old_position: INTEGER
		do
			old_control := control; old_position := position
			internal_search (key)
			Result := found
			control := old_control; position := old_position
		end

	has_item (v: G): BOOLEAN is
			-- Does structure include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			i: INTEGER
		do
			if has_default then
				Result := (v = default_key_value)
			end
			if not Result then
				if object_comparison then
					from
					until
						i = capacity or else Result
					loop
						Result := occupied (i) and equal (v, content.item (i))
						i := i + 1
					end
				else
					from
					until
						i = capacity or else Result
					loop
						Result := occupied (i) and (v = content.item (i))
						i := i + 1
					end
				end
			end
		end

	current_keys: ARRAY [H] is
			-- Array of actually used keys, from 1 to `count'
		local
			i, j: INTEGER
		do
			from
				!! Result.make (1, count)
			until
				i = capacity
			loop
				if truly_occupied (i) then
					j := j + 1
					Result.put (keys.item (i), j)
				end
				i := i + 1
			end
		ensure
			good_count: Result.count = count
 		end

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

	search_item: G
			-- Item, if any, yielded by last `search' operation

	cursor: CURSOR is
			-- Current cursor position
		do
			!HASH_TABLE_CURSOR! Result.make (iteration_position)
		ensure
			cursor_not_void: Result /= Void
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in table

	capacity: INTEGER
			-- Number of items that may be stored.

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does table contain the same information as `other'?
		do
			Result :=
				equal (keys, other.keys) and
				equal (content, other.content) and
				equal (deleted_marks, other.deleted_marks) and
				(has_default = other.has_default)
		end

feature -- Status report

	full: BOOLEAN is false
			-- Is structure filled to capacity? (Answer: no.)

	extendible: BOOLEAN is true
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := true
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
			Result := (control = Replaced_constant)
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
			Result := (not has_default and (iteration_position >= capacity)) or
				(has_default and (iteration_position > capacity))
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
				if cursor_position = capacity + 1 then
					Result := True
				elseif cursor_position >= 0 then
					Result := truly_occupied (cursor_position)
				end
			end
		end

feature -- Cursor movement

	start is
			-- Bring cursor to first position.
		do
			iteration_position := keys.lower - 1
			forth
		end

	forth is
			-- Advance cursor to next occupied position.
		require
			not_off: not off
		do
			from
				iteration_position := iteration_position + 1
			until
				off or else truly_occupied (iteration_position)
			loop
				iteration_position := iteration_position + 1
			end
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

	search (key: H) is
			-- Search for item of key `key'.
			-- If found, set `found' to true and `search_item' to item for `key'.
		do
			internal_search (key)
			search_item := content.item (position)
		end

feature -- Element change

	put (new: G; key: H) is
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
			-- Make `inserted' true if and only if an insertion has
			-- been made (i.e. `key' was not present).
			-- If so, set `position' to the insertion position.
		local
			default_key: H
		do
			internal_search (key)
			if found then
				set_conflict
			else
				if soon_full then
					add_space
					internal_search (key)
				end
				if deleted_position /= Impossible_position then
					position := deleted_position
					set_not_deleted (position)
				end
				count := count + 1
				insert_at_position (new, key)
			end
		ensure then
			insertion_done: inserted implies item (key) = new
			one_more_if_inserted: inserted implies (count = old count + 1)
			unchanged_if_conflict: conflict implies (count = old count)
		end

	force (new: G; key: H) is
			-- If `key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `key'.
			-- Make `inserted' true.
		require else
			True
		local
			default_key: H
		do
			internal_search (key)
			if not found then
				if soon_full then
					add_space
					internal_search (key)
				end
				if deleted_position /= Impossible_position then
					position := deleted_position
					set_not_deleted (position)
				end
				count := count + 1
			end
			insert_at_position (new, key)
		ensure then
			insertion_done: item (key) = new
			same_count_or_one_more:  (count = old count) or (count = old count + 1)
			inserted: inserted
		end

	replace (new: G; key: H) is
			-- Replace item at `key', if present,
			-- with `new'; do not change associated key.
			-- Make `replaced' true if and only if a replacement has
			-- been made (i.e. `key' was present).
		do
			internal_search (key)
			if found then
				content.put (new, position)
				set_replaced
			else
				set_not_found
			end
		ensure
			insertion_done: replaced implies item (key) = new
		end

	replace_key (new_key: H; old_key: H) is
			-- If there is an item of key `old_key' and no item of key
			-- `new_key', replace the former's key by `new_key'
			-- and set status to `replaced'.
		local
			insert_position: INTEGER
			default_value: G
			default_key: H
		do
			put (default_value, new_key)
			if not conflict then
				count := count -1
				insert_position := position
				internal_search (old_key)
				if found then
					content.put (content.item (position), insert_position)
					set_replaced
					if old_key = default_key then
						set_no_default
					else
						remove_at_position
					end
					if new_key = default_key then
						set_default
					end
				else
					position := insert_position
					remove_at_position
				end
			end
		ensure
			old_absent: (replaced and not equal (new_key, old_key))
								implies (not has (old_key))
			new_present: replaced implies (has (new_key))
			same_count: count = old count
		end


feature -- Removal

	remove (key: H) is
			-- Remove item associated with `key', if present.
			-- Make `removed' true if and only if an item has been
			-- removed (i.e. `key' was present).
			-- If so, set `position' to index of removed element.
		local
			default_key: H
		do
			internal_search (key)
			if found then
				set_removed
				if key = default_key then
					set_no_default
				else
					remove_at_position
				end
				count := count - 1
			end
		ensure
			not_there: not has (key)
			one_less: found implies (count = old count - 1)
		end

	clear_all is
			-- Reset all items to default values.
		do
			content.clear_all
			keys.clear_all
			deleted_marks.clear_all
			count := 0
			set_no_status
			position := 0
			set_no_default
			iteration_position := capacity + 1
		ensure then
			position_equal_to_zero: position = 0
			count_equal_to_zero: count = 0
			has_default_set: not has_default
			status_set: control = 0
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (order is same as original order of insertion)
		local
			i: INTEGER
		do
			from
				!! Result.make (count)
			until
				i = capacity
			loop
				if occupied (i) then
					Result.extend (content.item (i))
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
			set_keys (clone (other.keys))
			set_content (clone (other.content))
			set_deleted_marks (clone (other.deleted_marks))
		end

feature -- Obsolete

	dead_key: H is
			obsolete "this special key is no more used"
		do
		end
		
	pos_for_iter: INTEGER is
			obsolete "use iteration_position"
		do
			Result:= iteration_position
		end
		
	changed_constant: INTEGER is
			obsolete "use Replaced_constant"
		do
			Result := Replaced_constant
		end

	valid_key (k: H): BOOLEAN is
			obsolete "The default value is now accepted"
			-- Is `k' a valid key?
			-- Answer: yes
		do
			Result := True
		ensure then
			Result
		end

feature {HASH_TABLE} -- Implementation: content attributes and preservation procedure

	content: ARRAY [G]
			-- Array of contents

	keys: ARRAY [H]
			-- Array of keys

	deleted_marks: ARRAY [BOOLEAN]
			-- Is position that of a deleted element?

	has_default: BOOLEAN
			-- Is the default key present?

	set_default is
			-- Record information that there is a value for default key.
		do
			has_default := True
		end

	set_no_default is
			-- Record information that there is no value for default key.
		do
			has_default := False
		end

feature {HASH_TABLE} -- Implementation: search attributes

	iteration_position: INTEGER
			-- Cursor for iteration primitives

	position: INTEGER
			-- Hash table cursor, updated after each operation:
			-- put, remove, has, replace, force, change_key...

	soon_full: BOOLEAN is
			-- Is table close to being filled to current capacity?
			-- (If so, resizing is needed to avoid performance degradation.)
		do
			Result := (count * 100 >= capacity * Size_threshold)
		end

	control: INTEGER
			-- Control code set by operations that may produce
			-- several possible conditions.

	deleted_position: INTEGER
			-- Place where a deleted element was found during a search

feature {NONE} -- Implementation

	Size_threshold: INTEGER is 80
			-- Filling percentage over which table will be resized

	Impossible_position: INTEGER is -1
			-- Position outside the array indices

	occupied (i: INTEGER): BOOLEAN is
			-- Is position `i' occupied by a non-default key and a value?
		require
			in_bounds: i >= 0 and i < capacity
		local
			default_key: H
		do
			Result := (keys.item (i) /= default_key)
		end	

	truly_occupied (i: INTEGER): BOOLEAN is
			-- Is position `i' occupied by a key and a value?
		require
			in_bounds: i >= 0 and i <= capacity
		do
			Result := (has_default and i = capacity) or else (i < capacity and then occupied (i))
		ensure
			normal_key: (i < capacity) implies (occupied (i) implies Result)
			default_key: (i= capacity)implies (Result = has_default)
		end


	set_content (c: like content) is
			-- Assign `c' to `content'.
		do
			content := c
		end

	deleted (i: INTEGER): BOOLEAN is
			-- Is position `i' that of a deleted item?
		require
			in_bounds: i >= 0 and i < capacity
		do
			Result := deleted_marks.item (i)
		end	

	set_not_deleted (i: INTEGER) is
			-- Mark position `i' as not deleted.
		require
			in_bounds: i >= 0 and i < capacity
		do
			deleted_marks.put (False, i)
		end	

	set_deleted (i: INTEGER) is
			-- Mark position `i' as deleted.
		require
			in_bounds: i >= 0 and i < capacity
		do
			deleted_marks.put (True, i)
		end	

	set_keys (c: like keys) is
			-- Assign `c' to `keys'.
		do
			keys := c
		end

	set_deleted_marks (d: like deleted_marks) is
			-- Assign `d' to `deleted_marks'.
		do
			deleted_marks := d
		end

	default_key_value: G is
			-- Value associated with the default key, if any
		require
			has_default
		do
			Result := content.item (capacity)
		end

	internal_search (key: H) is
			-- Search for item of key `key'.
			-- If successful, set `position' to index
			-- of item with this key (the same index as the key's index).
			-- If not, set `position' to possible position for insertion,
			-- and set status to `found' or `not_found'.
		local
			default_key: H
			hash_code, increment: INTEGER
			stop: BOOLEAN
		do
			deleted_position := Impossible_position
			set_no_status
			if key = default_key then
				position := capacity
				if has_default then
					set_found
				else
					set_not_found
				end
			else
				from
					hash_code := key.hash_code
					increment := position_increment (hash_code)
					position := initial_position (hash_code)
				until
					stop
				loop
					if deleted (position) then
						deleted_position := position
						to_next_candidate (increment)
					elseif keys.item (position) = default_key then
						stop := True
						set_not_found
					elseif keys.item (position).is_equal (key) then
						stop := True
						set_found
					else
						to_next_candidate (increment)
					end
				end
			end
		end

	insert_at_position (new: G; key: H) is
			-- Insert `new' with `key' at current position,
			-- or, if resizing necessary, at new position after resizing.
			-- Correct only after a call to `internal_search'
			-- (so that `deleted_position' is meaningful).
		local
			default_key: H
		do
			content.put (new, position)
			keys.put (key, position)
			set_inserted
			if key = default_key then
				set_default
			end
		end

	remove_at_position is
			-- Remove item at `position'
		local
			default_value: G
			default_key: H
		do
			content.put (default_value, position)
			keys.put (default_key, position)
			set_deleted (position)
			if (iteration_position = position) then
				forth
			end
		end

	key_at (n: INTEGER): H is
			-- Key corresponding to entry `n'
		require
			in_bounds: n >=0 and n < capacity
		do
			Result := keys.item (n)
		end

	initial_position (hash_code: INTEGER): INTEGER is
				-- The initial position for this hash code
			do
				Result := (hash_code \\ capacity)
			end

	position_increment (hash_code: INTEGER): INTEGER is
				-- The distance between successive positions for this hash_code
				-- (computed for no cycle: `capacity' is prime)
			do
				Result := 1 + hash_code \\ (capacity - 1)
			end

	to_next_candidate (increment: INTEGER) is
			-- Move from current `position' to next for same key
		do
				position := (position + increment) \\ capacity
		end

	Conflict_constant: INTEGER is unique
			-- Could not insert an already existing key

	set_conflict is
			-- Set status to conflict.
		do
			control := Conflict_constant
		end

	Inserted_constant: INTEGER is unique
			-- Insertion successful

	Found_constant: INTEGER is unique
			-- Key found

	set_found is
			-- Set status to found.
		do
			control := Found_constant
		end

	set_inserted is
			-- Set status to inserted.
		do
			control := Inserted_constant
		end

	Not_found_constant: INTEGER is unique
			-- Key not found

	set_not_found is
			-- Set status to not found.
		do
			control := Not_found_constant
		end

	Removed_constant: INTEGER is unique
			-- Remove successful

	set_no_status is
			-- Set status to normal.
		do
			control := 0
		end

	set_removed is
			-- Set status to removed.
		do
			control := Removed_constant
		end

	Replaced_constant: INTEGER is unique
			-- Replaced value

	set_replaced is
			-- Set status to replaced.
		do
			control := Replaced_constant
		end

	non_default_status: BOOLEAN is
			-- Has status been set to any non-default value?
		do
			Result := (control > 0)
		end

	add_space is
			-- Increase capacity.
		local
			i: INTEGER
			other: HASH_TABLE [G, H]
		do
			from
				!! other.make ((High_ratio * capacity) // Low_ratio)
			until
				i = capacity
			loop
				if occupied (i) then
					other.put (content.item (i), keys.item (i))
				end
				i := i + 1
			end

			if has_default then
				other.put (content.item (capacity), keys.item (capacity))
			end

			capacity := other.capacity
			iteration_position := other.iteration_position

			set_content (other.content)
			set_keys (other.keys)
			set_deleted_marks (other.deleted_marks)
		end


	Minimum_size : INTEGER is 5

	High_ratio : INTEGER is 3

	Low_ratio : INTEGER is 2

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

invariant

	keys_not_void: keys /= Void
	content_not_void: content /= Void
	count_big_enough: 0 <= count
	count_small_enough: count <= capacity
	keys_same_capacity_plus_one: keys.count = capacity + 1
	content_same_capacity_plus_one: content.count = capacity + 1
	deleted_same_capacity: deleted_marks.count = capacity
	keys_starts_at_zero: keys.lower = 0
	content_starts_at_zero: content.lower = 0
	deleted_starts_at_zero: deleted_marks.lower = 0
	valid_iteration_position: off or truly_occupied (iteration_position)
							
end -- class HASH_TABLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
