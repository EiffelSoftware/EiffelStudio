
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
			k, count, size, interval: INTEGER;
			a: ARRAY [STRING];
		do
			count := args.item (1).to_integer;
			size := args.item (2).to_integer;
			interval := 1;
			create a.make_filled ("", 1, count);
			
			from
				k := 1;
			until
				k > count
			loop
				a.put ("weasel", k);
				if k \\ interval = 0 then
					waste_memory (size);
				end
				k := k + 1;
			end
			
			from
				k := 1;
			until
				k > count
			loop
				if not equal (a.item (k), the_weasel) then
					io.putstring (a.item (k));
					io.new_line;
				end
				k := k + 1;
			end
		end

	the_weasel: STRING = "weasel";

	waste_memory (limit: INTEGER)
		local
			k: INTEGER;
			s: STRING;
		do
			from
				k := 1;
			until
				k > limit
			loop 
				create s.make (100);
				s.fill_blank;
				k := k + 1;
			end
		end
	

end
