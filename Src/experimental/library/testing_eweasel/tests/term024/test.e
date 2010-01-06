
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler exception trace.

class TEST
creation
	make
feature
	make is
		do
			!BIT Weasel_bits!weasel;
		end;

	weasel: BIT 8;
end

