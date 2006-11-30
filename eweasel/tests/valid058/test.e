
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts it, even though it
	--	violates VFFD1 since it has a Formal_arguments part.

class TEST
creation
	make
feature
	
	make is
		do
		end;
	
	$FEATURE
end

