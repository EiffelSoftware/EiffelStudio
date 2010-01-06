
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler accepts them, but TEST1 will
	--	never be able to be used as an expanded type.  Violates
	--	spirt but not the letter of VGCP(4).

class TEST
inherit
	TEST1
creation
	make
feature

	make is
		do
		end;
		
end
