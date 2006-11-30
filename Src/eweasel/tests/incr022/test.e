
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  
	-- Then change class header to commented line below, making
	--	class generic.  Recompile.
	-- Compiler does pass 1 on class TEST twice.

class TEST
creation
	make
feature
	make is
		do
		end;

end

