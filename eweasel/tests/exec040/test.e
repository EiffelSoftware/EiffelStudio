
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature

	make (args: ARRAY [STRING])
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

	new_list (item_count, seed: INTEGER): M_ARRAYED_LIST [INTEGER]
		local
			r: RANDOM;
			k: INTEGER;
		do 
			create r.set_seed (seed);
			from
				k := 1 ;
				create Result.make (item_count);
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
