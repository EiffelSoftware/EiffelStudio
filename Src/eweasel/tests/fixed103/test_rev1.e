
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.
	-- Then comment out the 8 lines of `make' beginning with
	--	`local' and ending with `end', but not the header
	--	line.  Uncomment the 5 commented lines, making `make'
	--	an external routine.
	-- Recompile.  Compiler dies while refreezing system.

class TEST
creation
	make
feature
	make is
		external
			"C"
		alias
			"weaselhead"
		end;

	two: INTEGER is 2;
end



