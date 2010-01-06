
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
			try (1111111111B);
			x :=  1111111111B;
			print (x); io.new_line;
		end

	x: BIT 20;
	
	try (arg: BIT 20) is
		do
			print (arg); io.new_line;
		end

end
