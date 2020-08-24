
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  No problems.
	-- Then, removed the 3 lines below `inherit TEST1' in this
	--	class (redefine subclause).
	-- Rerun es3.  Compiler correctly complains about violation
	--	of VMFN.
	-- Now modify class TEST2 so that it is deferred and feature
	--	`z' in it is deferred.
	-- Hit return to retry compilation.  Compiler reports VMFN
	--	which is *not* being violated. The real problem is that 
	--	class TEST1 is violating VCCH since it has no deferred 
	--	header mark).
class 
	TEST
inherit TEST1
		redefine
			z
		end
create
	make
feature
	
	make 
		do
		end;

	z
		do
		end;
	
end
