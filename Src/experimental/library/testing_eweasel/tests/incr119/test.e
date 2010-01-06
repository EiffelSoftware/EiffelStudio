
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
			io.putint (b.count); io.new_line;
		end;

	b: BIT Weasel_bits;
	
	Weasel_bits: INTEGER is $VALUE
end
