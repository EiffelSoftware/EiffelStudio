
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  Then replace declaration for `feat'
	--	with the commented line below (different actual generic parm).
	-- Recompile.  Exception trace while melting changes.

class 
	TEST
creation
	make
feature

	make is
		do
		end;

	feat: TEST1 [expanded TEST2 [STRING]];
end

