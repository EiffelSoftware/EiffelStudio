
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	
	try is
		local
			y: TEST2;
		do
			io.put_integer (value); io.new_line;
			!!y;
			y.weasel (Current);
			io.put_integer (value); io.new_line;
		end
	
	set_value (v: INTEGER) is
		do
			value := v;
		end;

	value: INTEGER;
end
