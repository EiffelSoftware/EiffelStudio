indexing

	description:
		"Possibly circular sequences of items, %
		%without commitment to a particular representation";

	status: "See notice at end of class";
	names: chain, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CHAIN [G] inherit

	CURSOR_STRUCTURE [G]
		undefine
			prune_all
		select
			put
		end;

	INDEXABLE [G, INTEGER]
		rename
			item as i_th,
			put as put_i_th
		undefine
			prune_all
		end;

	SEQUENCE [G]
		rename
			put as sequence_put
		export
			{NONE} sequence_put
		redefine
			index_of, has, off, occurrences
		select
			index_of, has, occurrences
		end;

	SEQUENCE [G]
		rename
			put as sequence_put,
			index_of as sequential_index_of,
			has as sequential_has,
			occurrences as sequential_occurrences
		export
			{NONE}
				sequential_index_of, sequential_has, 
				sequence_put
		redefine
			off
		end;

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
			-- Does chain include `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.) 

		local
			pos: CURSOR
		do
			pos := cursor;
			Result := sequential_has (v);
			go_to (pos)
		end;

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.) 
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
		local
			pos: CURSOR
		do
			pos := cursor;
			go_i_th (i);
			Result := item;
			go_to (pos)
		end;

	index: INTEGER is
			-- Current cursor index
		deferred
		end;

	occurrences (v: like item): INTEGER is
			-- Number of times `v' appears.
			-- (Reference or object equality,
			-- based on `object_comparison'.) 
		local
			pos: CURSOR
		do
			pos := cursor;
			Result := sequential_occurrences (v);
			go_to (pos)
		end;

	
feature -- Cursor movement

	start is
			-- Move cursor to first position.
			-- (No effect if empty)
		do
			if not empty then
				go_i_th (1)
			end
		ensure then
			at_first: not empty implies isfirst
		end;

	finish is
			-- Move cursor to last position.
			-- (No effect if empty)
		do
			if not empty then
				go_i_th (count)
			end
		ensure then
			at_last: not empty implies islast
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the absolute value of `i'
			-- is too big.
		local
			counter, pos,  final: INTEGER
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
				final := index + i;
				if final <= 0 then
					start;
					back
				else
					from
						start;
						pos := 1
					until
						pos = final
					loop
						forth;
						pos := pos + 1
					end
				end
			end
		ensure
			too_far_right: (old index + i > count) implies exhausted;
			too_far_left: (old index + i < 1) implies exhausted;
			expected_index: (not exhausted) implies (index = old index + i)
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

 feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within allowable bounds?
		do
			Result := (i >= 1) and (i <= count)
		ensure then
			valid_index_definition: Result = (i >= 1) and (i <= count)
		end;


	isfirst: BOOLEAN is
			-- Is cursor at first position?
		do
			Result := not empty and (index = 1)
		ensure
			valid_position: Result implies not empty
		end;

	islast: BOOLEAN is
			-- Is cursor at last position?
		do
			Result := not empty and (index = count)
		ensure
			valid_position: Result implies not empty
		end;

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := (index = 0) or (index = count + 1)
		end;


	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= count + 1)
		ensure
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end;

feature -- Element change

	put (v: like item) is
			-- Replace current item by `v'.
			-- (Synonym for `replace')
		do
			replace (v)
		ensure then
	 		same_count: count = old count;
		end;

	put_i_th (v: like item; i: INTEGER) is
			-- Put `v' at `i'-th position.
		local
			pos: CURSOR
		do
			pos := cursor;
			go_i_th (i);
			replace (v);
			go_to (pos)
		end;

feature -- Transformation

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
	 		swapped_to_item: item = old i_th (i);
	 		swapped_from_item: i_th (i) = old item
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-chain beginning at current position
			-- and having min (`n', `from_here') items, 
			-- where `from_here' is the number of items
			-- at or to the right of current position.
		require
			not_off_unless_after: off implies after;
			valid_subchain: n >= 0
		deferred
		end;

feature -- Obsolete

	position: INTEGER is obsolete "Use ``index''"
		do
			Result := index
		end;

	mark is obsolete "Use ``pos := cursor''"
			-- Mark cursor position.
		do
		end;

	return is obsolete "Use ``go_to (pos)''"
			-- Move cursor to last marked position.
		do
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

feature {NONE} -- Inapplicable

	remove is
			-- Remove current item.
		do
		end;

invariant

	non_negative_index: index >= 0;
	index_small_enough: index <= count + 1;
	off_definition: off = ((index = 0) or (index = count + 1));
	isfirst_definition: isfirst = ((not empty) and (index = 1));
	islast_definition: islast = ((not empty) and (index = count));
	item_corresponds_to_index: (not off) implies (item = i_th (index))

end -- class CHAIN


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
