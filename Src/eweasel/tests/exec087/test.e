
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
			c: CHARACTER;
			b: BOOLEAN;
			k: INTEGER;
		do
			Zee := 'Z';
			io.putchar (('A').twin); io.new_line;
			io.putbool (equal ('A', ('A').twin));
			io.new_line;
			io.putbool (equal (('A').twin, 'A'));
			io.new_line;
			io.putchar ((Zee).twin); io.new_line;
			io.putbool (equal (Zee, (Zee).twin));
			io.new_line;
			io.new_line;
			
			c := ('A').twin; io.putchar (c); io.new_line;
			io.putbool (equal (c, 'A')); io.new_line;
			io.putbool (equal ('A', c)); io.new_line;
			c := (Zee).twin; io.putchar (c); io.new_line;
			io.putbool (equal (c, Zee)); io.new_line;
			io.putbool (equal (Zee, c)); io.new_line;
			io.putbool (c = Zee); io.new_line;
			io.putbool (equal (c, Zee)); io.new_line;
			io.new_line;
			
			print ((True).twin); io.new_line;
			io.putbool (equal (True, (True).twin)); io.new_line;
			io.putbool ((True).twin); io.new_line;
			b := (True).twin; io.putbool (b); io.new_line;
			io.putbool (equal (b, (True).twin)); io.new_line;
			io.putbool (equal ((True).twin, b)); io.new_line;
			io.new_line;
			
			print ((1).twin); io.new_line;
			io.putbool (equal (1, (1).twin)); io.new_line;
			io.putbool (equal ((1).twin, 1)); io.new_line;
			io.putint ((1).twin); io.new_line;
			k := (1).twin; io.putint (k); io.new_line;
			io.putbool (equal (k, (1).twin)); io.new_line;
			io.putbool (equal ((1).twin, k)); io.new_line;
			
		end
	
	Zee: CHARACTER;
end
