
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
			print (x.count); io.new_line;
			print (x.item (1)); io.new_line;
			x.put (true, 1);
			print (x.item (1)); io.new_line;
			x := 11001B;
			y := 00110B;
			z := x ^ 3;
			print (z); io.new_line;
			z := x # 3;
			print (z); io.new_line;
			z := x and y;
			print (z); io.new_line;
			z := x or y;
			print (z); io.new_line;
			z := x xor y;
			print (z); io.new_line;
			z := x implies y;
			print (z); io.new_line;
			z := not x;
			print (z); io.new_line;
		end

	x, y, z: BIT 5;

end
