
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
			c := '%/0/';
			d := '%/0/';
			io.put_boolean (c /= '%/0/'); io.new_line;
			io.put_boolean (d /= '%/0/'); io.new_line;
			c := '%/127/';
			d := '%/127/';
			io.put_boolean (c /= '%/127/'); io.new_line;
			io.put_boolean (d /= '%/127/'); io.new_line;
			c := '%/128/';
			d := '%/128/';
			io.put_boolean (c /= '%/128/'); io.new_line;
			io.put_boolean (d /= '%/128/'); io.new_line;
			c := '%/255/';
			d := '%/255/';
			io.put_boolean (c /= '%/255/'); io.new_line;
			io.put_boolean (d /= '%/255/'); io.new_line;
		end
	
	d: CHARACTER;
	
end

