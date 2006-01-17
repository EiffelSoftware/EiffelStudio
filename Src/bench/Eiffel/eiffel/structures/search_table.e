indexing
	description: "Set based on implementation of HASH_TABLE for fast lookup"
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

create
	make

feature -- Creation

	make (n: INTEGER) is
			-- Allocate hash table for at least `n' items.
			-- The table will be resized automatically
			-- if more than `n' items are inserted.
		local
			clever: PRIMES
			local_content: ARRAY [H]
			local_deleted_marks: ARRAY [BOOLEAN]
		do
			create clever
			capacity := clever.higher_prime ((3 * n) // 2)
			if capacity < 5 then
				capacity := 5
			end
			create local_content.make (0, capacity - 1)
			create local_deleted_marks.make (0, capacity - 1)
			content := local_content.area
			deleted_marks := local_deleted_marks.area
		ensure
			capacity_big_enough: capacity >= n and capacity >= 5
		end

feature -- Access and queries

	item (key: H): H is
			-- Item associated with `key', if present
			-- otherwise default value of type `G'
		require
			valid_key: valid_key (key)
		do
			internal_search (key)
			if control = Found_constant then
				Result := content.item (position)
			end
		end

	has (key: H): BOOLEAN is
			-- Is `access_key' currently used?
			-- (Shallow equality)
		require
			valid_key: valid_key (key)
		do
			internal_search (key)
			Result := (control = Found_constant)
		end

	key_at (n: INTEGER): H is
			-- Key corresponding to entry `n'
		do
			if n >= 0 and n < content.count then
				Result := content.item (n)
			end
		end

	is_empty: BOOLEAN is
			-- Is structure empty?
		do
			Result := (count = 0)
		end

	search (key: H) is
			-- Search for item of key `key'
			-- If found, set `found' to True, and set
			-- `found_item' to item associated with `key'.
		local
			default_value: H
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

	found_item: H
			-- Item found during a search with `has' to reduce the number of
			-- search for clients

	found: BOOLEAN is
			-- Did last operation find the item sought?
		do
			Result := (control = Found_constant)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does table contain the same information as `other'?
		do
			Result :=
				equal (content, other.content) and
				equal (deleted_marks, other.deleted_marks)
		end

feature -- Insertion, deletion

	put (key: H) is
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

	force (key: H) is
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

	change_key (new_key: H; old_key: H) is
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

	remove, prune (key: H) is
			-- Remove item associated with `key', if present.
			-- Set `control' to `Removed' or `Not_found_constant'.
		require
			valid_key: valid_key (key)
		local
			dead_key: H
		do
			internal_search (key)
			if control = Found_constant then
				content.put (dead_key, position)
				deleted_marks.put (True, position)
				count := count - 1
			end
		ensure
			not_has: not has (key)
		end

	wipe_out, clear_all is
			-- Reset all items to default values.
		local
			default_value: H
		do
			content.clear_all
			deleted_marks.clear_all
			count := 0
			control := 0
			position := 0
			found_item := default_value
		end

	merge (other: like Current) is
			-- Merge two search_tables
		require
			other_not_void: other /= Void
		local
			local_other, local_current, new_content: SPECIAL[H]
			new: SEARCH_TABLE[H]
			i, my_size, other_size: INTEGER
			current_key: H
		do
			if other.count /= 0 then
				local_other := other.content
				local_current := content
				other_size := local_other.count
				my_size := local_current.count
				if ((my_size + other_size) * Size_threshold <= 100*count) then
					from		
						create new.make (3 * (capacity + other_size) // 2)
						new_content := new.content
					until
						i >= my_size
					loop
						current_key := local_current.item(i)
						if valid_key (current_key) then
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
					current_key := local_other.item(i)
					if valid_key (current_key) then
						put (current_key)
					end
					i := i + 1
				end
			end
		end
				
feature -- Number of elements

	count: INTEGER
			-- Number of items actually inserted in `Current'

feature -- Duplication

	copy (other: like Current) is
			-- Re-initialize from `other'.
		do
			standard_copy (other)
			content := other.content.twin
			deleted_marks := other.deleted_marks.twin
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [H] is
			-- Representation as a linear structure
			-- (order is same as original order of insertion)
		local
			i, table_size: INTEGER
			l_content: like content
			l_item: H
		do
			from
				l_content := content
				create Result.make (count)
				table_size := l_content.count - 1
			until
				i > table_size
			loop
				l_item := l_content.item (i)
				if valid_key (l_item) then
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
			-- Hash table cursor

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
			local_content: SPECIAL [H]
			local_deleted_marks: SPECIAL [BOOLEAN]
		do
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
				if old_key = default_key then
					if not local_deleted_marks.item (pos) then
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

	add_space is
			-- Double the capacity of `Current'.
			-- Transfer everything except deleted keys.
		local
			i, table_size: INTEGER
			current_key: H
			other: SEARCH_TABLE [H]
			local_content: SPECIAL [H]
		do
			from
				create other.make ((3 * capacity) // 2)
				local_content := content
				table_size := local_content.count
			until
				i >= table_size
			loop
				current_key := local_content.item (i)
				if valid_key (current_key) then
					other.put (current_key)
				end
				i := i + 1
			end
			content := other.content
			deleted_marks := other.deleted_marks
			capacity := other.capacity
		end

	Size_threshold: INTEGER is 80
			-- Filling percentage over which some resizing is done

	soon_full: BOOLEAN is
			-- Is `Current' close to being filled?
			-- (If so, resizing is needed to avoid performance degradation.)
		do
			Result := (content.count * Size_threshold <= 100 * count)
		end

feature -- Assertion check

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
		local
			dead_key: H
		do
			Result := k /= dead_key and then k.is_hashable
		end

feature {NONE} -- Status

	control: INTEGER
			-- Control code set by operations that may return
			-- several possible conditions.
			-- Possible control codes are the following:

	Inserted: INTEGER is unique
			-- Insertion successful

	Found_constant: INTEGER is unique
			-- Key found

	Changed: INTEGER is unique
			-- Change successful

	Removed: INTEGER is unique
			-- Remove successful

	Conflict: INTEGER is unique
			-- Could not insert an already existing key

	Not_found_constant: INTEGER is unique
			-- Key not found

feature {SEARCH_TABLE}

	capacity: INTEGER
			-- Size of the table

	deleted_marks: SPECIAL [BOOLEAN]
			-- Deleted marks

	content: SPECIAL [H]
			-- Content

feature -- Iteration

	start is
			-- Iteration initialization
		do
			iteration_position := -1
			forth
		end

	forth is
			-- Iteration
		local
			stop: BOOLEAN
			local_content: SPECIAL [H]
			pos_for_iter, table_size: INTEGER
		do
			from
				local_content := content
				pos_for_iter := iteration_position
				table_size := capacity - 1
			until
				stop
			loop
				pos_for_iter := pos_for_iter + 1
				stop := pos_for_iter > table_size or else valid_key (local_content.item (pos_for_iter))
			end
			iteration_position := pos_for_iter
		end

	after, off: BOOLEAN is
			-- Is the iteration cursor off ?
		do
			Result := iteration_position > capacity - 1
		end

	item_for_iteration, key_for_iteration: H is
			-- Item at cursor position
		require
			not_off: not after
		do
			Result := content.item (iteration_position)
		end

feature {NONE} -- Iteration cursor

	iteration_position: INTEGER
			-- Iteration position value

invariant
	count_big_enough: 0 <= count

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SEARCH_TABLE
