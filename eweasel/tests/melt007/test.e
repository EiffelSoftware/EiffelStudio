
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile classes as is with `assertion (ensure)' (without freezing).
	-- Execute `test'.  Precondition `impossible' is violated, but
	--	the full precondition of try is `false or else true',
	--	which is true.  
	-- Freeze system.  Now no precondition violation.

class 
	TEST
inherit
	TEST1
		redefine
			try
		end
	
creation
	make
feature

	make is
		do
			try;
		end;

	try is
		require else
			impossible: false
		do
		end
end

