
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce the error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Runs fine and produces correct output.
	-- Now uncomment last line in body of `make'.  Rerun es3.
	--	Execute `test'.  Dies with run-time PANIC.
class 
	TEST

creation	
	make
feature
	
	make is 
		do
			$BODY
		end;

end
