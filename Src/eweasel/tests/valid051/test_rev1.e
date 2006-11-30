
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Uncomment only one of the lines labeled VEEN #1, VEEN #2
	--	VEEN #3.  Then run compiler.  Compiler reports VTAT,
	--	VOMB or VTBT violation respectively, instead of VEEN
	--	violation which is the true cause of the problem.

class TEST

creation
	make
feature

	make is
		local
			-- a: like weasel;		-- VEEN #1
			k: INTEGER;
		do
			inspect
				k
			when weasel then		-- VEEN #2
			end;
		end;

	-- b: BIT Weasel_bits;				-- VEEN #3
end
