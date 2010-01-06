
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing. Execute `test'.
	--	Output looks correct.
	-- Uncomment first line of `make'.  Rerun es3.  Execute `test'.
	--	Values printed for reals and doubles are not correct.
	
class 
	TEST
creation
	make
feature
	
	make is 
		local
			k: INTEGER
		do
			io.putstring ("print (9.876534): ");
			print (9.876534); io.new_line;
			io.putstring ("io.putreal (9.876534): ");
			io.putreal ({REAL_32} 9.876534); io.new_line;
			io.putstring ("print (9.876534) double: ");
			print (9.876534); io.new_line;
			io.putstring ("io.putdouble (9.876534): ");
			io.putdouble (9.876534); io.new_line;
		end;
end

