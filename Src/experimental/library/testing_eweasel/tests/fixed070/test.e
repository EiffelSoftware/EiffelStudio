
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Uncomment the entire declaration of feature `prime' (but
	--	leave the inheritance clause for SINGLE_MATH commented out).
	-- Rerun es3.  Compiler detects VEEN violation.  Uncomment
	--	inheritance clause for SINGLE_MATH and save.  Hit return to
	--	retry compilation.  Compiler accepts the invalid assignment 
	--	(INTEGER <- REAL) in `prime'.
	

class 
	TEST
creation	
	make
feature
	
	make is
		do
		end;
	
end
