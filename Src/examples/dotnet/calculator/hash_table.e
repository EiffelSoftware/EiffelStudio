indexing
	description: "Hash tables, used to store items identified by hashable keys"
	external_name: "ISE.Examples.Calculator.HashTable"

class
	HASH_TABLE [G, H]

creation
        make

feature {NONE} -- Initialization

	make (n: INTEGER) is
		indexing
			description: "Creation routine"
			external_name: "Make"
		local
			table_size: INTEGER
		do
			table_size := n * 2
			if table_size < Minimum_size then
				table_size := Minimum_size
			end

			create content.make (table_size - 1);
			create keys.make (table_size - 1);
			create deleted_marks.make (table_size - 1);
			iteration_position := table_size
		end

feature -- Access

	item (key: H): G is
		indexing
			description: "Item associated with `key', if present, otherwise default value of type `G'"
			external_name: "Item"
		require
			non_void_key: key /= Void
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
			external_name: "CurrentKeys"
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
			external_name: "DeadKey"
		do
		end

	found_item: G
		indexing
			description: "Item found during a search with `has' to reduce the number of search for clients"
			external_name: "FoundItem"
		end

	position: INTEGER
		indexing
			description: "[Hash table cursor, updated after each operation:%
						%put, remove, has, replace, force, change_key...]"
			external_name: "Position"
		end

feature -- Element change

	put (new: G; key:H) is
		indexing
			description: "[Insert `new' with `key' if there is no other item%
						%associated with the same key.%
						%Make `inserted' true if and only if an insertion has%
						%been made (i.e. `key' was not present).]"
			external_name: "Put"
		require
			non_void_new_item: new /= Void
			non_void_key: key /= Void
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

	has (key: H): BOOLEAN is
		indexing
			description: "Is there an item in the table with key `key'? If found, make item available in `found_item'."
			external_name: "Has"
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
		
	full: BOOLEAN is False
		indexing
			description: "Is structured filled to capacity? (Answer: no.)"
			external_name: "Full"
		end

	extendible: BOOLEAN is True
		indexing
			description: "May new items be added? (Answer: yes.)"
			external_name: "Extendible"
		end

	prunable: BOOLEAN is
		indexing
			description: "May items be removed? (Answer: yes.)"
			external_name: "Prunable"
		do
			Result := True
		ensure
			is_prunable: Result
		end

	valid_key (k: H): BOOLEAN is
		indexing
			description: "Is `k' a valid key? Answer: yes if and only if `k' is not the default value of type `H'."
			external_name: "ValidKey"
		require
			non_void_key: k /= Void
		local
			dkey: H
		do
			Result := k /= dkey
		ensure
			valid_if_key_is_default_value: Result = (k /= void)
		end

	conflict: BOOLEAN is
		indexing
			description: "Did last operation cause a conflict?"
			external_name: "Conflict"
		do
			Result := (control = Conflict_constant)
		end

	inserted: BOOLEAN is
		indexing
			description: "Did last operation insert an item?"
			external_name: "Inserted"
		do
			Result := (control = Inserted_constant)
		end

	replaced: BOOLEAN is
		indexing
			description: "Did last operation replace an item?"
			external_name: "Replaced"
		do
			Result := (control = Changed_constant)
		end

	removed: BOOLEAN is
		indexing
			description: "Did last operation remove an item?"
			external_name: "Removed"
		do
			Result := (control = Removed_constant)
		end

	found: BOOLEAN is
		indexing
			description: "Did last operation find the item sought?"
			external_name: "Found"
		do
			Result := (control = Found_constant)
		end
		
feature -- Measurement

	count: INTEGER
		indexing
			description: "Number of items in table"
			external_name: "Count"
		end

feature {HASH_TABLE} -- Implementation

	content: ARRAY [G]
		indexing
			description: "Array of contents"
			external_name: "Content"
		end

	keys: ARRAY [H]
		indexing
			description: "Array of keys"
			external_name: "Keys"
		end

	deleted_marks: ARRAY [BOOLEAN]
		indexing
			description: "Array of deleted marks"
			external_name: "DeletedMarks"
		end

	Size_threshold: INTEGER is 80
		indexing
			description: "Filling percentage over which some resizing is done"
			external_name: "SizeThreshold"
		end

	set_content (c: like content) is
		indexing
			description: "Assign `c' to `content'."
			external_name: "SetContent"
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
			external_name: "SetKeys"
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
			external_name: "SetDeletedMarks"
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
			external_name: "SetReplaced"
		do
			control := changed_constant
		end

feature {NONE} -- Implementation

	iteration_position: INTEGER
		indexing
			description: "Cursor for iteration primitives"
			external_name: "IterationPosition"
		end

	internal_search (search_key: H) is
		indexing
			description: "[Search for item of `search_key'.%
						%If successful, set `position' to index%
						%of item with this key (the same index as the key's index).%
						%If not, set position to possible position for insertion.%
						%Set `control' to `Found_constant' or `Not_found_constant'.]"
			external_name: "InternalSearch"
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
		indexing
			description: "Insertion successful"
			external_name: "InsertedConstant"
		end

	Found_constant: INTEGER is unique
		indexing
			description: "Key found"
			external_name: "FoundConstant"
		end

	Changed_constant: INTEGER is unique
		indexing
			description: "Change successful"
			external_name: "ChangedConstant"
		end

	Removed_constant: INTEGER is unique
		indexing
			description: "Remove successful"
			external_name: "RemovedConstant"
		end

	Conflict_constant: INTEGER is unique
		indexing
			description: "Could not insert an already existing key"
			external_name: "ConflictConstant"
		end

	Not_found_constant: INTEGER is unique
		indexing
			description: "Key not found"
			external_name: "NotFoundConstant"
		end

	add_space is
		indexing
			description: "Increase capacity."
			external_name: "AddSpace"
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
		indexing
			description: "[Is table close to being filled to current capacity?%
						%(If so, resizing is needed to avoid performance degradation.)]"
			external_name: "SoonFull"
		do
			Result := (keys.count * Size_threshold <= 100 * count)
		end

	control: INTEGER
		indexing
			description: "Control code set by operations that may produce several possible conditions."
			external_name: "Control"
		end

	Minimum_size : INTEGER is 5
		indexing
			description: "Minimum size"
			external_name: "MinimumSize"
		end
		
	High_ratio: INTEGER is 3
		indexing
			description: "High ratio"
			external_name: "HighRatio"
		end
		
	Low_ratio: INTEGER is 2
		indexing
			description: "Low ratio"
			external_name: "LowRatio"
		end
		
end -- class HASH_TABLE


--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

