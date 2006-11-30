
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature

	make (args: ARRAY [STRING]) is
		local
			item_count: INTEGER;
			seed: INTEGER;
			list: M_ARRAYED_LIST [INTEGER];
		do
			item_count :=  args.item (1).to_integer;
			seed :=  args.item (2).to_integer;
			list := new_list (item_count, seed);
			list.process;
			list.process;
		end;

	new_list (item_count, seed: INTEGER): M_ARRAYED_LIST [INTEGER] is
		local
			r: RANDOM;
			k: INTEGER;
		do
			!!r.set_seed (seed);
			from
				k := 1;
				!!Result.make (item_count);
				r.start;
			until
				k > item_count
			loop
				Result.extend (r.item);
				r.forth;
				k := k + 1;
			end
		end;

end
