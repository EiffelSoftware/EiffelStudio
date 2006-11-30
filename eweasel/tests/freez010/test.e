
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
			r: RANDOM;
			k, seed, item_count, n: INTEGER;
			str: STRING;
			temp: like Current;
		do
			io.putstring ("Starting%N");
			b := bitmap;
			b := not b;
			seed := args.item (1).to_integer;
			item_count := args.item (2).to_integer;
			from
				!!r.set_seed (seed);
				r.start;
				k := 1;
			until
				k > 100000
			loop
				if (k \\ 1000) = 0 then
					io.putint (k); io.new_line;
				end;
				n := r.item \\ item_count + 1;
				check
					valid_length: 1 <= n and n <= item_count;
				end
				!!str.make (n);
				temp := deep_twin
				r.forth;
				k := k + 1;
			end
		end
	
	b: BIT_REF;

	bitmap: BIT 180 is
		do
		end
	
end

