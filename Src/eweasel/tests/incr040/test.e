
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Remove parentheses from precondition of try to yield: `not 3 = 5'.
	-- Recompile.  When compiler reports VWOE error, add the
	--	parentheses back in, returning file to its original state.
	-- Resume.  Exception trace.

class TEST
creation
	make
feature
	make is
		do
		end;

	try is
		require
			not (3 = 5);
		do
		end;
	
end

