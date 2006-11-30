
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
			a: TEST1 [DOUBLE];
			b: TEST1 [INTEGER];
			c: TEST1 [REAL];
			d: TEST1 [BOOLEAN];
			e: TEST1 [CHARACTER];
			f: TEST1 [POINTER];
			g: TEST1 [STRING];
			p: POINTER;
		do
			!!a;
			io.putdouble (a # 13.47); io.new_line;
			io.putdouble (a # 13); io.new_line;
			io.putdouble (a # Double_const); io.new_line;
			io.putdouble (a # Real_const); io.new_line;
			io.putdouble (a # Integer_const); io.new_line;
			!!b;
			io.putint (b # 13); io.new_line;
			io.putint (b # Integer_const); io.new_line;
			!!c;
			io.putreal (c # 13.47); io.new_line;
			io.putreal (c # 13); io.new_line;
			io.putreal (c # Real_const); io.new_line;
			io.putreal (c # Integer_const); io.new_line;
			!!d;
			io.putbool (d # True); io.new_line;
			!!e;
			io.putchar (e # 'Z'); io.new_line;
			!!f;
			print (f # p); io.new_line;
			!!g;
			io.putstring (g # "weasel"); io.new_line;
			$INSTRUCTION;
		end

	Double_const: DOUBLE is 29.47;
	Real_const: REAL is 29.47;
	Integer_const: INTEGER is 13;
	
end
