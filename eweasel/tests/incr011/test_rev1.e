
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Then delete declaration for feature `z'.  Recompile.
	--	Compiler reports VEEN violation.  Press return.
	--	Compilation proceeds and finishes, although the VEEN
	--	violation is still present.

class 
	TEST
create
	make
feature
	make
		do 
			create z;
		end;

end

