
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Gives correct output.
	-- Uncomment the three commented out lines in this class.
	--	Rerun es3.  Execute `test'.  Two unique attributes have
	--	the same value.

class 
	TEST
creation	
	make
feature
	
	make is 
		local
			b: BOOLEAN;
		do
			print (uniq1); io.new_line;
			print (uniq2); io.new_line;
			print (uniq3); io.new_line;
			print (uniq1 = uniq2); io.new_line;
			print (uniq2 = uniq3); io.new_line;
		end;

	uniq3, 
	uniq2, 
	uniq1: INTEGER is unique;
	
end
