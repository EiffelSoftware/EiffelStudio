
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing (use `gcc').  Execute `test'.
	--	Produces incorrect output: attribute `b' is not named in
	--	the Strip list, but it is not included in the array.
	
class 
	TEST
creation
	make
feature
	
	make is
		local
			m: ARRAY [ANY];
			k: INTEGER;
		do
			b := 47;
			m := strip (a);
			from 
				k := m.lower;
			until
				k > m.upper
			loop
				print (m.item (k));
				k := k + 1;
			end
			io.new_line;
		end;

	a: INTEGER;
	b: INTEGER;

end
