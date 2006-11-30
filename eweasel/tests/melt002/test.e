
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Works correctly.
	-- Uncomment first line of `make'.
	--	Rerun es3.  Execute `test'.  Get run-time PANIC.

class 
	TEST
creation
	make
feature
	
	make is
		local
			b: BIT 4;
		do
			print (1100B ^ 0); io.new_line;
		end;
	
end
