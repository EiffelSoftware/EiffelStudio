--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Possibly circular sequences of items,
-- without commitment to a particular representation

indexing

	names: chain, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CHAIN [G] inherit

	CURSOR_STRUCTURE [G]
		undefine
			empty
		end;

	INDEXABLE [G, INTEGER]
		rename
			item as i_th,
			put as put_i_th
		undefine
			empty
		end;

	SEQUENCE [G]
		rename
			put as sequence_put
		export
			{NONE} sequence_put
		undefine
			empty, has, index_of
		end;

	BIDIRECTIONAL [G]
		rename
			index_of as sequential_index_of,
			has as sequential_has
		export
			{NONE}
				sequential_index_of, sequential_has
		end;

	BIDIRECTIONAL [G]
		redefine
			index_of, has
		select
			index_of, has
		end;

	FINITE

feature -- Access

	first: like item is
			-- Item at first position
		require
			not_empty: not empty
		local
			pos: CURSOR
		do
			pos := cursor;
			start;
			Result := item;
			go_to (pos)
		end;

	last: like item is
			-- Item at last position
		require
			not_empty: not empty
		local
			pos: CURSOR
		do
			pos := cursor;
			finish;
			Result := item;
			go_to (pos)
		end;

	has (v: like item): BOOLEAN is
			-- Does `Current' include `v'?
			-- (According to the currently
			-- discrimination rule used in `search')
		local
			pos: CURSOR
		do
			pos := cursor;
			Result := sequential_has (v);
			go_to (pos)
		end;

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'.
			-- (According to the currently adopted
			-- discrimination rule)
			-- 0 if none.
		local
			pos: CURSOR
		do
			pos := cursor;
			Result := sequential_index_of (v, i);
			go_to (pos)
		end;

	i_th, infix "@" (i: INTEGER): like item is
			-- Item at `i'-th position
		require else
			valid_index: valid_index (i)
		local
			pos: CURSOR
		do
			pos := cursor;
			go_i_th (i);
			Result := item;
			go_to (pos)
		end;

feature -- Insertion

	put (v: like item) is
			-- Replace current item by `v'.
			-- (Synonym for `replace')
		require
			writable: writable
		do
			replace (v)
		ensure
	--		same_count: count = old count;
			item_inserted: has (v)
		end;

	put_i_th (v: like item; i: INTEGER) is
			-- Put `v' at `i'-th position.
		require else
			valid_index: valid_index (i)
		local
			pos: CURSOR
		do
			pos := cursor;
			go_i_th (i);
			replace (v);
			go_to (pos)
		ensure then
			item_inserted: i_th (i) = v
		end;

feature -- Deletion

	contractable: BOOLEAN is
			-- May items be removed from `Current'?
			--|This feature has to be a function!
		do
			Result := false
		end;

feature {NONE} -- Deletion

	remove_item (v: G) is
			-- Remove `v' from `Current'.
		do
		end;

	remove is
			-- Remove current item.
		do
		end;

feature -- Transformation

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-chain beginning at cursor position
			-- and having min (`n', `count' - `index' + 1) items
		require
			not_off: not off;
			valid_subchain: n >= 1
		deferred
		end;

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		require
			not_off: not off;
			valid_index: valid_index (i)
		local
			old_item, new_item: like item;
			pos: CURSOR
		do
			pos := cursor;
			old_item := item;
			go_i_th (i);
			new_item := item;
			replace (old_item);
			go_to (pos);
			replace (new_item)
		ensure
	--		item = old i_th (i);
	--		i_th (i) = old item
		end;

feature -- Cursor

	start is
			-- Move cursor to first position.
			-- (No effect if empty)
		do
			if not empty then
				go_i_th (1)
			end
		ensure then
			(not empty) implies isfirst
		end;

	finish is
			-- Move cursor to last position.
			-- (No effect if empty)
		do
			if not empty then
				go_i_th (count)
			end
		ensure then
			(not empty) implies islast
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the offset is too big.
		local
			counter: INTEGER
		do
			if i > 0 then
				from
				until
					(counter = i) or else off
				loop
					forth;
					counter := counter + 1
				end
			elseif i < 0 then
				from
				until
					(counter = i) or else off
				loop
					back;
					counter := counter - 1
				end
			end
		ensure
	--		(not off) implies (index = old index + i)
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		require
			valid_cursor_index: valid_cursor_index (i)
		do
			move (i - index);
		ensure
			position_expected: index = i
		end;

	index: INTEGER is
			-- Current cursor index
		deferred
		end;

	isfirst: BOOLEAN is
			-- Is cursor at first position?
		do
			Result := (index = 1)
		ensure
			Result implies (not empty)
		end;

	islast: BOOLEAN is
			-- Is cursor at last position?
		do
			Result := (index = count)
		ensure
			Result implies (not empty)
		end;

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := (index = 0) or (index = count + 1)
		end;

feature -- Assertion check

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded?
		do
			Result := (i >= 1) and (i <= count)
		ensure then
			valid_index_definition: Result = (i >= 1) and (i <= count)
		end;

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= count + 1)
		ensure
			valid_cursor_index_definition: Result = (i >= 0) and (i <= count + 1)
		end;

feature -- Obsolete features

	mark_stack: LINKED_STACK [CURSOR];
			-- Stack used by `mark' and `return'
			-- To be removed as soon as `mark' and `return' are removed.
--		once
--			!! Result.make;
--		end;
		
	mark is obsolete "Use ``pos := cursor''"
			-- Mark cursor position.
		do
			if mark_stack = Void then
				!! mark_stack.make
			end;
			mark_stack.put (cursor)
		end;

	return is obsolete "Use ``go_to (pos)''"
			-- Move cursor to last marked position.
		require
			mark_stack_not_void:
				mark_stack /= Void
		do
			go_to (mark_stack.item);
			mark_stack.remove
		end;

	position: INTEGER is obsolete "Use ``index''"
		do
			Result := index
		end;

	go (i: INTEGER) is obsolete "Use ``go_i_th''"
			-- Move cursor to `i'-th position.
		require
			valid_cursor_index: valid_cursor_index (i)
		do
			go_i_th (i)
		ensure
			position_expected: index = i
		end;

invariant

	empty_list: empty implies off;
	positive_index: index >= 0;
	index_small_enough: index <= count + 1;
	off_definition: off = ((index = 0) or (index = count + 1));
	isfirst_definition: isfirst = (index = 1);
--	islast_definition: islast = (not empty) and (index = count);
	item_corresponds_to_index: (not off) implies (item = i_th (index))

end
