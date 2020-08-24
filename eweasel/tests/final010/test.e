
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
			item_count1, item_count2, item_count3: INTEGER;
			seed1, seed2, seed3: INTEGER;
			k, pos, count: INTEGER;
			list_of_lists: ARRAYED_LIST [ARRAYED_LIST [STRING]];
			list: ARRAYED_LIST [STRING];
			r, s, t: RANDOM;
			loop_count: INTEGER;
		do
			item_count1 := args.item (1).to_integer;
			item_count2 := args.item (2).to_integer;
			item_count3 := args.item (3).to_integer;
			seed1 := args.item (4).to_integer;
			seed2 := args.item (5).to_integer;
			seed3 := 44 ;
			create r.set_seed (seed1) ;
			create s.set_seed (seed2) ;
			create t.set_seed (seed3) ;
			create list_of_lists.make_filled (item_count1);
			from
				k := 1;
				r.start;
				s.start;
				t.start;
			until
				k > 1000
			loop
				if (k \\ 100) = 0 then
					io.putint (k); io.new_line;
				end;
				count := s.item \\ item_count2;
				list := new_list (t, count, item_count3);
				pos := (r.item \\ item_count1) + 1;
				list_of_lists.put_i_th (list, pos);
				r.forth;
				s.forth;
				t.forth;
				k := k + 1;
			end
		end;

	new_list (t: RANDOM; item_count, max_len: INTEGER): ARRAYED_LIST [STRING]
		local
			k: INTEGER;
			s: STRING;
		do
			from
				k := 1 ;
				create Result.make (item_count);
				Result.wipe_out;
			until
				k > item_count
			loop 
				create s.make (t.item \\ max_len + 1);
				s.fill_blank;
				Result.extend (s);
				t.forth;
				k := k + 1;
			end
		end;

end
