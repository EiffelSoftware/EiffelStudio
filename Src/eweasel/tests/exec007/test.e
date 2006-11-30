
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Current is not equal to `old Current', although it should
	--	be.

class 
	TEST
creation
	make
feature
	
	make is
		do
			try;
		end;

	try is
		do
		ensure
			same_current: Current = old Current
		end;

	show (arg: ANY): BOOLEAN is
		do
			print (arg); io.new_line;
			Result := True;
		end


end
