
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler dies with run-time PANIC.


class TEST
creation
	make
feature
	make is
		local
			t: TEST1 [STRING]
		do
			create t
			t.once_procedure
		end;
	
	
end

