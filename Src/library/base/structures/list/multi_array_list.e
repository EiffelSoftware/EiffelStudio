indexing

	description:
		"Lists implemented as sequences of arrays, the last of which may be non-full. %
		%No limit on size (a new array is allocated if list outgrows its initial allocation)."

	status: "See notice at end of class";
	names: list, sequence;
	representation: array, linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class MULTI_ARRAY_LIST [G] inherit

	DYNAMIC_LIST [G]
		redefine
			start, finish, move, has, first, last, prune_all, search,
			remove, duplicate, wipe_out, put_left, put_right,
			put_front, extend
		end;

creation
	make

feature -- Initialization

	make (b: INTEGER) is
			-- Create an empty list, setting block_size to b
		local
			first_array: ARRAYED_LIST [G]
		do
			block_size := b;
			!!first_array.make (b);
			first_element := new_cell (first_array);
			last_element := first_element;
			active := first_element
		end;

feature -- Access

	item: G is
			-- Item at cursor position
		do
			Result := active.item.item;
		end;

	first: like item is
			-- Item at first position
		do
			Result := first_element.item.first
		end;

	last: like item is
			-- Item at last position
		do
			Result := last_element.item.last
		end;

	has (v: like item): BOOLEAN is
			-- Does list include `v'?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			pos: CURSOR;
		do
			if not empty then
				pos := cursor;
				start;
				search (v);
				Result := not after;
				go_to (pos);
			end;
		end;

	index: INTEGER;
			-- Current cursor index

	cursor: CURSOR is
			-- Current cursor position
		do
			!MULTAR_LIST_CURSOR [G]! Result.make
				(active, active.item.index, index)
		end;

	first_element: BI_LINKABLE [ARRAYED_LIST [G]];
			-- First array_sequence element of the list

	last_element: BI_LINKABLE [ARRAYED_LIST [G]];
			-- Last array_sequence element of the list

	block_size: INTEGER;

feature -- Measurement

	count: INTEGER;
			-- Number of items

feature -- Status report

	full: BOOLEAN is
		do
			Result := false
		end;

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			al_c: MULTAR_LIST_CURSOR [G]
		do
			al_c ?= p;
				check
					al_c /= Void
				end;
			Result := (al_c /= Void)
				and then valid_cursor_index (al_c.index)
				and then al_c.active.item.valid_cursor_index (al_c.active_index)
		end;

feature -- Cursor movement

	start is
			-- Move cursor to first position.
			-- (No effect if empty)
		do
			active := first_element;
			active.item.start;
			index := 1
		end;

	finish is
			-- Move cursor to last position.
			-- (No effect if empty)
		do
			active := last_element;
			active.item.finish;
			index := count
		end;

	forth is
			-- Move cursor to next position, if any.
		local
			current_array: ARRAYED_LIST [G]
		do
			if not empty then
				current_array := active.item;
				current_array.forth;
				if current_array.after then
					if active /= last_element then
						active := active.right;
						active.item.start
					end
				end
			end;
			index := index + 1
		end;

	back is
			-- Move cursor to previous position, if any.
		local
			current_array: ARRAYED_LIST [G]
		do
			if not empty then
				current_array := active.item;
				current_array.back;
				if current_array.before then
					if active /= first_element then
						active := active.left;
						active.item.finish
					end
				end
			end;
			index := index - 1
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the offset is too big.
		local
			counter: INTEGER;
			cell: like active;
			current_array: ARRAYED_LIST [G]
		do
			cell := active;
			current_array := cell.item;
			if i > 0 then
				from
					counter := i + active.item.index
				until
					counter <= current_array.count or cell = Void
				loop
					counter := counter - current_array.count;
					cell := cell.right;
					if cell /= Void then current_array := cell.item end
				end;
				if cell = Void then
					cell := last_element;
					current_array.finish;
					current_array.forth
				else
					active := cell;
					current_array.go_i_th (counter)
				end
			elseif i < 0 then
				from
					counter := current_array.count - current_array.index - i
				until
					counter <= current_array.count or cell = Void
				loop
					counter := counter - current_array.count;
					cell := cell.left;
					if cell /= Void then current_array := cell.item end
				end;
				if counter = current_array.count then
					counter := 0;
					cell := cell.left;
					if cell /= Void then current_array := cell.item end
				end;
				if cell = Void then
					cell := first_element;
					current_array.go_i_th (0);
				else
					active := cell;
					current_array.go_i_th (current_array.count - counter)
				end
			end;
			if i /= 0 then
				if current_array.before then
					index := 0
				elseif current_array.after then
					index := count + 1
				else
					index := index + i
				end;
			end;
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position `p'
		local
			al_c: MULTAR_LIST_CURSOR [G]
		do
			al_c ?= p;
				check
					al_c /= Void
				end;
			active := al_c.active;
			active.item.go_i_th (al_c.active_index)
			index := al_c.index
		end;

	search (v: like item) is
			-- Move cursor to first position (at or after current
			-- cursor position) where `item' and `v' are equal.
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			current_array: ARRAYED_LIST [G];
			old_index: INTEGER;
			cell: like active;
		do
			cell := active;
			current_array := cell.item;
			old_index := current_array.index;
			if object_comparison then
				current_array.compare_objects
			else
				current_array.compare_references
			end;
			current_array.search (v);
			if current_array.after then
				cell := cell.right;
				index := index + current_array.count - old_index + 1
			else
				index := index + current_array.index - old_index
			end;
			from
			invariant
				index <= count + 1
			until
				not current_array.after or else cell = Void
			loop
				current_array := cell.item
				if object_comparison then
					current_array.compare_objects
				else
					current_array.compare_references
				end;
				current_array.start
				current_array.search (v);
				if current_array.after then
					cell := cell.right
					index := index + current_array.count
				else
					index := index + current_array.index - 1
				end
			end;
			if cell /= Void then
				active := cell
			else
				active := last_element
			end
		end;

