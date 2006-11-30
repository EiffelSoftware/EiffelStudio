
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- After compile finishes, uncomment the full inheritance clause
	-- in both TEST and TEST1.
	-- Rerun es3.  When compiler reports VDCC violation, 
	-- 	comment out the inheritance clause in class TEST1 only,
	--	save and hit return to retry compilation.  Compiler dies
	--	with exception trace.
class 
	TEST
$TEST_INHERITANCE
creation
	make
feature
	
	make is 
		local
			z: TEST1
		do
		end;
end
