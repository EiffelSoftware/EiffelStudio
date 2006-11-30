
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile classes as is.  Es3 accepts them without complaint,
	-- 	even though the constraint `like weasel' on the formal
	--	generic parameter of TEST1 is completely meaningless.
class 
	TEST
inherit
	TEST1 [NONE];
creation
	make
feature
	
	make is
		local
			x: TEST1 [NONE];
		do
		end;

end


