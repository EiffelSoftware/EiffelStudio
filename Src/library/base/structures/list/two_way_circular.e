indexing

	description:
		"Circular chains implemented as two-way linked lists";

	copyright: "See notice at end of class";
	names: two_way_circular, ring, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_CIRCULAR [G] inherit

	DYNAMIC_CIRCULAR [G]
		undefine
			readable, isfirst, islast
		redefine
			start
		select
			search, remove,
			start, finish, back, forth, move, go_i_th,
			after, before, off,
			isfirst, islast, index,
			remove_left, remove_right
		end;

	TWO_WAY_LIST [G]
		rename
			after as standard_after,
			back as standard_back,
			before as standard_before,
			finish as standard_finish,
			forth as standard_forth,
			go_i_th as standard_go_i_th,
			index as standard_index,
			isfirst as standard_isfirst,
			islast as standard_islast,
			move as standard_move,
			off as standard_off,
			remove as standard_remove,
			remove_left as standard_remove_left,
			remove_right as standard_remove_right,
			search as standard_search,
			start as standard_start
		export {NONE}
			standard_after, standard_back, standard_before,
			standard_finish, standard_forth, standard_go_i_th,
			standard_index, standard_isfirst, standard_islast,
			standard_move, standard_off, standard_remove,
			standard_remove_left, standard_remove_right, standard_search,
			standard_start
		undefine
			valid_cursor_index, first, last, exhausted, wipe_out,
			duplicate
		redefine
		 	new_chain
		end;

creation

	make


feature -- Status report

	isfirst: BOOLEAN is
			-- Is cursor on first item?
		do
			if not empty then
				if starter = Void then
					Result := (active = first_element)
				else
					Result := (active = starter)
				end
			end
		end;
		
	islast: BOOLEAN is
			-- Is cursor on last item?
		do
			if not empty then
				if (starter = Void) or (starter = first_element) then
					Result := standard_islast
				else
					Result := (active.right = starter)
				end
			end
		end;
		
feature -- Cursor movement

	set_start is
			-- Select current item as the first.
		do
			starter := active
		end;

	start is
			-- Move to position currently selected as first.
		do
			if starter = Void then
				standard_start;
				starter := first_element
			else
				from
					standard_start
				until
					standard_off or else (active = starter)
				loop
					standard_forth
				end;
				if standard_off then standard_start end
			end
		end

feature -- Element removal

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require else
			count > 1
		do
			if standard_isfirst then
				standard_finish; remove
			else
				standard_remove_left
			end
		end;

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		require else
			count > 1
		do
			if standard_islast then
				standard_start; remove; finish
			else
				standard_remove_right
			end
		end;

feature {TWO_WAY_CIRCULAR} -- Implementation

	fix_start_for_remove is
			-- Before deletion, update starting position if necessary.
		do
			if starter = active then
				if standard_islast then
					starter := first_element
				else
					starter := starter.right
				end
			end
		end;
		
	starter: like first_element;
			-- The cell currently selected as first

		
	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make
		end;

invariant

	(active = Void) implies empty

end -- class TWO_WAY_CIRCULAR


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
