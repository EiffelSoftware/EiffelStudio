
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts `old s', even though
	--	it is in a precondition (violates VAOL).

class 
	TEST
creation
	make
feature
	
	make is
		do
			try;
		end;

	s: STRING;

	try is
		require
			 pre1: equal (s, old s);
		do
		end;

end
