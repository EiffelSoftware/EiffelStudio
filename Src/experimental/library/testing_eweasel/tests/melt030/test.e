
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
			b: BIT 8;
		do
			show (b.twin);
		end;

	show (arg: BIT 8) is
		do
			print (arg); io.new_line;
		end

end
