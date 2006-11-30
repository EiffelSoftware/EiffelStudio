
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
			try (00B);
			try (a);
		end

	a: BIT 2 is 00B;

	try (x: BIT 2) is
		do
			print (x); io.new_line;
		end
end
