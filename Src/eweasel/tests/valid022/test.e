
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

-- To reproduce error:
-- Compile classes as is.  Compiler accepts them, even though the
--	attribute `wimp' in TEST1 is anchored to the attribute `weasel'
--	whose type is a Formal_generic_name (which is
--	not a reference type).  Violates condition 1 of VTAT.

class TEST
inherit
	TEST1 [INTEGER]
creation
	make
feature
	make is
		do
		end;

end
