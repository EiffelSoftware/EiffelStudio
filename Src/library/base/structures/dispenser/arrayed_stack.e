indexing

	description:
		"Stacks implemented by resizable arrays";

	copyright: "See notice at end of class";
	names: dispenser, array;
	representation: array;
	access: fixed, lifo, membership;
	size: fixed;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class ARRAYED_STACK [G] inherit

	STACK [G]
		undefine
			copy, is_equal, consistent, setup, prune_all, replace
		redefine
			sequential_representation
		select
			remove, extend
		end;

	ARRAYED_LIST [G]
		rename
			extend as al_extend,
			remove as al_remove,
			start as finish,
			finish as start,
			forth as back,
			back as forth,
			after as before,
			before as after
		export
			{NONE} all;
			{ANY} readable;
			{STACK} start, finish, forth, back;
			{ARRAYED_STACK} count
		undefine
			readable, writable,
			append, fill, put
		redefine
			sequential_representation
		end;

creation

	make

feature -- Element change

	extend, put (v: like item) is
			-- Push `v' on top.
		do							
			al_extend (v);
			start
		end;

feature -- Removal

	remove is
			-- Remove top item.
		require else
			not_empty: count /= 0
		do
			al_remove;
			start
		end;

feature -- Conversion

	sequential_representation: ARRAYED_LIST [G] is
			-- Representation as a sequential structure
			-- (in the reverse order of original insertion)
		local
			i: INTEGER
		do
			from
				!!Result.make (count);
				i := count
			until
				i < 1
			loop
				Result.extend (i_th (i));
				i := i - 1
			end		
		end;

feature -- Obsolete

	max_size: INTEGER is obsolete "Use ``capacity''"
		do
			Result := capacity
		end;

	change_item (v: G) is obsolete "Use ``replace (v)''"
		do
			replace (v)
		end;

end -- class STACK


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
