indexing
	description: "Hash tables, used to store items identified by hashable keys"
	external_name: "ISE.Base.HashTable"

class
	HASH_TABLE [G, H]

inherit
	TABLE [G, H]
	
	FINITE [G]
		rename
			has as has_item
		end
		
create
        make

feature {NONE} -- Initialization

	make (n: INTEGER) is
		indexing
			description: "Creation routine"
		local
			table_size: INTEGER
		do
			table_size := n * 2
			if table_size < Minimum_size then
				table_size := Minimum_size
			end

			create content.make (table_size - 1)
			create keys.make (table_size - 1)
			create deleted_marks.make (table_size - 1)
			iteration_position := table_size
		end

feature -- Access

	item (key: H): G is
		indexing
			description: "Item associated with `key', if present, otherwise default value of type `G'"
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

	infix "@" (key: H): G is
		indexing
			description: "Item associated with `key', if present, otherwise default value of type `G'"
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
		
	current_keys: ARRAY [H] is
		indexing
			description: "Array of actually used keys, from 1 to `count'"
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
		indexing
			description: "Special key used to mark deleted items"
		do
		end

	found_item: G
		indexing
			description: "Item found during a search with `has' to reduce the number of search for clients"
		end

	position: INTEGER
		indexing
			description: "[
						Hash table cursor, updated after each operation:
						put, remove, has, replace, force, change_key...
					  ]"
		end

feature -- Element change

	put (new: G; key:H) is
		indexing
			description: "[
						Insert `new' with `key' if there is no other item
						associated with the same key.
						Make `inserted' true if and only if an insertion has
						been made (i.e. `key' was not present).
					  ]"
		require else
			non_void_new_item: new /= Void
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
				internal_count := count + 1
				control := Inserted_constant
			end
		ensure then
			insertion_done: inserted implies item (key) = new
		end

feature -- Status report

	has (key: H): BOOLEAN is
		indexing
			description: "Is there an item in the table with key `key'? If found, make item available in `found_item'."
		require
			non_void_key: key /= Void
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
		indexing
			description: "[
						Does structure include `v'?
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		local
			i, bound: INTEGER
			local_content: ARRAY [G]
		do
			local_content := content
			bound := local_content.upper
			if object_comparison then
				if v /= Void then
					from
					until
						i > bound or else Result
					loop
						Result := local_content.item (i) /= Void and then v.is_equal (local_content.item (i))
						i := i + 1
					end
				end
			else
				from
				until
					i > bound or else Result
				loop
					Result := local_content.item (i) = v
					i := i + 1
				end
			end
		end
		
	full: BOOLEAN is
		indexing
			description: "Is structured filled to capacity? (Answer: no.)"
		do
			Result := False
		end

	extendible: BOOLEAN is True
		indexing
			description: "May new items be added? (Answer: yes.)"
		end

	prunable: BOOLEAN is
		indexing
			description: "May items be removed? (Answer: yes.)"
		do
			Result := True
		ensure
			is_prunable: Result
		end

	valid_key (k: H): BOOLEAN is
		indexing
			description: "Is `k' a valid key? Answer: yes if and only if `k' is not the default value of type `H'."
		require else
			non_void_key: k /= Void
		local
			dkey: H
		do
			Result := k /= dkey
		ensure then
			valid_if_key_is_default_value: Result = (k /= Void)
		end

	conflict: BOOLEAN is
		indexing
			description: "Did last operation cause a conflict?"
		do
			Result := (control = Conflict_constant)
		end

	inserted: BOOLEAN is
		indexing
			description: "Did last operation insert an item?"
		do
			Result := (control = Inserted_constant)
		end

	replaced: BOOLEAN is
		indexing
			description: "Did last operation replace an item?"
		do
			Result := (control = Changed_constant)
		end

	removed: BOOLEAN is
		indexing
			description: "Did last operation remove an item?"
		do
			Result := (control = Removed_constant)
		end

	found: BOOLEAN is
		indexing
			description: "Did last operation find the item sought?"
		do
			Result := (control = Found_constant)
		end

	is_empty: BOOLEAN is
		indexing
			description: "Is there no element?"
		do
			Result := (count = 0)
		end

	object_comparison: BOOLEAN is 
		indexing
			description: "[ 
						Must search operations use `equal' rather than `='
						for comparing references? (Default: no, use `='.)
					  ]"
		do
			Result := internal_object_comparison
		end

	changeable_comparison_criterion: BOOLEAN is
		indexing
			description: "[
						May `object_comparison' be changed?
						(Answer: yes by default.)
					  ]"
		do
			Result := True
		end

feature -- Status Setting

	compare_objects is
		indexing
			description: "[
						Ensure that future search operations will use `equal'
						rather than `=' for comparing references.
					  ]"
		do
			internal_object_comparison := True
		end

	compare_references is
		indexing
			description: "[
						Ensure that future search operations will use `='
						rather than `equal' for comparing references.
					  ]"
		do
			internal_object_comparison := False
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
		indexing
			description: "Representation as a linear structure"
		local
			i, table_size: INTEGER
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
					Result.extend (local_content.item (i))
				end
				i := i + 1
			end
		ensure then
			Result_exists: Result /= Void
			good_count: Result.count = count
		end
		
