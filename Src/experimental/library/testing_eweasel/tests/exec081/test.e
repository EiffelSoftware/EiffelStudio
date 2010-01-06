
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
		do
			c := '%U';
			io.putchar ('%/0/'); io.new_line;
			io.putchar ('%U'); io.new_line;
			io.putchar (c); io.new_line;
			print ('%/0/'); io.new_line;
			print ('%U'); io.new_line;
			print (c); io.new_line;
		end;

end
