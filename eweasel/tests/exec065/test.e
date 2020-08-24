
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
			k, item_count, count, interval: INTEGER;
			seed: INTEGER;
			r: RANDOM;
		do
			seed :=  47;
			item_count :=  args.item (1).to_integer;
			interval :=  args.item (2).to_integer ;
			create r.set_seed (seed);
			from
				k := 1;
				r.start;
			until
				k > 1000
			loop
				if (k \\ interval) = 0 then
					io.putint (k); io.new_line;
				end;
				count := r.item \\ item_count;
				create a.make_filled (0, 1, count);
				k := k + 1;
				r.forth;
			end
		end;

	a: ARRAY [INTEGER];
	
end
