
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler reports VTGG, although
	--	it seems that the constraint `-> ARRAY [G]' out to
	--	be interpreted with the actual generic parameter INTEGER
	--	substituted for G before checking conformance.  This
	--	would give a constraint of `-> ARRAY [INTEGER]' which
	--	the actual generic parameter in TEST does satisfy.

class TEST
creation
	make
feature
	make is
		do
		end;

	x: TEST1 [INTEGER,  ARRAY [INTEGER]];

end

