
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	
	try
		local
			y: TEST2;
		do
			io.put_integer (value); io.new_line ;
			create y;
			y.weasel (Current);
			io.put_integer (value); io.new_line;
		end
	
	set_value (v: INTEGER)
		do
			value := v;
		end;

	value: INTEGER;
end
