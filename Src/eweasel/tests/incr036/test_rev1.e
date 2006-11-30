
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.


	-- To reproduce error:
	-- Compile class as is.
	-- Change name of root class to `TEST_WEASEL'.  Recompile.
	-- Compiler exception trace.

class TEST_WEASEL

creation
	make
feature

	make is
		do
		end;

end


