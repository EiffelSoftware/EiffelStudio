--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Dynamically modifiable chains

indexing

	names: dynamic_chain, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class DYNAMIC_CHAIN [G] inherit

	CHAIN [G]
		export
			remove, remove_item
		undefine
			remove, remove_item
		redefine
			contractable
		end;

	UNBOUNDED

feature -- Insertion

	add_front (v: like item) is
			-- Add `v' to the beginning of `Current'.
		require
			extensible: extensible
		deferred
		ensure
	--		new_count: count = old count + 1;
			item_inserted: first = v
		end;

	add_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		require
			extensible: extensible;
			not_off: not off
		deferred
		ensure
	--		new_count: count = old count + 1;
	--		new_index: index = old index + 1
		end;

	add_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		require
			extensible: extensible;
			not_off: not off
		deferred
		ensure
	--		new_count: count = old count + 1;
	--		same_index: index = old index
		end;

	merge_left (other: like Current) is
			-- Merge `other' into `Current' before cursor
			-- position. Do not move cursor. Empty `other'.
		require
			extensible: extensible;
			not_off: not off;
			other_exists: other /= Void
		deferred
		ensure
	--		new_count: count = old count + old other.count;
	--		new_index: index = old index + old other.count;
			is_empty: other.empty
		end;

	merge_right (other: like Current) is
			-- Merge `other' into `Current' after cursor
			-- position. Do not move cursor. Empty `other'.
		require
			extensible: extensible;
			not_off: not off;
			other_exists: other /= Void
		deferred
		ensure
	--		new_count: count = old count + old other.count;
	--		same_index: index = old index;
			is_empty: other.empty
		end;

	extensible: BOOLEAN is true;
			-- May new items be added to `Current'?

feature -- Deletion

	remove_item (v: like item) is
			-- Remove `v' from `Current'.
			-- Move cursor to right neighbor
			-- (or `off' if no right neighbor or `v'
			-- not in `Current').
		do
			start;
			search (v);
			if not off then
				remove
			end
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require
			is_not_first: not isfirst;
			contractable: contractable
		deferred
		ensure
	--		new_count: count = old count - 1;
	--		new_index: index = old index - 1
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require
			is_not_last: not islast;
			contractable: contractable
		deferred
		ensure
	--		new_count: count = old count - 1;
	--		same_index: index = old index
		end;

	remove_all_occurrences (v: like item) is
			-- Remove all items identical to `v'.
			-- (According to the currently adopted
			-- discrimination rule in `search')
			-- Leave cursor `off'.
		do
			from
				start;
				search (v)
			until
				off
			loop
				remove;
				search (v)
			end
		ensure
			is_off: off
		end;

	wipe_out is
			-- Empty `Current'.
		do
			from
				start
			until
				off
			loop
				remove
			end
		end;

	contractable: BOOLEAN is
			-- May items be removed from `Current'?
		do
			Result := not off
		end;

feature -- Transformation

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-chain beginning at cursor position
			-- and having min (`n', `count' - `index' + 1) items
		local
			pos: CURSOR;
			counter: INTEGER
		do
			pos := cursor;
			Result := new_chain;
			from
			until
				(counter = n) or else off
			loop
				Result.add (item);
				forth;
				counter := counter + 1
			end;
			go_to (pos)
		end;

feature {DYNAMIC_CHAIN} -- Creation

	new_chain: like Current is
			-- Instance of class `like Current'.
			-- This feature should be implemented in
			-- every effective descendant of DYNAMIC_CHAIN,
			-- so as to return an adequatly allocated and
			-- initialized object.
		deferred
		ensure
			result_exists: Result /= Void
		end;

feature -- Obsolete features

	remove_n_left (n: INTEGER) is
			obsolete "Use ``remove_left'' repeatedly"
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				off or else (counter > n)
			loop
				remove_left;
				counter := counter + 1
			end
		end;

	remove_n_right (n: INTEGER) is
			obsolete "Use ``remove_right'' repeatedly"
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				off or else (counter > n)
			loop
				remove_right;
				counter := counter + 1
			end
		end;

invariant

	extensible: extensible = true;
	access_assertion: contractable = not off

end -- class DYNAMIC_CHAIN
