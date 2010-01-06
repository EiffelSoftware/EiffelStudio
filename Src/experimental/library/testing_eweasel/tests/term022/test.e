
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Classes are valid, but compiler dies
	-- 	with exception trace.

class TEST
inherit
	TEST1 [BIT Weasel_bits]

creation
	make
feature
	make is
		do
			print (x); io.new_line
		end;

	Weasel_bits: INTEGER is 2;
end

