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

	DYNAMIC_CIRCULAR [G]
        undefine
			wipe_out,
            isfirst,
            readable, first ,
            islast, last
		select
			search, search_equal,
			remove,
			start, finish, back, forth, move, go_i_th
        end;


	TWO_WAY_LIST [G]
		rename
			search as standard_search,
			search_equal as standard_search_equal,
			remove as standard_remove,
			forth as standard_forth,
			back as standard_back,
			move as standard_move,
			start as standard_start,
			finish as standard_finish,
			go_i_th as standard_go_i_th
		undefine
			valid_cursor_index, exhausted
		redefine
			new_chain
		end;

	TWO_WAY_LIST [G]
		undefine
			valid_cursor_index, exhausted,
			search, search_equal,
			remove,
			forth, back, move, start, finish, go_i_th
		redefine
			new_chain
		end

	

creation

	make

feature  {TWO_WAY_CIRCULAR} -- Initialization

	new_chain: like Current is
			-- Instance of class `like Current'.
		do
			!! Result.make
		end;

end -- class TWO_WAY_CIRCULAR
