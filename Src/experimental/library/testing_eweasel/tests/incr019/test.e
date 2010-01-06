
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Then change header of TEST1 to `expanded class TEST1'.
	-- Recompile.  Compiler reports VDRD violation, although none
	--	is present.

class TEST
inherit
	TEST1
		redefine
			try
		end
creation
	make
feature
	make is
		do
		end;

	try: TEST1 is
		do
		end
end

