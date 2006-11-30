
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
		
	-- To reproduce error:
	-- Compile classes as is.
	-- Uncomment inheritance clauses for TEST1 and TEST2 in
	-- 	class TEST. Rerun es3.
	-- Comment out inheritance clause for TEST2 in TEST.  Uncomment 
	--	inheritance clause for TEST2 in TEST1 (but not the redefine 
	--	or declaration for `d').  Rerun es3.
	-- Uncomment the redefine of `d' inherited from TEST2 in TEST1 
	--	and the declaration of `d' in TEST1. Rerun es3.

$TEST_INHERITANCE
		
creation
	make
feature
	
	make is
		local
			x: TEST1 [STRING];
		do
		end;
	
	c: INTEGER is
		external
			"C"
		end;
end 
