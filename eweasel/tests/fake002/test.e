
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
create
	make
feature

	make (args: ARRAY [STRING])
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

	new_list (item_count: INTEGER): ARRAYED_LIST [INTEGER]
		local
			k: INTEGER;
		do
			from
				k := 1 ;
				create Result.make (item_count);
				Result.wipe_out;
			until
				k > item_count
			loop
				Result.extend (0);
				k := k + 1;
			end
		end;

end
