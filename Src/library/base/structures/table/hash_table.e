indexing

	description:
		"Hash tables, used to store items identified by hashable keys";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class HASH_TABLE [G, H -> HASHABLE] inherit

	UNBOUNDED [G]
		rename
			has as has_item
		redefine
			has_item, copy, is_equal
		end;

	TABLE [G, H]
		rename
			has as has_item,
			wipe_out as clear_all
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
			clever: PRIMES;
			table_size: INTEGER
		do
			!! clever;
			table_size := clever.next_prime (n);
			if table_size < 5 then
				table_size := 5
			end;
			!! content.make (0, table_size - 1);
			!! keys.make (0, table_size - 1);
			!! deleted_marks.make (0, table_size - 1);
		ensure
			keys_big_enough: 		keys.capacity >= n
										and
										keys.capacity >= 5;
			content_big_enough: 	content.capacity >= n
									  	and
										content.capacity >= 5;
			deleted_marks_big_enough: 	deleted_marks.capacity >= n
									  	and
										deleted_marks.capacity >= 5
		end;

feature -- Access

	item, infix "@" (key: H): G is
			-- Item associated with `key', if present;
			-- otherwise default value of type `G'
		do
			internal_search (key);
			if control = Found_constant then
				Result := content.item (position)
			end
		end;

	has (key: H): BOOLEAN is
			-- Is there an item in the table with key `key'?
		do
			internal_search (key);
			Result := (control = Found_constant)
		end;

	has_item (v: G): BOOLEAN is
				-- Does structure include `v'?
				-- (According to the currently adopted
				-- discrimination rule)
		local
			i, bound: INTEGER
		do
			from
				bound := content.upper
			until
				i > bound or else Result
			loop
				Result := content.item (i) = v;
				i := i + 1
			end;
		end;

	key_at (n: INTEGER): H is
			-- Key corresponding to entry `n'
		do	
			if n >=0 and n < keys.count  then	
				Result := keys.item (n);
			else
				Result := void;
			end;
		end;

	current_keys: ARRAY [H] is
			-- Array of actually used keys, from 1 to `count'
		local
			i, j, table_size: INTEGER;
			scanned_key: H
		do
			from
				table_size := keys.upper;
				!! Result.make (1, count);
			until
				i > table_size
			loop
				scanned_key := keys.item (i);
				if valid_key (scanned_key) then
					j := j + 1;
					Result.put (scanned_key, j)
				end;
				i := i + 1
			end
		ensure
			good_count: Result.count = count
 		end;

	position: INTEGER;
			-- Hash table cursor, updated after each operation:
			-- put, remove, has, replace, force, change_key...

    item_for_iteration: G is
            -- Element at current iteration position
        require
            not_over: not over
        do
            Result := content.item (pos_for_iter)
        end;

    key_for_iteration: H is
            -- Key at current iteration position
        require
            not_over: not over
        do
            Result := keys.item (pos_for_iter)
        end;

feature -- Measurement

	count: INTEGER;
			-- Number of elements in table

