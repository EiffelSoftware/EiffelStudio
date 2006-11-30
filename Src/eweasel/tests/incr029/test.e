
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- Then change `attr' in TEST1 from a deferred routine
	--	to a constant attribute of type STRING (uncomment
	--	commented out line) and delete deferred routine
	--	and deferred header mark in TEST1.
	-- Recompile.  Compiler exception trace.

class 
	TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
		end;

	attr: STRING;
end

