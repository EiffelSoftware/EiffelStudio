--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Circular chains implemented as linked lists

indexing

	names: linked_circular, ring, sequence;
	representation: linked;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_CIRCULAR [G] inherit

	DYNAMIC_CIRCULAR [G]
		undefine
			go_i_th, remove, isfirst,
			start, first, finish, readable,
			islast, last, search, search_equal
		redefine
			forth, back, move
		select
			forth, back, move
		end;

	LINKED_LIST [G]
		rename
			forth as ll_forth,
			back as ll_back,
			move as ll_move
		export
			{NONE}
				ll_forth, ll_back,
				ll_move
		undefine
			wipe_out, valid_cursor_index
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
					ll_forth
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
					ll_back
				end
			end
		end;

	move (i: INTEGER) is
			-- Move cursor `i' positions around.
		local
			ind: INTEGER
		do
			ind := index;
			ll_move (modulo (ind + i, count) - ind)
		end;

feature {LINKED_CIRCULAR} -- Secret

	modulo (n1, n2: INTEGER): INTEGER is
			-- Modulus, plus one; 0 if `n2' = 0
		require
			positive_number: n2 >= 0
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

feature {LINKED_CIRCULAR} -- Creation

	new_chain: like Current is
			-- Instance of class `like Current'.
		do
			!! Result.make
		end;

end -- class LINKED_CIRCULAR
