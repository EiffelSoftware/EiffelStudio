
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is.  Es3 reports syntax error on declaration
	-- of `b'.
class 
	TEST
creation
	make
feature
	
	make is
		do
		end;

	infix "+" (x: STRING): STRING is
		do
		end;
	
	plus (x: STRING): STRING is
		do
		end;

	a: like plus;
	
	b: like infix "+";
	
end
