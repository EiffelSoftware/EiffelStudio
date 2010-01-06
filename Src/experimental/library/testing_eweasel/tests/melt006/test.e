
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Output is correct (calls three different unary operators).
	-- Uncomment first line of each routine in this class.  Rerun es3.
	--	Execute `test'.  Calls same unary operator `||' three 
	--	times instead of calling the three different unary operators.

class 
	TEST
creation
	make
feature
	
	make is
		local
			x: TEST
		do
			x := ## && || Current;
		end;
	
	prefix "##": TEST is
		do
			io.putstring ("In prefix %"##%"%N");
			Result := Current;
		end;
	
	
	prefix "||": TEST is
		do
			io.putstring ("In prefix %"||%"%N");
			Result := Current;
		end;
	
	prefix "&&": TEST is
		do
			io.putstring ("In prefix %"&&%"%N");
			Result := Current;
		end;
	
end