feature -- Comparison
 
	is_equal (other: like Current): BOOLEAN is
			-- Does table contain the same information as `other'?
		do
			Result := 
				equal (keys, other.keys) and
				equal (content, other.content) and
				equal (deleted_marks, other.deleted_marks)
		end;

feature -- Status report
 
	full: BOOLEAN is false;
			-- Is structured filled to capacity? (Answer: no.)

	extendible: BOOLEAN is true;
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := true
		end;

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
		do
			Result := k /= Void and then k.hash_code > 0
		end;

 
	conflict: BOOLEAN is
			-- Did the last operation lead to a conflict status?
		do
			Result := control = Conflict_constant
		end;

	inserted: BOOLEAN is
			-- Did the last operation lead to an insertion?
		do
			Result := control = Inserted_constant
		end;

	changed: BOOLEAN is
			-- Did the last operation lead to a replacement?
		do
			Result := control = Changed_constant
		end;

	found: BOOLEAN is
			-- Did the last operation lead to a found status?
		do
			Result := control = Found_constant
		end;

	not_found: BOOLEAN is
			-- Did the last operation lead to a not-found status?
		do
			Result := control = Not_found_constant
		end;

    over: BOOLEAN is
            -- Is the cursor at the end?
        do
            Result := pos_for_iter > keys.upper
        end;

feature -- Cursor movement

    start is
            -- Bring cursor to first position.
        do
            pos_for_iter := keys.lower - 1;
            forth
        end;

    forth is
            -- Advance cursor by one position.
        require
            not_over: not over
        local
            stop: BOOLEAN
        do
            from
            until
                stop
            loop
                pos_for_iter := pos_for_iter + 1;
                stop := over or else valid_key (keys.item (pos_for_iter))
            end
        end;

feature -- Element change

	put (new: G; key: H) is
			-- Attempt to insert `new' with `key'.
			-- Set `control' to `Inserted_constant' or `Conflict_constant'.
			-- No insertion if conflict.
		do
			internal_search (key);
			if control = Found_constant then
				control := Conflict_constant
			else
				if soon_full then
					add_space;
					internal_search (key)
				end;
				content.put (new, position);
				keys.put (key, position);
				count := count + 1;
				control := Inserted_constant
			end
		ensure then
			insertion_done: control = Inserted_constant implies item (key) = new
		end;

	replace (new: G; key: H) is
			-- Replace item at `key', if present,
			-- with `new'; do not change associated key.
			-- Set `control' to `Changed_constant' or `Not_found_constant'.
		require
			valid_key (key)
		do
			internal_search (key);
			if control = Found_constant then
				content.put (new, position);
				control := Changed_constant
			else
				control := Not_found_constant
			end
		ensure
			insertion_done: control = Changed_constant implies item (key) = new
		end;

	force (new: G; key: H) is
			-- If `key' is present, replace corresponding item by `new',
			-- if not, insert item `new' with key `key'.
			-- Set `control' to `Inserted_constant'.
		require else
			valid_key (key);
		do
			internal_search (key);
			if control /= Found_constant then
				if soon_full then
					add_space;
					internal_search (key)
				end;
				keys.put (key, position);
				count := count + 1
			end;
			content.put (new, position);
			control := Inserted_constant
		ensure then
			insertion_done: item (key) = new
		end;

	change_key (new_key: H; old_key: H) is
			-- If table contains an item at `old_key',
			-- replace its key by `new_key'.
		require
			valid_keys: valid_key (new_key) and valid_key (old_key)
		local
			old_index: INTEGER;
			dead_key: H;
			dead_item: G
		do
			internal_search (old_key);
			if control = Found_constant then
				old_index := position;
				put (content.item (old_index), new_key);
				if control /= Conflict_constant then
					count := count - 1;
					if position /= old_index then
						keys.put (dead_key, old_index);
						content.put (dead_item, old_index);
						deleted_marks.put (true, old_index);
					end;
					control := Changed_constant
				end
			end
		ensure
			changed: control = Changed_constant implies not has (old_key)
		end;

feature -- Removal

	remove (key: H) is
			-- Remove item associated with `key', if present.
			-- Set `control' to `Removed_constant' or `Not_found_constant'.
		require
			valid_key: valid_key (key)
		local
			iter_pos, increment, hash_code, table_size: INTEGER;
			k, dead_key: H;
			old_item, dead_item: G
		do
			internal_search (key);
			if control = Found_constant then
				keys.put (dead_key, position);
				content.put (dead_item, position);
				deleted_marks.put (true, position);
				control := Removed_constant;
				count := count - 1
			end
		ensure
			removed: not has (key)
		end;

	clear_all is
			-- Reset all items to default values.
		do
			content.clear_all;
			keys.clear_all;
			deleted_marks.clear_all;
			count := 0;
			control := 0;
			position := 0
		end;

feature -- Conversion

	sequential_representation: ARRAYED_LIST [G] is
			-- Representation as a sequential structure
			-- (order is same as original order of insertion)
		local
			i, table_size: INTEGER;
		do
			from
				!! Result.make (count);
				table_size := content.upper;
			until
				i > table_size
			loop
				if valid_key (keys.item (i)) then
					Result.extend (content.item (i));
				end;
				i := i + 1
			end;
		ensure then
			Result_exists: Result /= Void;
			good_count: Result.count = count
		end;

feature -- Duplication
 
	copy (other: like Current) is
			-- Re-initialize from `other'.
		do
			set_keys (clone (keys));
			set_content (clone (content));
			set_deleted_marks (clone (deleted_marks))
		end;

