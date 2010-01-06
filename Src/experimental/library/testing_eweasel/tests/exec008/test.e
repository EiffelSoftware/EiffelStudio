
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Calls infix "+" before prefix "##" (wrong precedence).

class 
	TEST
creation
	make
feature
	
	make is
		local
			k: TEST;
		do
			k := ## Current + Current;
		end;
	
	prefix "##": TEST is
		do
			io.putstring ("In prefix %"##%"%N");
			Result := Current;
		end;
	
	infix "+" (arg: TEST): TEST is
		do
			io.putstring ("In infix %"+%"%N");
			Result := Current;
		end
end
