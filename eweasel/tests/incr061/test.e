
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- When compiler reports VJAW error, comment out the body of
	-- 	`x' in TEST1 (line `is do end;'), thereby turning it into 
	--	an attribute.
	-- Resume.  Compiler later reports that it cannot write the
	--	.UPDT file.

class TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
			x := x;
		end

end
