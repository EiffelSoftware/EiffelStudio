indexing

	description:
		"Circular chains, without commitment to a particular representation";

	status: "See notice at end of class";
	names: circular, ring, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CIRCULAR [G] inherit

	CHAIN [G]
		redefine
			remove,
			forth, back, before, after, off,
			move, go_i_th,
			valid_cursor_index, exhausted,
			first, last, index
		end;

feature -- Access

	first: G is
			-- Item at position currently defined as first
		local
			pos: INTEGER
		do
			pos := standard_index;
			start;
			Result := item;
			move (pos-1)
		end;

	index: INTEGER is
			-- Current cursor index, with respect to position
			-- currently defined as first
		local
			first_ind, std_ind: INTEGER
			p : CURSOR
		do
			p := cursor
			std_ind := standard_index;
			start;
			first_ind := standard_index;
			Result := std_ind - first_ind + 1;
			if Result < 0 then
				Result := count + Result
			end;
			move (Result-1)
			go_to (p)
		end

	last: like first is
			-- Item at position currently defined as last
		local
			pos: INTEGER
		do
			pos := standard_index;
			finish;
			Result := item;
			start;
			move (pos-1)
		end;

feature -- Status report

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' a possible cursor position?
		do
			Result := (i >= 0) and (i <= count)
		ensure then
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count))
		end;

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := empty and standard_after
		ensure then
			empty_and_std_after: Result = (empty and standard_after)
		end;

	before: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := empty and standard_before
		ensure then
			empty_and_std_before: Result = (empty and standard_before)
		end;

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := empty
		ensure then
			only_when_empty: Result = empty
		end;

	exhausted: BOOLEAN is
			-- Has structure been completely explored?
		do
			Result := empty or internal_exhausted
		end

feature -- Cursor movement

	forth is
			-- Move cursor to next item, cyclically.
		do
			if islast then
				internal_exhausted := true
			end
			standard_forth;
			if standard_after then
				standard_start
			end;
		ensure then
			moved_forth_at_end: (old index = count) implies (index = 1)
		end;

	back is
			-- Move cursor to previous item, cyclically.
		do
			if isfirst then
				internal_exhausted := true
			end
			standard_back;
			if standard_before then
				standard_finish
			end;
		end;

	move (i: INTEGER) is
			-- Move cursor to `i'-th item from current position,
			-- cyclically.
		local
			real_move, counter, start_index: INTEGER
		do
			if i /= 0 and count > 0 then
				start_index := index
				real_move := i \\ count;
				if real_move < 0 then
					real_move := count + real_move
				end
				from
				until
					counter = real_move
				loop
					forth;
					counter := counter + 1
				end
				if (start_index + i > count) or (start_index + i < 1) then
					internal_exhausted := true
				end
			end
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position from current start, cyclically.
		require else
			index_big_enough: i>=1;
			not_empty: not empty
		do
			start;
			move (i - 1)
		end;

	set_start is
			-- Define current position as the first.
		require
			not_empty: not empty
		deferred
		end;

feature -- Removal

	remove is
			-- Remove item at cursor position.
			-- Move cursor to right neighbor (cyclically).
			-- If removed item was at current starting position,
			-- move starting position to right neighbor.
		do
			fix_start_for_remove;
			standard_remove;
			if standard_after then
				finish
			elseif standard_before then
				start
			end;
		end;

feature {CIRCULAR} -- Implementation

	fix_start_for_remove is
			-- Before deletion, update starting position if necessary.
		deferred
		end;

	internal_exhausted: BOOLEAN;
			-- Has last `forth' or `back' operation exhausted the structure?

	standard_after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
			-- (Non-cyclically)
		deferred
		end;

	standard_back is
			-- Move cursor to previous element, non-cyclically.
		deferred
		end;

	standard_before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor?
			-- (Non-cyclically)
		deferred
		end;

	standard_finish is
			-- Move cursor to last element.
		deferred
		end;

	standard_forth is
			-- Move cursor to next element, non-cyclically.
		deferred
		end;

	standard_isfirst: BOOLEAN is
			-- Is cursor at first position, non-cyclically?
		deferred
		end;

	standard_islast: BOOLEAN is
			-- Is cursor at last position, non-cyclically?
		deferred
		end;

	standard_move (i: INTEGER) is
			-- Move cursor to `i'-th element, non-cyclically.
		deferred
		end;

	standard_go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th element, non-cyclically.
		deferred
		end;

	standard_index: INTEGER is
			-- Current cursor index, non-cyclically
		deferred
		end;

	standard_remove is
			-- Remove, non-cyclically.
		deferred
		end;

	standard_search (v: like first) is
			-- Search non-cyclically.
		deferred
		end;

	standard_start is
			-- Move cursor to first element.
		deferred
		end;

invariant

	not_before_unless_empty: before implies empty;
	not_after_unless_empty: after implies empty;
	not_off_unless_empty: off implies empty

end -- class CIRCULAR


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

