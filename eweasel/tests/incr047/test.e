
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
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
create
	make
feature
	make
		do
			no_message_on_failure 
			create x;
			x.y.try;
			io.putreal (x.y.m); io.new_line;
		end;
		
	x: TEST1 [expanded TEST2];
	-- x: TEST1 [TEST2];
end

