
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Executes correctly (does nothing).
	-- Uncomment 1st line in body of `make' (but not 2nd line)
	--	and declaration of `s'.  Rerun es3.  Execute `test'.
	--	Still executes correctly.
	-- Uncomment 2nd line in body of `make'.  Change type of `s'
	--	from INTEGER to REAL.  Save and rerun es3.  Execute `test'.
	--	Dies with run-time PANIC.

class 
	TEST
creation	
	make
feature
	
	make is
		do
			s := 1;
		end;
	
	s: INTEGER;

end
