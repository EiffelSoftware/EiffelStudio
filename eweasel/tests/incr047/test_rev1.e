
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Change `x' below to be of type `TEST1 [TEST2]'.
	-- Recompile.  Execute `test'.
	-- 	Should get `try' applied to Void reference, but instead
	--	prints 0 and then dies with run-time panic.

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	make is
		do
			no_message_on_failure
			!!x;
			x.y.try;
			io.putreal (x.y.m); io.new_line;
		end;
		
	x: TEST1 [TEST2];
end