feature -- Measurement

	count: INTEGER is
		indexing
			description: "Number of items in table"
		do
			Result := internal_count		
		end

feature {HASH_TABLE} -- Implementation

	internal_implementation: SYSTEM_COLLECTIONS_HASHTABLE
	
	internal_count: INTEGER
	
	internal_object_comparison: BOOLEAN
		
	content: ARRAY [G]
		indexing
			description: "Array of contents"
		end

	keys: ARRAY [H]
		indexing
			description: "Array of keys"
		end

	deleted_marks: ARRAY [BOOLEAN]
		indexing
			description: "Array of deleted marks"
		end

	Size_threshold: INTEGER is 80
		indexing
			description: "Filling percentage over which some resizing is done"
		end

	set_content (c: like content) is
		indexing
			description: "Assign `c' to `content'."
		require
			non_void_content: c /= Void
		do
			content := c
		ensure
			content_set: content = c
		end

	set_keys (k: like keys) is
		indexing
			description: "Assign `k' to `keys'."
		require
			non_void_keys: k /= Void
		do
			keys := k
		ensure
			keys_set: keys = k
		end

	set_deleted_marks (dm: like deleted_marks) is
		indexing
			description: "Assign `dm' to `deleted_marks'."
		require
			non_void_marks: dm /= Void
		do
			deleted_marks := dm
		ensure
			deleted_marks_set: deleted_marks = dm
		end

	set_replaced is
		indexing
			description: "Set `control' with `changed_constant'."
		do
			control := changed_constant
		end

feature {NONE} -- Implementation

	implementation: SYSTEM_COLLECTIONS_HASHTABLE is
		indexing
			description: "Object for .NET access and implementation"
		do
			Result := internal_implementation
		end
		
	iteration_position: INTEGER
		indexing
			description: "Cursor for iteration primitives"
		end

	internal_search (search_key: H) is
		indexing
			description: "[
						Search for item of `search_key'.
						If successful, set `position' to index
						of item with this key (the same index as the key's index).
						If not, set position to possible position for insertion.
						Set `control' to `Found_constant' or `Not_found_constant'.
					  ]"
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
				hash_code := search_key.get_hash_code
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
				elseif search_key.is_equal (old_key) then
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
		indexing
			description: "Insertion successful"
		end

	Found_constant: INTEGER is unique
		indexing
			description: "Key found"
		end

	Changed_constant: INTEGER is unique
		indexing
			description: "Change successful"
		end

	Removed_constant: INTEGER is unique
		indexing
			description: "Remove successful"
		end

	Conflict_constant: INTEGER is unique
		indexing
			description: "Could not insert an already existing key"
		end

	Not_found_constant: INTEGER is unique
		indexing
			description: "Key not found"
		end

	add_space is
		indexing
			description: "Increase capacity."
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
				create other.make ((High_ratio * table_size) // Low_ratio)
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
		indexing
			description: "[
						Is table close to being filled to current capacity?
						(If so, resizing is needed to avoid performance degradation.)
					  ]"
		do
			Result := (keys.count * Size_threshold <= 100 * count)
		end

	control: INTEGER
		indexing
			description: "Control code set by operations that may produce several possible conditions."
		end

	Minimum_size : INTEGER is 5
		indexing
			description: "Minimum size"
		end
		
	High_ratio: INTEGER is 3
		indexing
			description: "High ratio"
		end
		
	Low_ratio: INTEGER is 2
		indexing
			description: "Low ratio"
		end
		
feature --

	remove (key: H)is
		indexing
			description: "[
						Remove item associated with `key', if present.
						Make `removed' true if and only if an item has been
						removed (i.e. `key' was not present).
					  ]"
		require
			valid_key: valid_key (key)
		local
			dkey: H
			dead_item: G
		do
			internal_search (key)
			if control = Found_constant then
				keys.put (position, dkey)
				content.put (position, dead_item)
				deleted_marks.put (position, True)
				control := Removed_constant
				internal_count := count - 1
			end
		ensure
			removed: not has (key)
		end
		
	start is
		indexing
			description: "[
						Bring cursor to first position.
					  ]"
		do
			iteration_position := keys.lower - 1
			forth
		end
		
	after: BOOLEAN is
		indexing
			description: "Is cursor past last item?"
		do
			Result := iteration_position > keys.upper
		end
		
	off: BOOLEAN is
		indexing
			description: "Is cursor past last item?"
		do
			Result := iteration_position > keys.upper
		end
		
	forth is
		indexing
			description: "Advance cursor by one position."
		require
			not_off: not off
		local
			stop: BOOLEAN
			local_keys: ARRAY [H]
			pos_for_iter, table_size: INTEGER
		do
			from
				local_keys := keys
				table_size := keys.upper
				pos_for_iter := iteration_position
			until
				stop
			loop
				pos_for_iter := pos_for_iter + 1
				stop := pos_for_iter > table_size or else valid_key (local_keys.item (pos_for_iter))
			end
			iteration_position := pos_for_iter
		end
		
	item_for_iteration: G is
		indexing
			description: "Element at current iteration position."
		require
			not_off: not off
		do
			Result := content.item (iteration_position)
		end

	key_for_iteration: H is
		indexing
			description: "Key at current iteration position."
		require
			not_off: not off
		do
			Result := keys.item (iteration_position)
		end
		
end -- class HASH_TABLE
