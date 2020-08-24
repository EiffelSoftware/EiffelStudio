
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Uncomment first line of `make' in TEST.
	--	Add `make1' as additional creation procedure in TEST1
	--	and have it be a synonym for `make' (both frozen).
	--	Recompile.
	-- Make creation clause in TEST1 be `creation {NONE}'.
	-- Recompile.  When compiler reports VGCC violation,
	--	change local `x' below to be of type TEST.  Also, add creation
	--	procedure `make1' to TEST.
	-- When compiler reports validity violation, change TEST
	--	creation clause to `creation {TEST}'.  Hit return.
	--	Compiler dies with exception trace while melting changes.

class 
	TEST
create {NONE}
	make, make1
feature {NONE}
	make1, make
		local
			x: TEST;
		do 
			create x.make1 ;
			create x.make;
		end

end

