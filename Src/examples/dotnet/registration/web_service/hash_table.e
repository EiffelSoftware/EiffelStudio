indexing
	description:
		"Hash tables, used to store items identified by hashable keys"

class
	HASH_TABLE [G, H]
alias
	"ISE.Base.HashTable"

create
        make

feature -- Initialization

	make (n: INTEGER) is
		local
			table_size: INTEGER
			lg: ARRAY [G]
			lh: ARRAY [H]
			lb: ARRAY [BOOLEAN]
		do
			table_size := n * 2
			if table_size < Minimum_size then
				table_size := Minimum_size
			end;

			create lg.make (table_size - 1);
			content := lg

			create lh.make (table_size - 1);
			keys := lh

			create lb.make (table_size - 1);
			deleted_marks := lb

			iteration_position := table_size
		end

feature -- Access

	item (key: H): G is
			-- Item associated with `key', if present
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

	current_keys: ARRAY [H] is
			-- Array of actually used keys, from 1 to `count'
		local
			i, j, table_size: INTEGER
			scanned_key: H
			local_keys: ARRAY [H]
		do
			from
				local_keys := keys
				table_size := local_keys.upper
				create Result.make (count)
			until
				i > table_size
			loop
				scanned_key := local_keys.item (i)
				if valid_key (scanned_key) then
					Result.put (j, scanned_key)
					j := j + 1
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

feature -- Conversion

	linear_representation: ARRAY [G] is
			-- Representation as a linear structure
			-- (order is same as original order of insertion)
		local
			i, j, table_size: INTEGER
			local_keys: ARRAY [H]
			local_content: ARRAY [G]
		do
			from
				local_content := content
				local_keys := keys
				create Result.make (count)
				table_size := local_content.upper
			until
				i > table_size
			loop
				if valid_key (local_keys.item (i)) then
					Result.put (j, local_content.item (i))
					j := j + 1
				end
				i := i + 1
			end
		ensure then
			Result_exists: Result /= Void
			good_count: Result.Count = count
		end

feature -- Element change

	put (new: G; key:H) is
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
				content.put (position, new)
				keys.put (position, key)
				count := count + 1
				control := Inserted_constant
			end
		ensure then
			insertion_done: inserted implies item (key) = new
		end

feature -- Status report

	full: BOOLEAN is false
			-- Is structured filled to capacity? (Answer: no.)

	extendible: BOOLEAN is true
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := true
		end

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
			-- Answer: yes if and only if `k' is not the default
			-- value of type `H'.
		local
			dkey: H
		do
			Result := k /= dkey
		ensure
			--Result = (k /= void)
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
feature -- Measurement

	count: INTEGER
			-- Number of items in table

feature {HASH_TABLE} -- Implementation

	keys: ARRAY [H]
			-- Array of keys

	content: ARRAY [G]
			-- Array of contents

	deleted_marks: ARRAY [BOOLEAN]
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
			first_deleted_position, trace_deleted, visited_count: INTEGER
			old_key, default_key: H
			stop: BOOLEAN
			local_keys: ARRAY [H]
			local_deleted_marks: ARRAY [BOOLEAN]
		do
			from
				local_keys := keys
				local_deleted_marks := deleted_marks
				first_deleted_position := -1
				table_size := local_keys.count
				hash_code := search_key.gethashcode
				-- Increment computed for no cycle: `table_size' is prime
				increment := 1 + hash_code \\ (table_size - 1)
				pos := (hash_code \\ table_size) - increment
			until
				stop or else visited_count >= table_size
			loop
				pos := (pos + increment) \\ table_size
				visited_count := visited_count + 1
				old_key := local_keys.item (pos)
				if old_key = default_key then
					if not local_deleted_marks.item (pos) then
						control := Not_found_constant
						stop := true
						if first_deleted_position >= 0 then
							pos := first_deleted_position
						end
					elseif first_deleted_position < 0 then
						first_deleted_position := pos
					end
				elseif search_key.equals (old_key) then
					control := Found_constant
					stop := true
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
			local_keys: ARRAY [H]
			local_content: ARRAY [G]
		do
			from
				local_content := content
				local_keys := keys
				table_size := local_keys.count
				!! other.make ((High_ratio * table_size) // Low_ratio)
			until
				i >= table_size
			loop
				current_key := local_keys.item (i)
				if valid_key (current_key) then
					other.put (local_content.item (i), current_key)
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

	Minimum_size : INTEGER is 5

	High_ratio : INTEGER is 3

	Low_ratio : INTEGER is 2

end
