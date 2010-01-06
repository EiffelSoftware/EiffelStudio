
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	--	Gives correct output.
	-- Delete the declaration for `uniq2' and the `print (uniq2)'
	--	line.  Rerun es3.  Execute `test'.  Two unique 
	--	attributes which should have consecutive values do not.

class 
	TEST
creation	
	make
feature
	
	make is 
		do
			print (uniq1); io.new_line;
			print (uniq2); io.new_line;
			print (uniq3); io.new_line;
		end;

	uniq1, 
	uniq2, 
	uniq3: INTEGER is unique;
	
end
