
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler reports violation of VUEX,
	--	although removing the argument list `(3)' makes
	--	the calls in the body of `try' valid.

class 
	TEST
creation
	make
feature
	make is
		do
			print (try (Current));
		end;

feature
	
	try (arg: TEST): TEST is
		local
			loc: TEST;
		do
			print (arg (3));
			print (loc (3));
		end;

end

