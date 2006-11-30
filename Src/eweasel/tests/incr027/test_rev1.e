
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  When compiler reports VSRC violation,
	--	make class header `class TEST [G, G]'.
	-- Hit return.  Compiler dies trying to report VCFG violation.

class 
	TEST [G, G]
creation
	make
feature
	make is
		do
		end;
	
end
