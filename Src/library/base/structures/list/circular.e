indexing

	description:
		"Circular chains, without commitment to a particular representation";

	copyright: "See notice at end of class";
	names: circular, ring, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class CIRCULAR [G] inherit

	CHAIN [G]
		undefine
			off, exhausted, isfirst, islast
		redefine
			search, 
			remove,
			start, finish,
			forth, back,
			move, go_i_th,
			valid_cursor_index
		end

feature -- Access
	
	search(v: like item) is
		do
			standard_search(v);
			if after or exhausted then
				finish;
				exhausted := true;
			end;
		ensure then
			not_off_or_else_empty: not off or else empty
		end;

feature -- Status report

	exhausted: BOOLEAN; 
			-- Are there no more items to be read?

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
		do
			Result := (i >= 0) and (i <= count)
		ensure then
			valid_cursor_index_definition: Result = (i >= 0) and (i <= count)
		end;

feature -- Cursor movement

	start is
		do
			standard_start;
			exhausted := off;
		ensure then
			not_off_or_else_empty: not off or else empty
		end;

	finish is
		do
			standard_finish;
			exhausted := off;
		ensure then
			not_off_or_else_empty: not off or else empty
		end;
	

	forth is
			-- Move to next item.
		do		
			standard_move(1);
			if after then
				start;
				exhausted := true;
			end;
		ensure then
			not_off_or_else_empty: not off or else empty
		end;

	back is
			-- Move to previous item.
		do
			standard_move(-1);
			if before then
				finish;
				exhausted := true;
			end;
		ensure then
			not_off_or_else_empty: not off or else empty
		end;

	move(i: INTEGER) is
		local
			ind: INTEGER;
		do
			ind := index;
			standard_move(modulo(ind+i, count) - ind);
		ensure then
			not_off_or_else_empty: not off or else empty
		end;

	go_i_th(i: INTEGER) is
		require else
			index_small_enough: i<=count;
			index_big_enough: i>=1;
			not_empty: not empty
		do
			standard_go_i_th(i);
		ensure then
			not_off_or_else_empty: not off or else empty
		end;

feature -- Removal

	remove is
		do
			standard_remove;
			if after then
				finish;
			elseif before then
				start;
			end;
		ensure then
			not_off_or_else_empty: not off or else empty
		end;

feature {CIRCULAR} -- Implementation

	standard_search(v: like item) is
			deferred
		end;

	standard_remove is
			deferred
		end;

	standard_start is
			deferred
		end;	

	standard_finish is
			deferred
		end;

	standard_forth is
			deferred
		end;

	standard_back is
			deferred
		end;

	standard_move(i: INTEGER) is
			deferred
		end;

	standard_go_i_th(i: INTEGER) is
			deferred
		end;

	modulo (n1, n2: INTEGER): INTEGER is
			-- Modulus, plus one; 0 if `n2' = 0
		require
			 non_negative_number: n2 >= 0
		do
			if n2 /= 0 then
				 Result := n1 \\ n2;
				if Result <= 0 then
					 Result := Result + n2
				end
			end
		ensure
			 Result >= 0 and Result <= n2
		end;
		
	after: BOOLEAN is
		deferred
		end;
	
	before: BOOLEAN is
		deferred
		end;

end -- class CIRCULAR


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
