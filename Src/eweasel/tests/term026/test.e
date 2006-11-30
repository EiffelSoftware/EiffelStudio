
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Invalid generic derivation causes compiler 
	--	exception trace.

class TEST

creation
	make
feature

	make is
		local
			x: ARRAY [INTEGER];
		do
			!ARRAY!x.make (1, 10);
		end;

end
