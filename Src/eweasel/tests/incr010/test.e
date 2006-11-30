
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Change `x' to a procedure with no arguments and empty body.
	-- Recompile.  When VTAT violation is reported, press return.
	-- Compilation finishes even though nothing has changed.

class 
	TEST
creation
	make
feature

	make is
		local
			y: like x
		do
		end;

	x: STRING;
	
end

