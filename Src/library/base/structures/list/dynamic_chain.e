indexing

	description:
		"Dynamically modifiable chains";

	copyright: "See notice at end of class";
	names: dynamic_chain, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class DYNAMIC_CHAIN [G] inherit

	CHAIN [G]
		export
			{ANY} remove, prune_all, prune
		undefine
			remove, prune_all, prune
		end;

	UNBOUNDED [G]

feature -- Status report

	extendible: BOOLEAN is true;
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed ? (Answer: yes.)
		do
			Result :=  true
		end;

feature -- Element change

	add_front (v: like item) is
			-- Add `v' to beginning.
		deferred
		ensure
	 		--new_count: count = old count + 1;
			item_inserted: first = v
		end;

	add_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		require
			not_off: not off
		deferred
		ensure
	 		--new_count: count = old count + 1;
	 		--new_index: index = old index + 1
		end;

	add_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		require
			extendible: extendible;
			not_off: not off
		deferred
		ensure
	 		--new_count: count = old count + 1;
	 		--same_index: index = old index
		end;

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		require
			extendible: extendible;
			not_off: not off;
			other_exists: other /= Void
		deferred
		ensure
	 		--new_count: count = old count + old other.count;
	 		--new_index: index = old index + old other.count;
			is_empty: other.empty
		end;

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		require
			extendible: extendible;
			not_off: not off;
			other_exists: other /= Void
		deferred
		ensure
	 		--new_count: count = old count + old other.count;
	 		--same_index: index = old index;
			is_empty: other.empty
		end;

feature -- Removal

	prune (v: like item) is
			-- Remove first occurrence of `v', if any,
			-- after cursor position.
			-- Move cursor to right neighbor
			-- (or `off' if no right neighbor or `v' does not occur).
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
			left_exist: index > 1
		deferred
		ensure
	 		--new_count: count = old count - 1;
	 		--new_index: index = old index - 1
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require
			right_exist: index < count
		deferred
		ensure
	 		--new_count: count = old count - 1;
	 		--same_index: index = old index
		end;

	prune_all (v: like item) is
			-- Remove all occurrences of `v'.
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
		ensure then
			is_off: off
		end;

	wipe_out is
			-- Remove all elements.
		do
			from
				start
			until
				off
			loop
				remove
			end
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-chain beginning at cursor position
			-- and having min (`n', `count' - `index' + 1) items
		local
			pos: CURSOR;
			counter: INTEGER
		do
			from
				Result := new_chain;
				pos := cursor
			until
				(counter = n) or else off
			loop
				Result.finish;
				Result.add_left (item);
				forth;
				counter := counter + 1
			end;
			go_to (pos)
		end;

feature -- Obsolete

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

feature {DYNAMIC_CHAIN} -- Implementation

	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		deferred
		ensure
			result_exists: Result /= Void
		end;

invariant

	extendible: extendible;

end -- class DYNAMIC_CHAIN


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
