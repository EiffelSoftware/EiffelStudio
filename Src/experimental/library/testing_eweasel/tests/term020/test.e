
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler dies with illegal instruction
	--	after pass 5 (using more and more memory too).

class 
	TEST
inherit
	ANY
		redefine
			default_create
		end
creation
	default_create
feature
	default_create is
		do
		end;
	
	a: expanded TEST1;
end

