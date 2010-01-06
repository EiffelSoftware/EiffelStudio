
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
creation
	make
feature

	make (args: ARRAY [STRING]) is
		local
			item_count: INTEGER;
			k, pos, count: INTEGER;
			list_of_lists: ARRAYED_LIST [ARRAYED_LIST [INTEGER]];
			list: ARRAYED_LIST [INTEGER];
			r, s: RANDOM;
		do
			item_count :=  args.item (1).to_integer;
			list := new_list (item_count);
		end;

	new_list (item_count: INTEGER): ARRAYED_LIST [INTEGER] is
		local
			k: INTEGER;
		do
			from
				k := 1;
				!!Result.make (item_count);
				Result.wipe_out;
			until
				k > item_count
			loop
				Result.extend (0);
				k := k + 1;
			end
		end;

end
