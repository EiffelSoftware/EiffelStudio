
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is, with or without freezing.
	-- (Note that all classes are expanded).
	--	Execute `test'.  Creation procedures called in wrong order.

expanded class 
	TEST
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		do
			io.putstring ("In creation procedure of TEST%N");
		end;

	try: TEST1;
end

