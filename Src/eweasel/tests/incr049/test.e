
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler correctly reports VHPR violation.
	-- Remove inheritance clause.  Resume.  Cycle is now gone, but
	--	compiler still reports VHPR violation.

class TEST
inherit
	TEST
creation
	make
feature
	
	make is
		do
		end;
	
end

