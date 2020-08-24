
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make
		local
			a: INTEGER;
			b: BOOLEAN;
			c: CHARACTER;
			d: DOUBLE;
			e: REAL;
			f, g: POINTER;
		do 
			create a;
			a := a + 1 ;
			create b;
			b := b or True ;
			create c;
			c := 'A' ;
			create d;
			d := d + 1.3 ;
			create e;
			e := e + {REAL_32} 1.3 ;
			create f;
			f := g;
		end

end
