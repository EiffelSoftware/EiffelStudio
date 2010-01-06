
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  C file for TEST
	--	won't compile.

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
			d := 13;
			e := 29;
			f := 47;
			m := strip (a, b, c);
			from 
				k := m.lower;
			until
				k > m.upper
			loop
				print (m.item (k)); io.new_line;
				k := k + 1;
			end
		end;

	a: INTEGER;
	b: INTEGER;
	c: INTEGER;
	d: INTEGER;
	e: INTEGER;
	f: INTEGER;

end
