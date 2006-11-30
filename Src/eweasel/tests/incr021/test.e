
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.
	-- Then delete entire text of class TEST1 (make it an empty file).
	-- Recompile.  Compiler correctly reports VD10 violation.
	--	Hit return to resume.  Now compiler reports syntax error
	--	on class TEST1, although there is no such class in the
	--	universe.

class 
	TEST
creation
	make
feature

	make is
		do
		end;

	x: TEST1;
end

