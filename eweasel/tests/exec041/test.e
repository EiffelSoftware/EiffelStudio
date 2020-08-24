
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
			item_count1, item_count2: INTEGER;
			seed1, seed2: INTEGER;
			k, pos, count: INTEGER;
			list_of_lists: ARRAYED_LIST [ARRAYED_LIST [INTEGER]];
			list: ARRAYED_LIST [INTEGER];
			r, s: RANDOM;
			gc: INTEGER;
		do
			gc :=  args.item (1).to_integer;
			item_count1 :=  args.item (2).to_integer;
			item_count2 :=  args.item (3).to_integer;
			seed1 :=  args.item (4).to_integer;
			seed2 :=  args.item (5).to_integer;
			inspect
				gc
			when 1 then
				allocate_fast
			when 2 then
				allocate_compact
			when 3 then
				allocate_tiny
			end 
			create r.set_seed (seed1) ;
			create s.set_seed (seed2) ;
			create list_of_lists.make_filled (item_count1);
			from
				k := 1;
				r.start;
				s.start;
			until
				k > 5
			loop
				if (k \\ 100) = 0 then
					io.putint (k); io.new_line;
				end;
				count := s.item \\ item_count2;
				list := new_list (count);
				pos := (r.item \\ item_count1) + 1;
				list_of_lists.put_i_th (list, pos);
				r.forth;
				s.forth;
				k := k + 1;
			end
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
