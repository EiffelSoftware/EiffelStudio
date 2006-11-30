
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler correctly reports VTBT, but
	--	also reports VTAT, though no anchored types are used.

class TEST
creation
	make
feature
	make is
		do
		end;

	x: BIT Weasel_bits;

	Weasel_bits: STRING is "abc";
end

