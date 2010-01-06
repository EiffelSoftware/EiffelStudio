
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is (with or without freezing).  
	-- Compiler dies with run-time panic.

class TEST
creation
	make
feature
	make is
		do
		end;
		
	the_Void: NONE is
		do
		end
end

