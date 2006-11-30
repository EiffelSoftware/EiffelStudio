
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile with classes as is.  
	-- Execute `test'.  Incorrect output.

class TEST
creation
	make
feature

	make is
		do
			io.putdouble (Current @ 3); io.new_line;
		end
	
	infix "@" (other: DOUBLE): DOUBLE is
		do
			io.putstring ("Other is ");
			io.putdouble (other); io.new_line;
			Result := other;
		end
end

