
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.  Compiler accepts them, ignoring
	-- trailing %U (null) characters in standard operator names.

class TEST
inherit
	TEST1
		rename
			infix "and%U%U%U%U" as infix "or%U%U"
		redefine
			infix "or%U%U%U%U%U%U"
		end
creation
	make
feature
	
	make is
		local
			x: TEST1;
		do
			print (Current or Current); io.new_line;
		end;

	infix "or%U" (n: TEST): TEST is
		do
			io.putstring ("In or%N");
		end;
	
end

