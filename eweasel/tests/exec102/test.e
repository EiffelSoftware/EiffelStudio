
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
			item_count, seed1, seed2, limit, size: INTEGER;
			k, pos, count: INTEGER;
			list_of_lists: ARRAYED_LIST [ARRAY [STRING]];
			list: ARRAY [STRING];
			r, s: RANDOM;
		do
			item_count :=  args.item (1).to_integer;
			seed1 :=  args.item (2).to_integer;
			seed2 :=  args.item (3).to_integer;
			limit :=  args.item (4).to_integer ;
			create r.set_seed (seed1) ;
			create s.set_seed (seed2) ;
			create list_of_lists.make_filled (item_count);
			from
				k := 1;
				r.start;
				s.start;
			until
				k > limit
			loop
				if (k \\ 1000) = 0 then
					io.put_integer (k); io.new_line;
				end;
				pos := (r.item \\ item_count) + 1;
				list := new_list;
				list_of_lists.put_i_th (list, pos);
				r.forth;
				s.forth;
				k := k + 1;
			end
		end;

	new_list: ARRAY [STRING]
		local
			k: INTEGER;
		do
			Result := << 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w", 
			"w", "w", "w", "w", "w", "w", "w", "w", "w", "w"
			>>;
		end;

end
