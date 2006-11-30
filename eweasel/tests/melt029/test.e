
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		do
			io.putint (a); io.new_line;
			io.putstring (a.out); io.new_line;
			io.putreal (b); io.new_line;
			io.putstring (b.out); io.new_line;
			io.putdouble (c); io.new_line;
			io.putstring (c.out); io.new_line;
			io.putbool (d); io.new_line;
			io.putstring (d.out); io.new_line;
			io.putchar (e); io.new_line;
			io.putstring (e.out); io.new_line;
			io.putstring (f); io.new_line;
			io.putstring (f.out); io.new_line;
			
		end

	a: INTEGER is 13;
	b: REAL is 47.0;
	c: DOUBLE is 29.0;
	d: BOOLEAN is True;
	e: CHARACTER is 'W';
	f: STRING is "Weasel"

end
