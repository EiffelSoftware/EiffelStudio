
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- Enter large number for cycle length (>= 43664 on my machine).
	-- Enter 'y' or 'n' in response to "Make cycle" prompt 
	--	(doesn't matter).
	-- Program dies with `Illegal instruction'.

class TEST

create
	make, make_obj
feature

	make
		local
			last: TEST;
			length: INTEGER;
			make_cycle: BOOLEAN;
		do
			io.putstring ("Cycle length: ");
			io.readline;
			length := io.laststring.to_integer;
			io.putstring ("Make cycle? (y/n) ");
			io.readline;
			last := deep (length, Current);
			if io.laststring.item (1) = 'Y' or io.laststring.item (1) = 'y' then
				io.putstring ("Making cycle%N");
				last.set_next (Current);
			end;
			io.putstring ("Calling deep_twin%N");
			last := deep_twin
		end;

	make_obj
		do
		end;

	deep (count: INTEGER; obj: TEST): TEST
		local
			k: INTEGER;
			curr_obj, next_obj: TEST;
		do
			from
				k := 1;
				curr_obj := obj;
			until
				k > count
			loop 
				create next_obj.make_obj;
				curr_obj.set_next (next_obj);
				curr_obj := next_obj;
				k := k + 1;
			end;
			Result := curr_obj;
		end;

	set_next (n: TEST)
		do
			next := n;
		end;

	next: TEST;
end
