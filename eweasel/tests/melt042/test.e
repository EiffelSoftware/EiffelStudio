
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
			a, b: INTEGER;
		do
			io.put_real ((5 / 2).truncated_to_real); io.new_line;
			io.put_double (5 / 2); io.new_line;
			a := 5; b := 2;
			io.put_real ((a / b).truncated_to_real); io.new_line;
			io.put_double (a / b); io.new_line;
		end;

end
