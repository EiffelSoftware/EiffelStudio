
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Then change `s' in TEST1 to an
	--	attribute of type STRING (delete old declaration).
	-- Recompile.  Compiler exception trace.

class 
	TEST
inherit
	TEST1
		select
			s
		end;
	TEST1
		rename
			s as t
		end
	
creation
	make
feature

	make is
		do
		end;

end

