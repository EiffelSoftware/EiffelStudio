--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Circular chains, implemented as two way linked lists

indexing

	names: two_way_circular, ring, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_CIRCULAR [G] inherit

	LINKED_CIRCULAR [G]
		undefine
			remove_right, remove_left, add_front,
			remove, first_element, previous, last_element,
			ll_move, finish, islast, merge_left, add_left,
			add_right, add, merge_right, wipe_out,
			new_chain, new_cell
		redefine
			forth, back, move
		select
			back, move, forth
		end;

	TWO_WAY_LIST [G]
		rename
			back as twl_back,
			move as twl_move,
			forth as twl_forth
		export
			{NONE}
				twl_back, twl_move, twl_forth
		undefine
			valid_cursor_index
		redefine
			new_chain
		end

creation

	make

feature -- Cursor

	forth is
			-- Move to next item in `Current'.
		do
			if not empty then
				if islast then
					start
				else
					twl_forth
				end
			end
		end;

	back is
			-- Move to previous item in `Current'.
		do
			if not empty then
				if isfirst then
					finish
				else
					twl_back
				end
			end
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions around.
		local
			ind: INTEGER
		do
			ind := index;
			twl_move (modulo (ind + i, count) - ind)
		end;

feature {TWO_WAY_CIRCULAR} -- Creation

	new_chain: like Current is
			-- Instance of class `like Current'.
		do
			!! Result.make
		end;

end -- class TWO_WAY_CIRCULAR
