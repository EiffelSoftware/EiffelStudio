
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is (with `es3 -F' to finalize).
	-- Compiler dies with run-time panic doing pass 6 on class TEST.

class TEST
creation
	make
feature
	
	make is
		local
			mem: expanded MEMORY;
		do
			mem.collection_on;
		end;
	
end

