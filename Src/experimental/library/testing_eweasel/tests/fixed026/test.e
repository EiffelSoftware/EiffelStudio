
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
	
	-- To reproduce the error:
	-- Compile with class as is.

creation
	make
feature
	
	make is
		do
		end;

	try: INTEGER is
		require
			$PRECONDITION
		do
		end;
	
end 