feature -- Obsolete

	max_size: INTEGER is obsolete "Use ``capacity''"
		do
			Result := keys.count
		end;


	change_item (new: G; access_key: H) is obsolete "Use ``replace''"
		do
			replace (new, access_key)
		end;

feature {HASH_TABLE} -- Implementation

	content: ARRAY [G];
			-- Array of contents

	keys: ARRAY [H];
			-- Array of keys

	deleted_marks: ARRAY [BOOLEAN];
			-- Array of deleted marks

	Size_threshold: INTEGER is 80;
			-- Filling percentage over which some resizing is done

 
	set_content (c: like content) is
			-- Assign `c' to `content'.
		do
			content := c
		end;

	set_keys (c: like keys) is
			-- Assign `c' to `keys'.
		do
			keys := c
		end;

	set_deleted_marks (c: like deleted_marks) is
			-- Assign `c' to `deleted_marks'.
		do
			deleted_marks := c
		end;

feature {NONE} -- Inapplicable

	prune (v: G) is
			-- Remove one occurrence of `v' if any.
		do
		end;

	extend (v: G) is
			-- Insert a new occurrence of `v' 
		do
		end;

	occurrences (v: G): INTEGER is
			-- Here temporarily; must be brought back as
			-- exported feature!
		do
		end;

feature {NONE} -- Implementation

    pos_for_iter: INTEGER;
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
			increment, hash_code, table_size: INTEGER;
			first_deleted_position, trace_deleted, visited_count: INTEGER;
			old_key: H;
			stop: BOOLEAN
		do
			from
				first_deleted_position := -1;
				table_size := keys.count;
				hash_code := search_key.hash_code;
				-- Increment computed for no cycle: `table_size' is prime
				increment := 1 + hash_code \\ (table_size - 1);
				position := (hash_code \\ table_size) - increment;
			until
				stop or else visited_count >= table_size
			loop
				position := (position + increment) \\ table_size;
				visited_count := visited_count + 1;
				old_key := keys.item (position);
				if old_key = Void then
					if not deleted_marks.item (position) then
						control := Not_found_constant;
						stop := true;
						if first_deleted_position >= 0 then
							position := first_deleted_position
						end
					elseif first_deleted_position < 0 then
						first_deleted_position := position
					end
				elseif search_key.is_equal (old_key) then
					control := Found_constant;
					stop := true
				elseif old_key.hash_code = 0 then
					if not deleted_marks.item (position) then
						control := Not_found_constant;
						stop := true;
						if first_deleted_position >= 0 then
							position := first_deleted_position
						end
					elseif first_deleted_position < 0 then
						first_deleted_position := position
					end
				end
			end;
			if not stop then
				control := Not_found_constant;
				if first_deleted_position >= 0 then
					position := first_deleted_position
				end;
			end;
		end;

	Inserted_constant: INTEGER is unique;
			-- Insertion successful

	Found_constant: INTEGER is unique;
			-- Key found

	Changed_constant: INTEGER is unique;
			-- Change successful

	Removed_constant: INTEGER is unique;
			-- Remove successful

	Conflict_constant: INTEGER is unique;
			-- Could not insert an already existing key

	Not_found_constant: INTEGER is unique;
			-- Key not found


	add_space is
			-- Increase capacity.
		local
			i, table_size: INTEGER;
			current_key: H;
			other: HASH_TABLE [G, H]
		do
			from
				table_size := keys.count;
				!! other.make ((3 * table_size) // 2);
			until
				i >= table_size
			loop
				current_key := keys.item (i);
				if valid_key (current_key) then
					other.put (content.item (i), current_key)
				end;
				i := i + 1
			end;
			content := other.content;
			keys := other.keys;
			deleted_marks := other.deleted_marks
		end;


	soon_full: BOOLEAN is
			-- Is table close to being filled to current capacity?
			-- (If so, resizing is needed to avoid performance degradation.)
		do
			Result := (keys.count * Size_threshold <= 100 * count)
		end;


	control: INTEGER;
			-- Control code set by operations that may produce
			-- several possible conditions.

invariant

	count_big_enough: 0 <= count

end -- class HASH_TABLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
