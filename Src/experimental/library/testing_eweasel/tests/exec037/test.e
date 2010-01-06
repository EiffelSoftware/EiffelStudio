
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		local
			a: INTEGER;
			b: BOOLEAN;
			c: CHARACTER;
			d: DOUBLE;
			e: REAL;
			f, g: POINTER;
		do
			!!a;
			a := a + 1;
			!!b;
			b := b or True;
			!!c;
			c := 'A';
			!!d;
			d := d + 1.3;
			!!e;
			e := e + {REAL_32} 1.3;
			!!f;
			f := g;
		end

end
