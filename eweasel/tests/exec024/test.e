
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is, using `es3 -f'.  
	-- Finish_freezing.  Execute `test'.  Ends with illegal instruction.

class TEST
create
	make
feature
	make
		local
			k: INTEGER
		do
			from
				k := 1
			until
				k > 3
				-- k > 10000
			loop
				io.putstring ("Starting iteration "); 
				io.putint (k); io.new_line;
				waste_memory;
				k := k + 1;
			end
		end;
		
	waste_memory
		local
			list: LINKED_LIST [INTEGER];
			k: INTEGER;
		do
			io.putstring ("Entering waste_memory%N");
			from 
				create list.make;
				k := 1
			until
				k > 1_000_000
			loop
				if (k \\ 1000) = 0 then
					io.putstring ("Waste_memory: iteration ");
					io.putint (k); io.new_line;
				end;
				list.put_front (k);
				k := k + 1;
			end;
			io.putstring ("Leaving waste_memory%N");
		end

end

