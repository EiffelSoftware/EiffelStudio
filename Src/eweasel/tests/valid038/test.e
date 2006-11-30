
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 reports VUAR violation in `make'.

class 
	TEST
creation	
	make
feature
	
	make is
		do
			try ($make);
			try ($a);
			try ($try);
		end;
		
	try (p: POINTER) is
		do
		end;

	a: STRING;
	
end
