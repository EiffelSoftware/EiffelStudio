--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	--
--|	270 Storke Road, Suite 7 Goleta, California 93117	--
--|				   (805) 685-1006		--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sequential, two-way linked lists

indexing

	names: two_way_list, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_LIST [G] inherit

	LINKED_LIST [G]
		redefine
			first_element, last_element,
			add, add_front, add_left, add_right,
			merge_right, merge_left, new_cell,
			remove, remove_left, remove_right, wipe_out,
			previous, finish, move, islast, new_chain
		select
			add, add_front,
			merge_right,
			remove_right,
			move, add_right,
			wipe_out
		end;

	LINKED_LIST [G]
		rename
			add as ll_add,
			add_front as ll_add_front,
			add_right as ll_add_right,
			merge_right as ll_merge_right,
			remove_right as ll_remove_right,
			move as ll_move,
			wipe_out as ll_wipe_out
		export
			{NONE}
				ll_add, ll_add_front, ll_add_right,
				ll_remove_right, ll_move, ll_merge_right,
				ll_wipe_out
		redefine
			add_left, merge_left, remove, new_chain,
			remove_left, finish, islast, first_element,
			last_element, previous, new_cell
		end

creation

	make_sublist, make

feature {TWO_WAY_LIST} -- Access

	previous: like first_element is
			-- Element left of cursor
		do
			if after then
				Result := active
			elseif active /= Void then
				Result := active.left
			end
		end;

feature -- Insertion

	add_front (v: like item) is
			-- Add `v' to the beginning of `Current'.
		do
			ll_add_front (v);
			if count = 1 then
				last_element := first_element
			end
		end;

	add (v: like item) is
			-- Add `v' to the end of `Current'.
		do
			ll_add (v);
			if count = 1 then
				last_element := first_element;
			else
				last_element := last_element.right;
			end
		end;

	add_left (v: like item) is
			-- Put `v' to the left of cursor position.
			-- Do not move cursor.
		local
			p: like first_element;
		do
			p := new_cell (v);
			if empty then
				first_element := p;
				last_element := p;
				active := p;
			elseif after then
				p.put_left (last_element);
				last_element := p;
				active := p;
			elseif isfirst then
				p.put_right (active);
				first_element := p
			else
				p.put_left (active.left);
				p.put_right (active);
			end;
			count := count + 1
		end;

	add_right (v: like item) is
			-- Put `v' to the right of cursor position.
			-- Do not move cursor.
		local
			was_last: BOOLEAN;
		do
			was_last := islast;
			ll_add_right (v);
			if count = 1 then
					-- `p' is only element in list
				last_element := active
			elseif was_last then
					-- `p' is last element in list
				last_element := active.right;
			end;
		end;

	merge_left (other: like Current) is
			-- Merge `other' into `Current' before cursor
			-- position. Do not move cursor. Empty `other'.
		local
			other_first_element: like first_element;
			other_last_element: like first_element;
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
				if empty or else isfirst then
					if empty then
						last_element := other_last_element;
					else
						other_last_element.put_right (first_element);
					end;
					first_element := other_first_element;
					active := first_element;
				elseif after then
					other_first_element.put_left (last_element);
					last_element := other_last_element;
					active := last_element;
				elseif not before then
					other_first_element.put_left (active.left);
					active.put_left (other_last_element);
				end;
				count := count + other_count;
				other.wipe_out
			end
		end;

	merge_right (other: like Current) is
			-- Merge `other' into `Current' after cursor
			-- position. Do not move cursor. Empty `other'.
		do
			if empty or else islast then
				last_element := other.last_element
			end;
			ll_merge_right (other);
		end;

feature -- Deletion

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or after if no right neighbor).
		local
			p: like first_element;
		do
			if isfirst then
				first_element := first_element.right;
				active := first_element;
				if count = 1 then
					check
						no_active: active = Void
					end;
					after := true;
					last_element := Void
				else
					check
						active_exists: active /= Void
					end;
					active.forget_left
				end;
			elseif islast then
				last_element := last_element.left;
				active := last_element;
				active.forget_right;
				after := true
			else
				p := active.left;
				p.put_right (active.right);
				active.simple_forget_left;
				active.simple_forget_right;
				active := p.right;
			end;
			count := count - 1
		end;

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		local
			p: like first_element;
		do
			if after then
				last_element := last_element.left;
				active.forget_left;
				active := last_element;
				if count = 1 then
					first_element := Void
				end;
			else
				p := active.left;
				active.put_left (active.left.left);
				p.simple_forget_left;
				p.simple_forget_right;
				if active.left = Void then
					first_element := active
				end;
			end;
			count := count - 1
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		local
			p: like first_element;
		do
			p := active.right;
			ll_remove_right;
			if not before then
				p.simple_forget_left;
			elseif active /= Void then
				active.simple_forget_left;
			end;
			if (active = Void) or else
				(active.right = Void) then
				last_element := active
			end
		end;

	wipe_out is
			-- Empty `Current'.
		do
			ll_wipe_out;
			last_element := Void
		end;

