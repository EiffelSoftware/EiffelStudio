
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
			t: ANY;
		do
			g := 'a';

			t ?= a;
			show (t);
			t ?= b;
			show (t);
			t ?= c;
			show (t);
			t ?= d;
			show (t);
			t ?= e;
			show (t);
			t ?= f;
			show (t);
			t ?= g;
			show (t);
			t ?= h;
			show (t);
			t ?= i;
			show (t);
			t ?= j;
			show (t);
			t ?= k;
			show (t);
			t ?= p;
			show (t);
		end

	show (v: ANY) is
		do
			print (v = Void); io.new_line;
			print (v); io.new_line;
		end

	a: DOUBLE;
	b: DOUBLE is 3.14159;
	c: REAL;
	d: REAL is 2.718;
	e: INTEGER;
	f: INTEGER is 47;
	g: CHARACTER;
	h: CHARACTER is 'Z';
	i: BOOLEAN;
	j: BOOLEAN is False;
	k: POINTER;
	
	p: DOUBLE is
		do
			Result := 1.414;
		end

end
