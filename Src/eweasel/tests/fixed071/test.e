
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Works correctly (does not print anything).
	-- Uncomment first line of `make' and first line of `control'.
	--	Rerun es3.  Execute `test'.  `Control' seems to be
	--	void the second time.

class TEST 
creation
	make
feature
	make is
		do
			if (control = Void) then
				io.putstring("Test1: control is Void%N");
			end;
			if (control = Void) then
				io.putstring("Test2: control is Void%N");
			end;
		end;

	control: STRING is
		once
			!!Result.make (10);
			Result.append("weasel");
		end
end 
