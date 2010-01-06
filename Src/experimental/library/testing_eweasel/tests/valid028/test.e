
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts it even though
	--	the instruction `x := x.item (1)' in `display' in
	--	class TEST1 violates the Assignment Rule.

	-- Finish_freezing.  Execute `test'.  Disaster.

class TEST
inherit
	TEST1 [ARRAY [STRING]]
		rename
			make as test1_make
		end
creation
	make
feature
	make is
		do
			test1_make (<< "weasel", "wimp", "hamster" >>);
			display;
		end;
end
