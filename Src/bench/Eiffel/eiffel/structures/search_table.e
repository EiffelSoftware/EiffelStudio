-- Hash tables to store ``hashable'' items

class SEARCH_TABLE [H -> HASHABLE]

inherit
	ARRAY [H]
		rename
			make as basic_make,
			item as array_item,
			put as array_put,
			force as array_force,
			has as array_has,
			count as array_count
		export
			{SEARCH_TABLE} area, lower, upper
		redefine
			clear_all
		end

creation

	make

feature -- Creation

	make (n: INTEGER) is
			-- Allocate hash table for at least `n' items.
			-- The table will be resized automatically
			-- if more than `n' items are inserted.
		local
			clever: PRIMES;
			table_size: INTEGER
		do
			!!clever;
			table_size := clever.higher_prime (n);
			if table_size < 5 then
				table_size := 5
			end;
			basic_make (0, table_size - 1);
			!! deleted_marks.make (0, table_size - 1);
		ensure
			capacity_big_enough: capacity >= n and capacity >= 5;
		end;

feature -- Access and queries

	item (key: H): H is
			-- Item associated with `key', if present;
			-- otherwise default value of type `G'
		do
			internal_search (key);
			if control = Found then
				Result := array_item (position)
			end
		end;

	has (key: H): BOOLEAN is
			-- Is `access_key' currently used?
			-- (Shallow equality)
		do
			internal_search (key);
			Result := (control = Found)
		end;

	key_at (n: INTEGER): H is
			-- Key corresponding to entry `n'
		do
			Result := array_item (n)
		end;

feature -- Insertion, deletion

	put (key: H) is
			-- Attempt to insert `new' with `key'.
			-- Set `control' to `Inserted' or `Conflict'.
			-- No insertion if conflict.
		do
			internal_search (key);
			if control = Found then
				control := Conflict
			else
				if soon_full then
					add_space;
					internal_search (key)
				end;
				array_put (key, position);
				count := count + 1;
				control := Inserted
			end
		ensure then
			insertion_done: control = Inserted implies item (key) = key
		end;

	force (key: H) is
			-- If `key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `key'.
			-- Set `control' to `Inserted'.
		require else
			valid_key (key);
		do
			internal_search (key);
			if control /= Found then
				if soon_full then
					add_space;
					internal_search (key)
				end;
				count := count + 1
			end;
			array_put (key, position);
			control := Inserted
		ensure then
			insertion_done: item (key) = key
		end;

	change_key (new_key: H; old_key: H) is
			-- If table contains an item at `old_key',
			-- replace its key by `new_key'.
			-- Set `control' to `Changed', `Conflict' or `Not_found'.
		require
			valid_keys: valid_key (new_key) and valid_key (old_key)
		do
			internal_search (old_key);
			if control = Found then
				array_put (new_key, position);
				if control /= Conflict then
					remove (old_key);
					control := Changed
				end
			end
		ensure
			changed: control = Changed implies not has (old_key)
		end;

	remove (key: H) is
			-- Remove item associated with `key', if present.
			-- Set `control' to `Removed' or `Not_found'.
		require
			valid_key: valid_key (key)
		local
			dead_key: H;
		do
			internal_search (key);
			if control = Found then
				array_put (dead_key, position);
				deleted_marks.put (True, position);
				count := count - 1;
			end
		ensure
			not_has: not has (key);
		end;

	clear_all is
			-- Reset all items to default values.
		do
			{ARRAY} precursor
			deleted_marks.clear_all
			count := 0
			control := 0
			position := 0
		end;

