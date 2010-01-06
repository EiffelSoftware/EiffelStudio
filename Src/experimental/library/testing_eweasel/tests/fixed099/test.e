
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Es3 reports violation of VUAR on class
	--	TEST.
	-- Change type of local `the_list' from `FIXED_LIST [INTEGER]'
	--	to `LINKED_LIST [INTEGER]'.  Save and hit return.
	--	Compiler later dies with exception trace.

class 
	TEST
creation	
	make
feature
	
	make is
		local
			the_list: $LOCAL_TYPE;
		do
			f (the_list);
		end;
	

	f (x: LINKED_LIST [INTEGER]) is
		do
		end;

end
