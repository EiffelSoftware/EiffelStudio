
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is (with `es3 -f' to freeze).  Finish_freezing.
	-- Execute `test 100000'.  No problems.
	-- Replace 2nd line in loop body of this class with the
	--	`print' line below it.
	-- Change `d' in TEST4 to the commented declaration `d: STRING'.
	-- Recompile (no freezing).
	-- Execute `test 100000'.  Dies with run-time panic.

class TEST
inherit
	ARGUMENTS
create
	make
feature
	
	make
		local
			k, count: INTEGER;
		do
			from
				count := argument (1).to_integer;
				k := 1;
			until
				k > count
			loop 
				create t;
				print (t.a.b.c.d);
				k := k + 1;
			end
		end;
	
	t: TEST1;
	
end

