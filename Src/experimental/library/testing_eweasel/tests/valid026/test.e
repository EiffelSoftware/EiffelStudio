
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler does not report VTUG violations
	--	(generic parameters supplied for basic types).

class TEST

creation
	make
feature

	make is
		local
			b: $TYPE;
		do
		end;

end
