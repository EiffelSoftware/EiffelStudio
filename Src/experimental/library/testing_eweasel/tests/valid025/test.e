
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts it, even though
	-- the non-existent language "weasel" is not supported.

class TEST


creation
	make
feature

	make is
		do
			try;
		end;

	
	try is
		external
			"weasel"
		end;

end


