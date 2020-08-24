
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
			r: RANDOM;
			k, seed, item_count, string_len, n: INTEGER;
			str: STRING;
			temp: LINKED_LIST [STRING];
		do
			seed := 47;
			item_count := args.item (1).to_integer;
			string_len := args.item (2).to_integer;
			from 
				create r.set_seed (seed);
				r.start;
				k := 1;
			until
				k > 1000
			loop
				if (k \\ 10) = 0 then
					io.putint (k); io.new_line;
				end;
				n := r.item \\ item_count + 1;
				check
					valid_length: 1 <= n and n <= item_count;
				end
				temp := make_list (n, string_len);
				list1 := temp.deep_twin;
				list2 := temp.deep_twin;
				list3 := temp.deep_twin;
				r.forth;
				k := k + 1;
			end
		end
	
	list1: LIST [STRING];
	list2: LIST [STRING];
	list3: LIST [STRING];

	make_list (n, len: INTEGER): LINKED_LIST [STRING]
		local
			k: INTEGER
			str: STRING;
		do 
			create Result.make;
			from
				k := 1;
			until
				k > n
			loop 
				create str.make (len);
				str.fill_blank;
				Result.extend (str);
				k := k + 1;
			end
		end;

end
