indexing

	description:
		"Hash tables, used to store items identified by hashable keys"
	legal: "See notice at end of class."

	instructions: "[
		Several procedures are provided for inserting an item
		with a given key.

		Here is how to choose between them:

			- Use `put' if you want to do an insertion only if
			  there was no item with the given key, doing nothing
			  otherwise. (You can find out on return if there was one,
			  and what it was.)

			- Use `force' if you always want to insert the item;
			  if there was one for the given key it will be removed,
			  (and you can find out on return what it was).

			- Use `extend' if you are sure there is no item with
			  the given key, enabling faster insertion (but
			  unpredictable behavior if this assumption is not true).

			- Use `replace' if you want to replace an already present
			  item with the given key, and do nothing if there is none.

		In addition you can use `replace_key' to change the key of an
		already present item, identified by its previous key, or
		do nothing if there is nothing for that previous key.
		You can find out on return.
		]"

	instructions: "[
		To find out whether a key appears in the table, use `has'.
		To find out the item, if any, associated with a certain key,
		use `item'.

		Both of these routines perform a search. If you need
		both pieces of information (does a key appear? And, if so,
		what is the associated item?), you can avoid performing
		two redundant traversals by using instead the combination
		of `search', `found' and `found_item' as follows:

			your_table.search (your_key)
			if your_table.found then
				what_you_where_looking_for := your_table.found_item
				... Do whatever is needed to `what_you_were_looking_for' ...
			else
				... No item was present for `your_key' ...
			end
		]"

	compatibility: "[
		This version of the class accepts any value of type H as key.
		Previous versions did not accept the default value as a key;
		this restriction no longer applies. Most clients of the old version
		should work correctly with this one; a client that explicitly relied
		on the default value not being hashable should use the old version
		available in the EiffelBase 3.3 compatibility cluster.

		Also, `force' now sets either `found' or `not_found'.
		(Previously it would always set `inserted'.)
		]"

	storable_compatibility: "[
		Persistent instances of the old version of this class will not be
		 retrievable with the present version.
		]"

	warning: "[
		Modifying an object used as a key by an item present in a table will
		cause incorrect behavior. If you will be modifying key objects,
		pass a clone, not the object itself, as key argument to
		`put' and `replace_key'.
		]"

	status: "See notice at end of class."
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
			wipe_out as clear_all,
			extend as collection_extend
		export
			{NONE} prune_all
		redefine
			copy, is_equal, clear_all, has_item
		end

	MISMATCH_CORRECTOR
		export
			{NONE} all
		undefine
			copy, is_equal
		redefine
			correct_mismatch
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
			l_void_item: G
		do
			create clever
			capacity := n.Max (Minimum_capacity)
			capacity := capacity + capacity // 2 + 1
			capacity := clever.higher_prime (capacity)
			create content.make (capacity + 1)
			create keys.make (capacity + 1)
					-- Position `capacity' ignored by hash sequences,
					-- used to store value for default key.
			create deleted_marks.make (capacity + 1)
			iteration_position := capacity + 1
			count := 0
			deleted_position := 0
			control := 0
			found_item := l_void_item
			has_default := False
			position := 0
			used_slot_count := 0
		ensure
			breathing_space: n < capacity * Initial_occupation
			minimum_space: Minimum_capacity < capacity * Initial_occupation
			more_than_minimum: capacity >= Minimum_capacity
			no_status: not special_status
		end

	accommodate (n: INTEGER) is
			-- Reallocate table with enough space for `n' items;
			-- keep all current items.
		require
			n >= 0
		local
			i: INTEGER
			new_table: HASH_TABLE [G, H]
			default_key: H
			l_content: like content
			l_keys: like keys
		do
				-- (Could also use iteration facilities.)
			from
				create new_table.make (count.max (n))
				l_content := content
				l_keys := keys
			until
				i = capacity
			loop
				if occupied (i) then
					check
						not new_table.soon_full
							-- See invariant clause `sized_generously_enough'
					end
					new_table.put (l_content.item (i), l_keys.item (i))
				end
				i := i + 1
			end

			if has_default then
				new_table.put (l_content.item (capacity), default_key)
			end

			set_content (new_table.content)
			set_keys (new_table.keys)
			set_deleted_marks (new_table.deleted_marks)

			capacity := new_table.capacity
			used_slot_count := count
			iteration_position := new_table.iteration_position
		ensure
			count_not_changed: count = old count
			slot_count_same_as_count: used_slot_count = count
			breathing_space: count < capacity * Initial_occupation
		end

feature -- Access

	found_item: G
			-- Item, if any, yielded by last search operation

	item alias "[]", infix "@" (key: H): G assign put is
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
		ensure then
			default_value_if_not_present:
				(not (has (key))) implies (Result = computed_default_value)
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
		ensure then
			default_case:
				(key = computed_default_key) implies (Result = has_default)
		end

	has_item (v: G): BOOLEAN is
			-- Does structure include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			i: INTEGER
			l_content: like content
		do
			if has_default then
				Result := (v = default_key_value)
			end
			if not Result then
				l_content := content
				if object_comparison then
					from
					until
						i = capacity or else Result
					loop
						Result := occupied (i) and then equal (v, l_content.item (i))
						i := i + 1
					end
				else
					from
					until
						i = capacity or else Result
					loop
						Result := occupied (i) and then (v = l_content.item (i))
						i := i + 1
					end
				end
			end
		end

	current_keys: ARRAY [H] is
			-- New array containing actually used keys, from 1 to `count'
		local
			j: INTEGER
			old_iteration_position: INTEGER
		do
			old_iteration_position := iteration_position
			from
				create Result.make (1, count)
				start
			until
				off
			loop
				j := j + 1
				Result.put (key_for_iteration, j)
				forth
			end
			iteration_position := old_iteration_position
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
		ensure
			at_iteration_position: Result = key_at (iteration_position)
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

	capacity: INTEGER
			-- Number of items that may be stored.

	occurrences (v: G): INTEGER is
			-- Number of table items equal to `v'.
		local
			old_iteration_position: INTEGER
		do
			old_iteration_position := iteration_position
			if object_comparison then
				from
					start
				until
					off
				loop
					if equal (item_for_iteration, v) then
						Result := Result + 1
					end
					forth
				end
			else
				from
					start
				until
					off
				loop
					if item_for_iteration = v then
						Result := Result + 1
					end
					forth
				end
			end
			iteration_position := old_iteration_position
		end

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

	full: BOOLEAN is False
			-- Is structure filled to capacity? (Answer: no.)

	extendible: BOOLEAN is True
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := True
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

	not_found: BOOLEAN is
			-- Did last operation fail to find the item sought?
		do
			Result := (control = Not_found_constant)
		end

	after, off: BOOLEAN is
			-- Is cursor past last item?
		do
			Result := is_off_position (iteration_position)
		ensure
			definition:
				Result = ((not has_default and (iteration_position >= capacity)) or
							(has_default and (iteration_position = (capacity + 1))))
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
				Result :=
						(is_off_position (cursor_position)) or else
							((cursor_position >= 0) and
							(cursor_position <= capacity) and then
							truly_occupied (cursor_position))
			end
		end

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
			-- (Answer: always yes for hash tables in this version)
		do
			Result := True
		ensure then
			Result
		end

feature -- Cursor movement

	start is
			-- Bring cursor to first position.
		do
			iteration_position := -1
			forth
		end

	forth is
			-- Advance cursor to next occupied position,
			-- or `off' if no such position remains.
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
			-- If found, set `found' to true, and set
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
			found_or_not_found: found or not_found
			item_if_found: found implies (found_item = content.item (position))
		end

	search_item: G is
		obsolete
			"Use found_item instead."
		do
			Result := found_item
		end

feature -- Element change

	put (new: G; key: H) is
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
			-- Set `inserted' if and only if an insertion has
			-- been made (i.e. `key' was not present).
			-- If so, set `position' to the insertion position.
			-- If not, set `conflict'.
			-- In either case, set `found_item' to the item
			-- now associated with `key' (previous item if
			-- there was one, `new' otherwise).
			--
			-- To choose between various insert/replace procedures,
			-- see `instructions' in the Indexing clause.
		do
			internal_search (key)
			if found then
				set_conflict
				found_item := content.item (position)
			else
				if soon_full then
					add_space
					internal_search (key)
						check
							not found
								-- The key didn't magically insert itself.
						end
				end
				if deleted_position /= Impossible_position then
					position := deleted_position
					set_not_deleted (position)
				else
					used_slot_count := used_slot_count + 1
				end
				count := count + 1
				put_at_position (new, key)
				found_item := new
				set_inserted
			end
		ensure then
			conflict_or_inserted: conflict or inserted
			insertion_done: inserted implies item (key) = new
			now_present: inserted implies has (key)
			one_more_if_inserted: inserted implies (count = old count + 1)
			unchanged_if_conflict: conflict implies (count = old count)
			same_item_if_conflict: conflict implies (item (key) = old (item (key)))
			slot_count_unchanged_if_conflict:
				conflict implies (used_slot_count = old used_slot_count)
			found_item_associated_with_key: found_item = item (key)
			new_item_if_inserted: inserted implies (found_item = new)
			old_item_if_conflict: conflict implies (found_item = old (item (key)))
			default_property:
				has_default =
					((inserted and (key = computed_default_key)) or
						((conflict or (key /= computed_default_key))
							and (old has_default)))
		end

	force (new: G; key: H) is
			-- Update table so that `new' will be the item associated
			-- with `key'.
			-- If there was an item for that key, set `found'
			-- and set `found_item' to that item.
			-- If there was none, set `not_found' and set
			-- `found_item' to the default value.
			--
			-- To choose between various insert/replace procedures,
			-- see `instructions' in the Indexing clause.
		require else
			True
		local
			default_key: H
		do
			search (key)
			if not_found then
				if soon_full then
					add_space
					internal_search (key)
				end
				if deleted_position /= Impossible_position then
					position := deleted_position
					set_not_deleted (position)
				else
					used_slot_count := used_slot_count + 1
				end
				keys.put (key, position)
				if key = default_key then
					set_default
				end
				count := count + 1
			end
			content.put (new, position)
		ensure then
			insertion_done: item (key) = new
			now_present: has (key)
			found_or_not_found: found or not_found
			not_found_if_was_not_present: not_found = not (old has (key))
			same_count_or_one_more: (count = old count) or (count = old count + 1)
			same_slot_count_or_one_more_unless_reallocated:
				(used_slot_count = old used_slot_count) or
				(used_slot_count = old used_slot_count + 1) or
				(used_slot_count = count)
			found_item_is_old_item: found implies (found_item = old (item (key)))
			default_value_if_not_found:
				not_found implies (found_item = computed_default_value)
					-- The reverse is not true, as we can always insert
					-- an item with the default value, for any key.

			default_property:
				has_default =
					((key = computed_default_key) or
						((key /= computed_default_key) and (old has_default)))
		end

	extend (new: G; key: H) is
			-- Assuming there is no item of key `key',
			-- insert `new' with `key'.
			-- Set `inserted'.
			--
			-- To choose between various insert/replace procedures,
			-- see `instructions' in the Indexing clause.
		require
			not_present: not has (key)
		do
			search_for_insertion (key)
			if soon_full then
				add_space
				search_for_insertion (key)
			end
			if position < capacity and then deleted_marks.item (position) then
				set_not_deleted (position)
			else
				used_slot_count := used_slot_count + 1
			end
			count := count + 1
			put_at_position (new, key)
			set_inserted
		ensure
			inserted: inserted
			insertion_done: item (key) = new
			one_more: count = old count + 1
			same_slot_count_or_one_more_unless_reallocated:
				(used_slot_count = old used_slot_count) or
				(used_slot_count = old used_slot_count + 1) or
				(used_slot_count = count)
			default_property:
				has_default =
					((key = computed_default_key) or (old has_default))
		end

	replace (new: G; key: H) is
			-- Replace item at `key', if present,
			-- with `new'; do not change associated key.
			-- Set `replaced' if and only if a replacement has been made
			-- (i.e. `key' was present); otherwise set `not_found'.
			-- Set `found_item' to the item previously associated
			-- with `key' (default value if there was none).
			--
			-- To choose between various insert/replace procedures,
			-- see `instructions' in the Indexing clause.
		do
			search (key)
			if found then
				content.put (new, position)
				set_replaced
			end
		ensure
			replaced_or_not_found: replaced or not_found
			insertion_done: replaced implies item (key) = new
			no_change_if_not_found: not_found implies
						item (key) = old (item (key))
			found_item_is_old_item: found_item = old (item (key))
		end

	replace_key (new_key: H; old_key: H) is
			-- If there is an item of key `old_key' and no item of key
			-- `new_key', replace the former's key by `new_key',
			-- set `replaced', and set `found_item' to the item
			-- previously associated with `old_key'.
			-- Otherwise set `not_found' or `conflict' respectively.
			-- If `conflict', set `found_item' to the item previously
			-- associated with `new_key'.
			--
			-- To choose between various insert/replace procedures,
			-- see `instructions' in the Indexing clause.
		local
			insert_position: INTEGER
			default_value: G
			default_key: H
		do
			put (default_value, new_key)
			if inserted then
				count := count - 1
				insert_position := position
				search (old_key)
				if found then
					content.put (found_item, insert_position)
					if old_key = default_key then
						set_no_default
					else
						remove_at_position
					end
					if new_key = default_key then
						set_default
					end
					set_replaced
						-- The call to `search' has set `found_item'
						-- to the item previously associated with `old_key'.
				else
					position := insert_position
					remove_at_position
					check
						not_found: not_found
					end
				end
			-- else the call to `put' has set `found_item'
			-- to the item previously associated with `new_key'.
			end
		ensure
			same_count: count = old count
			replaced_or_conflict_or_not_found: replaced or conflict or not_found
			old_absent: (replaced and not equal (new_key, old_key))
								implies (not has (old_key))
			new_present: (replaced or conflict) = has (new_key)
			new_item: replaced implies (item (new_key) = old (item (old_key)))
			not_found_implies_no_old_key: not_found implies old (not has (old_key))
			conflict_iff_already_present: conflict = old (has (new_key))
			not_inserted_if_conflict: conflict implies
						(item (new_key) = old (item (new_key)))
			default_property:
				has_default =
					((new_key = computed_default_key) or
					((new_key /= computed_default_key) and (old has_default)))
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
			-- Set `removed' if and only if an item has been
			-- removed (i.e. `key' was present);
			-- if so, set `position' to index of removed element.
			-- If not, set `not_found'.
			-- Reset `found_item' to its default value if `removed'.
		local
			default_key: H
			default_value: G
		do
			internal_search (key)
			if found then
				if key = default_key then
					set_no_default
				else
					remove_at_position
				end
				count := count - 1
				set_removed
				found_item := default_value
			end
		ensure
			removed_or_not_found: removed or not_found
			not_present: not has (key)
			one_less: found implies (count = old count - 1)
			same_slot_count: used_slot_count = old used_slot_count
			default_case:
				(key = computed_default_key) implies (not has_default)
			non_default_case:
				(key /= computed_default_key) implies
					(has_default = old has_default)
		end

	clear_all is
			-- Reset all items to default values; reset status.
		local
			default_value: G
		do
			content.clear_all
			keys.clear_all
			deleted_marks.clear_all
			found_item := default_value
			count := 0
			used_slot_count := 0
			position := 0
			iteration_position := capacity + 1
			set_no_status
			set_no_default
		ensure then
			position_equal_to_zero: position = 0
			count_equal_to_zero: count = 0
			used_slot_count_equal_to_zero: used_slot_count = 0
			has_default_set: not has_default
			no_status: not special_status
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
		local
			old_iteration_position: INTEGER
		do
			old_iteration_position := iteration_position
			from
				create Result.make (count)
				start
			until
				off
			loop
				Result.extend (item_for_iteration)
				forth
			end
			iteration_position := old_iteration_position
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

feature {NONE} -- Transformation

	correct_mismatch is
			-- Attempt to correct object mismatch during retrieve using `mismatch_information'.
		local
			array_content: ARRAY [G]
			array_keys: ARRAY [H]
			array_marks: ARRAY [BOOLEAN]
			l_deleted_marks: SPECIAL [BOOLEAN]
		do
				-- In version 5.1 and earlier, `content', `keys' and `deleted_marks'
				-- where of base class ARRAY. In 5.2 we changed it to be a SPECIAL for
				-- efficiency reasons. In order to retrieve an old HASH_TABLE we
				-- need to convert those ARRAY instances into SPECIAL instances.

				-- Convert `content' from ARRAY to SPECIAL
			array_content ?= mismatch_information.item ("content")
			if array_content /= Void then
				content := array_content.area
			end

				-- Convert `keys' from ARRAY to SPECIAL
			array_keys ?= mismatch_information.item ("keys")
			if array_keys /= Void then
				keys := array_keys.area
			end

				-- Convert `deleted_marks' from ARRAY to SPECIAL
			array_marks ?= mismatch_information.item ("deleted_marks")
			if array_marks /= Void then
				deleted_marks := array_marks.area
			end

				-- In version 5.5 and later, `deleted_marks' had its size increased by 1 to take
				-- into account removal of default key, and therefore if we hit a 5.4 or earlier
				-- version, we need to resize `deleted_marks' to the new expected size.
			if deleted_marks /= Void then
				if not mismatch_information.has ("hash_table_version_57") then
						-- Unfortunately this handling of the mismatch was added in 5.7 and
						-- therefore we might have stored a valid HASH_TABLE using 5.5 or 5.6.
						-- Fortunately enough we can simply compare the counts of
						-- `deleted_marks' and `keys'. If they are the same it is 5.5 or 5.6,
						-- otherwise it is 5.4 or older.
					if deleted_marks.count /= keys.count then
						l_deleted_marks := deleted_marks
						create deleted_marks.make (keys.count)
						deleted_marks.copy_data (l_deleted_marks, 0, 0, l_deleted_marks.count)
					end
				end
			end

			if content = Void or keys = Void or deleted_marks = Void then
					-- Could not retrieve old version of HASH_TABLE. We throw an exception.
				Precursor {MISMATCH_CORRECTOR}
			end
		end

	hash_table_version_57: BOOLEAN
			-- Fake attribute for versioning purposes. Used in `correct_mismatch'.

feature {HASH_TABLE} -- Implementation: content attributes and preservation

	content: SPECIAL [G]
			-- Array of contents

	keys: SPECIAL [H]
			-- Array of keys

	deleted_marks: SPECIAL [BOOLEAN]
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
		local
			default_value: G
		do
			has_default := False
			content.put (default_value, capacity)
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
			Result := ((used_slot_count + 1) >= capacity * Max_occupation)
		ensure
			Result = ((used_slot_count + 1) >= capacity * Max_occupation)
		end

	control: INTEGER
			-- Control code set by operations that may produce
			-- several possible conditions.

	deleted_position: INTEGER
			-- Place where a deleted element was found during a search

feature {NONE} -- Implementation

	Max_occupation: REAL is 0.9
			-- Filling percentage over which table will be resized

	Initial_occupation: REAL is 0.67
			-- Filling percentage for initial requested occupation (2/3)

	Impossible_position: INTEGER is - 1
			-- Position outside the array indices

	used_slot_count: INTEGER
			-- Number of slots occuped by an element either present
			-- or marked as deleted

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
			default_key: (i = capacity) implies (Result = has_default)
		end

	is_off_position (pos: INTEGER): BOOLEAN is
			-- Is `pos' a cursor position past last item?
		do
			Result := (not has_default and (pos >= capacity)) or
				(has_default and (pos = (capacity + 1)))
		ensure
			definition:
				Result = ((not has_default and (pos >= capacity)) or
							(has_default and (pos = (capacity + 1))))
		end

	set_content (c: like content) is
			-- Assign `c' to `content'.
		do
			content := c
		end

	deleted (i: INTEGER): BOOLEAN is
			-- Is position `i' that of a deleted item?
		require
			in_bounds: i >= 0 and i <= capacity
		do
			Result := deleted_marks.item (i)
		end

	set_not_deleted (i: INTEGER) is
			-- Mark position `i' as not deleted.
		require
			in_bounds: i >= 0 and i <= capacity
		do
			deleted_marks.put (False, i)
		end

	set_deleted (i: INTEGER) is
			-- Mark position `i' as deleted.
		require
			in_bounds: i >= 0 and i <= capacity
		do
			deleted_marks.put (True, i)
		ensure
			deleted: deleted (i)
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
			has_default: has_default
		do
			Result := content.item (capacity)
		end

	computed_default_key: H is
			-- Default key
			-- (For performance reasons, used only in assertions;
			-- elsewhere, see use of local entity `default_key'.)
		do
			-- No instructions necessary (returns default value of type H)
		end

	computed_default_value: G is
			-- Default value of type G
			-- (For performance reasons, used only in assertions;
			-- elsewhere, see use of local entity `default_value'.)
		do
			-- No instructions necessary (returns default value of type G)
		end

	internal_search (key: H) is
			-- Search for item of key `key'.
			-- If successful, set `position' to index
			-- of item with this key (the same index as the key's index).
			-- If not, set `position' to possible position for insertion,
			-- and set status to `found' or `not_found'.
		local
			default_key: H
			hash_value, increment, l_pos, l_capacity: INTEGER
			first_deleted_position: INTEGER
			stop: BOOLEAN
			l_keys: like keys
			l_deleted_marks: like deleted_marks
		do
			first_deleted_position := Impossible_position
			if key = default_key then
				position := capacity
				if has_default then
					control := Found_constant
				else
					control := Not_found_constant
				end
			else
				from
					l_keys := keys
					l_deleted_marks := deleted_marks
					l_capacity := capacity
					hash_value := key.hash_code
					increment := 1 + hash_value \\ (l_capacity - 1)
					l_pos := (hash_value \\ l_capacity)
				until
					stop
				loop
					if l_deleted_marks.item (l_pos) then
						if first_deleted_position = Impossible_position then
							first_deleted_position := l_pos
						end
							-- Go to next increment.
						l_pos := (l_pos + increment) \\ l_capacity
					elseif l_keys.item (l_pos) = default_key then
						stop := True
						control := Not_found_constant
					elseif l_keys.item (l_pos).is_equal (key) then
						stop := True
						control := Found_constant
					else
							-- Go to next increment.
						l_pos := (l_pos + increment) \\ l_capacity
					end
				end
				position := l_pos
			end
			deleted_position := first_deleted_position
		ensure
			found_or_not_found: found or not_found
			deleted_item_at_deleted_position:
				(deleted_position /= Impossible_position) implies
					(deleted (deleted_position))
			default_value_if_not_found:
				not_found implies
					(content.item (position) = computed_default_value)
			default_iff_at_capacity:
				(position = capacity) = (key = computed_default_key)
		end

	search_for_insertion (key: H) is
			-- Assuming there is no item of key `key', compute
			-- `position' at which to insert such an item.
		require
			not_present: not has (key)
		local
			default_key: H
			hash_value, increment, l_pos, l_capacity: INTEGER
			l_deleted_marks: like deleted_marks
			l_keys: like keys
		do
			if key = default_key then
					check
						not has_default
							-- Because of the precondition
					end
				position := capacity
			else
				from
					hash_value := key.hash_code
					l_capacity := capacity
					increment := 1 + hash_value \\ (l_capacity - 1)
					l_pos := (hash_value \\ l_capacity)
					l_deleted_marks := deleted_marks
					l_keys := keys
				until
					l_deleted_marks.item (l_pos) or l_keys.item (l_pos) = default_key
				loop
					l_pos := (l_pos + increment) \\ l_capacity
				end
				position := l_pos
			end
		ensure
			deleted_or_default:
				deleted (position) or (key_at (position) = computed_default_key)
			default_iff_at_capacity:
				(position = capacity) = (key = computed_default_key)
		end

	put_at_position (new: G; key: H) is
			-- Put `new' with `key' at `position'.
		require
			in_bounds: position >= 0 and position <= capacity
			default_if_at_capacity:
				(position = capacity) implies (key = computed_default_key)
		local
			default_key: H
			l_pos: INTEGER
		do
			l_pos := position
			content.put (new, l_pos)
			keys.put (key, l_pos)
			if key = default_key then
				set_default
			end
		ensure
			item_at_position: content.item (position) = new
			key_at_position: key_at (position) = key
			default_if_at_capacity:
				(position = capacity) implies has_default
		end

	remove_at_position is
			-- Remove item at `position'
		require
			in_bounds: position >= 0 and position <= capacity
		local
			default_value: G
			default_key: H
			l_pos: INTEGER
		do
			l_pos := position
			content.put (default_value, l_pos)
			keys.put (default_key, l_pos)
			set_deleted (l_pos)
			if iteration_position = l_pos then
				forth
			end
		ensure
			deleted: deleted (position)
			status_not_changed: control = old control
			count_not_changed: count = old count
			slot_count_not_changed: used_slot_count = old used_slot_count
			key_at (position) = computed_default_key
		end

	key_at (n: INTEGER): H is
			-- Key at position `n'
		require
			in_bounds: n >= 0 and n < capacity
		do
			Result := keys.item (n)
		end

	initial_position (hash_value: INTEGER): INTEGER is
			-- Initial position for an item of hash code `hash_value'
		do
			Result := (hash_value \\ capacity)
		end

	position_increment (hash_value: INTEGER): INTEGER is
			-- Distance between successive positions for hash code
			-- `hash_value' (computed for no cycle: `capacity' is prime)
		do
			Result := 1 + hash_value \\ (capacity - 1)
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
		ensure
			conflict: conflict
		end

	Found_constant: INTEGER is unique
			-- Key found

	set_found is
			-- Set status to found.
		do
			control := Found_constant
		ensure
			found: found
		end

	Inserted_constant: INTEGER is unique
			-- Insertion successful

	set_inserted is
			-- Set status to inserted.
		do
			control := Inserted_constant
		ensure
			inserted: inserted
		end

	Not_found_constant: INTEGER is unique
			-- Key not found

	set_not_found is
			-- Set status to not found.
		do
			control := Not_found_constant
		ensure
			not_found: not_found
		end

	set_no_status is
			-- Set status to normal.
		do
			control := 0
		ensure
			default_status: not special_status
		end

	Removed_constant: INTEGER is unique
			-- Remove successful

	set_removed is
			-- Set status to removed.
		do
			control := Removed_constant
		ensure
			removed: removed
		end

	Replaced_constant: INTEGER is unique
			-- Replaced value

	set_replaced is
			-- Set status to replaced.
		do
			control := Replaced_constant
		ensure
			replaced: replaced
		end

	special_status: BOOLEAN is
			-- Has status been set to some non-default value?
		do
			Result := (control > 0)
		ensure
			Result = (control > 0)
		end

	add_space is
			-- Increase capacity.
		do
				-- Be pessimistic: plan for more growth by allocating 1.5 more than before
			accommodate (count + count // 2)
		ensure
			count_not_changed: count = old count
			slot_count_same_as_count: used_slot_count = count
			breathing_space: count < capacity * Initial_occupation
		end

	Minimum_capacity: INTEGER is 5

feature {NONE} -- Inapplicable

	prune (v: G) is
			-- Remove one occurrence of `v' if any.
		do
		end

	collection_extend (v: G) is
			-- Insert a new occurrence of `v'.
		do
		end

invariant

	keys_not_void: keys /= Void
	content_not_void: content /= Void
	deleted_marks_not_void: deleted_marks /= Void
	keys_same_capacity_plus_one: keys.count = capacity + 1
	content_same_capacity_plus_one: content.count = capacity + 1
	deleted_same_capacity: deleted_marks.count = capacity + 1
	valid_iteration_position: off or truly_occupied (iteration_position)
	control_non_negative: control >= 0
	special_status: special_status =
		(conflict or inserted or replaced or removed or found or not_found)

	max_occupation_meaningful: (Max_occupation > 0) and (Max_occupation < 1)
	initial_occupation_meaningful: (Initial_occupation > 0) and (Initial_occupation < 1)
	sized_generously_enough: Initial_occupation < Max_occupation
	count_big_enough: 0 <= count
	count_small_enough: count <= capacity
	breathing_space: count <= capacity * Max_occupation
	count_no_more_than_slot_count: count <= used_slot_count
	slot_count_big_enough: 0 <= count
	slot_count_small_enough: used_slot_count <= capacity

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class HASH_TABLE


