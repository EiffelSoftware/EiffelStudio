--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	--
--|	270 Storke Road, Suite 7 Goleta, California 93117	--
--|				   (805) 685-1006		--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sequential, one-way linked lists

indexing

	names: linked_list, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_LIST [G] inherit

	DYNAMIC_LIST [G]
		redefine
			first, go_i_th, add_left, move, wipe_out,
			isfirst, islast, search, search_equal,
			last, finish, merge_left, merge_right,
			readable, start, before, after
		end

creation

	make

feature -- Creation

	make is
			-- Create an empty list.
		do
			before := true
		ensure
			is_before: before;
		end;

feature -- Access

	item: G is
			-- Current item
		do
			Result := active.item
		end;

	first: like item is
			-- Item at first position
		do
			Result := first_element.item
		end;

	last: like item is
			-- Item at last position
		do
			Result := last_element.item
		end;

	search (v: like item) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where `item' and `v' are identical.
			-- (According to the `=' rule)
			-- `exhausted' becomes true and the cursor
			-- ends up `off' if `Current'
			-- does not include `v'.
		do
			if before then forth end;
			from
			until
				after or else active.item = v
			loop
				if active.right = Void then
					after := true
				else
					active := active.right
				end;
			end
		end;

	search_equal (v: like item) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where `item' and `v' are equal.
			-- (According to the `equal' rule)
			-- `exhausted' becomes true and the cursor
			-- ends up `off' if `Current'
			-- does not include `v'.
		do
			if before then forth end;
			from
			until
				after or else equal (active.item, v)
			loop
				if active.right = Void then
					after := true
				else
					active := active.right
				end
			end
		end;

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not off
		end;

feature {LINKED_LIST} -- Access

	previous: like first_element is
			-- Element left of cursor
		local
			p: like first_element;
		do
			if after then
				Result := active
			elseif not (isfirst or before) then
				from
					p := first_element
				until
					p.right = active
				loop
					p := p.right
				end;
				Result := p;
			end
		end;

	next: like first_element is
			-- Element right of cursor
		do
			if before then
				Result := active
			elseif active /= Void then
				Result := active.right
			end
		end;

feature -- Insertion

	add_front (v: like item) is
			-- Add `v' to the beginning of `Current'.
		local
			p: like first_element
		do
			p := new_cell (v);
			p.put_right (first_element);
			first_element := p;
			if before then active := p end;
			count := count + 1;
		end;

	add (v: like item) is
			-- Add `v' to the end of `Current'.
		local
			p: like first_element
		do
			p := new_cell (v);
			if empty then
				first_element := p;
				active := p
			else
				last_element.put_right (p);
				if after then active := p end
			end;
			count := count + 1
		end;

	add_left (v: like item) is
			-- Put `v' to the left of cursor position.
			-- Do not move cursor.
		local
			p: like first_element
		do
			if after then
				back;
				add_right (v);
				move (2)
			else
				p := new_cell (active.item);
				p.put_right (active.right);
				active.put (v);
				active.put_right (p);
				active := p;
				count := count + 1
			end
		ensure then
			previous_exists: previous /= Void;
			item_inserted: previous.item = v
		end;

	add_right (v: like item) is
			-- Put `v' to the right of cursor position.
			-- Do not move cursor.
		local
			p: like first_element;
		do
			p := new_cell (v);
			if before then
				p.put_right (first_element);
				first_element := p;
				active := p;
			else
				p.put_right (active.right);
				active.put_right (p);
			end;
			count := count + 1
		ensure then
			next_exists: next /= Void;
			item_inserted: next.item = v
		end;

	replace (v: like item) is
			-- Replace current item by `v'.
		do
			active.put (v)
		end;

	merge_left (other: like Current) is
			-- Merge `other' into `Current' before cursor
			-- position. Do not move cursor. Empty `other'.
		local
			other_first_element: like first_element;
			other_last_element: like first_element;
			p: like first_element;
			other_count: INTEGER
		do
			if not other.empty then
				other_first_element := other.first_element;
				other_last_element := other.last_element;
				other_count := other.count;
					check
						other_first_element /= Void;
						other_last_element /= Void
					end;
				if empty or else isfirst then
					if not empty then
						p := first_element;
						if p /= Void then
							other_last_element.put_right (p)
						end;
					end;
					first_element := other_first_element;
					active := first_element;
				else
					p := previous;
					if p /= Void then
						p.put_right (other_first_element)
					end;
					other_last_element.put_right (active)
				end;
				count := count + other_count;
				other.wipe_out;
			end
		end;

	merge_right (other: like Current) is
			-- Merge `other' into `Current' after cursor
			-- position. Do not move cursor. Empty `other'.
		local
			other_first_element: like first_element;
			other_last_element: like first_element;
			p: like first_element;
			other_count: INTEGER;
		do
			if not other.empty then
				other_first_element := other.first_element;
				other_last_element := other.last_element;
				other_count := other.count;
					check
						other_first_element /= Void;
						other_last_element /= Void
					end;
				if empty then
					first_element := other_first_element;
					active := first_element;
				else
					if not islast then
						other_last_element.put_right (active.right);
					end;
					active.put_right (other_first_element);
				end;
				count := count + other_count;
				other.wipe_out;
			end
		end;

feature -- Deletion

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		local
			p: like first_element
		do
			if isfirst then
				first_element := first_element.right;
				active.forget_right;
				active := first_element;
				if count = 1 then
					check
						no_active: active = Void
					end;
					after := true;
				end
			elseif islast then
				active := previous;
				if active /= Void then
					active.forget_right
				end;
				after := true
			else
				p := active.right;
				previous.put_right (p);
				active.forget_right;
				active := p
			end;
			count := count - 1
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			move (-2);
			remove_right;
			forth
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		local
			p: like first_element
		do
			if before then
				first_element := first_element.right;
				active.forget_right;
				active := first_element
			else
				p := active.right;
				active.put_right (active.right.right);
				p.forget_right;
			end;
			count := count - 1
		end;

	wipe_out is
			-- Empty `Current'.
		do
			active := Void;
			first_element := Void;
			before := true;
			after := false;
			count := 0
		end;

feature -- Number of elements

	count: INTEGER;
			-- Number of items in `Current'

feature -- Cursor

	index: INTEGER is
			-- Current cursor index
		local
			p: like first_element
		do
			if after then
				Result := count + 1
			elseif not before then
				from
					p := first_element;
					Result := 1
				until
					p = active
				loop
					p := p.right;
					Result := Result + 1
				end
			end
		end;

	after: BOOLEAN;
			-- Is there no position to the right of the cursor?

	before: BOOLEAN;
			-- Is there no position to the left of the cursor?

	start is
			-- Move cursor to first position.
		do
			if first_element /= Void then
				active := first_element;
				after := false
			else
				after := true
			end;
			before := false
		ensure then
			not_before: not before
		end;

	finish is
			-- Move cursor to last position.
			-- (Go before if empty)
		local
			p: like first_element
		do
			if not empty then
				from
					p := active
				until
					p.right = Void
				loop
					p := p.right
				end;
				active := p;
				after := false;
				before := false
			else
				before := true;
				after := false
			end;
		ensure then
			Islast: (not empty) implies islast;
			Empty_convention: empty implies before
		end;

	forth is
			-- Move to next item in `Current'.
		do
			if empty then
				before := false;
				after := true
			elseif before then
				before := false
			elseif islast then
				after := true
			else
				active := active.right
			end
		end;

	back is
			-- Move to previous item in `Current'.
		do
			if empty then
				before := true;
				after := false
			elseif after then
				after := false
			elseif isfirst then
				before := true
			else
				active := previous
			end
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the offset is too big.
		local
			counter, new_index: INTEGER;
			p: like first_element
		do
			if i > 0 then
				if before then
					before := false;
					counter := 1
				end;
				from
					p := active
				until
					(counter = i) or else (p = Void)
				loop
					active := p;
					p := p.right;
					counter := counter + 1
				end;
				if p = Void then
					after := true
				else
					active := p
				end
			elseif i < 0 then
				new_index := index + i;
				before := true;
				after := false;
				active := first_element;
				if (new_index > 0) then
					move (new_index)
				end
			end
		ensure then
	--		moved_if_inbounds:
	--			(old index + i) >= 0 and
	--			(old index + i) <= (count + 1)
	--				implies index = (old index + i);
	--		(old index + i) <= 0 implies before;
	--		(old index + i) >= (count + 1) implies after
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			if i = 0 then
				before := true;
				after := false;
				active := first_element
			elseif i = count + 1 then
				before := false;
				after := true;
				active := last_element
			else
				move (i - index)
			end
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			ll_c: LINKED_LIST_CURSOR [G]
		do
			ll_c ?= p;
				check
					ll_c /= Void
				end;
			after := ll_c.after;
			before := ll_c.before;
			if before then
				active := first_element
			elseif after then
				active := last_element
			else
				active := ll_c.active;
			end
		end;

	cursor: CURSOR is
			-- Current cursor position
		do
			!LINKED_LIST_CURSOR [G]! Result.make
				(active, after, before)
		end;

	isfirst: BOOLEAN is
			-- Is cursor at first position in `Current'?
		do
			Result := (active = first_element)
				and then not after
				and then not before
		end;

	islast: BOOLEAN is
			-- Is cursor at last position in `Current'?
		do
			Result := not after
					and then not before
					and then active.right = Void
		end;

feature {LINKED_LIST} -- Cursor

	active: like first_element;
			-- Element at cursor position

feature -- Assertion check

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			ll_c: LINKED_LIST_CURSOR [G];
			temp, sought: like first_element
		do
			ll_c ?= p;
			if ll_c /= Void then
				from
					temp := first_element;
					sought := ll_c.active;
					Result := ll_c.after or else ll_c.before
				until
					Result or else temp = Void
				loop
					Result := (temp = sought);
					temp := temp.right
				end;
			end
		end;

feature -- Representation

	first_element: LINKABLE [G];
			-- Head of list

	last_element: like first_element is
			-- Tail of list
		local
			p: like first_element
		do
			if not empty then
				from
					Result := active;
					p := active.right
				until
					p = Void
				loop
					Result := p;
					p := p.right
				end
			end
		end;

feature {LINKED_LIST} -- Creation

	new_chain: like Current is
			-- Instance of class `like Current'.
			-- This feature should be implemented in
			-- every descendant of LINKED_LIST,
			-- so as to return an adequatly allocated and
			-- initialized object.
		do
			!! Result.make
		end;

	new_cell (v: like item): like first_element is
			-- Instance of class `like first_element'.
			-- This feature should be implemented in
			-- every descendant of LINKED_LIST,
			-- so as to return an adequatly allocated and
			-- initialized object.
		do
			!! Result;
			Result.put (v)
		ensure
			result_exists: Result /= Void
		end;

invariant

	empty_constraint: empty implies ((first_element = Void) and (active = Void));
	before_constraint: before implies (active = first_element);
	after_constraint: after implies (active = last_element)

end