feature -- Transformation

	split (n: INTEGER) is
			-- Remove from current list
			-- min (`n', `count' - `index' - 1) items
			-- starting at cursor position.
			-- Move cursor right one position.
			-- Make extracted sublist accessible
			-- through attribute `sublist'.
		require
			not_off: not off;
			valid_sublist: n >= 0
		local
			actual_number, active_index: INTEGER;
			p_elem, s_elem, e_elem, n_elem: like first_element;
		do
				-- recognize first breakpoint
			active_index := index;
			if active_index + n > count + 1 then
				actual_number := count + 1 - active_index
			else
				actual_number := n
			end;
			s_elem := active;
			p_elem := previous;
				-- recognize second breakpoint
			move (actual_number - 1);
			e_elem := active;
			n_elem := next;
				-- make sublist
			s_elem.forget_left;
			e_elem.forget_right;
			!! sublist.make_sublist (s_elem, e_elem, actual_number);
				-- fix `Current'
			count := count - actual_number;
			if p_elem /= Void then
				p_elem.put_right (n_elem)
			else
				first_element := n_elem
			end;
			if n_elem /= Void then
				active := n_elem
			else
				last_element := p_elem;
				active := p_elem;
				after := true
			end
		end;

	sublist: like Current;
			-- Result produced by last `split'

feature -- Cursor

	finish is
			-- Move cursor to last position.
			-- (Go after if empty)
		do
			if not empty then
				active := last_element;
				after := false
			else
				after := true
			end;
			before := false
		ensure then
			not_before: not before
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the offset is to big.
		local
			counter: INTEGER;
			p: like first_element
		do
			if i > 0 then
				ll_move (i)
			elseif i < 0 then
				if after then
					after := false;
					counter := -1
				end;
				from
					p := active
				until
					(counter = i) or else (p = Void)
				loop
					active := p;
					p := p.left;
					counter := counter - 1
				end;
				if p = Void then
					before := true
				else
					active := p
				end
			end
		end;

	islast: BOOLEAN is
			-- Is cursor at last position in `Current'?
		do
			Result := (active = last_element)
				and then not after
				and then not before
		end;

feature -- Representation

	first_element: BI_LINKABLE [G];
			-- Head of list
			-- (Anchor redefinition)

	last_element: like first_element;
			-- Tail of the list

feature {TWO_WAY_LIST} -- Creation

	make_sublist (first_item, last_item: like first_element; n: INTEGER) is
			-- Create an empty sublist
		do
			make;
			first_element := first_item;
			last_element := last_item;
			count := n
		end;

	new_chain: like Current is
			-- Instance of class `like Current'.
		do
			!! Result.make
		end;

	new_cell (v: like item): like first_element is
			-- Instance of class `like first_element'.
		do
			!! Result;
			Result.put (v)
		ensure then
			Result /= Void
		end;

end