feature -- Element change

	replace (v: like item) is
			-- Replace current item by `v'.
		do
			active.item.replace (v)
		end;

	extend (v: like item) is
			-- Add `v' to end.
		local
			cell: like first_element;
			current_array: ARRAYED_LIST [G]
		do
			current_array := last_element.item;
			if current_array.count = block_size then
				!!current_array.make (block_size);
				last_element.put_right (new_cell (current_array));
				last_element := last_element.right
			end;
			current_array.extend (v);
			count := count + 1
		end;

	put_front (v: like item) is
			-- Add `v' at the beginning.
			-- Do not move cursor.
		local
			first_array: ARRAYED_LIST [G];
			pos: INTEGER;
		do
			first_array := first_element.item;
			if active = first_element then
				pos := first_array.index
			else
				pos := -1
			end;
			first_array.start;
			put_left (v);
			if pos > 0 then
				first_array.go_i_th	(pos + 1)
			elseif pos = 0 then
				first_array.go_i_th (0)
			end;
			if not before then index := index + 1 end;
			count := count + 1
		end;

	put_left (v: like item) is
			-- Add `v' to the left of current position.
			-- Do not move cursor.
		local
			cell: like first_element;
			current_array, previous_array: ARRAYED_LIST [G];
			pos, cut: INTEGER;
		do
			current_array := active_array;
				check empty implies after end;
			if after then
				extend (v)
			elseif
				active /= first_element
				and then not active.left.item.full
			then
				active.left.item.extend (v)
			elseif current_array.count <= block_size then
				current_array.put_left (v)
			else
				pos := current_array.index;
				current_array.go_i_th (block_size // 2 + 1);
				cut := index;
				cell := new_cell (current_array.duplicate (count));
				cell.put_right (active.right);
				cell.put_left (active);
				if last_element = active then
					last_element := cell
				end;
				if pos < cut then
					current_array.go_i_th (pos);
					current_array.put_left (v);
				elseif pos = cut then
					current_array.extend (v);
					active := cell;
					active.item.start
				else
					active := cell;
					current_array := cell.item;
					current_array.go_i_th (pos - cut + 1);
					current_array.put_left (v)
				end
			end;
			index := index + 1;
			count := count + 1
		end;

	put_right (v: like item) is
			-- Add `v' to the left of current position.
			-- Do not move cursor.
		do
			forth;
			put_left (v);
			back;
			back;
		end;

feature -- Removal

	wipe_out is
			-- Remove all items.
		do
			count := 0;
			index := 0;
			check first_element /= Void end
			first_element.item.wipe_out;
			first_element.forget_right
			active := first_element;
			last_element := first_element
		end;

	remove is
			-- Remove current item
		local
			current_array: ARRAYED_LIST [G]
		do
			current_array := active.item;
			current_array.remove;
			if current_array.empty then
				if active = first_element then
					if active /= last_element then
						first_element := active.right;
						first_element.forget_left
					end;
				elseif active = last_element then
					last_element := active.left;
					last_element.forget_right;
				else
					active.right.put_left (active.left);
					active := active.right
				end
			elseif current_array.after then
				if active /= last_element then
					active := active.right;
					active.item.start
				end
			end;
			count := count - 1
		end;

	remove_left is
		do
			back;
			remove;
		end;

	remove_right is
		do
			forth;
			remove;
			back
		end;

	prune_all (v: like item) is
		local
			cell: like active;
			array: ARRAYED_LIST [G]
		do
			from
				cell := first_element
			until
				cell = Void
			loop
				array := cell.item;
				if object_comparison then
					array.compare_objects
				else
					array.compare_references
				end;
				count := count - array.count;
				array.prune_all (v);
				count := count + array.count;
				if array.empty then
					if cell = first_element then
						if cell /= last_element then
							first_element := cell.right;
							cell := first_element;
							cell.forget_left
						else
							cell := Void
						end
					elseif cell = last_element then
						last_element := cell.left;
						last_element.forget_right;
						cell := Void
					else
						cell.right.put_left (cell.left);
						cell := cell.right
					end
				else
					cell := cell.right
				end
			end;
			active := last_element;
			index := count + 1
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-list beginning at cursor position
			-- and having min (`n', `count' - `index' + 1) items
		local
			pos: CURSOR;
			counter, i: INTEGER
		do
			from
				pos := cursor;
				Result := new_chain
			until
				(counter = n) or exhausted
			loop
				Result.extend (item);
				forth;
				counter := counter + 1
			end;
			go_to (pos)
		end;

feature {MULTI_ARRAY_LIST} -- Implementation

	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make (block_size)
		end;

	active_array: ARRAYED_LIST [G] is
			-- Array_sequence at cursor position
		require
			active_exists: active /= Void;
			not_off: not off
		do
			Result := active.item
		end;

	active: like first_element;
			-- Element at cursor position

feature {NONE} -- Implementation

	go_before is
			-- Move the cursor before first position.
		do
			active := Void;
			index := 0
		ensure
			is_before: before
		end;

	new_cell (a: ARRAYED_LIST [G]): like first_element is
		do
			!!Result;
			Result.put (a)
		end;

invariant

	writable_definition: writable = not off;
	readable_definition: readable = not off;
	extendible_definition: extendible;

end -- class MULTI_ARRAY_LIST


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

