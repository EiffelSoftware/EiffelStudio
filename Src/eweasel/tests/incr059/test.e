
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  When compiler reports VAOL error,
	--	change invariant assertion to `a = a'.  Resume.
	-- 	Compiler still reports VAOL error, though there is none.

class TEST
creation
	make
feature

	make is
		do
		end;

	a: INTEGER;

invariant
	$INVARIANT
end
