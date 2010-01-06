
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature
	
	make is
		local
			s: STRING;
			c: CHARACTER;
			n: INTEGER_64;
			r: REAL;
		do
			-------------------------------------------------
			-- The following are accepted, but ETL says they
			-- shouldn't be.

			-- Integer with invalid and missing underscores
			n := 12_3456_38383;
			-------------------------------------------------
		
		end;
	
end 

