
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
			io.put_real (64); io.new_line
			io.put_real ({REAL_32} 64.0); io.new_line
			io.put_real (r); io.new_line
		end;

	r: REAL is 64.0
end