feature -- Number of elements

	count: INTEGER;
			-- Number of items actually inserted in `Current'

feature {NONE} -- Internal features

	position: INTEGER;
			-- Hash table cursor

	internal_search (search_key: H) is
			-- Search for item of `search_key'.
			-- If successful, set `position' to index
			-- of item with this key (the same index as the key's index).
			-- If not, set position to possible position for insertion.
			-- Set `control' to `Found' or `Not_found'.
		require
			good_key: valid_key (search_key)
		local
			increment, hash_code, table_size: INTEGER;
			first_deleted_position, trace_deleted, visited_count: INTEGER;
			old_key: H;
			stop: BOOLEAN
		do
			from
				first_deleted_position := -1;
				table_size := array_count;
				hash_code := search_key.hash_code;
				-- Increment computed for no cycle: `table_size' is prime
				increment := 1 + hash_code \\ (table_size - 1);
				position := (hash_code \\ table_size) - increment;
			until
				stop or else visited_count >= table_size
			loop
				position := (position + increment) \\ table_size;
				visited_count := visited_count + 1;
				old_key := array_item (position);
				if not valid_key (old_key) then
					if not deleted_marks.item (position) then
						control := Not_found;
						stop := true;
						if first_deleted_position >= 0 then
							position := first_deleted_position
						end
					elseif first_deleted_position < 0 then
						first_deleted_position := position
					end
				elseif search_key.is_equal (old_key) then
					control := Found;
					stop := true
				end
			end;
			if not stop then
				control := Not_found;
				if first_deleted_position >= 0 then
					position := first_deleted_position
				end;
			end;
		end;

	add_space is
			-- Double the capacity of `Current'.
			-- Transfer everything except deleted keys.
		local
			i, table_size: INTEGER;
			current_key: H;
			other: SEARCH_TABLE [H]
		do
			from
				table_size := array_count;
				!!other.make ((3 * table_size) // 2);
			until
				i >= table_size
			loop
				current_key := array_item (i);
				if valid_key (current_key) then
					other.put (current_key)
				end;
				i := i + 1
			end;
			area := other.area;
			lower := other.lower;
			upper := other.upper;
			deleted_marks := other.deleted_marks;
		end;

	Size_threshold: INTEGER is 80;
			-- Filling percentage over which some resizing is done

	soon_full: BOOLEAN is
			-- Is `Current' close to being filled?
			-- (If so, resizing is needed to avoid performance degradation.)
		do
			Result := (array_count * Size_threshold <= 100 * count)
		end;

feature -- Assertion check

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
		local
			dead_key: H
		do
			Result := k /= dead_key and then k.is_hashable
		end;

feature {NONE} -- Status

	control: INTEGER;
			-- Control code set by operations that may return
			-- several possible conditions.
			-- Possible control codes are the following:

	Inserted: INTEGER is unique;
			-- Insertion successful

	Found: INTEGER is unique;
			-- Key found

	Changed: INTEGER is unique;
			-- Change successful

	Removed: INTEGER is unique;
			-- Remove successful

	Conflict: INTEGER is unique;
			-- Could not insert an already existing key

	Not_found: INTEGER is unique;
			-- Key not found

feature {SEARCH_TABLE}

	deleted_marks: ARRAY [BOOLEAN];
			-- Deleted marks

	set_deleted_marks (d: ARRAY [BOOLEAN]) is
			-- Assign `d' to `deleted_marks'.
		do
			deleted_marks := d
		end;

feature -- Iteration

	start is
			-- Iteration initialization
		do
			pos_for_iter := lower - 1;
			forth;
		end;

	forth is
			-- Iteration
		local
			stop: BOOLEAN;
		do
			from
			until
				stop
			loop
				pos_for_iter := pos_for_iter + 1;
				stop := after or else valid_key (array_item (pos_for_iter));
			end
		end;

	after: BOOLEAN is
			-- Is the iteration cursor off ?
		do
			Result := pos_for_iter > upper
		end;

	offright: BOOLEAN is obsolete "Use `after'"
		do
			Result := after
		end;

	item_for_iteration: H is
			-- Item at cursor position
		require
			not_off: not after
		do
			Result := array_item (pos_for_iter)
		end;

feature {NONE} -- Iteration cursor

	pos_for_iter: INTEGER;
			-- Iteration position value

invariant

	count_big_enough: 0 <= count;

end
